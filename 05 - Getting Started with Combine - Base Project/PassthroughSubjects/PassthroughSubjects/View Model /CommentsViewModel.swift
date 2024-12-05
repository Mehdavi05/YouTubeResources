//
//  CommentsViewModel.swift
//  PassthroughSubjects
//
//  Created by Shujaat-Hussain on 11/28/24.
//

import Foundation
import Combine

final class CommentsViewModel {
    
    private let commentEntered = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private let badWords = ["MC", "BC"]
    
    private var manager: AccountViewModel
    
    init(manager: AccountViewModel) {
        self.manager = manager
        setUpSubscriptions()
    }
    
    func send(comment: String) {
        commentEntered.send(comment)
    }
}

extension CommentsViewModel {
    
    func setUpSubscriptions() {
        commentEntered
            .filter{!$0.isEmpty}
            .sink { [weak self] val in
                guard let self = self else { return }
                if self.badWords.contains(val) {
                    self.manager.incrementWarnings()
                } else {
                    print("New comment: \(val)")
                }
            }
            .store(in: &subscriptions)
    }
}
