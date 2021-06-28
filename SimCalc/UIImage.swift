//
//  UIImage.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/28.
//

import UIKit

extension UIImage {
    func paintOver(with color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        let renderedImage = renderer.image { (context) in
            color.set()
            self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: self.size))
        }
        return renderedImage
    }
}
