//
//  Mock.swift
//  SaalTests
//
//  Created by Mozhgan 
//

import Saal

extension Category {
    static var desk : Category {
        .init(id: "abc",
              name: "Desk",
              comment: """
                         A desk or bureau is a piece of furniture with a
                         flat table-style work surface used in a school,
                        office, home or the like for academic
                     """)
    }
    
    static var calculator : Category {
        .init(id: "def",
              name: "Calculator",
              comment: """
                          Clothing are items worn on the body. Typically,
                          clothing is made of fabrics or textiles
                        """)
    }
    
    static var employee : Category {
        .init(id: "ghy",
              name: "Employee",
              comment: """
                        An employee is a term for workers and managers working
                         for a company, organization or community.
                       """)
    }
    
    static var server : Category {
        .init(id: "klm",
              name: "Server",
              comment: """
                      Server (computing), a computer program or a
                      device that provides functionality for other
                      programs or devices, called clients
                      """)
    }
}
extension Product {
    static var desk34 : Product {
        .init(id: "123", name: "34",
              productDescription: """
                                    Bought on 2019-01-15. Located in the development office.
                                    """)
    }
    
    static var calculatorT5812 : Product {
        .init(id: "456", name: "T5812", productDescription: "Bought on 2019-04-24")
    }
    
    static var employeeMax : Product {
        .init(id: "789", name: "Max", productDescription: "Entry date: 2018-01-01")
    }
    
    static var serverK32145 : Product {
        .init(id: "0123", name: "K32145", productDescription: "Bought on 2019-03-20")
    }
}
