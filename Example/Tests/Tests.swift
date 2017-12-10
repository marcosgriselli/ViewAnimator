import UIKit
import XCTest
import ViewAnimator

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPreservesTransform() {
        let view = UIView()
        let preTransform = CGAffineTransform(rotationAngle: 3.14)
        view.transform = preTransform
        
        let zoom = AnimationType.zoom(scale: 2.5)
        let translate = AnimationType.from(direction: .bottom, offset: 50)
        
        let animationCompleteExpectation = expectation(description: "Animate with multiple transforms")
        
        view.animate(animations: [zoom, translate]) {
            animationCompleteExpectation.fulfill()
            XCTAssert(view.transform == preTransform)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

