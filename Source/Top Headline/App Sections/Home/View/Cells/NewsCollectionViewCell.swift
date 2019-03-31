//
//  NewsCollectionViewCell.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {
    
    struct Model {
        let title: String?
        let author: String?
        let urlToImage: String?
        let publishedAt: String?
    }
    
    @IBOutlet weak var articlePicture: UIImageView!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    
    func setupStyle() {
        
    }
    
    func fill(with model: Model) {
        publishDateLabel.text = model.publishedAt
        titleLabel.text = model.title
        authorLabel.text = model.author
        guard let urlToImage = model.urlToImage, let url = URL(string: urlToImage) else { return }
        articlePicture.kf.setImage(with: url, placeholder: UIImage(named: "imagePlaceholder"))
    }

}
