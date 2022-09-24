const path = require("path");
const fs = require("fs");
const axios = require("axios");
const FormData = require("form-data");
require("dotenv").config();

const PinImageToIpfs = async (filePath, filename) => {
  const pinataEndpoint = "https://api.pinata.cloud/pinning/pinFileToIPFS";
  const pinataApiKey = "edc178df7a8c503ef278";
  const pinataApiSecret ="cac54ad6ab4af83bd8212f60535b25015fbdf6b2ad1967c3a179d3656942a8c0";

  const form_data = new FormData();
  try {
    form_data.append("file", fs.createReadStream(`${filePath}//${filename}`));

    const request = {
      method: "post",
      url: pinataEndpoint,
      maxContentLength: "Infinity",
      headers: {
        pinata_api_key: pinataApiKey,
        pinata_secret_api_key: pinataApiSecret,
        "Content-Type": `multipart/form-data; boundary=${form_data._boundary}`,
      },
      data: form_data,
    };

    const response = await axios(request);
    const imageHash = response.data.IpfsHash;
    console.log(imageHash);
    let str = filename;
    const Name = str.slice(0, -4);

    metaData = {
    //   description: "A nice monkey is looking cool and sketing on ice during snow fall.",
    //   image: "https://ipfs.io/ipfs/" + imageHash,
    //   name: `${Name}`,
    //   attributes: [
    //     {
    //         trait_type: "Personality",
    //         value: "Nice"
    //     },
    //     {
    //         trait_type: "Eye color",
    //         value: "Black & White"
    //     }
    // ]
    };

    const metadataJson = JSON.stringify(metaData);

    await fs.writeFile(
      path.join(__dirname, `../Metadata/${Name}.json`),
      metadataJson,
      "utf8",
      function (err) {
        if (err) {
          console.log("An error occured while writing JSON Object to File.");
          return console.log(err);
        } else {
          console.log("JSON file has been saved to " + `Metadata/${Name}`);
        }
      }
    );

    const getMetaDataJson = path.join(__dirname, `../Metadata/${Name}.json`);
    const form_meta_data = new FormData();
    try {
      form_meta_data.append("file", fs.createReadStream(getMetaDataJson));
      const request = {
        method: "post",
        url: pinataEndpoint,
        maxContentLength: "Infinity",
        headers: {
          pinata_api_key: pinataApiKey,
          pinata_secret_api_key: pinataApiSecret,
          "Content-Type": `multipart/form-data; boundary=${form_meta_data._boundary}`,
        },
        data: form_meta_data,
      };

      const response = await axios(request);
      console.log(response.data.IpfsHash);
    } catch (err) {
      console.log(err);
    }
  } catch (err) {
    console.log(err);
  }
};

module.exports = {
  PinImageToIpfs,
};