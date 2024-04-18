#include "purchase.h"

//Constructors
Purchase::Purchase() : _item(""), _qty(0), _cost(0.0){}
Purchase::Purchase(const std::string& item, int qty, double cost)
    : _item(item), _qty(qty), _cost(cost){}
    
//Accessors
std::string Purchase::item() const{
    return _item;
}

int Purchase::qty() const{
    return _qty;
}

double Purchase::cost() const{
    return _cost;
}

double Purchase::total() const{
    return _qty * _cost;
}
