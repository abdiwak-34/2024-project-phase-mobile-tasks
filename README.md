# 🛒 Ecommerce App

A modular, testable **Ecommerce App** built using **Clean Architecture** principles. This structure allows for separation of concerns, making the codebase scalable, maintainable, and test-friendly.

---

## 📁 Project Structure
---
## 🧱 Architecture Overview

The app is based on the **Clean Architecture** pattern:

- **Entities Layer** – Domain-level models (e.g., `Product`) that are framework-independent.
- **Use Cases Layer** – Application-specific business rules (e.g., `ViewSpecificProduct`).
- **Repository Layer (Abstract)** – Interfaces for fetching or modifying data (e.g., `ProductRepository`).
- **Data Layer (Implementation)** – Handles data access and implements repositories.
- **Presentation Layer** *(optional)* – Flutter UI code (if integrated).

---

## 🔁 Data Flow Diagram

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


### ✔️ Benefits:

- Loose coupling between layers  
- Clear separation of concerns  
- Easy replacement of infrastructure (e.g., switch from mock to real API)  
- Highly testable system  

---

## 📦 Entity: `Product`

Represents a product in the domain layer, independent of any framework.

```dart
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


🔍 Field Descriptions
Field	Type	Description
id	String	Unique product identifier
name	String	Product name/title
description	String	Detailed product description
price	double	Price of the product
imageUrl	String	URL to an image representing the product
