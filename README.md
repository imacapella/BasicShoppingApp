# BasicShoppingApp

BasicShoppingApp is a fundamental shopping application designed to demonstrate the integration of **MVVM architecture** with SwiftUI. The app fetches products from the **dummyjson/products API** and displays them in a user-friendly interface.

## Features
- **Product Listing**: Displays products with details such as name, price, rating, and image in a card format.
- **Search Functionality**: Allows users to search for products.
- **Favorites Management**: Enables users to add/remove products to/from favorites.
- **Cart System**: Lets users manage items in their cart.
- **Empty State Views**: Handles and displays appropriate screens when favorites or cart are empty.

## Learning Outcomes
This project helped improve my understanding and skills in:
- API Integration with SwiftUI.
- Implementing **MVVM Architecture**.
- Designing folder structures for scalability.
- Creating reusable SwiftUI components.
- Utilizing **ObservedObject** and **ObservableObject** effectively.

## Tech Stack

This project uses the following technologies:
- **Swift** for the development language
- **SwiftUI** for the user interface
- **MVVM Architecture** for the design pattern
- **SDWebImageSwiftUI** for using images which comes from **dummyjson/products API**
- **URLSession** for API requests

## Screenshots
Here are some screenshots demonstrating the app's functionality:

### Product Listing, Details & Search
Displays all products and details fetched from the API in a card format.

| Product List | Product Details | Like & Add to Cart Actions | Product List |
|--------------|-----------------|-----------------|-----------------|
| <img src="https://github.com/user-attachments/assets/2b1e7030-b85e-4126-b727-84bcc7924726" width="290"/> | <img src="https://github.com/user-attachments/assets/9f538909-674d-480f-a680-997a05cd692a" width="290"/> | <img src="https://github.com/user-attachments/assets/9b90365e-a843-42b0-ba32-2b8385ad8bcd" width="290"/> | <img src="https://github.com/user-attachments/assets/6cd33273-b3be-4964-8ff9-1d95985d06cb" width="290"/> 
  
### Favorites
Displays products added to the favorites list.

| Without Item | With Item |
|--------------|-----------------|
| <img src="https://github.com/user-attachments/assets/d7d90d72-5632-465e-a0d6-9693e4c16f4e" width="290"/> | <img src="https://github.com/user-attachments/assets/2887fc2d-92e1-43a9-8c1a-21e4445abdbe" width="290"/> |

### Cart
Displays items added to the cart and their details.
| Without Item | With Item |
|--------------|-----------------|
| <img src="https://github.com/user-attachments/assets/761ae6e0-69c3-42c6-ae54-73851d8bf6ba" width="290"/> | <img src="https://github.com/user-attachments/assets/23a6bdaf-ea8a-4f08-8418-7d708e8e9dd8" width="290"/> |


## Folder Structure
The project is organized as follows:
```
BasicShoppingApp/
┣ 📁Assets.xcassets/
┣ 📁Components/
┃ ┣ 📄Divider.swift
┃ ┗ 📄EmptyView.swift
┣ 📁Model/
┃ ┗ 📄ProductsModel.swift
┣ 📁NetworkingManager/
┃ ┗ 📄ProductsDao.swift
┣ 📁Preview Content/
┃ ┗ Preview Assets.xcassets/
┃   ┗ 📄Contents.json
┣ 📁Utilities/
┣ 📁Views/
┃ ┣ 📁Cart/
┃ ┃ ┣ 📄CartCheckoutBtn.swift
┃ ┃ ┣ 📄CartProductView.swift
┃ ┃ ┣ 📄CartView.swift
┃ ┃ ┗ 📄CartViewModel.swift
┃ ┣ 📁ContentView/
┃ ┃ ┗ 📄ContentView.swift
┃ ┣ 📁Favorites/
┃ ┃ ┣ 📄FavoritesCardView.swift
┃ ┃ ┣ 📄FavoritesView.swift
┃ ┃ ┗ 📄FavoritesViewModel.swift
┃ ┣ 📁ProductDetail/
┃ ┃ ┣ 📄DetailViewModel.swift
┃ ┃ ┗ 📄ProductDetailView.swift
┃ ┗ 📁ProductsList/
┃   ┣ 📄ProductCardView.swift
┃   ┣ 📄ProductListViewModel.swift
┃   ┗ 📄ProductsListView.swift
┣ BasicShoppingAppApp.swift
┗ Info.plist

```


## Installation

To get started with this project locally, follow these steps:

1. **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/BasicShoppingApp.git
    ```

2. **Navigate to the project directory**
    ```bash
    cd BasicShoppingApp
    ```

3. **Open the project in Xcode**
    ```bash
    open BasicShoppingApp.xcodeproj
    ```

4. **Build and run the project** in Xcode by pressing `Cmd + R`.


## Contact

For any questions or feedback, you can reach me at:

- Email: gurkankaradas42@gmail.com
- GitHub: [@imacapella](https://github.com/imacapella)
- LinkedIn: [Gürkan Karadaş](linkedin.com/gurkankaradas)
