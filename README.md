## Big Data Analytics Project Documentation

This project involves the development of a data analytics system leveraging smartphone sensors to classify different activities such as standing, walking, running, not with the user, and phone in use. The project is divided into three deliverables as outlined below:

---

#### Deliverable #1 (Assignment) - May 23, 2022

**Tasks (30 Marks):**

1. **Data Generation and Labeling**:
   - Developed a mobile application utilizing smartphone sensors (Accelerometer and Gyroscope) to collect data.
   - Created a basic Android/iOS app using Flutter framework.
   - Utilized sensors_plus package for accessing device sensors.
   - Implemented data uploading to laptop either via Flask API or Bluetooth.

2. **Data Labeling**:
   - Defined labels for classifying activities: Standing, Walking, Running, Not with me, Phone in use.
   - Enabled labeling within the app or later on the laptop.
   - Stored labeled data in MongoDB or MySQL databases.

---

#### Deliverable #2 (Project) - May 27, 2022

**Tasks (50 Marks):**

1. **Data Ingestion and Processing**:
   - Ingested labeled data into Kafka environment for real-time data streaming.
   - Employed ML classification models (e.g., KNN, Naive Bayes, SVM) to process and classify activity labels.
   - Implemented multiple models for comparison and evaluation.

---

#### Deliverable #3 (Project) - June 3, 2022

**Tasks (30 Marks):**

1. **Frontend Website Development**:
   - Developed a frontend website using Flask or any other suitable framework.
   - Integrated live data streaming from the mobile device connected via API or Bluetooth.
   - Displayed predicted activity states based on previous labeled data.
   - Provided real-time readings of Accelerometer and Gyroscope on the website.

2. **Documentation and Report**:
   - Documented all code thoroughly.
   - Submitted a comprehensive report outlining the project's objectives, methodology, implementation details, and results.
   - Ensured documentation aesthetics to receive bonus marks.

---

### Documentation

This README serves as a high-level overview of the Big Data Analytics project. For detailed documentation, including code explanations, setup instructions, and project insights, please refer to the respective documentation files within each deliverable's directory.

For any inquiries or assistance, feel free to contact the project team.

*Project Team: Abdullah Basharat, Hamza Khan, Ahmed Suhail*

*Date:  June 3, 2022 *

--- 
