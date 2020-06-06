//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var messageLabel:UILabel!
    @IBOutlet private weak var topbar: UIView!
    @IBOutlet private weak var lightButton: UIButton!
    
    // MARK: - Variables
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var scaneCodeFrameView: UIView?
    
    // MARK: - ViewController Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButton()
        setupCaptureSession()
        sutupHighlight()
        view.bringSubviewToFront(messageLabel)
        view.bringSubviewToFront(topbar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            captureSession?.startRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
        }
    }
    
    // MARK: - Overriding values
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func lightingButtonWasPressed(_ sender: Any) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        try? device.lockForConfiguration()
        
        device.torchMode = device.isTorchActive ? .off : .on
        
        device.unlockForConfiguration()
    }
    
    // MARK: - Private Methods
    private func configureButton() {
        lightButton.setBackgroundImage(UIImage(named: "lightbulb.fill"), for: .selected)
        lightButton.setBackgroundImage(UIImage(named: "lightbulb.slash.fill"), for: .normal)
    }
    
    private func setupCaptureSession() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        guard captureSession?.canAddInput(videoInput) ?? false else { return failed() }
        
        captureSession?.addInput(videoInput)

        let metadataOutput = AVCaptureMetadataOutput()
        
        guard captureSession?.canAddOutput(metadataOutput) ?? false else { return failed() }
        
        captureSession?.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr, .dataMatrix, .interleaved2of5, .itf14, .aztec, .code128, .code93, .code39Mod43, .code39, .upce]
        
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.frame = view.layer.bounds
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer.flatMap { view.layer.addSublayer($0) }
        
        captureSession?.startRunning()
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported",
                                   message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    private func sutupHighlight() {
        scaneCodeFrameView = UIView()
        
        guard let scaneCodeFrameView = scaneCodeFrameView else { return }
        
        scaneCodeFrameView.layer.borderColor = UIColor.green.cgColor
        scaneCodeFrameView.layer.borderWidth = 3
        view.addSubview(scaneCodeFrameView)
        view.bringSubviewToFront(scaneCodeFrameView)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
        
        guard metadataObjects.count > 0 else {
            scaneCodeFrameView?.frame = .zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
        
        guard let stringValue = metadataObject.stringValue else { return }
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
        scaneCodeFrameView?.frame = barCodeObject?.bounds ?? .zero
        
        messageLabel.text = stringValue
        
        //        let str = "https://www.google.com/search?q=\(stringValue)"
        //        let str = "https://cse.google.com/cse/publicurl?cx=\(stringValue)"
        //        let str2 = "https://www.googleapis.com/customsearch/v1?key=AIzaSyAv8b6SqZ_AmbH3kucL7Ttz8CyKnRn2jDI&cx=015261035819156121642:qj7jmhlymjw&q&q=\(stringValue)&cr=countryUA"
        let str = "https://www.googleapis.com/customsearch/v1?key=AIzaSyBaPxycT3gj82T5qm66XGgIvtSEP31LISo&cx=015261035819156121642:qj7jmhlymjw&q=\(stringValue) склад"
        guard let url = URL(string: str) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            let responseArray = try? decoder.decode([ProductItem].self, from: data)
            responseArray?.forEach({
                print($0.snippet)
            })
            
            
        }
        
        task.resume()
        
        
        
        //        UIApplication.shared.open(url)
        
        //        dismiss(animated: true)
    }
}
