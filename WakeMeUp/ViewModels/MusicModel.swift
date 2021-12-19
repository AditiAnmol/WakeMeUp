import Foundation

class MusicModel {
    func playMusic(name: String) {
        AudioController.shared.playSoundEffect(for: name)
    }
    
    func stopMusic() {
        AudioController.shared.player.stop()
    }
}

