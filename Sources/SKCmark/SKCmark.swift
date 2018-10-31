//
//  SKCmark.swift
//  cmark
//
//  Created by sk on 2018/10/31.
//

import Foundation
import cmark
public typealias MarkdownOption = Int32
extension MarkdownOption {
  public  static var sourcePosition = Int32(1 << 1)
  public  static var hardBreaks = Int32(1 << 2)
  public  static var safe = Int32(1 << 3)
  public  static var noBreaks = Int32(1 << 4)
  public  static var normalize = Int32(1 << 8)
 public   static var validateUt8 = Int32(1 << 9)
  public  static var smartQuotes =  Int32(1 << 10)
}
public enum SKCmarkError: Error{
    case conversionFailed
}
extension Array  {
    var rawValue:MarkdownOption{
        var value : MarkdownOption = self.first! as! MarkdownOption
        for item in 1 ..< self.count {
            value = value | ( self[item] as! MarkdownOption)
        }
        return value
    }
}
public func skMarkdownToHTML(_ str: String, options : [MarkdownOption ] = [MarkdownOption.safe] ) throws -> String {
    var buffer: String?
    try str.withCString {
        guard let buf = cmark_markdown_to_html($0, Int(strlen($0)), options.rawValue) else {
            throw SKCmarkError.conversionFailed
        }
        buffer = String(cString: buf)
        free(buf)
    }
    guard let output = buffer else {
        throw SKCmarkError.conversionFailed
    }
    return output
}
