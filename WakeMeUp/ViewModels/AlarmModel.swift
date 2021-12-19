import Combine
import SwiftUI

class AlarmModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    private var cancellable: AnyCancellable?
    
    init(alarmPublisher: AnyPublisher<[Alarm], Never> = AlarmController.shared.alarms.eraseToAnyPublisher()) {
        cancellable = alarmPublisher.sink { alarms in
            self.alarms = alarms
        }
    }
    
    // Adds new alarm data to the alarm storage and adds new notification
    func addAlarm(name: String, time: Date, music: String, alarmDuration: String, repeats: [(String, Bool)]) {
        let alarmRepeat = self.getAllDays(from: repeats)
        let activityDuration = self.getTimeInSeconds(from: alarmDuration)
        let id = UUID().uuidString
        
        AlarmController.shared.add(id: id, name: name, time: time, music: music, activityDuration: activityDuration, repeats: alarmRepeat)
        NotificationController.shared.scheduleNotifications(id: id, title: name, for: repeats, on: time, stopDuration: alarmDuration, musicName: music)

    }
    
    // Delete the current alarm from context
    func delete(alarm: Alarm) {
        NotificationController.shared.cancelScheduledNotification(for: alarm.id!)
        AlarmController.shared.delete(alarm: alarm)
    }
    
    // Edit the current alarm and update it in context
    func editAlarm(alarm: Alarm, name: String, time: Date, music: String, activityDuration: String, repeats: [(String, Bool)]) {
        let alarmRepeat = self.getAllDays(from: repeats)
        let activityTime = self.getTimeInSeconds(from: activityDuration)
        
        NotificationController.shared.cancelScheduledNotification(for: alarm.id!)
        NotificationController.shared.scheduleNotifications(id: alarm.id!, title: name, for: repeats, on: time, stopDuration: activityDuration, musicName: music)
        
        AlarmController.shared.edit(alarm: alarm, name: name, time: time, music: music, activityDuration: activityTime, repeats: alarmRepeat)
    }
    
    // Toggle the active state of alarm
    func toggleAlarm(for alarm: Alarm) {
        AlarmController.shared.toggle(alarm: alarm)
        if alarm.active {
            NotificationController.shared.scheduleNotifications(id: alarm.id!, title: alarm.name!, for: self.daysMapper(from: alarm.repeatOn!), on: alarm.time!, stopDuration: self.timeToString(from: alarm.activityDuration), musicName: alarm.music!)
        } else {
            NotificationController.shared.cancelScheduledNotification(for: alarm.id!)
        }
    }
    
    // Returns the time in string format
    private func timeToString(from time: Int16) -> String {
        return String(format: "%.1f min", Double(time) / 60)
    }
    
    // Returns the time in seconds
    private func getTimeInSeconds(from time: String) -> Int16 {
        let str = time.split(separator: " ")
        
        return Int16(Double(str[0])! * 60)
    }
    
    // Returns days mapped as boolean value. True is that day is selected or else false
    private func daysMapper(from data: [String]) -> [(String, Bool)] {
        return [
            ("SUN", data.contains("SUN")),
            ("MON", data.contains("MON")),
            ("TUE", data.contains("TUE")),
            ("WED", data.contains("WED")),
            ("THU", data.contains("THU")),
            ("FRI", data.contains("FRI")),
            ("SAT", data.contains("SAT")),
        ]
    }
    
    // Returns all the days for the alarm
    private func getAllDays(from data: [(String, Bool)]) -> [String] {
        var alarmRepeat = [String]()
        for days in data {
            if days.1 {
                alarmRepeat.append(days.0)
            }
        }
        
        return alarmRepeat
    }
}
