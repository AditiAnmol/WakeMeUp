import SwiftUI

struct AddAlarm: View {
    @StateObject private var viewModel = AlarmViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    private var durations = ["0 min", "0.5 min", "1 min", "1.5 min", "2.0 min", "2.5 min", "3 min"]
    
    @State private var alarmName = ""
    @State private var alarmDate = Date()
    @State private var alarmMusic: String? = "Adventure"
    @State private var alarmDuration = "0 min"
    @State private var alarmRepeat = [
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
                    TextField("Label", text: $alarmName)
                    DatePicker("Time", selection: $alarmDate, displayedComponents: .hourAndMinute)
                    NavigationLink(
                        destination: MusicList(selectedMusic: $alarmMusic),
                        label: {
                            HStack {
                                Text("Sound")
                                Spacer()
                                Text(alarmMusic!)
                                    .foregroundColor(.gray)
                            }
                        })
                }
                Section(header: Text("Repeat")) {
                    HStack {
                        ForEach(alarmRepeat.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(alarmRepeat[index].1 ? Color(#colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1)) : Color(#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)))
                                Text(alarmRepeat[index].0.first?.description ?? "")
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        alarmRepeat[index].1.toggle()
                                    }
                            }
                        }
                    }
                }
                Section(header: Text("Mission")) {
                    Picker("Duration", selection: $alarmDuration) {
                        ForEach(durations, id: \.self) { duration in
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
    
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveAlarm() {
        viewModel.addAlarm(name: self.alarmName, time: self.alarmDate, music: self.alarmMusic!, alarmDuration: self.alarmDuration, repeats: self.alarmRepeat)
        
        self.dismissSheet()
    }
}

struct AddAlarm_Previews: PreviewProvider {
    static var previews: some View {
        AddAlarm()
    }
}
