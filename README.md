# MockPosts app

<p align="center">
  <img src="https://github.com/Themakew/mock-posts-app/assets/3030029/99b221f1-1ea4-46f6-b7e8-35afb0efe619" alt="Simulator Screenshot - iPhone 15 Pro Max - 2023-10-10 at 17 54 33" width="200"/>
  <img src="https://github.com/Themakew/mock-posts-app/assets/3030029/d885305a-0363-447d-a042-fbc353b100dc" alt="Simulator Screenshot - iPhone 15 Pro Max - 2023-10-10 at 17 54 42" width="200"/>
</p>

MockPosts is a simple app to sample some basic features, such as: API integration, ViewCode, TableView and MVVM-C with RxSwift.

## Functionalities
✔️ Home screen displaying some posts from the server.

✔️ Detail screen displaying the post detail.

## Technologies and tools used

- Swift: program language
- RxSwift: for biding the data using the MVVM-C
- RxGesture: capture events on views that RxCocoa does not handle, such as UILabel
- UIKit: for building screen programatically
- XCoordinator: for organize the app navigation
- Kingfisher: a simple framework for image download

## Architecture used

Architecture used was MVVM-C, with some elements of Clean Architecture. Strong reference used: <a href="https://github.com/kudoleh/iOS-Clean-Architecture-MVVM">repo.</a></p> 

## API used for integration

API integration with this app was based on this <a href="https://jsonplaceholder.typicode.com">API.</a></p>
A simple service to list posts and their detail informations.

## How to run the project?

It is quite straightforward:

Run `./bootstrap.sh` from the root directory of this repository, it will install all dependecies and open the Xcode Project automatically.

---
<p align="center">Made by Ruyther Costa | Find me on <a href="https://www.linkedin.com/in/ruyther">LinkedIn</a></p>
