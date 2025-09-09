# 🗳️ Decentralized Voting Smart Contract

A decentralized voting system built with **Solidity (v0.8.17)**.  
This contract allows secure, transparent, and time-based voting with multiple features including candidate management, voter rights, and result tracking.

---

## ✨ Features
- **Candidate Management**  
  - Add candidates dynamically  
  - View candidate list & details  

- **Voting Mechanism**  
  - Assign right to vote (owner only)  
  - Prevents double voting  
  - Supports weighted votes  

- **Time-Based Control**  
  - Set start & end time of voting  
  - Emergency stop by contract owner  

- **Result System**  
  - Real-time vote count per candidate  
  - Detects winners (supports ties)  
  - Fetch winning candidate(s) name & ID  

- **Events**  
  - CandidateAdded  
  - VotingStarted  
  - VotingEnded  
  - Voted  

---

## 📜 Smart Contract Functions

### `constructor(bytes32[] memory _candidatesName)`
Deploy contract with initial candidate names.

### `giveRightToVote(address _voter)`
Owner assigns voting rights to an address.

### `vote(uint8 _candidate)`
Allows an eligible voter to cast a vote.

### `winningCandidatesID()`
Returns the ID(s) of the candidate(s) with the highest votes.

### `winningCandidateName()`
Returns the name of the leading candidate.

### `setStartTime(uint _startVoting)` / `setEndTime(uint _endVoting)`
Set the start and end of the voting period.

### `emergencyEndOfVote()`
Owner can end voting immediately in case of emergency.

### `showCandidates()`
Returns the list of all candidate names.

### `showCandidateInfo(uint _Id)`
Returns candidate name, vote count, and ID.

### `addCandidate(bytes32 _name)`
Owner adds a new candidate to the election.

---

## 🚀 Getting Started

### Clone repository

git clone https://github.com/mehrab425/Voting-SmartContract.git
