//
//  CategoryMock.swift
//  Saal
//
//  Created by Mozhgan on 8/11/22.
//

import Foundation
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
