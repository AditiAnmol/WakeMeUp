import SwiftUI

struct AlarmListView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @State private var editMode = false
    
    var body: some View {
        Group {
            if viewModel.alarms.isEmpty {
                VStack {
                    Text("No alarms added.")
                        .font(.title3)
                }
            } else {
                ScrollView {
                    ForEach(viewModel.alarms, id:\.self) { alarm in
                        ZStack {
                            HStack {
                                AlarmDeleteCard(alarm: alarm)
                            }
                            HStack {
                                AlarmCard(alarm: alarm)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Alarm")
    }
}
