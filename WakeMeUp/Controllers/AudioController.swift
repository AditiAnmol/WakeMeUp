import AVFoundation

class AudioController {
    static let shared = AudioController()
    
    let musicList = [
        "Bell": Bundle.main.url(forResource: "Bell", withExtension: "wav"),
        "Once Again": Bundle.main.url(forResource: "Once Again", withExtension: "wav"),
        "Tenderness": Bundle.main.url(forResource: "Tenderness", withExtension: "wav"),
        "Adventure": Bundle.main.url(forResource: "Adventure", withExtension: "wav"),
    ]
    
    var player = AVAudioPlayer()
    
    func playSoundEffect(for name: String) {
        do {
            player = try AVAudioPlayer(contentsOf: musicList[name]!!)
            player.play()
        } catch {
            fatalError("Can't play music for \(name)")
        }
    }
}

