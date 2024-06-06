
# Cooky

Cooky is a simple and intuitive food ordering app built with Swift. Users can register, log in, view products, see product details, add products to the cart, and update quantities in the cart. The app leverages Firebase for authentication and database, RxSwift for reactive programming, Alamofire for network requests, and Kingfisher for image loading. The project follows the MVVM architecture.

## Features

- **User Registration:** Allows new users to create an account.
- **User Login:** Allows existing users to log in.
- **View Products:** Displays a list of available food items.
- **Product Details:** Shows detailed information about a selected product.
- **Add to Cart:** Users can add items to their shopping cart.
- **Update Cart:** Users can update the quantity of items in their cart.

## Technologies Used

- **Swift:** The programming language used to build the app.
- **Firebase:** Used for user authentication and real-time database.
- **RxSwift:** For reactive programming.
- **Alamofire:** For handling network requests.
- **Kingfisher:** For efficient image loading and caching.
- **MVVM:** Architectural pattern followed to separate concerns and improve code maintainability.

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/cooky.git
    cd cooky
    ```

2. **Install CocoaPods dependencies:**
    ```bash
    pod install
    ```

3. **Open the project:**
    ```bash
    open Cooky.xcworkspace
    ```

4. **Configure Firebase:**
    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project or use an existing one.
    - Add an iOS app to your Firebase project.
    - Download the `GoogleService-Info.plist` file and add it to your Xcode project.

5. **Build and Run:**
    - Select the appropriate simulator or connect your device.
    - Build and run the project.

## Usage

1. **Register a new user:**
    - Open the app.
    - Navigate to the Registration screen.
    - Fill in the required details and create an account.

2. **Log in with an existing account:**
    - Open the app.
    - Navigate to the Login screen.
    - Enter your credentials and log in.

3. **View and order food:**
    - Browse through the list of available food items.
    - Tap on an item to view its details.
    - Add items to your cart.
    - Update item quantities in the cart as needed.

## Screenshots

![Login Screen] <img width="493" alt="login" src="https://github.com/omerkeskin98/Cooky/assets/145980440/e381b8b5-a05c-4fd3-b090-6d69cf84ab3b">
![Sign Up Screen]<img width="493" alt="signup" src="https://github.com/omerkeskin98/Cooky/assets/145980440/25ec875e-6162-4fa1-becf-0f4acdb4cc0f">
![Product List]<img width="493" alt="product_list" src="https://github.com/omerkeskin98/Cooky/assets/145980440/3b80f92f-d487-4a4b-a4f8-4d1b6c04a9e3">
![Product Details]<img width="493" alt="product_details" src="https://github.com/omerkeskin98/Cooky/assets/145980440/010ed4da-2d94-48a4-954d-3f4b9702f4c5">
![Cart]<img width="493" alt="cart" src="https://github.com/omerkeskin98/Cooky/assets/145980440/5a03860d-3277-4c7e-9ad2-ad78e8a2fef7">


## Acknowledgements

- Thanks to the developers of RxSwift, Alamofire, and Kingfisher for their fantastic libraries.
- Special thanks to Firebase for providing a robust backend solution.
