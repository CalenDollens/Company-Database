#include <iostream>
#include <fstream>
#include <string>
#include "person.h"
#include "purchase.h"
#include "employee.h"
#include "customer.h"
#include "company.h"
#include <iomanip>

int main() {
    std::string companyName;
    std::cout << "Company Name: ";
    std::cin >> companyName;

    // Load company data from specified company file
    std::ifstream inputFile(companyName + ".dat");
    Company company(companyName);

    if (!inputFile.is_open()) {
        // If the input file doesn't exist, create a new one
        std::ofstream newFile(companyName + ".dat");
        if (newFile.is_open()) {
            std::cerr << "New data file created: " << companyName << ".dat" << std::endl;
            // default data for company
            int numEmployees = 0;
            newFile << numEmployees << std::endl;
        } else {
            std::cerr << "Error: Unable to create new data file." << std::endl;
            return 1; // Exit the program with an error message
        }
    } else {
        // Read data from the existing input file
        int numEmployees;
        inputFile >> numEmployees;
        inputFile.ignore();
        for (int i = 0; i < numEmployees; ++i) {
            std::string name, email, phone;
            double salary;
            inputFile >> std::ws; // Discard leading whitespace
            std::getline(inputFile, name); // read entire line for name, email, phone
            std::getline(inputFile, email);
            std::getline(inputFile, phone);
            inputFile >> salary;
            Employee employee(name, email, phone, salary);
            company.addEmployee(employee);
        }

        // Read in the customers to company
        int numCustomers;
        inputFile >> numCustomers;
        inputFile.ignore();

        inputFile >> std::ws;

        for (int i = 0; i < numCustomers; ++i) {
            std::string name, email, phone;
            std::getline(inputFile, name); // Read entire line to get name, email, and phone
            std::getline(inputFile, email); 
            std::getline(inputFile, phone); 

            Customer customer(name, email, phone); // Create a customer object

            int numPurchases;
            inputFile >> numPurchases; // Read the number of purchases for this customer
            inputFile.ignore(); 

            inputFile >> std::ws;

            for (int j = 0; j < numPurchases; ++j) {
                std::string itemName;
                int quantity;
                double cost;

                std::getline(inputFile, itemName); // Read item name
                inputFile >> quantity >> cost; // Read quantity and cost from file

                inputFile.ignore();

                // Add the purchase to the customer
                Purchase purchase(itemName, quantity, cost);
                customer.addPurchase(purchase);
            }

            // Add the customer to the company
            company.addCustomer(customer);
        }
        
    }
     /*// Print details of all customers
    auto customerBegin = company.customerBegin();
    auto customerEnd = company.customerEnd();
    std::cout << "Customers read from file:\n";
    for (auto it = customerBegin; it != customerEnd; ++it) {
        std::cout << "Name: " << it->name() << std::endl;
        std::cout << "Email: " << it->email() << std::endl;
        std::cout << "Phone: " << it->phone() << std::endl;
        // Print purchase details if needed
        // for (const auto& purchase : it->getPurchases()) {
        //     std::cout << "Item: " << purchase.getItem() << ", Quantity: " << purchase.getQuantity() << ", Cost: " << purchase.getCost() << std::endl;
        // }
        std::cout << "-----------------------------\n";
    }*/

    // Main loop for program
    int choice;
    do {
        // Create Main menu of the program
        std::cout << "  MAIN MENU\n";
        std::cout << "1.) Employees\n";
        std::cout << "2.) Sales\n";
        std::cout << "3.) Quit\n";
        std::cout << "\nChoice? ";
        std::cin >> choice;

        std::cin.ignore();

        switch (choice) {
            case 1: {
                // Choice 1 list employees and prompts to add
                auto employeeBegin = company.employeeBegin();
                auto employeeEnd = company.employeeEnd();
                for (auto it = employeeBegin; it != employeeEnd; ++it) {
                    std::cout << *it << std::endl;
                }
                char employeesChoice;
                std::cout << "(A)dd Employee or (M)ain Menu? ";
                std::cin >> employeesChoice;

                if (employeesChoice == 'A' || employeesChoice == 'a') {
                    std::string name, email, phone;
                    double salary;

                    std::cin.ignore(); 
                    std::cout << "Name: ";
                    std::getline(std::cin, name);
                    std::cout << "Email: ";
                    std::getline(std::cin, email);
                    std::cout << "Phone: ";
                    std::getline(std::cin, phone);
                    std::cout << "Salary: ";
                    std::cin >> salary;

                    Employee newEmployee(name, email, phone, salary);
                    company.addEmployee(newEmployee);
                }
                break;
            }
            case 2: {
                // Choice 2 prompts (A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? handles sales menu
                char salesChoice;
                do {
                    std::cout << "(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? ";
                    std::cin >> salesChoice;

                    //nested switch for each "Sales" case
                    switch (salesChoice) {
                        case 'A':
                        case 'a': {
                            // Add a new customer to company
                            std::string name, email, phone;
                            std::cin.ignore();
                            std::cout << "Name: ";
                            std::getline(std::cin, name);
                            std::cout << "Email: ";
                            std::getline(std::cin, email);
                            std::cout << "Phone: ";
                            std::getline(std::cin, phone);

                            Customer newCustomer(name, email, phone);
                            company.addCustomer(newCustomer);
                            break;
                        }
                        case 'S':
                        case 's': {
                            // Prompts user to select customer to add a sale to
                            // Display customers
                            std::cout << "Customers:\n";
                            auto customerBegin = company.customerBegin();
                            auto customerEnd = company.customerEnd();
                            int customerIndex = 1;

                            for (auto it = customerBegin; it != customerEnd; ++it) {
                                std::cout << customerIndex << ".) " << it->name() << std::endl;
                                ++customerIndex;
                            }

                            // Allow user to select a customer
                            int customerChoice;
                            std::cout << "Choice? ";
                            std::cin >> customerChoice;

                            // validate customer choice
                            if (customerChoice >= 1 && customerChoice <= std::distance(customerBegin, customerEnd)) {
                                auto selectedCustomer = std::next(customerBegin, customerChoice - 1);

                                // Add a sale to the selected customer's purchase history
                                std::string item;
                                int quantity;
                                double cost;

                                std::cin.ignore();
                                std::cout << "Item: ";
                                std::getline(std::cin, item);
                                std::cout << "Quantity: ";
                                std::cin >> quantity;
                                std::cout << "Cost: ";
                                std::cin >> cost;

                                Purchase newPurchase(item, quantity, cost);
                                selectedCustomer->addPurchase(newPurchase);
                                std::cout << "Sale added to customer's purchase history.\n";
                            } else {
                                std::cout << "Invalid customer choice.\n";
                            }
                            break;
                        }
                        case 'V':
                        case 'v': {
                            // Prompt user to select customer to view purchase history
                            // Display customers
                            std::cout << "Customers:\n";
                            auto customerBegin = company.customerBegin();
                            auto customerEnd = company.customerEnd();
                            int customerIndex = 1;

                            for (auto it = customerBegin; it != customerEnd; ++it) {
                                std::cout << customerIndex << ".) " << it->name() << std::endl;
                                ++customerIndex;
                            }

                            // Prompt customer selection
                            int customerChoice;
                            std::cout << "Choice? ";
                            std::cin >> customerChoice;

                            // Validate choice
                            if (customerChoice >= 1 && customerChoice <= std::distance(customerBegin, customerEnd)) {
                                auto selectedCustomer = std::next(customerBegin, customerChoice - 1);

                                // Display selected customer's information and purchase history
                                std::cout << selectedCustomer->name() << " <" << selectedCustomer->email() << ">  Phone: " << selectedCustomer->phone() << std::endl;
                                std::cout << "\nOrder History\n";
                                std::cout << "Item                   Price  Quantity   Total\n";

                                auto purchaseBegin = selectedCustomer->purchaseBegin();
                                auto purchaseEnd = selectedCustomer->purchaseEnd();
                                for (auto purchaseIt = purchaseBegin; purchaseIt != purchaseEnd; ++purchaseIt) {
                                    std::cout << std::setw(24) << std::left << purchaseIt->item();
                                    std::cout << std::setw(7) << std::right << std::fixed << std::setprecision(2) << purchaseIt->cost();
                                    std::cout << std::setw(11) << std::right << purchaseIt->qty();
                                    std::cout << std::setw(9) << std::right << purchaseIt->total() << std::endl;
                                }
                            } else {
                                std::cout << "Invalid customer choice.\n";
                            }

                            break;
                        }
                        case 'M':
                        case 'm':
                            break; // Return to the main menu
                        default:
                            std::cout << "Invalid choice. Please try again.\n";
                            break;
                    }
                } while (salesChoice != 'M' && salesChoice != 'm'); // Continue "Sales" menu until 'M/m' is chosen
                break;
            }
            case 3: {
                // Choice 3 save company data to file and exit
                std::ofstream outputFile(companyName + ".dat");

                // Write employees
                auto employeeBegin = company.employeeBegin();
                auto employeeEnd = company.employeeEnd();
                outputFile << std::distance(employeeBegin, employeeEnd) << std::endl;
                for (auto it = employeeBegin; it != employeeEnd; ++it) {
                    outputFile << *it;
                }

                // Write customers
                auto customerBegin = company.customerBegin();
                auto customerEnd = company.customerEnd();
                outputFile << std::distance(customerBegin, customerEnd) << std::endl;
                for (auto it = customerBegin; it != customerEnd; ++it) {
                    outputFile << *it;
                }

                std::cout << "Data saved. Exiting program.\n";
                break;
            }
            default: {
                std::cout << "Invalid choice. Please try again.\n";
                break;
            }
        }
    } while (choice != 3);

    return 0;
}