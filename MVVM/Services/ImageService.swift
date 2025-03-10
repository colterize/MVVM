//
//  ImageServicr.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation

protocol ImageService {
    func fetchImage(with stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}
