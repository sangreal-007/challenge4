//
//  AudioRecorderController.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import Foundation
import AVFoundation
import SwiftData

class AudioRecorderController: ObservableObject {
    @Published var isRecording = false
    @Published var currentDuration: TimeInterval = 0
    
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    // Audio settings
    private var settings: [String: Any] {
        [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    
    // MARK: - Permission
    func requestPermission(completion: @escaping () -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { allowed in
            DispatchQueue.main.async {
                if allowed {
                    print("Permission granted")
                    completion()
                } else {
                    print("Permission denied")
                }
            }
        }
    }
    
    // MARK: - File paths
    private func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func audioFileURL() -> URL {
        let fileName = "recording_\(Date().timeIntervalSince1970).m4a"
        return documentsDirectory().appendingPathComponent(fileName)
    }
    
    // MARK: - Start recording
    func startRecording() {
        DispatchQueue.main.async {
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
                try session.setActive(true, options: .notifyOthersOnDeactivation)
                
                let url = self.audioFileURL()
                self.recorder = try AVAudioRecorder(url: url, settings: self.settings)
                self.recorder?.prepareToRecord()
                self.recorder?.record()
                
                self.isRecording = true
                self.currentDuration = 0
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    if let r = self.recorder {
                        self.currentDuration = r.currentTime
                    }
                }
                
                print("Recording started at: \(url.path)")
            } catch {
                print("Failed to start recording: \(error)")
            }
        }
    }
    
    // MARK: - Stop recording (no duration limit)
    func stopRecordingWithoutLimit() -> String? {
        guard let recorder = recorder, recorder.isRecording else { return nil }
        
        recorder.stop()
        timer?.invalidate()
        timer = nil
        
        let fileName = recorder.url.lastPathComponent
        
        self.isRecording = false
        self.recorder = nil
        
        print("Recording saved. File: \(fileName)")
        
        return fileName
    }

    
    // MARK: - Play audio
    func playRecording(fileName: String) {
        let url = documentsDirectory().appendingPathComponent(fileName)
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("File does not exist: \(url.path)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            print("Playing audio: \(url.path)")
        } catch {
            print("Playback failed: \(error)")
        }
    }
    
//    // MARK: - Cleanup old recordings
//    func cleanupOldRecordings(days: Int = 30, modelContext: ModelContext) {
//        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
//        let fetchRequest = FetchDescriptor<LogObject>() // masih diubah
//
//        do {
//            let oldRecords = try modelContext.fetch(fetchRequest).filter { $0.date < cutoff }
//            for record in oldRecords {
//                if let fileName = record.feeling { //masih di ubah
//                    let fileURL = documentsDirectory().appendingPathComponent(fileName)
//                    try? FileManager.default.removeItem(at: fileURL)
//                }
//                modelContext.delete(record)
//            }
//        } catch {
//            print("Cleanup failed: \(error)")
//        }
//    }
}
