#include "customer.h"
#include "purchase.h"

//Constructors
Customer::Customer() : Person(), _history(){}
Customer::Customer(const std::string& name, const std::string& email, const std::string& phone)
    : Person(name, email, phone), _history(){}

//Function to add purchases to customer history
void Customer::addPurchase(const Purchase& purchase){
    _history.push_back(purchase);
}

//iterators for purchase history
std::vector<Purchase>::const_iterator Customer::purchaseBegin() const {
    return _history.begin();
}

std::vector<Purchase>::const_iterator Customer::purchaseEnd() const {
    return _history.end();
}


//Operator Overloads for Customer
std::istream& operator>>(std::istream& input, Customer& customer) {
    std::string name, email, phone;
    input >> std::ws;
    std::getline(input, name);
    std::getline(input, email);
    std::getline(input, phone);

    customer = Customer(name, email, phone);

    int numPurchases;
    input >> numPurchases;
    input.ignore(); 

    return input;
}

std::ofstream& operator<<(std::ofstream& os, const Customer& customer) {
    os << customer.name() << std::endl;
    os << customer.email() << std::endl;
    os << customer.phone() << std::endl;
    const auto& history = customer.getHistory(); 
    os << history.size() << std::endl; // Writes the number of purchases for this customer
    for (const auto& purchase : history) {
        os << purchase.item() << std::endl; 
        os << purchase.qty() << std::endl; 
        os << purchase.cost() << std::endl; 
    }
    return os;
}