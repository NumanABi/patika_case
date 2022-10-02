// SPDX-License-Identifier: UNLICENSED
// www.patika.dev
pragma solidity ^0.8.0;

contract basicTODOList {

    // Structure of TODO list
    struct todoInfo {
        string reminderText;
        address remindTo;
        uint priority;
        bool isCompleted;
    }

    // array to store all TODO data
    todoInfo[] thingsToDo;

    // Create new TODO data
    function newTODO(string calldata textToRemind, uint priority) public {
        thingsToDo.push(todoInfo({
            reminderText: textToRemind,
            remindTo: msg.sender,
            priority: priority,
            isCompleted: false
        }));
    }

    // View a custom TODO data
    function viewTODO(uint key) public view returns(string memory, uint, bool) {
        return (thingsToDo[key].reminderText, thingsToDo[key].priority, thingsToDo[key].isCompleted);
    }

    // marking as completed/incompleted function
    function markAsCompleted(uint key) public {
        require(thingsToDo[key].remindTo == msg.sender, "This TODO does not belong to you.");
        require(key == returnTopPriorityTODO(), "You can not complete the less priority jobs before top priority one!");
        thingsToDo[key].isCompleted = true;
    }

    // Return top priority TODO data
    function returnTopPriorityTODO() public view returns(uint) {
        uint topPriority;
        uint topPriorityKey;
        for(uint i=0;i<thingsToDo.length;i++){
            if(thingsToDo[i].remindTo == msg.sender && !thingsToDo[i].isCompleted){
                if(thingsToDo[i].priority > topPriority){
                    topPriority = thingsToDo[i].priority;
                    topPriorityKey = i;
                }
            }
        }
    return topPriorityKey;
    }

}
