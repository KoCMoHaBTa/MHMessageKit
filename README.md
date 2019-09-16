# MHMessageKit

[![Build Status](https://app.bitrise.io/app/081833065ad63e7a/status.svg?token=HMgRO7Myg0QWhkR77Oi3hg&branch=master)](https://app.bitrise.io/app/081833065ad63e7a)

## Installation

[Embed]:
https://developer.apple.com/library/content/technotes/tn2435/_index.html#//apple_ref/doc/uid/DTS40017543-CH1-PROJ_CONFIG-APPS_WITH_MULTIPLE_XCODE_PROJECTS

#### [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

Add `MHMessageKit` to your Swift Package Dependencies.

#### [Carthage](https://github.com/Carthage/Carthage)

Add `github "KoCMoHaBTa/MHMessageKit"` to your `Cartfile`, then [Embed] the framework directly into your project.

#### [Cocoapods](https://cocoapods.org)

Add `pod 'MHMessageKit'` to your  `Podfile`

#### [Submodules](http://git-scm.com/docs/git-submodule)

[Add a submodule](https://git-scm.com/docs/git-submodule#git-submodule-add-bltbranchgt-f--force--nameltnamegt--referenceltrepositorygt--depthltdepthgt--ltrepositorygtltpathgt) to your repostiroy, then [Embed] the framework directly into your project

#### Manually

[Download](https://github.com/KoCMoHaBTa/MHMessageKit/releases), then [Embed] the framework directly into your project

## Highlights

- provides extensions of the Foundation's notification API for sending and receving strongly typed custom notifications that are really convinient to Swift
- provides extensions of the Foundation's notification API for weakly subscribing to notifications, that are automatically unsubscribed when no longer used
- provides an independant messaging abstraction
- provides default implementation of the provided messaging abstraction trough the Foundation's notification API

You can use any of the above features independantly.

### Strongly typed custom notification messages

The defined `NotificationMessage` protocol in conjuction with extensions to `NotificationCenter` and `NotificationQueue` will allow you send and receive custom strongly typed notifications.

- make any of your custom types conform to `NotificationMessage`
- using `NotificationCenter` - subscribe for receiving your custom messages
- using `NotificationCenter` - post instances of your custom messages
- using `NotificationQueue` - enque instances of your custom messages

### Weak observers

You know, you have to laways unsubscribe observers when you no logner need them, usually in dealloc.
And it is even more uncovenient when you use the block based API from `NotificationCenter` - you have to store the observer reference and again unsubscribe it when your class will get deallocated.

Well, in order to save tons of boilerplate code - we introduce the weak observers. Basically you use the same API, but your observer gets unsibscibed automatically upon dealloc.
This means that you don't have to care anymore about unsibscibing - just subscribe and thats it.

In order to take advantage of this feature - just use the methods added to `NotificationCenter`:

- `addWeakObserver(_:selector:name:object:)`
- `addWeakObserver(forName:object:queue:using:) -> NSObjectProtocol`
- `addWeakObserver(forObject:queue:handler:) -> NSObjectProtocol`
- `subscribe(_:) -> WeakMessageSubscription`

### Independant messaging abstraction

In case you want to have an independant messaging abstraction - there is one for you if think that it suits you.

It is defined as following:

- `Message` - a type that can be send and received trough publishers and subscibers
- `MessagePublisher` - a type that can send messages
- `MessageSubscriber` - a type that manage message subscriptions
- `MessageSubscription` - a type that represents a message subscription
- `WeakMessageSubscription` - a type that represents a weak message subscription
- `StaticMessageHandler` - a type that statically register and unregister subscriptions
- `StaticSubscriptionContainer` - a type that stores subscriptions statically
- `StaticWeakSubscriptionContainer` - a type that stores weak subscriptions statically

### Independant messaging abstraction - default implementation

A default implementation using the Foundation's notification API is provided as following:

- `NotificationCenter: MessageSubscriber`
- `NotificationCenter: MessagePublisher`
- `NotificationQueue: MessagePublisher`

This means that in order to use this infrastructur - you have to:

- conform your custom type to the `Message` protocol
- subscribe and publish your custom messages

In advance you could:

- define your own static handler type that conforms to `StaticMessageHandler` and `StaticSubscriptionContainer` and/or `StaticWeakSubscriptionContainer`
