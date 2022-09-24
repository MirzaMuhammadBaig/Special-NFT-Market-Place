require('dotenv').config();
const Web3 = require('web3');
const { API_URL_INFURA , CONTRCT_ADDRESS , PRIVATE_KEY , PUBLIC_KEY} = process.env;
const MyContract = require('../build/contracts/specialNftContract.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

async function ActiveAdminAddress(_Address) {
    const provider = new HDWalletProvider(PRIVATE_KEY, API_URL_INFURA);

    const web3 = new Web3(provider);
    
    let contract = new web3.eth.Contract(
        MyContract.abi,
        CONTRCT_ADDRESS,
        provider,
    );

    let ActiveAdminMinting = await contract.methods
    .ActiveAdminAddress('0xc9cf24A1145233d8607a6c996373c05dBC2397D4')
    .send({from : PUBLIC_KEY});
    console.log(`Your transection record`);
    console.log(ActiveAdminMinting);
    console.log(`You have successfuly add ${'0xc9cf24A1145233d8607a6c996373c05dBC2397D4'}`)
};

ActiveAdminAddress('0xc9cf24A1145233d8607a6c996373c05dBC2397D4');

