

# Clima

![App Brewery Banner](Documentation/AppBreweryBanner.png)

## Our Goal

It’s time to take our app development skills to the next level. We’re going to introduce you to the wonderful world of Application Programming Interfaces (APIs) to grab live data from the internet. If you’re dreaming of making that Twitter-powered stock trading app then you’re about add some serious tools to your toolbelt!

## What you will create

By the end of the module, you will have made a beautiful, dark-mode enabled weather app. You'll be able to check the weather for the current location based on the GPS data from the iPhone as well as by searching for a city manually.

## What you will learn

* How to create a dark-mode enabled app.
  * use system colors
  * use different background images for different modes
  * or you can create custom colors
* How to use vector images as image assets.
  * scales: Single Scale
  * Appearances: Any, Light, Dark
* Learn to use the UITextField to get user input.

```swift
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        doSomething(text)
    }
}
```

* Learn about the delegate pattern.

```swift
struct SomeStruct{
    delegate: SomeDelegate?

    func doSomething() {
        delegate?.doSomething()
    }
}

```

* Swift protocols and extensions.

```swift
protocol Flyable {
    func fly()
}

extension Flyable {
    func fly() {
        print("flying...")
    }
}
extension Double {
    round(places: Int) {
        var x = pow(10, places)
        var n = self
        n = n * x
        n = round(n)
        return n/x
}

var doubleNum = 99.9999
doubleNum.round(2) // 99.99
```

* Swift guard keyword.
* Swift computed properties.

```swift
struct WeatherData: Decodable {
    var city: City
    var cityName: String {
        city.name
    }
}
```

* Swift closures and completion handlers.

```swift
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    doSomething(data)
}
```

* Learn to use URLSession to network and make HTTP requests.

```swift
let url = URL(string: "some url")
guard let url = url else { return }
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        self.handleClientError(error)
        return
    }
    guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        self.handleServerError(response)
        return
    }
    
    guard let data = data else { return }
    
    doSomething(data) // for example: weatherDidUpdate(weather: WeatherData)

}
task.resume()
```

* Parse JSON with the native Encodable and Decodable protocols.

```swift
do {
    let parsedData = try JSONDecoder().decode(someStruct.self, from: data)
    doSomething(with: parsedData)
} catch {
    handleError(error)
}
```

* Learn to use Grand Central Dispatch to fetch the main thread.

```swift
// this function is called in a completion callback, see previous paragraph
 func weatherDidUpdate(weather: WeatherData) {
    DispatchQueue.main.schedule {
        self.conditionImageView.image = UIImage(systemName: weather.condition)
        self.temperatureLabel.text = String(format: "%.1f", weather.temperature)
        self.cityLabel.text = weather.cityName
    }
}

```

* Learn to use Core Location to get the current location from the phone GPS.

* you have to modify info.plist first, add `NSLocationWhenInUseUsageDescription` as key and a reason why you ask for the location privacy as value.

```swift
import UIKit
import CoreLocation
class WeatherViewController: UIViewController {
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self   
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Call this method whenever your code no longer needs to receive location-related events. Disabling event delivery gives the receiver the option of disabling the appropriate hardware (and thereby saving power) when no clients need location data. You can always restart the generation of location updates by calling the startUpdatingLocation() method again.
        manager.stopUpdatingLocation()
        doSomething(with: location)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
```

* How to use system image

```swift
let image = UIImage(systemName: ...)
```

### Condition Codes

```swift
switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
```

>This is a companion project to The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)
