//
//  NotificationManager.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {} // Prevents duplicate instances
    
    /// Requests alert, sound, and badge permissions from the user
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted successfully")
            }
        }
    }
    
    /// Schedules a recurring yearly local notification for a family member's birthday
    func sheduleBirthdayNotification(
        for member: Member,
        at notificationTime: Date = Date()
    ) {
        guard let name = member.name,
              let birthday = member.birthday,
              let identifier = member.id?.uuidString else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "🎂 Birthday Reminder"
        content.body = "Today is \(name)'s birthday! Don't forget to send wishes!"
        content.sound = .default
        
        // 1. Extract timing components dynamically
        let birthdayComponents = Calendar.current.dateComponents([.month, .day], from: birthday)
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        
        var dynamicComponents = DateComponents()
        dynamicComponents.month = birthdayComponents.month
        dynamicComponents.day = birthdayComponents.day
        dynamicComponents.hour = timeComponents.hour
        dynamicComponents.minute = timeComponents.minute
        
        // 2. Setup the calendar trigger to repeat yearly
        let trigger = UNCalendarNotificationTrigger(dateMatching: dynamicComponents, repeats: true)
        
        // 3. Register the request with the unique Core Data UUID string identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling birthday notification for \(name): \(error.localizedDescription)")
            } else {
                let formattedHour = String(format: "%02d", timeComponents.hour ?? 0)
                    let formattedMinute = String(format: "%02d", timeComponents.minute ?? 0)
                    print("Notification scheduled dynamically for \(name) at \(formattedHour):\(formattedMinute)")
            }
        }
    }
    
    /// Cancels a pending notification if a member is deleted from the application
    func cancelNotification(for member: Member) {
        guard let identifier = member.id?.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("Cancelled pending notifications for deleted member ID: \(identifier)")
    }
    
    func scheduleTestNotification(secondsFromNow: TimeInterval = 5) {
            let content = UNMutableNotificationContent()
            content.title = "⚠️ Test Birthday Reminder"
            content.body = "This is an instant test notification working perfectly!"
            content.sound = .default
            
            // Create a time interval trigger (e.g., 5 seconds from now)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsFromNow, repeats: false)
            
            // Create a unique key for testing
            let request = UNNotificationRequest(identifier: "TestNotificationID", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Test notification error: \(error.localizedDescription)")
                } else {
                    print("Test notification scheduled to fire in \(Int(secondsFromNow)) seconds!")
                }
            }
        }
}
