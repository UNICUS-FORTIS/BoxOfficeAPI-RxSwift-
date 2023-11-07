//
//  NetworkError.swift
//  BoxOfficeAPI-RxSwift
//
//  Created by LOUIE MAC on 11/6/23.
//

import Foundation


enum NetworkError: Int, Error {
    
    case parseError
    case urlError
    case statusError
    
    var errorDescription: String {
        switch self {
        case .parseError:
            return "Parsing 에러 발생"
        case .urlError:
            return "URL 에러 발생"
        case .statusError:
            return "상태 에러 발생"
        }
    }
}
