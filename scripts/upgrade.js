// scripts/upgrade_box.js
require('../dotenv').config();

const { ethers, upgrades } = require('hardhat');

const contractAddress = process.env.CONTRCT_ADDRESS;

async function main () {
  const specialNftContract = await ethers.getContractFactory('specialNftContract');
  console.log('Upgrading specialNftContract...');
  await upgrades.upgradeProxy(contractAddress , specialNftContract);
  console.log('specialNftContract upgraded');
}

main();