#include "person.h"

// Constructors
Person::Person() : _name(""), _email(""), _phone("") {
}

Person::Person(const std::string &_name, const std::string &_email, const std::string &_phone)
    : _name(_name), _email(_email), _phone(_phone) {
}

// Accessors and modifiers
std::string Person::name() const {
    return _name;
}

void Person::name(const std::string &_name) {
    this->_name = _name;
}

std::string Person::email() const {
    return _email;
}

void Person::email(const std::string &_email) {
    this->_email = _email;
}

std::string Person::phone() const {
    return _phone;
}

void Person::phone(const std::string &_phone) {
    this->_phone = _phone;
}

// Operator overloads for IOstream
std::ostream& operator<<(std::ostream& os, const Person& p) {
    os << "Name: " << p.name() << " Email: " << p.email() << " Phone: " << p.phone();
    return os;
}

std::ofstream& operator<<(std::ofstream& os, const Person& p) {
    os << p.name() << std::endl;
    os << p.email() << std::endl;
    os << p.phone() << std::endl;
    return os;
}

std::ifstream& operator>>(std::ifstream& is, Person& p) {
    std::string name, email, phone;
    std::getline(is, name);
    std::getline(is, email);
    std::getline(is, phone);
    p.name(name);
    p.email(email);
    p.phone(phone);
    return is;
}