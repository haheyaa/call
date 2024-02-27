// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract original{
    function add(uint a,uint b)public pure returns(uint){
        return a+b;
    }
    function power(uint a,uint b)public pure returns(uint){
        return add(a,b)*a**b;
    }
    function getData()public pure returns(uint){
        return 44;
    }
}
contract call{
    function call1(address _address,uint a, uint b)public pure returns (uint){
        return original(_address).add(a,b);
    }
    original copycontract=new original();
    function call2(uint a, uint b)public view returns(uint){
        return copycontract.add(a,b);
    }
    function call3(address _address,uint a,uint b)public  returns(uint){
        (bool success,bytes memory data)=_address.call{value:0}(abi.encodeWithSignature("add(uint256,uint256)", a,b));// we could eleminate value 
        require (success,"call is not done properly");
        return abi.decode(data,(uint256));
    }
}  
contract MostcommonCall{
    original copycontract;
    constructor(address _address){
        copycontract=original(_address);
    }
    function call4(uint a,uint b)public view returns(uint){
        return copycontract.add(a,b);
    }
}     

contract child is original{
    function call5(uint a, uint b)public pure returns(uint){
        return add(a,b);
    }
}
contract StaticCall{
    function callGetData(address _address)public view returns(uint){
        (bool success, bytes memory data)=_address.staticcall(abi.encodeWithSignature("getData()"));
        require(success,"failed");
        return abi.decode(data,(uint256));
    }
}