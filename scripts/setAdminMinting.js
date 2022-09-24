require('dotenv').config();
const Web3 = require('web3');
const { AlchemyAPI , CONTRCT_ADDRESS , PRIVATE_KEY , PUBLIC_KEY} = process.env;
const MyContract = require('../build/contracts/specialNftContract.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

async function ActiveAdminMinting() {
    const provider = new HDWalletProvider(PRIVATE_KEY, AlchemyAPI);

    const web3 = new Web3(provider);
    
    let contract = new web3.eth.Contract(
        MyContract.abi,
        CONTRCT_ADDRESS,
        provider,
    );

    let ActiveAdminMinting = await contract.methods
    .ActiveAdminMinting()
    .send({from : PUBLIC_KEY});
    console.log(`Your transection record`);
    console.log(ActiveAdminMinting);
    console.log(`You have successfuly add`)
};

ActiveAdminMinting(false , false , true);

