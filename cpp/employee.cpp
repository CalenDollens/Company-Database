#include <vector>
#include <string>
#include <fstream>
#include "employee.h"

//Constructors
Employee::Employee()
{
    salary(0.0);
}

Employee::Employee(std::string _name, std::string _email, std::string _phone, double _salary)
    :Person(_name, _email, _phone)
    {
        salary(_salary);
    }

//Acessors and modifiers
double Employee::salary() const
{
    return this->_salary; 
}

void Employee::salary(double _salary)
{
    this->_salary = _salary;
}

//Operator overload implementation for Employee
std::ostream& operator<<(std::ostream& os, const Employee& p)
{
    os <<(const Person&)p << " Salary: $" << p.salary();
    return os;
}

std::ofstream& operator<<(std::ofstream& os, const Employee& p)
{
    os << (const Person&)p << p.salary() << std::endl;
    return os;
}

std::ifstream& operator>>(std::ifstream& is, Employee& p)
{
    double salary;

    is >> (Person&)p;
    is>> salary;
    p.salary(salary);

    return is;
}
