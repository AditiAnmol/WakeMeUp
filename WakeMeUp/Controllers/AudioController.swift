import AVFoundation

class AudioController {
    static let shared = AudioController()
    
    let musicList = [
        "Sound 1": Bundle.main.url(forResource: "Sound 1", withExtension: "wav"),
        "Sound 2": Bundle.main.url(forResource: "Sound 2", withExtension: "wav"),
        "Sound 3": Bundle.main.url(forResource: "Sound 3", withExtension: "wav"),
        "Sound 4": Bundle.main.url(forResource: "Sound 4", withExtension: "wav"),
    ]
    
    var player = AVAudioPlayer()
    
    // Uses AVAudioPlayer to play music when requested
    func playSoundEffect(for name: String) {
        do {
            player = try AVAudioPlayer(contentsOf: musicList[name]!!)
            player.play()
        } catch {
            fatalError("Can't play music for \(name)")
        }
    }
}

