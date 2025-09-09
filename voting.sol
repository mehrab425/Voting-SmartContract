// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract voting{
    uint startVoting;
    uint endVoting;
    struct voter{
        bool voted;
        uint8 voteTo;
        uint weight;
    }
    struct candidate{
        bytes32 name;
        uint voteCount;
    }
    address public manager;
    mapping ( address => voter) public voters;

    candidate[] public candidates;
    event candidateAdded(bytes32 candidateName, uint candidateID);
    event votingStarted(uint statTime);
    event votingEnded(uint EndTime);
    event voted(bytes32 candidateName, uint voteCount);

    modifier ActiveVoting {
    require (
        block.timestamp >= startVoting &&
        block.timestamp <= endVoting,
        "voting is already ended"
        );
        _;
    }
    modifier onlyOwner {
        require(msg.sender == manager, "you are not the owner");
        _;

    }


    constructor (bytes32[] memory _candidatesName){
        manager = msg.sender;
        for (uint i = 0; i < _candidatesName.length; i++){
            candidates.push(candidate({name: _candidatesName[i], voteCount: 0}));
        }
    }


    function giveRightToVote(address _voter) public onlyOwner {
        require(!voters[_voter].voted, "this address already to voted");
        require(voters[_voter].weight == 0);
        voters[_voter].weight = 1;
    }

    function vote(uint8 _candidate) public ActiveVoting {
        voter memory sender = voters[msg.sender];
        require(sender.weight > 0, "you have no right to vote");
        require(!sender.voted, "you already voted");
        require(_candidate < candidates.length, "invalid candidate ID");

        sender.voted = true;
        sender.voteTo = _candidate;
        candidates[_candidate].voteCount += sender.weight;
        sender.weight = 0; // جلوگیری از دوباره رأی دادن با باگ
        emit voted(candidates[_candidate].name, candidates[_candidate].voteCount);
 }

    function winningCandidatesID() public view returns (uint8[] memory) {
        uint256 winningVoteCount = 0;
      
        for(uint i =0; i < candidates.length;i++){
            if(candidates[i].voteCount > winningVoteCount){
                winningVoteCount = candidates[i].voteCount;
            }
        }
        uint8[] memory winningCandidatesIDs = new uint8[](candidates.length);
        uint winningCount = 0;

    for(uint i = 0; i < candidates.length; i++){
        if(candidates[i].voteCount > winningVoteCount){
            winningVoteCount = candidates[i].voteCount;
            winningCount = 1;
            winningCandidatesIDs[0] = uint8(i);
        } else if (candidates[i].voteCount == winningVoteCount) {
            winningCandidatesIDs[winningCount] = uint8(i);
            winningCount++;
        }
    }

    uint8[] memory result = new uint8[](winningCount);
    for(uint i = 0; i < winningCount; i++){
        result[i] = winningCandidatesIDs[i];
    }

    return result;

    }


        function winningCandidateName() public view  returns(string memory){
            uint8[] memory winners = winningCandidatesID();
            require(winners.length > 0, "No winner yet");
            bytes32 _winnerName = candidates[winners[0]].name;
            return string(abi.encodePacked(_winnerName));
        }

        function setStartTime(uint _startVoting) public onlyOwner {
            startVoting = _startVoting;
            emit votingStarted(_startVoting);
        }
        function setEndTime(uint _endVoting) public onlyOwner {
            endVoting = _endVoting;
            emit votingEnded(_endVoting);
        }
        function emergencyEndOfVote() public onlyOwner ActiveVoting {
            endVoting = block.timestamp;
            emit votingEnded(endVoting);
        }

        function showCandidates() public view returns (bytes32[] memory) {
            bytes32[] memory names = new bytes32[](candidates.length);
            for(uint i = 0; i < candidates.length; i++) {
                names[i] = candidates[i].name;
    }
    return names;
}

        function showCandidateInfo(uint _Id) public view returns (bytes32, uint, uint){
    return (
        candidates[_Id].name,
        candidates[_Id].voteCount,
        _Id
    );
}


    function addCandidate(bytes32 _name) public onlyOwner{
        candidates.push(candidate({
            name:_name,
            voteCount : 0
        }));
        // destructure function
        (bytes32 _candidateName, ,uint _candidateID) = showCandidateInfo(candidates.length-1);
        emit candidateAdded(_candidateName, _candidateID);
    }
}