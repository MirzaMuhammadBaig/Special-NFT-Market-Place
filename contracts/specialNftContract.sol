// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
 
/**
 * @dev Implementation of https://eips.ethereum.org/EIPS/eip-721 Non-Fungible Token Standard, including
 * ERC721, ERC721Enumerable , ERC721URIStorage , Ownable
 */
 
contract specialNftContract is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
   
    uint public MaxSupply;
    uint public RemainingMaxSupply;
    uint CirculatingSupply;
    uint public PerWalletLimit;
    uint public AdminLimit;
    uint DoneNFTAdminLimit;
    uint public WhitelistLimit;
    uint DoneNFTWhitelistLimit;
    uint public PublicLimit;
    uint DoneNFTPublicLimit;
    bool public PublicSales ;
    bool public AdminMinting ;
    bool public WhiteListMinting ;
    bool public MintingStatus;
    bool public ForAllFunctions = true;
    string public BaseURI;
 
    struct saveNFTinfo{
        string Name;
        string MetaDataHash;
    }
 
    mapping (uint => saveNFTinfo) public storeNFTInfo;
    mapping (address => bool) public CheckAdminAddress;
    mapping (address => bool) public CheckWhitelistAddress;
    mapping (address => uint) public CheckNftsOnPerWalletAddress;
 
    error InvalidMetadataHash();
    error InvalidTokenURI();
 
    event SetBaseURI(
        string baseURI,
        address addedBy
    );
 
    event AddedAdminAdddress(
        address whitelistedAddress,
        address updatedBy
    );
 
    event AddedWhitelistAddress(
        address whitelistedAddress,
        address updatedBy
    );
 
 
    event NftMinted(
        address Minter,
        uint NftId,
        string metadataHash
    );
 
    constructor(uint256 _MaxSupply, uint256 _AdminLimit, uint256 _WhitelistLimit, uint256 _PerWalletLimit , bool mintingStatus) ERC721( "IEC-Token", "IET") {
        MaxSupply = _MaxSupply;
        AdminLimit = _AdminLimit;
        WhitelistLimit = _WhitelistLimit;
        PerWalletLimit = _PerWalletLimit;
        PublicLimit = MaxSupply - AdminLimit - WhitelistLimit;
        MintingStatus = mintingStatus;
        BaseURI = "https://gateway.pinata.cloud/ipfs/";
 
        emit SetBaseURI(BaseURI, msg.sender);
 
    }
 
    /**
     * @dev updateBaseURi is used to update the baseUri of Nft.
     * Requirement:
     * - This function can only called by whitelist address of the contract
     * @param _BaseURI - BaseURI
    */
 
    function updateBaseURi(string memory _BaseURI) public {
        require(ForAllFunctions == true,"Owner have stoped this function for some reason. It will be open later.");
        require(CheckAdminAddress[msg.sender] == true, "Only Admins Can Set BaseURI");
        BaseURI = _BaseURI;
 
        emit SetBaseURI(BaseURI, msg.sender);
    }
 
    /**
     * @dev ActiveAdminAddress is used to Admin & whitelsit account.
     * Requirement:
     * - This function can only called by owner of the contract
     * @param _Address - AdminAccount to be add
     * @param _Address - WhitelistAccount to be remove
    */
 
    function ActiveAdminAddress(address _Address) public onlyOwner{
        require(CheckAdminAddress[_Address] != true,"This address has already been declared as true");
        require(owner() != _Address ,"Owner can't active our address");
        CheckAdminAddress[_Address] = true;
        CheckWhitelistAddress[_Address] = false;
 
        emit AddedAdminAdddress(_Address, msg.sender);  
    }
 
    /**
     * @dev InactiveAdminAddress is used to whitelsit admin account.
     * Requirement:
     * - This function can only called by owner of the contract
     * @param _Address - AdminAccount to be remove
    */
 
    function InactiveAdminAddress(address _Address) public onlyOwner{
        require(CheckAdminAddress[_Address] != false,"This address has already been declared as false");
        CheckAdminAddress[_Address] = false;
 
 
    }
 
    /**
     * @dev ActiveWhiteListAddress is used to Admin & whitelsit account.
     * Requirement:
     * - This function can only called by owner of the contract
     * @param _Address - WhitelistAccount to be add
     * @param _Address - AdminAccount to be remove
    */
 
    function ActiveWhiteListAddress(address _Address) public onlyOwner{
        require(CheckWhitelistAddress[_Address] != true,"This address has already been declared as true");
        require(owner() != _Address ,"Owner can't active our address");
        CheckWhitelistAddress[_Address] = true;
        CheckAdminAddress[_Address] = false;
 
        emit AddedWhitelistAddress(_Address, msg.sender);  
       
    }
 
    /**
     * @dev InactiveWhiteListAddress is used to whitelsit admin account.
     * Requirement:
     * - This function can only called by owner of the contract
     * @param _Address - Whitelist-Account to be remove
    */
 
    function InactiveWhiteListAddress(address _Address) public onlyOwner{
        require(CheckWhitelistAddress[_Address] != false,"This address has already been declared as false");
        CheckWhitelistAddress[_Address] = false;
 
    }
 
    /**
     * @dev ActiveAdminMinting is used to true Admin-Minting, false whitelsit-Minting & false Public-Sales.
     * Requirement:
     * - This function can only called by owner of the contract
    */
 
    function ActiveAdminMinting() public onlyOwner{
        require(AdminMinting != true,"AdminMinting has already been true");
        PublicSales = false;
        WhiteListMinting = false;
        AdminMinting = true;
    }
 
    /**
     * @dev ActiveWhiteListMinting is used to false Admin-Minting, true whitelsit-Minting & false Public-Sales.
     * Requirement:
     * - This function can only called by owner of the contract
    */
 
    function ActiveWhiteListMinting() public onlyOwner{
        require(WhiteListMinting != true,"Public Sale has already been true");
        PublicSales = false;
        AdminMinting = false;
        WhiteListMinting = true;
    }
 
    /**
     * @dev ActivePublicSales is used to false Admin-Minting, false whitelsit-Minting & true Public-Sales.
     * @dev ActivePublicSales is used to set public limit.
     * Requirement:
     * - This function can only called by owner of the contract
    */
 
    function ActivePublicSales() public onlyOwner{
        require(PublicSales != true,"Public Sale has already been true");
        AdminMinting = false;
        WhiteListMinting = false;
        PublicSales = true;
        WhitelistLimit = WhitelistLimit -= DoneNFTWhitelistLimit;
        PublicLimit = WhitelistLimit += PublicLimit;
        WhitelistLimit = WhitelistLimit -= WhitelistLimit;
    }
 
    /**
     * @dev UnpausedMintingStatus is used to active mintng status.
     * Requirement:
     * - This function can only called by owner of the Contract
    */
 
    function UnpausedMintingStatus() public onlyOwner{
        require(MintingStatus != true,"Minting status has already declared as false");
        MintingStatus = true;
 
    }
 
    /**
     * @dev UnpausedMintingStatus is used to stop mintng status.
     * Requirement:
     * - This function can only called by owner of the Contract
    */
 
    function PausedMintingStatus() public  onlyOwner{
        require(MintingStatus != false,"Minting status has already declared as false");
        MintingStatus = false;
 
    }
 
    /**
     * @dev UnpausedMintingStatus is used to active all functions.
     * Requirement:
     * - This function can only called by owner of the Contract
    */
 
    function UnpausedAllFunctions() public onlyOwner{
        ForAllFunctions = true;
    }
 
    /**
     * @dev UnpausedMintingStatus is used to stop all functions.
     * Requirement:
     * - This function can only called by owner of the Contract
    */
 
    function PausedAllFunctions() public  onlyOwner{
        ForAllFunctions = false;
    }
 
    /**
     * @dev adminMinting is used to create a new nft from admin address.
     * Requirement:    
     * @param tokenId - nft tokenId
     * @param name - nft name
     * @param metaDataHash - nft metaDataHash
    */
 
    function adminMinting(uint256 tokenId,  string memory name, string memory metaDataHash) public {
        require(ForAllFunctions == true,"Owner have stoped this function for some reason. It will be open later.");
        require(MintingStatus == true, "Minting Function is not working yet, try later. ");
        require(AdminMinting == true , "Admin Minting Is not active now");
        require(tokenId != 0,"You can't put 0 for tokenId");
        if(AdminMinting == true){
            require(CheckAdminAddress[msg.sender] == true , "Your address is not allow for mint as admin");
        }
 
 
        if(CheckAdminAddress[msg.sender] == true ){
            CirculatingSupply++;
            DoneNFTAdminLimit++;
            CheckNftsOnPerWalletAddress[msg.sender]++;
            RemainingMaxSupply = MaxSupply - CirculatingSupply;
            require(RemainingMaxSupply <= MaxSupply, "Nfts has been null");
            require(DoneNFTAdminLimit <= AdminLimit , "Admin limit has been null");
            require(CheckNftsOnPerWalletAddress[msg.sender] <= PerWalletLimit, "Your Wallet Limit Has Been Full");
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidTokenURI();
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidMetadataHash();
        }
 
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, metaDataHash);
        storeNFTInfo[tokenId] = saveNFTinfo(name, metaDataHash);
 
        emit NftMinted(msg.sender, tokenId,metaDataHash);
    }
 
    /**
     * @dev whitelistMinting is used to create a new nft from whitelist address.
     * Requirement:    
     * @param tokenId - nft tokenId
     * @param name - nft name
     * @param metaDataHash - nft metaDataHash
    */
 
    function whitelistMinting( uint256 tokenId, string memory name, string memory metaDataHash) public {
        require(ForAllFunctions == true,"Owner have stoped this function for some reason. It will be open later.");
        require(MintingStatus == true, "Minting Function is not working yet, try later. ");
        require(WhiteListMinting == true , "Whitelisted Minting Is not active now");
        require(tokenId != 0,"You can't put 0 for tokenId");
        if(WhiteListMinting == true){
            require(CheckWhitelistAddress[msg.sender] == true , "Your address is not allow for mint as whitelisted");
        }
 
        require(RemainingMaxSupply <= MaxSupply, "Nfts has been null");
 
        if(CheckWhitelistAddress[msg.sender] == true ){
            CirculatingSupply++;
            DoneNFTWhitelistLimit++;
            CheckNftsOnPerWalletAddress[msg.sender]++;
            RemainingMaxSupply = MaxSupply - CirculatingSupply;
            require(CheckNftsOnPerWalletAddress[msg.sender] <= PerWalletLimit, "Your Wallet Limit Has Been Full");
            require(DoneNFTWhitelistLimit <= WhitelistLimit , "Admin limit has been null");
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidTokenURI();
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidMetadataHash();
        }
 
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, metaDataHash);
        storeNFTInfo[tokenId] = saveNFTinfo(name, metaDataHash);
 
        emit NftMinted(msg.sender, tokenId, metaDataHash);
 
    }
 
    /**
     * @dev publicMinting is used to create a new nft from public address.
     * Requirement:    
     * @param tokenId - nft tokenId
     * @param name - nft name
     * @param metaDataHash - nft metaDataHash
    */
   
    function publicMinting( uint256 tokenId, string memory name, string memory metaDataHash) public {
        require(ForAllFunctions == true,"Owner have stoped this function for some reason. It will be open later.");
        require(MintingStatus == true, "Minting Function is not working yet, try later. ");
        require(PublicSales == true , "Public Minting Is not active now");
        require(RemainingMaxSupply <= MaxSupply, "Nfts has been null");
        require(tokenId != 0,"You can't put 0 for tokenId");
        if(PublicSales == true ){
            CirculatingSupply++;
            DoneNFTPublicLimit++;
            CheckNftsOnPerWalletAddress[msg.sender]++;
            RemainingMaxSupply = MaxSupply - CirculatingSupply;
            require(CheckNftsOnPerWalletAddress[msg.sender] <= PerWalletLimit, "Your Wallet Limit Has Been Full");
            require(DoneNFTPublicLimit <= PublicLimit , "Public Minting limit has been null");
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidTokenURI();
        }
 
        if (bytes(metaDataHash).length != 46) {
            revert InvalidMetadataHash();
        }
 
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, metaDataHash);
        storeNFTInfo[tokenId] = saveNFTinfo(name, metaDataHash);
 
        emit NftMinted(msg.sender, tokenId,  metaDataHash);
 
    }
 
    /**
     * @dev Hook that is called before any (single) token transfer. This includes minting and burning.
     * See {_beforeConsecutiveTokenTransfer}.
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     * - When `to` is zero, ``from``'s `tokenId` will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn
    */
 
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
 
    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     * This is an internal function that does not check if the sender is authorized to operate on the token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
 
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }
 
    /**
     * @dev tokenURI is used to get tokenURI link.
     *
     * @param tokenId - ID of nft
     *
     * @return string .
     */
 
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        require(ForAllFunctions == true,"Owner have stoped this function for some reason. It will be open later.");
        return string(abi.encodePacked(BaseURI, storeNFTInfo[tokenId].MetaDataHash));
    }
 
 
 
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
 
 

