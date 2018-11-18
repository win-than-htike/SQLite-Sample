//
//  FontDetect.swift
//
//  Created by Win Than Htike on 8/7/18.
//  Copyright © 2018 MMDS. All rights reserved.
//

import UIKit

public struct FontDetect {
    
    public static let IS_UNICODE = "is_unicode"
    
    public static let IS_LOADED = "is_loaded"
    
    public static func detectFont() -> Bool {
        
        UserDefaults.standard.set(true, forKey: IS_LOADED)
        
        var fontFamilies = UIFont.familyNames
        
        for i in 0..<fontFamilies.count {
            let fontNames = UIFont.fontNames(forFamilyName: fontFamilies[i])
            print(fontNames)
            for name in fontNames {
                if name.lowercased().range(of: "zaw") != nil {
                    UserDefaults.standard.set(false, forKey: IS_UNICODE)
                    return false
                }
            }
        }
        UserDefaults.standard.set(true, forKey: IS_UNICODE)
        return false
        
    }
    
    public static func isUnicode() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_UNICODE)
    }
    
}
