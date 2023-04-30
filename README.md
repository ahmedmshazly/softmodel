# AI Model for Predicting Best Software Development Methodology

![Banner Image](./banner.png)

This project is developed by a team of students, aiming to provide an AI-driven solution to help software development teams determine the most appropriate development methodology for their projects. The AI model takes into account various project characteristics and recommends the best-fit software development methodology.

## Table of Contents
- [Features](#features)
- [Data Processing and Model Training](#data-processing-and-model-training)
- [Model Selection](#model-selection)
- [Evaluation Metrics](#evaluation-metrics)
- [Challenges and Limitations](#challenges-and-limitations)
- [Future Improvements](#future-improvements)
- [Creators](#creators)

## Features
The AI model considers the following features to make recommendations:

- Project Size (Small, Medium, Large)
- Project Type (Web Application, Mobile Application, Desktop Application)
- Methodology (Agile, Waterfall, Hybrid)
- Release Strategy (Continuous Deployment, Staged Release)
- Preferred Use Cases (Data Analytics, Gaming, Social Networking, E-commerce)
- Flexibility (High, Medium, Low)
- Communication & Collaboration (High, Medium, Low)
- Planning & Documentation (High, Medium, Low)
- Risk Management (High, Medium, Low)
- Quality Assurance (High, Medium, Low)
- Customer Involvement (High, Medium, Low)
- Resource Management (High, Medium, Low)
- Metrics & Measurement (High, Medium, Low)

## Data Processing and Model Training
The dataset used for training contains project characteristics and the corresponding best software development model for each project. Data preprocessing included handling missing values, categorical variables encoding, and splitting the dataset into training and testing sets.

## Model Selection
Three different models were experimented with:

1. Logistic Regression
2. Support Vector Machines (SVMs)
3. Random Forest

Hyperparameters were tuned using grid search, and the best-performing model was selected based on accuracy on a validation set.

## Evaluation Metrics
The performance of the models was evaluated using accuracy as the main metric. The chosen model, Random Forest, achieved an accuracy of 85%.

## Challenges and Limitations
- Limited dataset size, which might affect the model's generalization capabilities.
- Selection of relevant features and their importance in predicting the best development model.

## Future Improvements
- Expand the dataset to include more projects with diverse characteristics.
- Explore other machine learning models and techniques to improve prediction accuracy.
- Consider implementing an active learning approach to improve the model as more data becomes available.

## Creators
- Ahmed Mohamed
- Spencer Kamayo
- Samuel Wanza
