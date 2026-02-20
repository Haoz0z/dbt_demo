Project Overview

This project is a modular data transformation pipeline built using dbt (data build tool).

It transforms raw source data into clean, well-structured, and analytics-ready models using a layered modeling approach. The project focuses on maintainability, scalability, and data quality.

The pipeline follows modern analytics engineering best practices and is designed to be easily deployable in both local and cloud environments.


Data Modeling Strategy

This project follows a three-layer modeling framework:

1. Staging Layer (stg_)

Purpose: Standardize and clean raw source data.
	•	Renames columns
	•	Converts data types
	•	Handles null values
	•	Applies naming conventions

⸻

2. Intermediate Layer (int_)

Purpose: Apply business logic and transformations.
	•	Joins multiple sources
	•	Performs deduplication
	•	Calculates derived metrics
	•	Implements business rules

⸻

3. Marts Layer (fact_ / dim_)

Purpose: Provide analytics-ready datasets.
	•	Implements star schema
	•	Aggregates metrics
	•	Defines KPIs
	•	Supports reporting tools

