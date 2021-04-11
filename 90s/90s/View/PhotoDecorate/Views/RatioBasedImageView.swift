//
//  RatioBasedImageView.swift
//  90s
//
//  Created by woong on 2021/04/10.
//

import UIKit


// 참고: https://stackoverflow.com/a/58075706
class RatioBasedImageView : UIImageView {
    /// constraint to maintain same aspect ratio as the image
    private var aspectRatioConstraint:NSLayoutConstraint? = nil

    // This makes it use the correct size in Interface Builder
    public override func prepareForInterfaceBuilder() {
        invalidateIntrinsicContentSize()
    }

    @IBInspectable
    var maxAspectRatio: CGFloat = 999 {
        didSet {
            updateAspectRatioConstraint()
        }
    }

    @IBInspectable
    var minAspectRatio: CGFloat = 0 {
        didSet {
            updateAspectRatioConstraint()
        }
    }


    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }

    public override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }

    public override init(image: UIImage!) {
        super.init(image:image)
        self.setup()
    }

    public override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image:image,highlightedImage:highlightedImage)
        self.setup()
    }

    override public var image: UIImage? {
        didSet { self.updateAspectRatioConstraint() }
    }

    private func setup() {
        self.updateAspectRatioConstraint()
    }

    /// Removes any pre-existing aspect ratio constraint, and adds a new one based on the current image
    private func updateAspectRatioConstraint() {
        // remove any existing aspect ratio constraint
        if let constraint = self.aspectRatioConstraint {
            self.removeConstraint(constraint)
        }
        self.aspectRatioConstraint = nil

        if let imageSize = image?.size, imageSize.height != 0 {
            var aspectRatio = imageSize.width / imageSize.height
            aspectRatio = max(minAspectRatio, aspectRatio)
            aspectRatio = min(maxAspectRatio, aspectRatio)

            let constraint = NSLayoutConstraint(item: self, attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self, attribute: .height,
                                       multiplier: aspectRatio, constant: 0)
            constraint.priority = .required
            self.addConstraint(constraint)
            self.aspectRatioConstraint = constraint
        }
    }
}
