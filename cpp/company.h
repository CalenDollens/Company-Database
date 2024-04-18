#ifndef COMPANY_H
#define COMPANY_H

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include "employee.h"
#include "customer.h"

class Company
{
    public:
    // Constructors
    Company();
    Company(const std::string& name);

    // Accessors and modifiers
    std::string name() const;
    void name(const std::string& name);
    void addEmployee(const Employee& employee);
    void addCustomer(const Customer& customer);

    //decleration for employee and customer iterators
    std::vector<Employee>::iterator employeeBegin();
    std::vector<Employee>::iterator employeeEnd();
    std::vector<Customer>::iterator customerBegin();
    std::vector<Customer>::iterator customerEnd();

private:
    std::vector<Employee> _employees;
    std::vector<Customer> _customers;
    std::string _name;
};

#endif