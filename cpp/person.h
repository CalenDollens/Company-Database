#ifndef PERSON_H
#define PERSON_H

#include <string>
#include <iostream>
#include <fstream>

class Person
{
    public:
        //constructors
        Person();
        Person(const std::string &_name, const std::string &_email, const std::string &_phone);

        //accesors and modifiers
        virtual std::string name() const; 
        virtual void name(const std::string &__name);
        virtual std::string email() const;
        virtual void email(const std::string &_email);
        virtual std::string phone() const;
        virtual void phone(const std::string &_phone);
        
    private:
        std::string _name;
        std::string _email;
        std::string _phone;
};

//Operator overload decleration
std::ostream& operator<<(std::ostream& os, const Person& p);
std::ofstream& operator<<(std::ofstream& os, const Person& p);
std::ifstream& operator>>(std::ifstream& is, Person& p);
#endif