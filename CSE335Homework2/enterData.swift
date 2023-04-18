//
//  enterData.swift
//  CSE335Homework2
//
//  Created by Arjun Dadhwal on 4/18/23.
//

import Foundation
import SwiftUI

struct enterData: View {
    
    @State var enterBPSys:String = ""
    @State var enterBPDia:String = "";
    @State var enterWeight:String = "";
    @State var enterSugarLevel:String = "";
    
    @State var statusMessage:String = "";
    
    @State var dataController: coreDataController = coreDataController()

    func checkNumeric(givenString: String) -> Bool {
       return Double(givenString) != nil
    }


    var body: some View {
        NavigationView{
            VStack(spacing:100) {
                Text("Enter Data")
                

                    Text("\(statusMessage)")
                
                HStack() {
                    Text("Blood Pressure: ")
                    TextField("Systolic", text: $enterBPSys).keyboardType(.decimalPad);
                    TextField("Diastolic", text: $enterBPDia).keyboardType(.decimalPad);
                    
                }
                HStack() {
                    Text("Weight (lbs)")
                    TextField("Weight", text: $enterWeight).keyboardType(.decimalPad);
                }
                HStack() {
                    Text("Sugar Level: ")
                    TextField("Sugar Level", text: $enterSugarLevel).keyboardType(.decimalPad);
                }

                Button(action: {
                    if ( ( ((enterBPSys as NSString).doubleValue) < 0  ) || ( ((enterBPDia as NSString).doubleValue) < 0 ) || ( ((enterWeight as NSString).doubleValue) < 0) || ( ((enterSugarLevel as NSString).doubleValue) < 0))
                    {
                        statusMessage = "BP, Weight, and Sugar Level have to be positive!"
                    }
                    else if (enterBPSys.isEmpty || enterBPDia.isEmpty || enterWeight.isEmpty || enterSugarLevel.isEmpty )
                    {
                        statusMessage = "You have to fill all fields, except for symptoms!"
                    }
                    else if (checkNumeric(givenString: enterBPSys) == false || checkNumeric(givenString: enterBPDia) == false || checkNumeric(givenString: enterWeight) == false || checkNumeric(givenString: enterSugarLevel) == false )
                    {
                        statusMessage="BP, Weight, and Sugar Level have to be numeric!"
                    }
                    else {
                        /*dayData.add_day(Date.now, (enterBPSys as NSString).doubleValue, (enterBPDia as NSString).doubleValue, (enterWeight as NSString).doubleValue, (enterSugarLevel as NSString).doubleValue, "hunger");*/
                        
                        //Add the data for the following day
                        
                        dataController.add_day(date: Date.now, weight: (enterWeight as NSString).doubleValue, sugarLevel: (enterSugarLevel as NSString).doubleValue, bloodPressureDiastolic: (enterBPDia as NSString).doubleValue, bloodPressureSystolic: (enterBPSys as NSString).doubleValue)
                        
                        let today = Date.now;
                        let formatter1 = DateFormatter()
                        formatter1.dateStyle = .short;
                        
                        var todayString = formatter1.string(from: today);
                        
                        statusMessage = "Added data entry for today ( \(todayString) )" ;           }

                }) {
                    
                    Text("Submit")
                }
                
                Spacer()
                Spacer()
            }
                
            }
        }
    }
