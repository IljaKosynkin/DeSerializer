# DeSerializer
Lightweight framework for automatic JSON mapping. 

# Description
Framework for automatic JSON deserialization. Wrapper around KlappaDeSerializer 
with more Swifty syntax and better support for Swift features.

# Installation
Add:
```
    pod 'DeSerializer'
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

And according to it class declaration:
```swift
@objc
class SimpleObject: Ancestor {
    @objc var name: String!
    @objc var price: NSDecimalNumber!
    
    override static func getRequiredFields() -> [Any]! {
        return ["name"]
    }
}
```
And then you can deserialize it in the following way:
```swift
let object: SimpleObject? = DeSerializer.deserialize(json: dict)
```
where 'dict' - can be dictionary or JSON string.

## Nested objects
DeSerializer also let you to easily deserialize JSON with nested objects.
Lets consider following JSON object:
```json
{
  "Title": "potato jpg",
  "Summary": "Kentang Si bungsu dari keluarga Solanum tuberosum L ini ternyata memiliki khasiat untuk mengurangi kerutan  jerawat  bintik hitam dan kemerahan pada kulit  Gunakan seminggu sekali sebagai",
  "Url": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
  "ClickUrl": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
  "RefererUrl": "http://www.mediaindonesia.com/mediaperempuan/index.php?ar_id=Nzkw",
  "FileSize": 22630,
  "FileFormat": "jpeg",
  "Height": "362",
  "Width": "532",
  "Thumbnail": {
    "Url": "http://thm-a01.yimg.com/nimage/557094559c18f16a",
    "Height": "98",
    "Width": "145"
  }
}
```
And according to it classes declarations:
```swift
@objc
class Thumbnail: Ancestor {
    @objc var url: String!
    @objc var height: String!
    @objc var width: String!
}

@objc
class NestedObject: Ancestor {
    @objc var title: String!
    @objc var summary: String!
    @objc var url: String!
    @objc var clickUrl: String!
    @objc var refererUrl: String!
    @objc var fileSize: Int = 0
    @objc var fileFormat: String!
    @objc var height: String!
    @objc var width: String!
    @objc var thumbnail: Thumbnail?
}
```

It can be deserialized in exactly the same way it was for simple object:
```swift
let object: NestedObject? = DeSerializer.deserialize(json: dict)
```

## Array parsing
DeSerializer allows you to deserialize objects with array-fields in an easy way.
Let's take a look at following JSON:
```json
{
     "firstName": "John",
     "lastName": "Smith",
     "age": 25,
     "address":
     {
         "streetAddress": "21 2nd Street",
         "city": "New York",
         "state": "NY",
         "postalCode": "10021"
     },
     "phoneNumber":
     [
         {
           "type": "home",
           "number": "212 555-1234"
         },
         {
           "type": "fax",
           "number": "646 555-4567"
         }
     ]
 }
 ```
 And according to it classes' declarations:
 ```swift
 @objc
 class Address: Ancestor {
    @objc var streetAddress: String!
    @objc var city: String!
    @objc var state: String!
    @objc var postalCode: String!
}

@objc
class Phone: Ancestor {
    @objc var type: String!
    @objc var number: String!
}

