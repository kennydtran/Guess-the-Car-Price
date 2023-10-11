//
//  carData.swift
//  PROJECT1
//
//  Name: carData
//  Functionality: A large array to store all data for the cars used in the application. The stored information
//                 consists of the car's IMAGE, YEAR, MAKE and MODEL, and MSRP. Each attributes are manually
//                 inputted at the moment with no reference or APIs used from an online database. Images are
//                 stored in Assets.xcassets. All images are sourced from internet sites. 
//
//
//  Created by Kenny Tran
//

import Foundation

struct Car {
    let image: String
    let year: Int
    let makeModel: String
    let price: Double
}

let carData: [Car] = [
    
    Car(image: "image1", year: 2023, makeModel: "Toyota Camry", price: 26420.00),
    Car(image: "image2", year: 2023, makeModel: "Tesla Model Y", price: 47740.00),
    Car(image: "image3", year: 2018, makeModel: "Rolls-Royce Phantom", price: 450000.00),
    Car(image: "image4", year: 2023, makeModel: "Honda Civic", price: 23950.00),
    Car(image: "image5", year: 2017, makeModel: "Toyota Corolla", price: 18500.00),
    Car(image: "image6", year: 2009, makeModel: "Ford Mustang", price: 23290.00),
    Car(image: "image7", year: 2014, makeModel: "Chevrolet Camaro", price: 25750.00),
    Car(image: "image8", year: 2024, makeModel: "BMW 3 Series", price: 44500.00),
    Car(image: "image9", year: 1999, makeModel: "Audi A4", price: 28890.00),
    Car(image: "image10", year: 2022, makeModel: "Mercedes-Benz C Class", price: 43550.00),
    Car(image: "image11", year: 2006, makeModel: "Nissan Altima", price: 17750.00),
    Car(image: "image12", year: 2014, makeModel: "Subaru Impreza WRX", price: 25995.00),
    Car(image: "image13", year: 2018, makeModel: "Mazda 3", price: 18990.00),
    Car(image: "image14", year: 2012, makeModel: "Volkswagen Golf", price: 18765.00),
    Car(image: "image15", year: 1980, makeModel: "Toyota Corolla", price: 5208.0),
    Car(image: "image16", year: 1985, makeModel: "Ford Mustang GT", price: 13585.0),
    Car(image: "image17", year: 1990, makeModel: "Mazda MX-5 Miata", price: 13800.0),
    Car(image: "image18", year: 1995, makeModel: "BMW M3", price: 38845.0),
    Car(image: "image19", year: 2000, makeModel: "Honda S2000", price: 32000.0),
    Car(image: "image20", year: 2005, makeModel: "Chevrolet Corvette C6", price: 44245.0),
    Car(image: "image21", year: 2010, makeModel: "Nissan GT-R", price: 80790.0),
    Car(image: "image22", year: 2015, makeModel: "Porsche 911 GT3 RS", price: 130400.0),
    Car(image: "image23", year: 2020, makeModel: "McLaren 720S", price: 301500.0),
    Car(image: "image24", year: 2023, makeModel: "Bugatti Chiron Super Sport", price: 3825000.0),
    Car(image: "image25", year: 2023, makeModel: "Ferrari SF90 Stradale", price: 528765.0),
    Car(image: "image26", year: 2024, makeModel: "Aston Martin Valkyrie", price: 3500000.0),
    Car(image: "image27", year: 1988, makeModel: "Lamborghini Countach", price: 483200.0),
    Car(image: "image28", year: 1998, makeModel: "Mercedes-Benz CLK GTR", price: 1547620.0),
    Car(image: "image29", year: 2012, makeModel: "Bugatti Veyron", price: 1824000.0),
    Car(image: "image30", year: 2018, makeModel: "Koenigsegg Regera", price: 3277636.0)
    
    ]
