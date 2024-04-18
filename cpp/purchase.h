#ifndef PURCHASE_H
#define PURCHASE_H

#include <string>

class Purchase{
    public:
        //Constructors
        Purchase();
        Purchase(const std::string& item, int qty, double cost);

        //acessors 
        std::string item() const;
        int qty() const;
        double cost() const;
        double total() const;

    private:
        std::string _item;
        int _qty;
        double _cost;
};

#endif