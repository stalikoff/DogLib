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
                it("next image not nil") {
                    var result: UIImage?

                    library.getNextImage { imageResult in
                        if case let .success(image) = imageResult {
                            result = image
                        }
                    }

                    expect(result).toEventuallyNot(beNil(),
                                                timeout: DispatchTimeInterval.seconds(5))
                }

                it("previous image nil") {
                    var dogError: DogError?

                    library.getPreviousImage { imageResult in
                        if case let .failure(error) = imageResult {
                            dogError = error
                        }
                    }

                    expect(dogError).toEventually(equal(.previousImageNilError),
                                                timeout: DispatchTimeInterval.seconds(1))
                }
            }

            describe("Testing load images") {
                var imagesCount = 0

                it("test get one image") {
                    library.getImage { imageResult in
                        if case .success(_) = imageResult {
                            imagesCount = 1
                        }
                    }
                    expect(imagesCount).toEventually(equal(1),
                                                timeout: DispatchTimeInterval.seconds(5))
                }

                it("test get 3 images") {
                    library.getImages(number: 3, completion: { imageResult in
                        if case let .success(images) = imageResult {
                            imagesCount = images.count
                        }
                    })
                    expect(imagesCount).toEventually(equal(3),
                                                timeout: DispatchTimeInterval.seconds(5))
                }
            }
        }
    }
}
