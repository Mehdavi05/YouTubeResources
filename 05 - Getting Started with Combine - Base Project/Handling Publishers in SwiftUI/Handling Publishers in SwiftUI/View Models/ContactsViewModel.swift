//
//  ContactsViewModel.swift
//  Handling Publishers in SwiftUI
//
//  Created by Shujaat-Hussain on 12/5/24.
//

import Foundation
import Combine

final class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    func add(contact: Contact){
        contacts.append(contact)
    }
}
