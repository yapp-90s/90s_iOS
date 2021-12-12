//
//  ShareItem.swift
//  90s
//
//  Created by woongs on 2021/12/12.
//

import UIKit
import LinkPresentation

class ShareItem: NSObject, UIActivityItemSource {
    
    let image: UIImage
    let placeholder: String
    
    init(image : UIImage, placeholder: String) {
        self.image = image
        self.placeholder = placeholder
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.placeholder
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return self.image
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let imageProvider = NSItemProvider(object: self.image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        metadata.title = placeholder
        return metadata
    }
}
