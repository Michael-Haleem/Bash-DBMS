Simple Database Project
=======================

Overview
--------

This project is a simple database management system implemented using Bash. It allows you to create, list, drop, and connect to databases. Once connected to a database, you can manage tables and perform various operations on them.

Getting Started
---------------
## Cloning the Repository

clone this repository, use the following command:

`git clone https://github.com/Michael-Haleem/Bash-DBMS.git`

### Running the Project

To run the project, navigate to the project directory and execute the following command:

`./run.sh `

Features
--------

### Database Operations

*   **Create Database**
    
*   **List Databases**
    
*   **Drop Database**
    
*   **Connect to Database**
    

### Table Operations (after connecting to a database)

*   **Create Table**
    
*   **List Tables**
    
*   **Insert into Table**
    
*   **Select from Table**
    
    *   Select all
        
    *   Select specific columns
        
    *   Select based on a condition
        
*   **Update Table**
    
*   **Delete from Table**
    
*   **Drop Table**
    

### Navigation

*   Return to previous menu or exit
    
    *   Some menus require selecting the "exit" option from the list
        
    *   Others require typing 0 and pressing enter
        
    *   Some require typing exit and pressing enter
        

Data Constraints
----------------

*   **Primary Key**: Each table can have one primary key column, which must be unique and cannot be duplicated. The primary key can be an integer or a string.
    
*   **Naming**: Database names, table names, and column names must be strings and cannot contain numbers or special characters.