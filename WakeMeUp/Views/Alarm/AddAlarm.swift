import SwiftUI

// Add new alarm view
struct AddAlarm: View {
    @StateObject private var viewModel = AlarmModel()
    @Environment(\.presentationMode) var presentationMode
    
    private var timeDuration = ["0 min", "0.5 min", "1 min", "1.5 min", "2.0 min", "2.5 min", "3 min"]
    
    @State private var name = ""
    @State private var date = Date()
    @State private var actualAlarmDate = Date()
    @State private var music: String? = "Adventure"
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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Alarm Information")) {
                    TextField("Label", text: $name)
                    DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
                        .onChange(of: date) { date in
                            // Date picker has an existing issue and doesn't update the selection variable. Hence, this hack
                            actualAlarmDate = date
                        }
                    NavigationLink(
                        destination: MusicList(selectedMusic: $music),
                        label: {
                            HStack {
                                Text("Sound")
                                Spacer()
                                Text(music!)
                                    .foregroundColor(.gray)
                            }
                        })
                }
                Section(header: Text("Repeat")) {
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
                Section(header: Text("Mission")) {
                    Picker("Duration", selection: $duration) {
                        ForEach(timeDuration, id: \.self) { duration in
                            Text(duration)
                        }
                    }
                }
            }
            .navigationTitle("Add Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: dismissSheet), trailing: Button("Save", action: saveAlarm))
        }
    }
    
    // Closes the Add Alarm view
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // Send data to model to save the alarm
    private func saveAlarm() {
        viewModel.addAlarm(name: self.name, time: self.actualAlarmDate, music: self.music!, alarmDuration: self.duration, repeats: self.repeatDays)
        
        self.dismissSheet()
    }
}

struct AddAlarm_Previews: PreviewProvider {
    static var previews: some View {
        AddAlarm()
    }
}
