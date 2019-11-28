//
//  loader.h
//  Shoebox
//
//  Created by Mac on 4/7/19.
//  Copyright © 2019 Llau Systems. All rights reserved.
//

#ifndef loader_h
#define loader_h

#include <stdint.h>
#include <string>
#include <vector>

class Binary;
class Section;
class Symbol;

class Symbol {
    
public:
    enum SymbolType {
        SYM_TYPE_UKN = 0,
        SYM_TYPE_FUNC = 1
    };
    
    Symbol() : type(SYM_TYPE_UKN), name(), addr(0) {}
    
    SymbolType type;
    std::string name;
    uint64_t addr;
    
    
};

#endif /* loader_h */
