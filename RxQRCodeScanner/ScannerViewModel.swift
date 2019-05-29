//
//  ScannerViewModel.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa

class ScannerViewModel {
    
    private var captureSession: AVCaptureSession!
    private var metadataOutput: AVCaptureMetadataOutput!
    private let bag = DisposeBag()
    
    init() {
        captureSession = AVCaptureSession()
        guard let videoInput = getVideoInput(), captureSession.canAddInput(videoInput) else { return }
        captureSession.addInput(videoInput)
        configureMetadataOutput()
    }
}

//MARK: - ViewModelType
extension ScannerViewModel: ViewModelType {
    
    struct Input {
        let viewWillAppear: Driver<Bool>
        let viewWillDisappear: Driver<Bool>
    }
    
    struct Output {
        let previewLayer: AVCaptureVideoPreviewLayer
        let stringObserver: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear.drive(captureSession.rx.play).disposed(by: bag)
        input.viewWillDisappear.drive(captureSession.rx.stop).disposed(by: bag)
        return Output(previewLayer: getPreviewLayer(),
                      stringObserver: metadataOutput.rx.didFindQrData)
    }
}

//MARK: - Private
private extension ScannerViewModel {
    
    func getVideoInput() -> AVCaptureDeviceInput? {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return nil }
        return try? AVCaptureDeviceInput(device: videoCaptureDevice)
    }
    
    func configureMetadataOutput() {
        metadataOutput = AVCaptureMetadataOutput()
        guard captureSession.canAddOutput(metadataOutput) else { return }
        captureSession.addOutput(metadataOutput)
        metadataOutput.metadataObjectTypes = [.qr]
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }
}

