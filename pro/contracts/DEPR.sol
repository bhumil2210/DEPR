pragma solidity 0.5.2;
contract DEPR{
    
    mapping(string => address) log;
    mapping(address => string) u_type;
    
    struct access_given_cases{
        address p_address;
        uint c_id;
    }
    
    struct research{
        address company_address;
        string company_name;
        string domain;
        string description;
        string future_scope;
    }
    
    struct doctor{
        string username;
        bytes32 password;
        address doc_id;
        string doc_name;
        mapping(uint => access_given_cases) doc_cases;
        uint cases_given;
        //access_given_cases[] access_given_case;
    }
    
    // cases of a patient ( 1 patient => multiple cases) 
    struct patient_case{
        uint case_id;
        string symptom1;
        string symptom2;
        string symptom3;
        string disease_type;
        string medicines_taking;
        
        /* files related to a particular case is stored in ipfs and their hashes is 
         stored in this array*/
        bytes32[4] ipfs_file_hashes;
    }
    
    // patient records
    struct patient{
        string username;
        bytes32 password;
        string patient_name;
        uint contact_no;
        address patient_id;
        uint total_cases;
        mapping(uint => patient_case) cases2;
        //patient_case[] cases;
    }
    
    // constructor() public{
    //     doctor storage new_doctor;
    //     new_doctor.doc_id = address(msg.sender);
    //     new_doctor.doc_name = "ramesh";
        
    //     doctors[msg.sender] = new_doctor;
    //     access_given_cases memory a;
    //     a.p_address = msg.sender;
    //     a.c_id = 1;
    //     new_doctor.doc_cases[1] = a;
        
        
    // }
    
    
   mapping(address => patient) patients;
   mapping(address => doctor) doctors;
   
   function compareStringsbyBytes(string memory a, string memory b) public pure returns(bool){
       
       bytes memory a = bytes(a);
       bytes memory b = bytes(b);
      
        if(a.length != b.length) {
        return false;
    } else {
        for(uint i=0;i<a.length;i++){
            if(a[i]!=b[i])
            return false;
        }
    }
    return true;
    }
  
  
   function login_func(string memory username,bytes32 password,string memory user_type) public view returns(string memory val){
    
        address addr = log[username];
        string memory user_type_here = u_type[addr];
        
        if(compareStringsbyBytes(user_type_here,user_type)){
            val = "True";
        }
        else{
            val = "False";
        }
        
        
    
   }
   
   
   
   function get_patient_records(address patient_address) public view returns(string memory name , uint c_no,uint[10] memory c_id,
                                                                             bytes32[10] memory d_type,bytes32[10] memory m_take,
                                                                             bytes32[10] memory sym1,bytes32[10] memory sym2, bytes32[10] memory sym3,
                                                                             bytes32[4] memory case1_hashes,
                                                                             bytes32[4] memory case2_hashes,
                                                                             bytes32[4] memory case3_hashes ){
       patient storage patient_details = patients[patient_address];
       
       name = patient_details.patient_name;
       c_no = patient_details.contact_no;
       uint total = patient_details.total_cases;

       
       for(uint k=0;k<patient_details.total_cases;k++){
           
           c_id[k] = patient_details.cases2[k].case_id;
           d_type[k] = stringToBytes32(patient_details.cases2[k].disease_type);
           m_take[k] = stringToBytes32(patient_details.cases2[k].medicines_taking);
           sym1[k] = stringToBytes32(patient_details.cases2[k].symptom1);
           sym2[k] = stringToBytes32(patient_details.cases2[k].symptom2);
           sym3[k] = stringToBytes32(patient_details.cases2[k].symptom3);
           
           
        if(k==0){
            case1_hashes = patient_details.cases2[k].ipfs_file_hashes;
        }     
        if(k==1){
            case2_hashes = patient_details.cases2[k].ipfs_file_hashes;
        }
        if(k==2){
            case3_hashes = patient_details.cases2[k].ipfs_file_hashes;
        }
           
       }
       

       
       
       
       /* ideally should return all cases of a patient but due to solidity limitations
          that is can't return an array of any type nor struct so right now i am sending only ipfs 
          hash of first file of case that will be recognized by case id given by user */
          
       //file_hashes = patient_details.cases[case_id].ipfs_file_hashes[0];
       
   }
   

    function add_new_case(address patient_address,string memory d_type,string memory medicine_taking,string memory symp1,string memory symp2,string memory symp3,bytes32[4] memory ipfs_hashes) public{
        
        patient storage p = patients[patient_address];
        uint id = p.total_cases;
        
        
        patient_case memory new_case;
        new_case.case_id = id+1;
        new_case.disease_type = d_type;
        new_case.medicines_taking = medicine_taking;
        new_case.symptom1 = symp1;
        new_case.symptom2 = symp2;
        new_case.symptom3 = symp3;
        new_case.ipfs_file_hashes = ipfs_hashes;
        p.cases2[id+1] = new_case;
        p.total_cases+=1;
    
    }
    
    function add_new_patient(string memory username,bytes32 passwd,address patient_address,string memory patient_name,uint contact_no) public returns ( address pt_address){
        patient memory new_patient;
        new_patient.username = username;
        new_patient.password = passwd;
        new_patient.patient_name = patient_name;
        new_patient.contact_no = contact_no;
        new_patient.patient_id = patient_address;
        u_type[patient_address] = 'patient';
        log[username] = patient_address;
        new_patient.total_cases = 0;
        pt_address = patient_address;
    
        patients[patient_address] = new_patient;
        
        return pt_address;
    }
    
    function give_access_to_doctor(address patient_address, uint case_id, address doc_id) public returns(uint test123,address d_p,uint d_c) {

        doctor storage d = doctors[doc_id];
        uint id = d.cases_given;
        access_given_cases memory a;
        a.p_address = patient_address;
        a.c_id = case_id;
        d.doc_cases[id] = a;
        d.cases_given+=1;
        test123 = d.cases_given;
        d_p = d.doc_cases[id+1].p_address;
        d_c = d.doc_cases[id+1].c_id;
    
  }
  
    function doctor_detail(address doctorid) public view returns(address d_id,string memory d_name,address x,address y) {
        doctor storage d = doctors[doctorid];
        d_id = d.doc_id;
        d_name = d.doc_name;
        x = d.doc_cases[0].p_address;
        y = d.doc_cases[1].p_address;
    }
    
    function add_new_doctor(string memory username,bytes32 passwd,address doc_id,string memory doc_name) public {
        doctor memory new_doctor;
        new_doctor.username = username;
        new_doctor.password = passwd;
        new_doctor.doc_id = doc_id;
        log[username] = doc_id;
        u_type[doc_id] = "doctor";
        new_doctor.doc_name = doc_name;
        new_doctor.cases_given = 0;
        
        doctors[doc_id] = new_doctor;
    }
    
    // function get_doctor_details(address doc_id) public view returns(address ars,uint e){
        
    //     doctor memory r = doctors[doc_id];
    //     for(uint u=1;u<2;u++){
    //         address ars = r.doc_cases[u].p_address;
    //         uint e = r.doc_cases[u].c_id;
    //     }
        
    // }
    
    // function put_doctor_data(){
    //     doctor memory doce;
        
        
    // }
    
    function get_doctor_records(address doc_id) public view returns(uint t,bytes32[4] memory names,uint[1] memory contacts,
                                                                    bytes32[4] memory disease_types,bytes32[4] memory medicines,
                                                                    bytes32[4] memory case1_hashes,bytes32[4] memory case2_hashes,
                                                                    bytes32[4] memory case3_hashes) {
        doctor storage req_doc = doctors[doc_id];
        t = req_doc.cases_given;
        // address p = req_doc.doc_cases[1].p_address;
        // uint c = req_doc.doc_cases[1].c_id; 
        
        
        
        for(uint i=1;i<2;i++){
            address p = req_doc.doc_cases[i].p_address;
            uint c = req_doc.doc_cases[i].c_id;
            
            bytes32 name = stringToBytes32(patients[p].patient_name);
            uint contact = patients[p].contact_no;
            bytes32 disease_type = stringToBytes32(patients[p].cases2[c].disease_type);
            bytes32 medicine = stringToBytes32(patients[p].cases2[c].medicines_taking);
            names[i] = name;
            contacts[i] = contact;
            disease_types[i] = disease_type;
            medicines[i] = medicine;
       
            if(i==0){
                case1_hashes = patients[p].cases2[c].ipfs_file_hashes;
            }     
            if(i==1){
                case2_hashes = patients[p].cases2[c].ipfs_file_hashes;
            }
            if(i==2){
                case3_hashes = patients[p].cases2[c].ipfs_file_hashes;
            }
        }
       
        
    }


    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }

    }
    
    research[] researches_to_invest;
    
    function broadcast_research(address company_address,string memory company_name,string memory domain,string memory description,string memory future_scope) public {
        research memory r = research(company_address,company_name,domain,description,future_scope);
        researches_to_invest.push(r);
    }
    
    function get_research_data() public view returns(bytes32[10] memory company_name,
                                                bytes32[10] memory domain,
                                                bytes32[10] memory description,
                                                bytes32[10] memory future_scope) {
        
        for(uint j=0;j<researches_to_invest.length;j++){
            company_name[j] = stringToBytes32(researches_to_invest[j].company_name);
            domain[j] = stringToBytes32(researches_to_invest[j].domain);
            description[j] = stringToBytes32(researches_to_invest[j].description);
            future_scope[j] = stringToBytes32(researches_to_invest[j].future_scope);
        }   
    }
    
}
