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
        let translate = AnimationType.vector(CGVector(dx: 0, dy: 50))
        
        let animationCompleteExpectation = expectation(description: "Animate with multiple transforms")
        
        view.animate(animations: [zoom, translate]) {
            animationCompleteExpectation.fulfill()
            XCTAssert(view.transform == preTransform)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testTransformOnReverse() {
        let view = UIView()
        
        let rotate = AnimationType.rotate(angle: CGFloat.pi)
        let translate = AnimationType.vector(CGVector(dx: 20, dy: 0))
        let animations = [rotate, translate]
        
        var expectedTransform = view.transform
        animations.forEach { expectedTransform = expectedTransform.concatenating($0.initialTransform) }
        
        let animationCompleteExpectation = expectation(description: "Animate with multiple transforms")
        
        view.animate(animations: animations, reversed: true) {
            animationCompleteExpectation.fulfill()
            XCTAssert(view.transform == expectedTransform)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

