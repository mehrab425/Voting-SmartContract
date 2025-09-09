require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {},

    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY`,
      accounts: [`0x${YOUR_PRIVATE_KEY}`],
    },

    bscTestnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [`0x${YOUR_PRIVATE_KEY}`],
    },

    polygonMumbai: {
      url: `https://rpc-mumbai.maticvigil.com/`,
      accounts: [`0x${YOUR_PRIVATE_KEY}`],
    }
  }
};
