// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MarketPlace {
    address owner;
    uint256 public balance;
    uint itemCount;
    

    struct Items {
        string itemName;
        string itemDescription;
        uint256 id;
        uint256 itemPrice;
        uint256 quantity;
        // address owner;
    }
    struct Seller {
        address owner;
        string name;
        string shopAddress;
    }

    uint BalanceCount;
    struct Buyer {
        string BuyerName;
    }

    event ItemAdded();
    event ItemPurchased();

    mapping(uint256  => Items) items;
    mapping(address owner => Seller) seller;

    event ItemsPublished();
    event ItemsBought();

    function ListItems(string memory _itemName, string memory _itemDescription, uint256 _itemPrice, uint256 _quantity) external {
        if(msg.sender == address(0)) revert("cant be address zero value");
        // if(msg.sender != owner) revert("Only owner can perform action");
        itemCount++;
        Items storage it = items[itemCount];
        it.itemName=_itemName;
        it.itemDescription=_itemDescription;
        it.itemPrice=_itemPrice;
        it.quantity= _quantity;
        it.id = itemCount; 

        emit ItemsPublished();       

    }

    function purchaseItem( uint256 _id, uint _quantity) external payable {
          if(items[_id].id ==0) revert("Invalid Item");
        uint totalCost = items[_id].itemPrice * _quantity;
      
        require(msg.value >= totalCost, "Not enough");
        if (_quantity > items[_id].quantity) revert("Out of stock");
        require(msg.sender != address(0), "Address zero detected");
        
        // (bool sent, ) = address(this).call{value: totalCost} ("");
        balance += totalCost;
        items[_id].quantity -= _quantity;
        emit ItemPurchased();
        
        // items[_id].itemPrice = _quantity * msg.value;
    }

    

    function getItems(uint _id) external view returns (uint){
        return items[_id].quantity;

    }



}