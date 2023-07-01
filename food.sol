// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FoodSafetyApp {
struct FoodItem {
string name;
uint256 expiryDate;
string storageTips;
string usageTips;
}
enum Category {
    Confectionary,
    Frozen,
    MeatAndVegetablesAndFruits
}

mapping(address => mapping(Category => FoodItem[])) private foodItems;

function addFoodItem(Category _category, string memory _name) public {
    uint256 expiryDate;
    string memory storageTips;
    string memory usageTips;
    
    // Calculate expiry date and generate storage/usage tips based on category
    if (_category == Category.Confectionary) {
        expiryDate = block.timestamp + 30 days;
        storageTips = "Store in a cool, dry place";
        usageTips = "Enjoy before expiry date";
    } else if (_category == Category.Frozen) {
        expiryDate = block.timestamp + 90 days;
        storageTips = "Keep frozen at -18 degree Celsius or lower";
        usageTips = "Cook before expiry date";
    } else if (_category == Category.MeatAndVegetablesAndFruits) {
        expiryDate = block.timestamp + 7 days;
        storageTips = "Store in the refrigerator";
        usageTips = "Cook or consume before expiry date";
    }
    
    FoodItem memory newFoodItem = FoodItem(_name, expiryDate, storageTips, usageTips);
    foodItems[msg.sender][_category].push(newFoodItem);
}

function getFoodItemExpiryDate(Category _category, uint256 _index) public view returns (uint256) {
    return foodItems[msg.sender][_category][_index].expiryDate;
}

function getFoodItemStorageTips(Category _category, uint256 _index) public view returns (string memory) {
    return foodItems[msg.sender][_category][_index].storageTips;
}

function getFoodItemUsageTips(Category _category, uint256 _index) public view returns (string memory) {
    return foodItems[msg.sender][_category][_index].usageTips;
}
}