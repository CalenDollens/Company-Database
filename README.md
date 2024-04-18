Company Database

This repository contains four programs that achieve the same functionality using different programming languages: C++, Ruby, Lua, and BBC Basic. These programs are designed to manage a company's data, including employees and sales, and save this data to files for future use. Each program has been implemented according to the provided specifications.

1. It prompts for the name of a company.
2. It loads the company's data from the file "name.dat" (e.g., "acme.dat").
3. It presents a menu to:
	View/Add Employees
	View/Add Sales and Customers
	Exit
4. Upon exit, it saves the company database to the specified file.

Design:
The program uses object oriented programming principles and procedural programming in the absence of classes or objects. It uses the following UML design:


File Format
The file format is line-oriented, containing:

Number of Employees
Employee Records
Number of Customers
Customer Records
Employee records follow the format:

Name
Email
Phone
Salary
Customer records follow the format:

Name
Email
Phone
Number of Purchases
Purchases (Item, Quantity, Cost)

Sample Run
A sample run of the c++ program is shown below:

$ make clean
$ make
$ ./companydb
Company Name: acme
    MAIN MENU
1.) Employees
2.) Sales
3.) Quit

Choice? 1
Wile E. Coyote <wcoyote@acme.com>  Phone: 555-1234 Salary: $60000.00
Road Runner <rrunner@acme.com>  Phone: 555-1122 Salary: $90000.00
(A)dd Employee or (M)ain Menu? A
Name: Elmer Fudd
Email: efudd@acme.com
Phone: 555-5390
Salary: 65000.00
Wile E. Coyote <wcoyote@acme.com>  Phone: 555-1234 Salary: $60000.00
Road Runner <rrunner@acme.com>  Phone: 555-1122 Salary: $90000.00
Elmer Fudd <efudd@acme.com>  Phone: 555-5390 Salary: $65000.00
(A)dd Employee or (M)ain Menu? M
...


The Ruby, Lua, and BBC Basic programs can be found in their respective directories within this repository. These programs follow the same specifications as the C++ program but are implemented in their respective languages.
