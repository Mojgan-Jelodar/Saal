# Saal
This is an application which shows a list of some products as a list. In addition ,you can earn more detail about it with touching each of them.   



# Requirement
- XCode 13.4.1 +
- macOS Monterey 12.4

# Installation
- To run the project :
- Open Saal.xcodeproj

# Language used 
- Swift 5.0

# App Version
- 1.0.0 

# UI
- UIKit
- Modern View Configuration With UIContentConfiguration
- UITableviewdiffabledatasource 

# Design Pattern Used

## VIPER
Viper is a design pattern that implements ‘separation of concern’ paradigm. Mostly like MVP or MVC it follows a modular approach. One feature, one module. For each module VIPER has five (sometimes four) different classes with distinct roles. No class go beyond its sole purpose. These classes are following.
-  View: Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter.
-  Presenter: Nucleus of a module. It gets user response from the View and work accordingly. Only class to communicate with all the other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.
-  Interactor: Has the business logics of an app. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.
-  Router : Does the wire-framing. Listens from the presenter about which screen to present and executes that.
-  Entity: Contains plain model classes used by the interactor.

![Viper](https://miro.medium.com/max/2862/1*-Mfew6qvLQ-t-DSOkY23Aw.png)

# Features

## Product List
- Shows a list of products with search ability.

## Product Detail
- with CURD ability .


## Data Caching
- Realm is used for data caching. Items retrieve from a relational models.


# Assumptions                
-   App currently supports English language.
-   Mobile and iPad platform supported: iOS (14.x +)        
-   Device support : iPhone , iPad  
-   Data caching is available.



# Frameworks/Libraries used
- SnapKit
- RealmSwift
- Combine
- CombineCocoa



# Unit Test
- unit test

#### App Demo
<table>
 <tr>
  <td>
   <img width = "205" height = "448" src="https://user-images.githubusercontent.com/5070406/186627201-fe84b160-f044-4a61-8662-388be9fe3177.png" alt="" />
  </td>
  <td>
   <img width = "205" height = "448" src="https://user-images.githubusercontent.com/5070406/186627101-adcc342c-4d22-48f5-a2dd-202198a24c78.png" alt="" />
  </td>
  <td>
   <img width = "205" height = "448" src="https://user-images.githubusercontent.com/5070406/186626996-fd2d9ed5-4f31-4c80-b1ec-389e94f4fbb9.png" alt="" />
  </td>
 </tr>
</table>


