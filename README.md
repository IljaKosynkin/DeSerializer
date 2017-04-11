# DeSerializer
Lightweight framework for automatic JSON mapping. 

# Description
Framework for automatic JSON deserialization. Wrapper around KlappaDeSerializer 
with more Swifty syntax and better support for Swift features.

# Installation
Add:
```
    pod ‘DeSerializer’
```
to your Podfile.

Then run:
```
    pod install
```
or:
```
    pod update
```
And you're free to go.

# Usage
## Simple case
Library provides class with static methods called KLPDeserializer and it's highly encouraged to use it. 
Lets consider following JSON object:
```json
{
    "name": "A green door",
    "price": 12.50
}
```

```swift
class SimpleObject: Ancestor {
    var name: String!
    var price: NSDecimalNumber!
    
    override static func getRequiredFields() -> [Any]! {
        return ["name"]
    }
}
```
