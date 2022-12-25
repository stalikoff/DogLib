//
//  SubtractionSpec.swift
//  DogLib
//
//

@testable import DogLib
import Quick
import Nimble

class DogLibrarySpec: QuickSpec {
    override func spec() {
        describe("DogLibrary") {
            var library: DogLibrary!

            beforeEach {
                library = DogLibrary()
            }

            describe("Testing next previous methods") {
                var result: UIImage?

                it("next image not nil") {
                    library.getNextImage { image in
                        result = image
                    }

                    expect(result).toEventuallyNot(beNil(),
                                                timeout: DispatchTimeInterval.seconds(5))
                }

                it("previous image nil") {
                    library.getPreviousImage { image, isFirst in
                        result = image
                    }

                    expect(result).toEventually(beNil(),
                                                timeout: DispatchTimeInterval.seconds(1))
                }
            }

            describe("Testing load images") {
                var imagesCount = 0

                it("test get one image") {
                    library.getImage { imageData in
                        if imageData != nil {
                            imagesCount = 1
                        }
                    }
                    expect(imagesCount).toEventually(equal(1),
                                                timeout: DispatchTimeInterval.seconds(5))
                }

                it("test get 3 images") {
                    library.getImages(number: 3, completion: { images in
                        imagesCount = images?.count ?? 0
                    })
                    expect(imagesCount).toEventually(equal(3),
                                                timeout: DispatchTimeInterval.seconds(5))
                }
            }
        }
    }
}
