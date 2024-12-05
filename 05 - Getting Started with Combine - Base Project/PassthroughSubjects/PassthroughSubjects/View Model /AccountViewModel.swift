//
//  AccountViewModel.swift
//  PassthroughSubjects
//
//  Created by Shujaat-Hussain on 11/28/24.
//

import Foundation
import Combine

final class AccountViewModel {
    enum AccountStatus {
        case active
        case banned
    }
    
    private let warningLimit: Int = 3
    
    let userAccountStatus = CurrentValueSubject<AccountStatus, Never>(.active)
    let warnings = CurrentValueSubject<Int, Never>(0)
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        createSubscriptions()
    }
    
    func incrementWarnings() {
        warnings.value += 1
        print("Waning: \(warnings.value)")
    }
}

private extension AccountViewModel {
    
    func createSubscriptions() {
        warnings
            .filter( {[weak self] val in
                guard let self = self else { return false }
                return val >= self.warningLimit
            })
            .sink{ [weak self] _ in
                guard let self = self else { return }
                self.userAccountStatus.value = .banned
            }
            .store(in: &subscriptions)
    }
}
