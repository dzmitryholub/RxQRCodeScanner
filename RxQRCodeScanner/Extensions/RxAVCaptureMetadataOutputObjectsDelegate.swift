//
//  RxAVCaptureMetadataOutputObjectsDelegate.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa

class RxAVCaptureMetadataOutputObjectsProxy: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate>, DelegateProxyType, AVCaptureMetadataOutputObjectsDelegate {
    
    weak private(set) var output: AVCaptureMetadataOutput?
    
    init(output: ParentObject) {
        self.output = output
        super.init(parentObject: output, delegateProxy: RxAVCaptureMetadataOutputObjectsProxy.self)
    }
    
    static func registerKnownImplementations() {
        register { RxAVCaptureMetadataOutputObjectsProxy(output: $0) }
    }
    
    static func currentDelegate(for object: AVCaptureMetadataOutput) -> AVCaptureMetadataOutputObjectsDelegate? {
        return object.metadataObjectsDelegate
    }
    
    static func setCurrentDelegate(_ delegate: AVCaptureMetadataOutputObjectsDelegate?, to object: AVCaptureMetadataOutput) {
        object.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
    }
}

extension Reactive where Base: AVCaptureMetadataOutput {
    
    var delegate: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate> {
        return RxAVCaptureMetadataOutputObjectsProxy.proxy(for: base)
    }
    
    var didFindQrData: Observable<String> {
        let selector = #selector(AVCaptureMetadataOutputObjectsDelegate.metadataOutput(_:didOutput:from:))
        let delegate: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate> = self.delegate
        return delegate.methodInvoked(selector).map { metadataObjects in
            guard let object = (metadataObjects[1] as? [Any])?.last as? AVMetadataMachineReadableCodeObject, let string = object.stringValue else { return "" }
            return string
        }
    }
}

