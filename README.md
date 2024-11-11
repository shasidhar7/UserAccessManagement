**User Access Management System**

--Overview--
The User Access Management System is a web application that allows employees, managers, and admins to manage access to various software applications within an organization. It is developed using Java Servlets, JSP, and MySQL, and managed using Maven.

--Features--
  User Registration: Employees can sign up to create an account.
  User Authentication: Login functionality for Employees, Managers, and Admins.
  Role-Based Access:
      Employee: Request access to software.
      Manager: View and handle access requests.
      Admin: Create and manage software applications.
  Access Request Handling: Employees can submit requests for software access, which Managers or Admins can approve or reject.
  
--Setup Instructions--
  Prerequisites
    Java Development Kit (JDK) - Version 8 or higher.
    Apache Tomcat - Version 9 or higher.
    MySQL Database - Version 5.7 or higher.
    Maven - For managing project dependencies.
    IDE: IntelliJ, Eclipse, or any IDE that supports Java development.

Step 1: Clone the Repository
    Clone the project from your version control system (e.g., GitHub, GitLab).

    git clone https://github.com/shasidhar7/UserAccessManagement.git
    cd UserAccessManagement

Step 2: Setup MySQL Database
  Create Database:
    CREATE DATABASE useraccess;
  Create Tables:
  
    Users Table:

      CREATE TABLE users (
        user_id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        role_id INT NOT NULL
      );
      
Software Table:

    CREATE TABLE software (
      software_id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      description TEXT,
      access_levels VARCHAR(50)
    );
    
Requests Table:

    CREATE TABLE requests (
      request_id INT AUTO_INCREMENT PRIMARY KEY,
      user_id INT,
      software_id INT,
      access_type VARCHAR(50),
      reason TEXT,
      status VARCHAR(20) DEFAULT 'Pending',
      FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
      FOREIGN KEY (software_id) REFERENCES software(software_id) ON DELETE CASCADE
    );
    
Step 3: Configure Database Connection
  Update the database connection details:

    private static final String URL = "jdbc:mysql://localhost:3306/useraccess";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

Step 4: Build the Project
    Use Maven to build the project:
      mvn clean install

Step 5: Deploy on Apache Tomcat
  Copy the generated .war file from the target directory to the webapps folder of your Apache Tomcat installation.
  Start the Apache Tomcat server using:
  
    ./bin/startup.sh  (Linux/macOS)
    ./bin/startup.bat (Windows)
  Access the application in your browser at:

    http://localhost:8080/UserAccessManagement
    
--Running the Application--
    Sign-Up: Go to the sign-up page to create a new employee account.
    Login: Use your credentials to log in and navigate to your dashboard based on your role.
    Access Requests: Employees can submit requests, and Managers/Admins can handle those requests.
    Software Management: Admins can add or edit software applications.

--Additional Notes--
  Session Management: Ensure sessions are properly handled to maintain user authentication and authorization.
  Security: Use hashing techniques (like BCrypt) for storing passwords securely.
  Error Handling: Implement proper error messages for a better user experience.

--Troubleshooting--
  404 Error: Ensure that all JSP files are correctly placed in the webapp folder.
  Database Connection Issues: Double-check the database URL, username, and password.
  Compilation Errors: Make sure all dependencies are correctly loaded using Maven.
