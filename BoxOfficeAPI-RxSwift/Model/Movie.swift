//
//  Movie.swift
//  BoxOfficeAPI-RxSwift
//
//  Created by LOUIE MAC on 11/6/23.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: MovieData
}

struct MovieData: Decodable {
    let boxofficeType, showRange: String
    let yearWeekTime: String?
    let dailyBoxOfficeList: [MovieBoxList]
}

// MARK: - DailyBoxOfficeList
struct MovieBoxList: Decodable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: String
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}

