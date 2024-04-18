#ifndef EMPLOYEE_H
#define EMPLOYEE_H
#include <iostream>
#include <fstream>
#include "person.h"

class Employee : public Person
{
    public: 
        //Constructors
        Employee();
        Employee(std::string _name, std::string _email, std:: string _phone, double _salary  );

        //Accessors and modifiers
        virtual double  salary() const;
        virtual void salary(double _salary);
    private: 
        double _salary;  
   
};

//Operator overload decleration
std::ostream& operator<<(std::ostream& os, const Employee& p);
std::ofstream& operator<<(std::ofstream& os, const Employee& p);
std::istream operator>>(std::istream& is, Employee& p);
#endif