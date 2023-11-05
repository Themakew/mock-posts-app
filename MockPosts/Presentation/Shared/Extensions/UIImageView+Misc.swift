//
//  UIImageView+Misc.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-04.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImageWithKingfisher(
        _ urlString: String?,
        placeholder: UIImage? = nil,
        onFailureImage: UIImage? = UIImage(named: "placeholder-icon")
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeholder // Set the placeholder image only if the URL is invalid
            return
        }

        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(2)),
                .cacheOriginalImage,
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    debugPrint("Image downloaded: \(value.image)")
                case .failure:
                    self.image = onFailureImage
                }
            }
        )
    }
}
