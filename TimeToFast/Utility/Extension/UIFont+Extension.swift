//
//  UIFont+Extension.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit

extension UIFont {
    static func preferredFont(forTextStyle: TextStyle, weight: Weight) -> UIFont {
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: forTextStyle)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: forTextStyle)
        
        return metrics.scaledFont(for: font)
    }
}
