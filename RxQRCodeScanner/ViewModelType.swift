//
//  ViewModelType.swift
//  RxQRCodeScanner
//
//  Created by Dmitry Golub on 5/28/19.
//  Copyright © 2019 Dmitry Holub. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
