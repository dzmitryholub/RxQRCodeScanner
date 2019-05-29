//
//  AVCaptureSession+Rx.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa

extension Reactive where Base: AVCaptureSession {
    
    var play: Binder<Bool> {
        return Binder(base) { session, _ in
            guard !session.isRunning else { return }
            session.startRunning()
        }
    }
    
    var stop: Binder<Bool> {
        return Binder(base) { session, _ in
            guard session.isRunning else { return }
            session.stopRunning()
        }
    }
}
