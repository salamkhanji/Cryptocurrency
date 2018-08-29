// your code here

const Web3 = require('web3');
const HDWalletProvider = require('truffle-hdwallet-provider');

const { interface, bytecode } = require('./compile');


const provider = new HDWalletProvider(
  'viable cannon prize false mistake risk actual blast unable crunch pause stuff', 'https://rinkeby.infura.io/ZwOADuj2FQpu9C5RJ7kp');
const web3 = new  Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0]); // address of the deployer

  const result = await new web3.eth.Contract(JSON.parse(interface))
 .deploy({ data: '0x' + bytecode,arguments:['100', 'SToken','2','S','1']})
 .send({ gas: '1000000', from: accounts[0]});
 
  console.log('Contract deployed to', result.options.address); //address of the deployed contract
};
deploy();
