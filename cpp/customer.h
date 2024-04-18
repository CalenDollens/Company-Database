#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <string>
#include <vector>
#include <fstream>
#include "person.h"
#include "purchase.h" 

class Customer : public Person {
    public:
        //Constructors
        Customer();
        Customer(const std::string& name, const std::string& email, const std::string& phone);

        // Add Purchase to history
        void addPurchase(const Purchase& purchase);

        // Function to access the purchase history
        const std::vector<Purchase>& getHistory() const {
        return _history;
    }
        std::vector<Purchase>::const_iterator purchaseBegin() const;
        std::vector<Purchase>::const_iterator purchaseEnd() const;

        // function decleration to overload << for Customer class
        friend std::ofstream& operator<<(std::ofstream& os, const Customer& customer);

    private:
        std::vector<Purchase> _history;

};

#endif