//
//  NotificationViewModel.swift
//  Future & Deffered
//
//  Created by Shujaat-Hussain on 12/5/24.
//

import Foundation
import Combine
import UserNotifications

final class NotificationViewModel {
    
    func authorize() -> AnyPublisher<Bool, Error> {
        Deferred {
            Future { handler in
                UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .sound, .badge]){ (granted, error) in
                        if let error = error {
                            handler(.failure(error))
                        } else {
                            handler(.success(granted))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }
}
