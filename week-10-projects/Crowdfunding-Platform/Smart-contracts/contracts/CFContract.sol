// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Project {
    address private owner;
    string private title;
    string private description;
    bool private isActive;
    uint256 private target;
    string private preferredCurrency; // Set at creation time
    uint256 private totalRaised;
    uint256 private creationTimeStamp;

    struct Transaction {
        address contributor;
        uint256 amount;
        uint256 timestamp;
    }

    Transaction[] public transactions;

    event PaymentLogged(address indexed contributor, uint256 amount, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not project owner");
        _;
    }

    constructor(
        string memory _title,
        string memory _description,
        uint256 _target,
        string memory _preferredCurrency
    ) {
        owner = msg.sender;
        title = _title;
        description = _description;
        isActive = true;
        target = _target;
        preferredCurrency = _preferredCurrency;
        creationTimeStamp = block.timestamp;
    }

    function activate() external onlyOwner {
        isActive = true;
    }

    function deactivate() external onlyOwner{
        isActive = false;
    }

    // Contribute to the project (logs amount + timestamp)
    function logPayment(uint256 amount) external {
        require(isActive, "Project is not active");

        transactions.push(Transaction({
            contributor: msg.sender,
            amount: amount,
            timestamp: block.timestamp
        }));

        totalRaised += amount;

        emit PaymentLogged(msg.sender, amount, block.timestamp);
    }

    // Number of transactions
    function getTransactionCount() external view returns (uint256) {
        return transactions.length;
    }

    // View transaction details
    function getTransaction(uint256 index) external view returns (
        address contributor,
        uint256 amount,
        uint256 timestamp
    ) {
        Transaction memory txData = transactions[index];
        return (txData.contributor, txData.amount, txData.timestamp);
    }

    function getHighestContribution()external view returns(Transaction memory) {
        Transaction memory highestContribution;
         for (uint256 i = 0; i < transactions.length; i++) {
             Transaction memory txData = transactions[i];
            if(txData.amount > highestContribution.amount){
                highestContribution = txData;
            }
         }
         return highestContribution;
    }
    // Get basic project metadata
    function getProjectDetails() external view returns (
        address,
        string memory,
        string memory,
        uint256,
        uint256,
        string memory,
        bool,
        uint256
    ) {
        return (
            owner,
            title,
            description,
            target,
            totalRaised,
            preferredCurrency,
            isActive,
            (block.timestamp - creationTimeStamp)
        );
    }
}


//now, we create the CFContract

contract CFContract {
    address[] private projects;
    //projectCreators maps the creators address to an array of projects
    mapping(address => address[]) private projectCreators;
    address public creator;

    constructor(){
        creator = msg.sender;
    }

    event ProjectCreated(string indexed title , address indexed projectCreator, address indexed project);

    function createProject(string memory _title, string memory _description, uint256 _target, string memory _preferredCurrency) 
    external {
        Project p = new Project(_title, _description, _target, _preferredCurrency);
        projectCreators[msg.sender].push(address(p));
        projects.push(address(p));
        emit ProjectCreated(_title , msg.sender, address(p));
    }

    // getting an array of all the available projects
    function getAllProjects() external view returns (address[] memory) {
    return projects;
    }

    function getProjectsByCreator(address _creator) external view returns (address[] memory){
        return projectCreators[_creator];
    }

    function getProjectDetails(address projectAddress) 
    external 
    view 
    returns (
        address,
        string memory,
        string memory,
        uint256,
        uint256,
        string memory,
        bool,
        uint256
    ) 
    {
        return Project(projectAddress).getProjectDetails();
    }
   
    function logContribution(address projectAddress, uint256 amount) external {
    Project(projectAddress).logPayment(amount);
    }

    function getTransactionCount(address projectAddress) external view returns (uint256) {
    return Project(projectAddress).getTransactionCount();
    }

    function getTransaction(address projectAddress, uint256 index)
    external
    view
    returns (address contributor, uint256 amount, uint256 timestamp)
{
    return Project(projectAddress).getTransaction(index);
}

    
}