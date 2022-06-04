// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 <=0.9.0;

// Class Activity

contract Activity
{
    address private owner;
    bool private matching;

    mapping(address => bool) private user;
    

    constructor()
    {
        owner = msg.sender;
    }



    function setMatching(bool _match) public
    {
        require(msg.sender == owner, "You are not the owner");
        matching = _match;
    }



    event playerCreated(uint _id, string _name, address _address);
    event playerUpdated(uint _id, string _name, address _address);



    struct myPlayer
    {
        uint id;
        string Name;
        address Address;
        uint flag;
    }



    mapping(uint => myPlayer) private player;



    function approveUser(address _address, bool _status) public
    {
        require(msg.sender == owner, "You are not the owner");
        user[_address] = _status;
    }



    function createPlyer(uint _id, string memory _name, address _address) public
    {
        require(matching, "Matching is disabled, please come back latter");
        require(user[msg.sender], "You are not approved user");
        require(player[_id].flag !=1, "Already player exists by this id");

        player[_id] = myPlayer(_id, _name, _address, 1);
        emit playerCreated(_id, _name, _address);

    }




    function updatePlyer(uint _id, string memory _name, address _address) public
    {
        require(player[_id].flag !=0, "No player exists by this id, create player first");
        require(user[msg.sender], "You are not approved user");

        player[_id] = myPlayer(_id, _name, _address, 1);
        emit playerUpdated(_id, _name, _address);

    }



    function getPlayer(uint _id) public view returns(myPlayer memory)
    {
        return player[_id];
    }

}