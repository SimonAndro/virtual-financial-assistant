## Personal Finance Monitor

    The financial monitor relies on the biweekly python package for the heavy-lifting, the system uses flask framework.

### How to install and run simply
    The system has been packaged in a virtual environment with all modules installed.
    - Simply create a mysql database with a name 'biweekly'
    - Activate the virtual enviroment
    ```
    .\venv\Scripts\activate #activate virtual environment
    ```
    - Run the simple_run.bat from the cmd. This file has the initialization and configuration already set up so you need not do anything more.
    - open browser and visit the url and port to which the flask server is listening.
    - Enjoy!!!

### Note:
    incase of incorrect database credentials, adjust this line in the simple_run.bat
    ```
    set DB_CONNSTRING=mysql+mysqlconnector://root@localhost:3306/biweekly
    ```
