require("dotenv").config();
const { API_URL_INFURA , CONTRCT_ADDRESS, ADMIN_PRIVATE_KEY, ADMIN_PUBLIC_KEY} = process.env;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL_INFURA);

const contract = require("../build/contracts/specialNftContract.json");
const nftContract = new web3.eth.Contract(contract.abi, CONTRCT_ADDRESS);

async function adminMinting(tokenId, name, metaDataHash){

    const nonce = await web3.eth.getTransactionCount(ADMIN_PUBLIC_KEY, 'latest'); // nonce starts counting from 0

    const tx = {
        'from': ADMIN_PUBLIC_KEY,
        'to':CONTRCT_ADDRESS,
        'nonce': nonce,
        'gas': 500000,
        'maxPriorityFeePerGas': 1000000108,
        'data': nftContract.methods.adminMinting(tokenId, name, metaDataHash).encodeABI(),
    };



    const signedTx = await web3.eth.accounts.signTransaction(tx, ADMIN_PRIVATE_KEY);
    
    web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
    if (!error) {
      console.log("🎉 The hash of your transaction is: ", hash, "\n Check Alchemy's Mempool to view the status of your transaction!");
    } else {
      console.log("❗Something went wrong while submitting your transaction:", error)
    }
   });

}

adminMinting(2 , "Billed-Curlew" , "QmRrxoQap7T1dCk6JqCRf2ny72THxrNrsdq8PbokJHep9m");