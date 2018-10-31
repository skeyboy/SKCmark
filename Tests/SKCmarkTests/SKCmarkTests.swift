import XCTest
import Foundation
@testable import SKCmark

final class SKCmarkTests: XCTestCase {
    let textH1 = "# Hello"
    let text  = "我是一个简单的文本( ⊙ o ⊙ )啊！👌"
    let img = """
 ![我是一个img](https://www.baidu.com)
"""
     func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
       
    }
    
    func testOption(){
    let result = [MarkdownOption.noBreaks, MarkdownOption.validateUt8].rawValue
       
        XCTAssertEqual(result,  Int32(1 << 4) | Int32(1 << 9) )
    }
    
    func testDefault(){
        do{
            let result = try skMarkdownToHTML(textH1)
            XCTAssertEqual(result, "<h1>Hello</h1>\n")
        }catch{
            XCTAssertThrowsError(error)
        }
        do{
            let result = try skMarkdownToHTML(img)
            XCTAssertEqual(result, "<p><img src=\"https://www.baidu.com\" alt=\"我是一个img\" /></p>\n")
        }catch{
            XCTAssertThrowsError(error)

        }
    }
    func testText()  {
        do{
            let result = try skMarkdownToHTML(text)
            XCTAssertEqual(result, "<p>我是一个简单的文本( ⊙ o ⊙ )啊！👌</p>\n")
        }catch{
            XCTAssertThrowsError(error)
        }
        
        do{
            let result = try skMarkdownToHTML(text, options: [MarkdownOption.noBreaks])
            XCTAssertEqual(result, "<p>我是一个简单的文本( ⊙ o ⊙ )啊！👌</p>\n")
        }catch{
            XCTAssertThrowsError(error)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