@objc
class NestedObjectWithArray: Ancestor {
    @objc var firstName: String!
    @objc var lastName: String!
    @objc var age: Int = 0
    @objc var address: Address!
    @objc var phoneNumber: [Phone] = []
}
 ```
 It can be deserialized in exactly the same way as it was in previous cases:
```swift
let object: NestedObjectWithArray? = DeSerializer.deserialize(json: dict)
```

Sometimes you want to not object, but array of objects. DeSerializer let you to do so.
Lets consider following JSON sample:
```json
[
  {
    "Title": "potato jpg",
    "Summary": "Kentang Si bungsu dari keluarga Solanum tuberosum L ini ternyata memiliki khasiat untuk mengurangi kerutan  jerawat  bintik hitam dan kemerahan pada kulit  Gunakan seminggu sekali sebagai",
    "Url": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
    "ClickUrl": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
    "RefererUrl": "http://www.mediaindonesia.com/mediaperempuan/index.php?ar_id=Nzkw",
    "FileSize": 22630,
    "FileFormat": "jpeg",
    "Height": "362",
    "Width": "532",
    "Thumbnail": {
      "Url": "http://thm-a01.yimg.com/nimage/557094559c18f16a",
      "Height": "98",
      "Width": "145"
    }
  },
 {
 "Title": "potato jpg",
 "Summary": "Kentang Si bungsu dari keluarga Solanum tuberosum L ini ternyata memiliki khasiat untuk mengurangi kerutan  jerawat  bintik hitam dan kemerahan pada kulit  Gunakan seminggu sekali sebagai",
 "Url": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
 "ClickUrl": "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg",
 "RefererUrl": "http://www.mediaindonesia.com/mediaperempuan/index.php?ar_id=Nzkw",
 "FileSize": 22630,
 "FileFormat": "jpeg",
 "Height": "362",
 "Width": "532",
 "Thumbnail": {
 "Url": "http://thm-a01.yimg.com/nimage/557094559c18f16a",
 "Height": "98",
 "Width": "145"
 }
 }
]
```
And according classes' declarations:
```swift
@objc
class Thumbnail: Ancestor {
    @objc var url: String!
    @objc var height: String!
    @objc var width: String!
}

class NestedObject: Ancestor {
    @objc var title: String!
    @objc var summary: String!
    @objc var url: String!
    @objc var clickUrl: String!
    @objc var refererUrl: String!
    @objc var fileSize: Int = 0
    @objc var fileFormat: String!
    @objc var height: String!
    @objc var width: String!
    @objc var thumbnail: Thumbnail?
}
```
As you might already have guessed, deserialization is very easy:
```swift
let objects: [NestedObject]? = DeSerializer.deserialize(json: array)
```

# Custom fields mapping
## Naming strategies
Naming strategy - is a class that decides how the name of field from class should be translated to the name in a JSON. 
KlappaDeSerializer provides two strategies out of the box: KLPDefaultNamingStrategy and KLPExplicitNamingStrategy.
Explicit naming strategy is translates field from class one-to-one. For example, if you have field named "awesome_field" it will be translated to field "awesme_field" in the JSON. 
Default naming strategy translates camelCase to snake_case, i.e. if you have field "awesomeField" in your class, library will search for field "awesome_field" in a JSON.
Currently possibility of swapping global strategy on the fly is not supported - it's supposed to be added in next releases.

## Class-local fields mapping
Sometimes you want to set custom mapping for one or two fields for one class and don't set it globally, as with naming strategies. In KlappaInjector you can achieve it in two ways - by implementing function:
```swift
func getCustomFieldsMapping() -> [AnyHashable : Any]!
```
or by implementing function:
```swift
func getNamingStrategy() -> KLPNamingStrategy?
```

In getCustomFieldsMapping function you define how one field will be translated to another. So lets assume you have field "url" in your class and in JSON it corresponds to "super_puper_awesome_url". In such case you can implement function in following way:
```swift
func getCustomFieldsMapping() -> [AnyHashable : Any]! {
    return ["url": "super_puper_awesome_url"];
}
```
However, this will let you to translate fields one by one. If you want to set different naming strategy for class (i.e. one entity in API for some reason have different naming strategy), you should implement getNamingStrategy instead. That fucntion should define strategy of converting class' fields to JSON fields for this particular class.

# Required properties
It's quite common that in your network model you have some fields that are necessary for application to work and you don't want to pass objects that doesn't have those fields. KlappaInjector allows you to specify such required fields. In order to do so, you must implement function:
```swift
func getRequiredFields() -> [Any]!
```
Basically, let consider that you have field "id" in your model class and you want it to be present all the time. In such case, you should implement this function in a following way:
```swift
    override static func getRequiredFields() -> [Any]! {
        return ["name"]
    }
```
So, in this particular case, if KlappaInjector meet JSON that doesn't have "id" in it - it will return nil, even if the rest of fields is here.

# Warnings and restrictions
Note that all classes to which you want to deserialize JSON must conform to KLPDeserializable protocol. 
Please, **DO NOT** make extension on NSObject to conform to this protocol, inherit your classes from Ancestor instead.

# Contributing
All contributions and feedback are very appreciated and welcomed. If you have some issues or questions how DeSerializer works - you always can ask it in issues section or provide fix as Pull Request.
