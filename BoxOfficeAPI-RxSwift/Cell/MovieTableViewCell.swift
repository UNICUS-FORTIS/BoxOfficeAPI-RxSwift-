//
//  MovieTableViewCell.swift
//  BoxOfficeAPI-RxSwift
//
//  Created by LOUIE MAC on 11/8/23.
//

import UIKit
import SnapKit

final class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    let rank = UILabel()
    let titleLabel = UILabel()
    let totalAudience = UILabel()
    
    lazy var labelArray = [rank, titleLabel, totalAudience]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = ColorPreset.backgroundColor
        labelArray.forEach {
            contentView.addSubview( $0 )
            $0.textColor = ColorPreset.contents
            $0.font = .systemFont(ofSize: 13)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }
    
    private func setConstraints() {
        rank.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rank.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView).multipliedBy(0.45)
        }
        
        totalAudience.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
        }
    }
}
