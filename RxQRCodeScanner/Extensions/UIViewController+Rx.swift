//
//  UIViewController+Rx.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    var dismiss: Binder<Bool> {
        return Binder(base) { viewController, animated in
            viewController.dismiss(animated: animated)
        }
    }
    
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
