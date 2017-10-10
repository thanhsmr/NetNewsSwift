//
//  StringExtension.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

extension String {
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    static func localize(_ key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        //        let regEx = "\\d{8}$"//"^[+0-9]{0,1}+[0-9]"
        //        let regEx = "^[0-9+]+-[0-9]*$"
        let regEx = "\\++[0-9 -]*"   // for input must start at "+" and allow number, '-' and ' '
        return regCheck(regEx: regEx)
    }
    
    func isNumberic() -> Bool {
        let regEx = "^[0-9,.]*$" //"^[0-9]*$"
        return regCheck(regEx: regEx)
    }
    
    func isValidPassword() -> Bool {
        //let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_+|}{:\"?><.]).{8,}$"
        let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        return regCheck(regEx: regEx)
    }
    
    func isValidUserName() -> Bool {
        let regEx = "^[A-Za-z][a-zA-Z0-9-._]{5,16}$"
        return regCheck(regEx: regEx)
    }
    
    private func regCheck(regEx: String) -> Bool {
        let regTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return regTest.evaluate(with: self)
    }

    func getTextHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func isToDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let yourDate = formatter.date(from: self)
        let calendar = NSCalendar.autoupdatingCurrent
        
        if calendar.isDateInToday(yourDate!) {
            return "Hôm nay"
        }
        
        if calendar.isDateInYesterday(yourDate!) {
            return "Hôm qua"
        }
        
        return self
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension NSAttributedString {
    
    public convenience init?(HTMLString html: String, font: UIFont? = nil) throws {
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        
        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }
        
        
        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSFontAttributeName] = font
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
        
    }
    
}


