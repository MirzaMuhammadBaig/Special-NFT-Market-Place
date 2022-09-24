const path = require("path");
const { PinImageToIpfs } = require("./pinataApi");
const NftsPath = path.join(__dirname, "../Nfts");
const fs = require("fs");
require("dotenv").config();

const PinToPinata = async () => {
  const Nfts = fs.readdirSync(NftsPath);

  // for (const nft of Nfts) {
  //   await PinImageToIpfs(NftsPath, nft);
  // }
};

PinToPinata();