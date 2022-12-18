import AVFoundation
import AudioKitUI
import AudioKit
import AVKit
import SwiftUI

// Code from https://laurentbrusa.hashnode.dev/creating-an-accessible-audio-player-in-swiftui-part-1

let demoFileURL = Bundle.main.url(forResource: "toto-africa", withExtension: "mp3")!
let demoMIDIURL = Bundle.main.url(forResource: "toto-africa", withExtension: "mid")
let REWIND_TIME = 5.0

struct EditorView: View {
  
  @StateObject var viewModel = MIDITrackViewModel()
  @State var fileURL = demoMIDIURL

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
      
      // Huge lagging MIDI panel
      // Sometimes it's not even rendered
      GeometryReader { geometry in
        ScrollView {
          
          ForEach(
            MIDIFile(url: fileURL!).tracks.indices, id: \.self
          ) { number in
            
            MIDITrackView(fileURL: $fileURL,
                          trackNumber: number,
                          trackWidth: geometry.size.width,
                          trackHeight: 30.0)
            .environmentObject(viewModel)
            .foregroundColor(.red)
            .background(.blue)
          }
        }
      }
      
      
      // Waveform
      
      ZStack(alignment: .leading) {
        AudioFileWaveform(url: demoFileURL)
        .foregroundColor(.accentColor)
        
        // Current time line
        
        GeometryReader { geometry in
          
          if (start ... start + length).contains(progress) {
            let scaledProgress = (progress - start) / length
            ProgressLine(progress: scaledProgress)
          }
          
        }
        
      }
      .frame(minHeight: 70, maxHeight: 200)
      
      Spacer()
      
      // Minimap
      
      ZStack(alignment: .leading) {
        AudioFileWaveform(url: demoFileURL)
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
          
          viewModel.stop()
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
            viewModel.play()
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
      
      viewModel.startEngine()
      if let fileURL = demoMIDIURL {
          viewModel.loadSequencerFile(fileURL: fileURL)
      }
    }
    .onDisappear {
        viewModel.stop()
        viewModel.stopEngine()
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
