pragma solidity >=0.4.22 <0.6.0;

contract BeastsStore {
    
    
    struct BEASTS{
        uint id;
        string name;
        uint256 price;
        address owner;
        string image;
        bool have;
    }
    
    uint bid = 0;
    
    uint[] Beasts;
    mapping (uint => BEASTS) beasts;
    event ErrorLog(address indexed buyer,string text);
    event Sold(address indexed buyer,uint id);

    
    function add(string memory name,uint256 price ,string memory image) public returns(uint id){
        uint Id = bid++;
        
        beasts[Id] = BEASTS(Id,name, price, address(0x0000000000000000000000000000000000000000), image,false);
        Beasts.push(Id);
        
        return Id;
    }
    
    function sell(uint id) public payable returns(bool){
        if(beasts[id].have){
            emit ErrorLog(msg.sender,"Character is have owner!!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        beasts[id].owner = msg.sender;
        beasts[id].have = true;
        emit Sold(msg.sender,id);
        
        return true;
    }
    
    function getById(uint Id) public view returns(uint,string memory,uint256,address,string memory,bool){
        return (beasts[Id].id,beasts[Id].name,beasts[Id].price,beasts[Id].owner,beasts[Id].image,beasts[Id].have);
    }
    
    function getAll() public view returns(uint[] memory){
        return Beasts;
    }
    
}