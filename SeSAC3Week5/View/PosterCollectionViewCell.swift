//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 박소진 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //재사용할 때 준비할 사항있니? - 이전 이미지 흔적 지워줘!!
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil //or 플레이스홀더 이미지 같은 거
    }

}
