// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;


/* 
* @title: Subnet Masking
* @author: Tianchan Dong
* @notice: This contract illustrate how IP addresses are distributed and calculated
* @notice: This contract has no sanity checks! Only use numbers provided in constructor
*/ 

contract Masking{

    // Return Variables
    string public Country;
    string public ISP;
    string public Institute;
    string public Device;

    // Maps of IP interpretation
    mapping(uint => string) public Countries;
    mapping(uint => string) public ISPs;
    mapping(uint => string) public Institutions;
    mapping(uint => string) public Devices;

    constructor() {
        Countries[34] = "Botswana";
        Countries[58] = "Egypt";
        Countries[125] = "Brazil";
        Countries[148] = "USA";
        Countries[152] = "France";
        Countries[196] = "Singapore";
        ISPs[20] = "Orange";
        ISPs[47] = "Telkom";
        ISPs[139] = "b = byteVodafone";
        Institutions[89] = "University";
        Institutions[167] = "Government";
        Institutions[236] = "HomeNet";
        Devices[13] = "iOS";
        Devices[124] = "Windows";
        Devices[87] = "Android";
        Devices[179] = "Tesla ECU";
    }

    function IP(string memory input) public {
        uint binary_IP = 0;
        bytes memory bytes_IP = bytes(input);
        // Convert string IP to binary number
        for (uint i = 0; i < bytes_IP.length; i++) {
        // If the character is '1', set the corresponding bit in the uint
        if (bytes_IP[i] == "1") {
            // We shift '1' left based on its position from the right
            binary_IP |= (uint256(1) << (bytes_IP.length - 1 - i));
        }
    }


        //  dividing into 4 segments and masking 
        uint IP_country = (binary_IP >> 24) & 0xFF;
        uint IP_ISP = (binary_IP >> 16) & 0xFF;
        uint IP_Institution = (binary_IP >> 8) & 0xFF;
        uint IP_Device = binary_IP & 0xFF;
        //  mapping
        Country = Countries[IP_country];
        ISP = ISPs[IP_ISP];
        Institute = Institutions[IP_Institution];
        Device = Devices[IP_Device];

    }
}