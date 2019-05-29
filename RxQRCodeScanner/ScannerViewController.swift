//
//  ScannerViewController.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

public extension Reactive where Base: ScannerViewController {
    
    var qrCode: Signal<String> { return base.stringRelay.asSignal() }
}

public class ScannerViewController: UIViewController {
    
    @IBOutlet private weak var cameraView: UIView!
    
    private let viewModel = ScannerViewModel()
    private let bag = DisposeBag()
    
    fileprivate let stringRelay = PublishRelay<String>()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
}

//MARK: Bindings
private extension ScannerViewController {
    
    func bind() {
        let output = viewModel.transform(input: .init(viewWillAppear: rx.viewWillAppear.asDriver(),
                                                      viewWillDisappear: rx.viewWillDisappear.asDriver()))
        output.stringObserver.take(1).bind(to: stringRelay).disposed(by: bag)
        output.stringObserver.map { _ in true }.bind(to: rx.dismiss).disposed(by: bag)
        cameraView.layer.addSublayer(output.previewLayer)
    }
}

//MARK: - Actions
private extension ScannerViewController {
    
    @IBAction func closeAction() { dismiss(animated: true) }
}
