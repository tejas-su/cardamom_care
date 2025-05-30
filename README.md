# CardamomCare  

## Overview  
CardamomCare is an intelligent agriculture support system designed to assist farmers in identifying leaf diseases and predicting price trends. It integrates **image classification**, **real-time disease detection**, **price prediction**, and **visualizations** to enhance decision-making.

## Features  

### **Image Classification Module**  
- Utilizes a **TFLite model of MobileNetV2** for efficient image processing.  
- Live feed analysis—users simply **point their device at a leaf** to classify it as:  
  - **Phylosticta**  
  - **Dry Rot**  
  - **Aphid**  
  - **Healthy**  

### **Price Prediction Module**  
- Powered by a **FastAPI endpoint** for quick response processing.  
- Accepts user queries and returns structured price predictions based on historical trends.  

### **Visualization Screen**  
- Provides **data-driven insights** through visualizations.  
- Tracks **price trends across multiple years**, helping farmers make informed financial decisions.  

## Installation & Usage  
1. Clone this repository:  
   
   ``` git clone https://github.com/tejas-su/cardamom_care.git ```

2. Build the flutter app

    ``` flutter clean ```
    ``` flutter pub get ```
    ``` flutter build apk ```


## Screeshots
<img src="assets/images/merged.png" alt="Upload image and Live feed analysis screen" width="500"/> <img src="assets/images/merged_2.png" alt="Price prediction and Visualization screen analysis screen" width="500"/>

### Contributors

[@tejas-su](github.com/tejas-su)    [@Abhay-Prabhu](github.com/Abhay-Prabhu)