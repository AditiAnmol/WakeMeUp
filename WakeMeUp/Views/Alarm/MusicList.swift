import SwiftUI

// Shows the current music list and plays sound on tap of the music selected
struct MusicList: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var viewModel = MusicModel()
    let musics = ["Adventure", "Bell", "Once Again", "Tenderness"]
    
    @Binding var selectedMusic: String?
    
    var body: some View {
        List(musics, id: \.self) { music in
            HStack {
                Text(music)
                Spacer()
                if selectedMusic == music {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedMusic = music
                viewModel.playMusic(name: music)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                viewModel.stopMusic()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
                Text("Back")
            })
        }
    }
}
