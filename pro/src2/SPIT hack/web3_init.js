if (typeof web3 !== "undefined") {
  console.warn("Using web3 detected from external source like Metamask")
  // If there is a web3 instance(in Mist/Metamask), then we use its provider to create our web3object
  window.web3 = new Web3(web3.currentProvider)
} else {
  console.warn("No web3 detected.")
  // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
  window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
}

console.log(web3.currentProvider);
    web3 = new Web3(web3.currentProvider);
    web3.currentProvider.enable();
    window.setTimeout(function(){
      console.log(web3.eth.accounts[0]);
      after_getting_account(web3.eth.accounts[0]);
},5000);

function after_getting_account(account){
  var CoursetroContract = web3.eth.contract([
  {
    "constant": false,
    "inputs": [
      {
        "name": "doc_id",
        "type": "address"
      },
      {
        "name": "doc_name",
        "type": "string"
      }
    ],
    "name": "add_new_doctor",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "patient_address",
        "type": "address"
      },
      {
        "name": "d_type",
        "type": "string"
      },
      {
        "name": "medicine_taking",
        "type": "string"
      },
      {
        "name": "symp1",
        "type": "string"
      },
      {
        "name": "symp2",
        "type": "string"
      },
      {
        "name": "symp3",
        "type": "string"
      },
      {
        "name": "ipfs_hashes",
        "type": "bytes32[4]"
      }
    ],
    "name": "add_new_case",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "company_address",
        "type": "address"
      },
      {
        "name": "company_name",
        "type": "string"
      },
      {
        "name": "domain",
        "type": "string"
      },
      {
        "name": "description",
        "type": "string"
      },
      {
        "name": "future_scope",
        "type": "string"
      }
    ],
    "name": "broadcast_research",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "patient_address",
        "type": "address"
      },
      {
        "name": "case_id",
        "type": "uint256"
      },
      {
        "name": "doc_id",
        "type": "address"
      }
    ],
    "name": "give_access_to_doctor",
    "outputs": [
      {
        "name": "test123",
        "type": "uint256"
      },
      {
        "name": "d_p",
        "type": "address"
      },
      {
        "name": "d_c",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "get_research_data",
    "outputs": [
      {
        "name": "company_name",
        "type": "bytes32[10]"
      },
      {
        "name": "domain",
        "type": "bytes32[10]"
      },
      {
        "name": "description",
        "type": "bytes32[10]"
      },
      {
        "name": "future_scope",
        "type": "bytes32[10]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "doctorid",
        "type": "address"
      }
    ],
    "name": "doctor_detail",
    "outputs": [
      {
        "name": "d_id",
        "type": "address"
      },
      {
        "name": "d_name",
        "type": "string"
      },
      {
        "name": "x",
        "type": "address"
      },
      {
        "name": "y",
        "type": "address"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "patient_address",
        "type": "address"
      }
    ],
    "name": "get_patient_records",
    "outputs": [
      {
        "name": "name",
        "type": "string"
      },
      {
        "name": "c_no",
        "type": "uint256"
      },
      {
        "name": "c_id",
        "type": "uint256[10]"
      },
      {
        "name": "d_type",
        "type": "bytes32[10]"
      },
      {
        "name": "m_take",
        "type": "bytes32[10]"
      },
      {
        "name": "sym1",
        "type": "bytes32[10]"
      },
      {
        "name": "sym2",
        "type": "bytes32[10]"
      },
      {
        "name": "sym3",
        "type": "bytes32[10]"
      },
      {
        "name": "case1_hashes",
        "type": "bytes32[4]"
      },
      {
        "name": "case2_hashes",
        "type": "bytes32[4]"
      },
      {
        "name": "case3_hashes",
        "type": "bytes32[4]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "patient_address",
        "type": "address"
      },
      {
        "name": "patient_name",
        "type": "string"
      },
      {
        "name": "contact_no",
        "type": "uint256"
      }
    ],
    "name": "add_new_patient",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "doc_id",
        "type": "address"
      }
    ],
    "name": "get_doctor_records",
    "outputs": [
      {
        "name": "t",
        "type": "uint256"
      },
      {
        "name": "p",
        "type": "address"
      },
      {
        "name": "c",
        "type": "uint256"
      },
      {
        "name": "names",
        "type": "bytes32[4]"
      },
      {
        "name": "contacts",
        "type": "uint256[1]"
      },
      {
        "name": "disease_types",
        "type": "bytes32[4]"
      },
      {
        "name": "medicines",
        "type": "bytes32[4]"
      },
      {
        "name": "case1_hashes",
        "type": "bytes32[4]"
      },
      {
        "name": "case2_hashes",
        "type": "bytes32[4]"
      },
      {
        "name": "case3_hashes",
        "type": "bytes32[4]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "source",
        "type": "string"
      }
    ],
    "name": "stringToBytes32",
    "outputs": [
      {
        "name": "result",
        "type": "bytes32"
      }
    ],
    "payable": false,
    "stateMutability": "pure",
    "type": "function"
  }
])

var Coursetro = CoursetroContract.at('0x2503b37e9316131044e544ac4d970b652b279073')