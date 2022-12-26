# DogLib

DogLibrary is a library that get random dog images from public API https://dog.ceo/dog-api/ and save them in local database.
Library use Alamofire framework for network, CoreData for storage and Quick/Nimble for unit testing.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Example project use MVP architecture pattern.

![Simulator Screen Shot](https://user-images.githubusercontent.com/9357445/209521480-d35edf91-42ff-491d-a88d-ace38878f46b.png)

## Requirements

iOS 12.0+
Swift 5.0+

## Installation

DogLib is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DogLib'

or

pod 'DogLib', :git => 'https://github.com/stalikoff/DogLib'

```

## Usage 
```ruby
let dogLibrary = DogLibrary()

dogLibrary.getNextImage { [weak self] image in
    DispatchQueue.main.async {
        self?.imageView.image = image
    }
}

dogLibrary.getPreviousImage { [weak self] image, isFirst in
    DispatchQueue.main.async {
        self?.imageView.image = image
    }
}


```
Also you can use methods: 

```ruby
dogLibrary.getImages()
```
to fetch from api and save in cache one image 

```ruby
dogLibrary.getImages(number: number)
```
to fetch from api and save in cache number of images 

```ruby
dogLibrary.clearSavedImages()
```
to clear library cache 


## Author

Oleg Vasilev, o.vasilev@danycom.ru

## License

DogLib is available under the MIT license. See the LICENSE file for more info.
