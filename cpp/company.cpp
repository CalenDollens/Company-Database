#include "company.h"

// Constructors
Company::Company() : _name("") {
}

Company::Company(const std::string& name) : _name(name) {
}

// Accessors and modifiers
std::string Company::name() const {
    return _name;
}

void Company::name(const std::string& name) {
    _name = name;
}

void Company::addEmployee(const Employee& employee) {
    _employees.push_back(employee);
}

void Company::addCustomer(const Customer& customer) {
    _customers.push_back(customer);
}

//implementatiion for employee and customer iterators
std::vector<Employee>::iterator Company::employeeBegin() {
    return _employees.begin();
}

std::vector<Employee>::iterator Company::employeeEnd() {
    return _employees.end();
}

std::vector<Customer>::iterator Company::customerBegin() {
    return _customers.begin();
}

std::vector<Customer>::iterator Company::customerEnd() {
    return _customers.end();
}