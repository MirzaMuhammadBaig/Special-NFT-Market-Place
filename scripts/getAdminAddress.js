require('dotenv').config();
const Web3 = require('web3');
const MyContract = require('../build/contracts/specialNftContract.json');
const { AlchemyAPI , CONTRCT_ADDRESS } = process.env;

async function CheckAdminAddress() {
    const web3 = new Web3(AlchemyAPI);
    
    
    let contract = new web3.eth.Contract(
        MyContract.abi,
        CONTRCT_ADDRESS,
        web3
        );

    const AdminMinting = await contract.methods
    .CheckAdminAddress(yourAdminAddress)
    .call();
    console.log(`Tx is succesfull.`);
    console.log(`Your value is ${AdminMinting}`)


};

CheckAdminAddress();
