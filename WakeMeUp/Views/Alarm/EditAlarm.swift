import SwiftUI

// Logic similar to AddAlarm, due to time crunch copied all the code here and made the required changes.
struct EditAlarm: View {
    @StateObject private var viewModel = AlarmModel()
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var alarm: Alarm
    
    private var durations = ["0 min", "0.5 min", "1 min", "1.5 min", "2.0 min", "2.5 min", "3 min"]

    @State private var name = ""
    @State private var date = Date()
    @State private var music: String? = "Sound 1"
    @State private var duration = "0 min"
    @State private var repeatDays = [
        ("SUN", false),
        ("MON", false),
        ("TUE", false),
        ("WED", false),
        ("THU", false),
        ("FRI", false),
        ("SAT", false),
    ]
    
    init(alarm: Alarm) {
        self.alarm = alarm
        
        var repeats = repeatDays
        for i in repeats.indices {
            repeats[i].1 = alarm.repeatOn!.contains(repeatDays[i].0)
        }
        
        _repeatDays = State(initialValue: repeats)
        _name = State(initialValue: alarm.name!)
        _date = State(initialValue: alarm.time!)
        _music = State(initialValue: alarm.music!)
        if alarm.activityDuration == 0 {
            _duration = State(initialValue: "0 min")
        } else {
            _duration = State(initialValue: "\(String(Double(alarm.activityDuration) / 60)) min")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Alarm Information")) {
                    TextField("Alarm Name", text: $name)
                    DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
                    NavigationLink(
                        destination: MusicList(selectedMusic: $music),
                        label: {
                            HStack {
                                Text("Music")
                                Spacer()
                                Text(music!)
                                    .foregroundColor(.gray)
                            }
                        })
                }
                Section(header: Text("Alarm Repeat")) {
                    HStack {
                        ForEach(repeatDays.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(repeatDays[index].1 ? Color("TabBarHighlight") : Color(#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)))
                                Text(repeatDays[index].0.first?.description ?? "")
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        repeatDays[index].1.toggle()
                                    }
                            }
                        }
                    }
                }
                Section(header: Text("Alarm Activity")) {
                    Picker("Duration", selection: $duration) {
                        ForEach(durations, id: \.self) { duration in
                            Text(duration)
                        }
                    }
                }
            }
            .navigationTitle("Edit Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: dismissSheet), trailing: Button("Save", action: saveAlarm))
        }
    }
    
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveAlarm() {
        viewModel.editAlarm(alarm: alarm, name: name, time: date, music: music!, activityDuration: duration, repeats: repeatDays)
        
        self.dismissSheet()
    }
}

struct EditAlarm_Previews: PreviewProvider {
    static var previews: some View {
        EditAlarm(alarm: Alarm())
    }
}
