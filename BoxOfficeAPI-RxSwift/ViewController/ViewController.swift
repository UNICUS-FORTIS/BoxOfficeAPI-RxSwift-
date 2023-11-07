//
//  ViewController.swift
//  BoxOfficeAPI-RxSwift
//
//  Created by LOUIE MAC on 11/6/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    private let apiService = APIService()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    var items = PublishSubject<[MovieBoxList]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configure()
        setConstraints()
        bind()
    }
    
    private func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier,
                                          cellType: MovieTableViewCell.self)) { (row, element, cell) in
                cell.rank.text = element.rank
                cell.titleLabel.text = element.movieNm
                cell.totalAudience.text = "관객수 : \(element.audiAcc)"
            }.disposed(by: disposeBag)
        
        searchBar
            .rx
            .searchButtonClicked
            .throttle(.seconds(1),
                      scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty) { _ , query in
                return query
            }.flatMap { self.apiService.fetchMovieData(date: $0) }
            .subscribe(with: self) { owner, movie in
                let data = movie.boxOfficeResult.dailyBoxOfficeList
                owner.items.onNext(data)
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = ColorPreset.backgroundColor
        view.addSubview(searchBar)
        view.addSubview(tableView)
        navigationItem.titleView = searchBar
        searchBar.tintColor = .orange
        searchBar.searchTextField.textColor = .orange
        searchBar.placeholder = "검색할 날짜를 입력하세요."
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self,
                           forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 50
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

