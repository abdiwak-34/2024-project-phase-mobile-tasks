#🛒 Project Name: Ecommerce App
This is a modular, testable Ecommerce App built using Clean Architecture principles. The core domain logic is separated from external dependencies to ensure long-term maintainability and scalability.

#🧱 Architecture Overview
The project is structured based on Clean Architecture with the following layers:

Entities Layer – Domain-level models (e.g., Product) that are pure and framework-independent.

Use Cases Layer – Application-specific business logic (e.g., ViewSpecificProduct).

Repository Layer (Abstract) – Interface definitions for data access (e.g., ProductRepository).

Data Layer (Implementation) – Handles communication with APIs, local storage, or mock data using models.

Presentation Layer (optional) – Can be added to connect the domain to UI components (e.g., Flutter widgets).

#🔁 Data Flow Diagram
scss
Copy
Edit
[UI (optional)]
     ↓
UseCase (ViewSpecificProduct)
     ↓
Repository (Abstract)
     ↓
Repository Implementation
     ↓
Data Source (API / DB / Mock)
     ↓
Product Model
     ↓
Product Entity
This flow ensures:

Loose coupling between layers

Testable and maintainable code

Easy replacement of infrastructure (e.g., switch from mock to real API)

#📦 Entity: Product
This is the core domain entity representing a product in the ecommerce system.

dart
Copy
Edit
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, price, imageUrl];
}
#🔍 Field Descriptions
Field	Type	Description
id	String	Unique product identifier
name	String	Product name/title
description	String	Detailed product description
price	double	Price of the product
imageUrl	String	URL to an image representing the product



