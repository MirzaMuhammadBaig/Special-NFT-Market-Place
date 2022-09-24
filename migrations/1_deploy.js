const specialNftContract = artifacts.require('specialNftContract');

module.exports = async function (deployer) {
  await deployer.deploy(specialNftContract , 100 , 10 , 40 , 5 , true)
};