//
//  SubtractionSpec.swift
//  DogLib
//
//

@testable import DogLib
import Quick
import Nimble

class DoglibSpec: QuickSpec {
    override func spec() {
        describe("Subtraction") {
            var subtraction: DogLib!

            beforeEach {
              subtraction = DogLib()
            }

            it("can subtract one number from the first one") {
//                expect(subtraction.subtract(number1: 3, number2: 2)) == 1
            }
        }
    }
}
