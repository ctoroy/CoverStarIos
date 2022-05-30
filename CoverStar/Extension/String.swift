//
//  String.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/02.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    private func getDate(datetime: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzz"
        var temp = datetime
        let array = datetime.split(separator: ".")
        if array.count == 2 { temp = String(array[0]) }
        guard let date = dateFormatter.date(from: temp + " +0000") else { return Date() }
        return date
    }

//    func displayTime() -> String {
//
//        let local = getDate(datetime: self)
//        if Calendar.current.isDateInToday(local) { return getLocalTime() }
//        if Calendar.current.isDateInYesterday(local) { return I18N.yesterday }
//        return getLocalDate()
//    }
    
    func getLocalDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: getDate(datetime: self))
    }

    func getLocalTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: getDate(datetime: self))
    }
    
    func getCurrentTime() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateToConvert = formatter.string(from: date)
        let convertedDate = formatter.date(from: dateToConvert)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
    }
    
    func trim() -> String {
        
        if self == "null" || self == "<null>" { return "" }
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func encodeText() -> String {
        
        let data = self.trim().data(using: .utf8)!
        return data.base64EncodedString().replace("+", "%2B")
    }

    func decodeText() -> String {
        
        guard let data = Data(base64Encoded: self.trim()) else { return "?" }
        return String(data: data, encoding: .utf8)!
    }

    func urlEncode() -> String {
        
        return self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
    }
    
    func subString(startIndex: Int = 0, length: Int) -> String {
        
        let endIndex = startIndex + length - 1
        
        if self.count <= endIndex { return self }
        
        let end = (endIndex - self.count) + 1
        let indexStartOfText = self.index(self.startIndex, offsetBy: startIndex)
        let indexEndOfText = self.index(self.endIndex, offsetBy: end)
        let substring = self[indexStartOfText..<indexEndOfText]
        return String(substring)
    }

    func replace(_ from: String, _ to: String) -> String {
        
        return self.replacingOccurrences(of: from, with: to)
    }
    
    func split(_ delimeter: String) -> [String] {
        
        return self.components(separatedBy: delimeter)
    }
    
    func indexOf(_ subString: String) -> Int {
        
        let range = self.range(of: subString)
        return range == nil ? -1 : (range?.lowerBound.encodedOffset)!
    }
    
    func deserialize() -> NSDictionary? {
        
        return self.data(using: .utf8)?.deserialize()
    }

    
}

extension Data {

    func deserialize() -> NSDictionary? {
        do {
            guard let dict = try JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary else { return nil }
            return dict
        } catch {
            print("[DEBUG]", error)
            return nil
        }
    }

    func deserializeToArray() -> NSArray? {
        do {
            guard let array = try JSONSerialization.jsonObject(with: self, options: []) as? NSArray else { return nil }
            return array
        } catch {
            print("[DEBUG]", error)
            return nil
        }
    }

    
}

extension NSDictionary {
    
    func serialize() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    
}
