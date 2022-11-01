// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/Waveform/

import AVFoundation
import AVKit
import SwiftUI
import Waveform

let demoFileURL = Bundle.main.url(forResource: "Sullivan King Take Flight", withExtension: "mp3")!

class WaveformModel: ObservableObject {
    var samples: SampleBuffer

    init(file: AVAudioFile) {
        let stereo = file.toFloatChannelData()!
        samples = SampleBuffer(samples: stereo[0])
    }
}

func getFile() -> AVAudioFile {
    return try! AVAudioFile(forReading: demoFileURL)
}

struct EditorView: View {
    @StateObject var model = WaveformModel(file: getFile())

    @State var start = 0.0
    @State var length = 1.0
  
  @State var audioPlayer: AVAudioPlayer!
  @State var progress: CGFloat = 0.0
  @State private var playing: Bool = false
  @State var duration: Double = 0.0
  @State var formattedDuration: String = "00:00"
  @State var formattedProgress: String = "00:00"

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Waveform(samples: model.samples)
                  .foregroundColor(.cyan)
                  .padding(.vertical, 5)
              
                MinimapView(start: $start, length: $length)
            }
            .frame(height: 100)
            .padding(.horizontal, 20)
          
          ZStack(alignment: .leading) {
            Waveform(samples: model.samples,
                     start: Int(start * Double(model.samples.count - 1)),
                     length: Int(length * Double(model.samples.count)))
            .foregroundColor(.accentColor)
            
            // Current time line
            
            Rectangle()
              .fill(.red)
              .frame(width: 1)
              .offset(x: 20)
          }
          
          HStack {
            Text(formattedProgress)
              .font(.title3.monospacedDigit())
            
            Button {
              print("Back 5 seconds")
              let rewindTime = 5.0
              
              if audioPlayer.currentTime - rewindTime < 0.0 {
                audioPlayer.currentTime = 0.0
              } else {
                audioPlayer.currentTime -= rewindTime
              }
            } label: {
              Image(systemName: "gobackward.5")
                .resizable()
                .scaledToFit()
            }
            
            Button {
              if audioPlayer.isPlaying {
                playing = false
                audioPlayer.pause()
              } else if !audioPlayer.isPlaying {
                playing = true
                audioPlayer.play()
              }
            } label: {
              Image(systemName: playing ? "pause.fill" : "play.fill")
                .resizable()
                .scaledToFit()
            }
            
            Button {
              print("Forward 5 seconds")
              
              let rewindTime = 5.0
              
              if audioPlayer.currentTime + rewindTime >= audioPlayer.duration {
                audioPlayer.currentTime = audioPlayer.duration
              } else {
                audioPlayer.currentTime += rewindTime
              }

            } label: {
              Image(systemName: "goforward.5")
                .resizable()
                .scaledToFit()
            }
            
            Text(formattedDuration)
              .font(.title3.monospacedDigit())

          }
          .buttonStyle(.bordered)
          .controlSize(.large)
          .frame(height: 70)

        }
      
        .onAppear {
          initialiseAudioPlayer()
        }

    }
  
  func initialiseAudioPlayer() {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = [ .pad ]
    
#if os(iOS)
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print(error)
    }
#endif
    
    // init audioPlayer - I use force unwrapping here for brevity and because I know that it cannot fail since I just added the file to the app.
    self.audioPlayer = try! AVAudioPlayer(contentsOf: demoFileURL)
    self.audioPlayer.prepareToPlay()
    
    formattedDuration = formatter.string(from: TimeInterval(self.audioPlayer.duration))!
    duration = self.audioPlayer.duration
    
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      if !audioPlayer.isPlaying {
        playing = false
      }
      
      progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
      formattedProgress = formatter.string(from: TimeInterval(self.audioPlayer.currentTime))!
    }

  }

}
