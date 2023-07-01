// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodSafety {
    
    struct FoodItem {
        uint256 id;
        string name;
        string manufacturer;
        uint256 batchNumber;
        uint256 productionDate;
        uint256 expirationDate;
        address owner;
        bool isExpired;
    }

    mapping(uint256 => FoodItem) public foodItems;

    uint256 public foodItemCount;

    function createFoodItem(string memory _name, string memory _manufacturer, uint256 _batchNumber, uint256 _productionDate, uint256 _expirationDate) public {
        foodItemCount++;
        foodItems[foodItemCount] = FoodItem(foodItemCount, _name, _manufacturer, _batchNumber, _productionDate, _expirationDate, msg.sender, false);
    }

    function updateFoodItem(uint256 _id, uint256 _productionDate, uint256 _expirationDate) public {
        require(foodItems[_id].owner == msg.sender, "Only the owner of this food item can update it.");
        foodItems[_id].productionDate = _productionDate;
        foodItems[_id].expirationDate = _expirationDate;
    }

    function getFoodItem(uint256 _id) public view returns (string memory, string memory, uint256, uint256, uint256, address, bool) {
        return (foodItems[_id].name, foodItems[_id].manufacturer, foodItems[_id].batchNumber, foodItems[_id].productionDate, foodItems[_id].expirationDate, foodItems[_id].owner, foodItems[_id].isExpired);
    }

    function checkExpiration(uint256 _id) public {
        if (block.timestamp > foodItems[_id].expirationDate) {
            foodItems[_id].isExpired = true;
        }
    }
}
