# ERC721 Based Project

### 1. In this contract, I have created three users:

##### Admin/Platform user,

##### Whitelisted user,

##### Public user.




### 2. I HAVE SET LIMITATION Of THESE USERS:

We have reserved a limit for each Admin, Whitelist user, and public. 1 address can mint up to 5 NFTs. If an address have minted 5 nft, then it can't mint more nft.

First I have set Max-NFT Minting Limit,

then admin/platform users minting limit,

then Whitelisted users Minting limit,

then Public users Minting limit.      
            

### 3. MINTINGS

##### ADMIN-PLATFORM USERS MINTING: 

Only Admin/Platform users allow to mint the NFT, when admin-minting wil be active.

If the Admin/Platform User's Minting limit is reached then Admin/Platform users cannot mint the NFTs.


##### WHITELISTED-USERS MINTING: 

Only Whitelisted users allow to mint the NFT, when Whitelisted-minting wil be active.

If the Whitelisted User's Minting limit is reached then Whitelisted users cannot mint the NFTs.



##### PUBLIC-USERS MINTING:

Only Public users allow to mint the NFT, when Public-minting wil be active.

If the Public User's Minting limit is reached then Public users cannot mint the NFTs.


### 4. OTHER CHECKS:

All contract functions can be paused by contract owner.   

Contract have a default base URI function. It can be set from admin/platform address.

Contract have a pause/un-pause minting feature. Minting status can be changed by the owner of the contract.
 
Any user/address can be mint as public. But in whitelist minting only whiteisted users can mint and same as with admin users.

Admins cannot mint NFTs if the admin is paused.

Whitelisted cannot mint NFTs if the Whitelist is paused.

Public users cannot mint NFTs if public sales are not active.  
