//
//  SubtractionSpec.swift
//  DogLib
//
//

@testable import DogLib
import Quick
import Nimble
//import quic

class DogLibrarySpec: QuickSpec {
    override func spec() {
        describe("Subtraction") {
            var library: DogLibrary!

            beforeEach {
                library = DogLibrary()
                library.getNextImage { image in

                }
            }

            it("test next image") {
                var imageTest: UIImage?

                library.getPreviousImage { image, isPrevious in
                    imageTest = image
                }

                it("previous image should not be nil") {
                    expect(imageTest != nil)
                }


//                library.getNextImage { <#UIImage?#> in
//                    <#code#>
//                }
            }




//            it("can subtract one number from the first one") {
//                expect(library.getNextImage(completion: { <#UIImage?#> in
//                    <#code#>
//                }))
//                expect(subtraction.subtract(number1: 3, number2: 2)) == 1
//            }
        }
    }

    func testStart() {
        print("")
    }

}
