import Foundation
import AVFoundation
import UIKit

final class Recording: NSObject {
    
    static let shared = Recording()
    
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureMovieFileOutput()
    
    private var onRecord: ((URL) -> Void)?
    
    private override init() {}
    
    func start() {
        Task.detached(priority: .userInitiated) {
            let deviceSession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .front
            )
            
            guard let captureDevice = deviceSession.devices.first else {
                return
            }

            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if self.captureSession.inputs.isEmpty {
                    self.captureSession.addInput(input)
                }
                if self.captureSession.outputs.isEmpty {
                    self.captureSession.addOutput(self.videoOutput)
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
            self.captureSession.startRunning()
            
            let documentURL = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask)[0]
            
            let date = DateFormatter(.yyyyMMddHHmmss_none).string(from: Date())
            let filePath = documentURL.appendingPathComponent("neko\(date).mov")
            self.videoOutput.startRecording(to: filePath, recordingDelegate: self)
        }
    }
    
    func stop(onRecord: @escaping (URL) -> Void) {
        self.onRecord = onRecord
        videoOutput.stopRecording()
        captureSession.stopRunning()
    }
    
}

extension Recording: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        onRecord?(outputFileURL)
    }
    
}
