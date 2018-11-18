//
//  LanguageUtil.swift
//
//  Created by Win Than Htike on 8/14/18.
//  Copyright © 2018 MMDS. All rights reserved.
//

import Foundation
import UIKit
import Rabbit_Swift

class LanguageUtil {
    
    public static func changeLanguage(key : String) -> String {
        if UserDefaults.standard.bool(forKey: SharedConstants.MM) {
            let data = AppData.stringmy
            
            if let str = data[key] {
                return str.html2String
            } else {
                
                return key
            }
            
        } else {
            let data = AppData.stringen
            if let str = data[key] {
                return str.html2String
            } else {
                return key
            }
        }
    }
    
    public static func changeLanguage(key : String, _ isTextField : Bool) -> String {
        if UserDefaults.standard.bool(forKey: SharedConstants.MM) {
            let data = AppData.stringmy
            
            if isTextField && !FontDetect.isUnicode() {
             
                if let str = data[key] {
                    return Rabbit.uni2zg(unicode: str.html2String)
                } else {
                    return key
                }
                
            } else {
                
                if let str = data[key] {
                    return str.html2String
                } else {
                    return key
                }
                
            }
            
        } else {
            let data = AppData.stringen
            if let str = data[key] {
                return str.html2String
            } else {
                return key
            }
        }
    }
    
    public static func forceFontLabel(label : UILabel, size : CGFloat) {
        if UserDefaults.standard.bool(forKey: SharedConstants.MM) {
            let font = UIFont(name: "Myanmar3", size: size)
            label.font = font
        } else {
            let font = UIFont(name: "AvenirNext-Regular", size: size)
            label.font = font
        }
    }
    
    public static func forceFontTextField(textField : UITextField, size : CGFloat) {
        if UserDefaults.standard.bool(forKey: SharedConstants.MM) {
            if !FontDetect.isUnicode() {
                let font = UIFont(name: "Myanmar3", size: size)
                textField.font = font
            } else {
                
            }
        } else {
            let font = UIFont(name: "AvenirNext-Regular", size: size)
            textField.font = font
        }
    }
    
    public static func forceFontButton(button : UIButton, size : CGFloat) {
        if UserDefaults.standard.bool(forKey: SharedConstants.MM) {
            let font = UIFont(name: "Myanmar3", size: size)
            button.titleLabel?.font = font
        } else {
            let font = UIFont(name: "AvenirNext-Regular", size: size)
            button.titleLabel?.font = font
        }
    }
    
}
