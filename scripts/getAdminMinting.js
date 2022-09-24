require('dotenv').config();
const Web3 = require('web3');
const MyContract = require('../build/contracts/specialNftContract.json');
const { API_URL_INFURA , CONTRCT_ADDRESS } = process.env;

async function AdminMinting() {
    const web3 = new Web3(API_URL_INFURA);
    
    
    let contract = new web3.eth.Contract(
        MyContract.abi,
        CONTRCT_ADDRESS,
        web3
        );

    const AdminMinting = await contract.methods
    .AdminMinting()
    .call();
    console.log(`Tx is succesfull.`);
    console.log(`Your value is ${AdminMinting}`)


};

AdminMinting();
