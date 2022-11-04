import AVFoundation
import AVKit
import SwiftUI
import Waveform

// Code from https://laurentbrusa.hashnode.dev/creating-an-accessible-audio-player-in-swiftui-part-1

let demoFileURL = Bundle.main.url(forResource: "Slander Suffer", withExtension: "mp3")!
let REWIND_TIME = 5.0

class WaveformModel: ObservableObject {
    var samples: SampleBuffer

    init(file: AVAudioFile) {
        let stereo = file.toFloatChannelData()!
        samples = SampleBuffer(samples: stereo[0])
    }
}

struct EditorView: View {
  @StateObject var model = WaveformModel(file: try! AVAudioFile(forReading: demoFileURL))

  @State var start = 0.0
  @State var length = 1.0

  @State var audioPlayer: AVAudioPlayer!
  @State var progress: CGFloat = 0.0
  @State var duration: Double = 0.0
  @State private var playing: Bool = false
  
  @State var formattedDuration: String = "00:00"
  @State var formattedProgress: String = "00:00"

  var body: some View {
    VStack {
      
      // Waveform
      
      ZStack(alignment: .leading) {
        Waveform(samples: model.samples,
                 start: Int(start * Double(model.samples.count - 1)),
                 length: Int(length * Double(model.samples.count)))
        .foregroundColor(.accentColor)
        
        // Current time line
        
        GeometryReader { geometry in
          
          if (start ... start + length).contains(progress) {
            let scaledProgress = (progress - start) / length
            ProgressLine(progress: scaledProgress)
          }
          
        }
        
      }
      .frame(minHeight: 100)
      
      Spacer()
      
      // Minimap
      
      ZStack(alignment: .leading) {
        Waveform(samples: model.samples)
          .foregroundColor(.cyan)
          .padding(.vertical, 5)
        
        MinimapView(start: $start, length: $length)
        
        ProgressLine(progress: progress)
      }
      .frame(height: 100)
      .padding(.horizontal, 20)
      
      
      // Panel with buttons
      
      HStack {
        Text(formattedProgress)
          .font(.title3.monospacedDigit())
        
        Button {
          
          if audioPlayer.currentTime - REWIND_TIME < 0.0 {
            audioPlayer.currentTime = 0.0
          } else {
            audioPlayer.currentTime -= REWIND_TIME
          }
        } label: {
          Image(systemName: "gobackward.5")
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
        }
        
        Button {
          if audioPlayer.currentTime + REWIND_TIME >= audioPlayer.duration {
            audioPlayer.currentTime = audioPlayer.duration
          } else {
            audioPlayer.currentTime += REWIND_TIME
          }
        } label: {
          Image(systemName: "goforward.5")
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
  
  private func initialiseAudioPlayer() {
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
    
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
      if !audioPlayer.isPlaying {
        playing = false
      }
      
      formattedProgress = formatter.string(from: TimeInterval(self.audioPlayer.currentTime))!
      
      withAnimation(.linear(duration: 0.2)) {
        progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
      }
    }

  }

}
