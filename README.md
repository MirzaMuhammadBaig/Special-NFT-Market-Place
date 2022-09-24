# Special-NFT-Market-Place

## Setting Up Environment:
```
Remix
Solidity
Metamask
VS-code
Truffle
Web3.js
Node.js
```

### Note: In this README, I will explain you about this project in some parts. First is Smart-Contract.

## Smart Contract

1. In this contract, I have created three users:

- Admin/Platform user,

- Whitelisted user,

- Public user.


2. I HAVE SET LIMITATION Of THESE USERS:

We have reserved a limit for each Admin, Whitelist user, and public. 1 address can mint up to 5 NFTs. If an address have minted 5 nft, then it can't mint more nft.

First I have set Max-NFT Minting Limit,

then admin/platform users minting limit,

then Whitelisted users Minting limit,

then Public users Minting limit.      
            

3. MINTINGS

- ADMIN-PLATFORM USERS MINTING: 

Only Admin/Platform users allow to mint the NFT, when admin-minting wil be active.

If the Admin/Platform User's Minting limit is reached then Admin/Platform users cannot mint the NFTs.


- WHITELISTED-USERS MINTING: 

Only Whitelisted users allow to mint the NFT, when Whitelisted-minting wil be active.

If the Whitelisted User's Minting limit is reached then Whitelisted users cannot mint the NFTs.



- PUBLIC-USERS MINTING:

Only Public users allow to mint the NFT, when Public-minting wil be active.

If the Public User's Minting limit is reached then Public users cannot mint the NFTs.


4. OTHER CHECKS:

- All contract functions can be paused by contract owner.   

- Contract have a default base URI function. It can be set from admin/platform address.

- Contract have a pause/un-pause minting feature. Minting status can be changed by the owner of the contract.
 
- Any user/address can be mint as public. But in whitelist minting only whiteisted users can mint and same as with admin users.

- Admins cannot mint NFTs if the admin is paused.

- Whitelisted cannot mint NFTs if the Whitelist is paused.

- Public users cannot mint NFTs if public sales are not active.  

#### Note : Smart-Contract has been ended. Now, I am starting the explaination of next-step.

### Next-Step is initialize truffle:

First I install truffle from this command:
```
npx truffle init
```

Then, I was set migration.js file and config file as well.

And then remove contract in contracts folder and add my contract.

And then run below command:
```
npx truffle compile
```

For compile our contract.

And then run below command:
```
npx truffle migrate --network rinkeby
```

For integrating and deploying contract on blockchain.

#### Note : Truffle initializing has been ended. Now, I am starting the explaination of next-step.

### Next-Step is upload NFTs on pinata:

For upload Nfts on pinata, I was make scripts in scripts folder, it names is pinataApi and uploadMetadata.

And run below command:
```
node uploadMetadata
```

After completed this process our all nfts will be upload on pinata.

#### Note : Explaination of upload NFTs on pinata has been ended. Now, I am starting the next-step.

### Next-step is make scripts for set and get the data of smart-contract.

## Scripts

- First script those I was make, that name is getAdminMinting. Work of it's script is, it is check that adminMinting are active or not.

- Second script those I was make, that name is setAdminMinting. Work of it's script is, it is push those value, which I push in it's parameter, like (true or flase).

- Third script those I was make, that name is getAdminAddress. Work of it's script is, it is check that adminAddress are active or not.

- Fourth script those I was make, that name is setAdminAddress. Work of it's script is, it is push those address, which I push in it's parameter.

- Fifth script those I was make, that name is mint. Work of it's script is, it mint my nft on opensea-testnet.

#### End Explanation!

### Thanks For Reading this!!!
