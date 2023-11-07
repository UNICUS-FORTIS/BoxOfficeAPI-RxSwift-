//
//  MovieViewModel.swift
//  BoxOfficeAPI-RxSwift
//
//  Created by LOUIE MAC on 11/6/23.
//

import Foundation
import RxSwift


final class APIService {
    
    private let key = "9129b708154013c13ca0a53c21af849b"
    
    func fetchMovieData(date: String) -> Observable<Movie> {
        
        return Observable<Movie>.create { observer in
            
            guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(self.key)&targetDt=\(date)") else {
                observer.onError(NetworkError.urlError)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("DataTask Succeed")
                if let _ = error {
                    observer.onError(NetworkError.parseError)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(NetworkError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(Movie.self, from: data) {
                    observer.onNext(appData)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}
