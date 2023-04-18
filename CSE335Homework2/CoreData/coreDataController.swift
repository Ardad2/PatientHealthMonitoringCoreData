//
//  coreDataController.swift
//  CSE335ProjectConcept1
//
//  Created by Arjun Dadhwal on 4/13/23.
//

import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var dayData:[Day] = [Day]();
    
    // Handler to persistent object container
    let persistentContainer:NSPersistentContainer
    
    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "tableData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        dayData = getDays()

        
    }
    
    func getDays() -> [Day]
    {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            return x
        }
        catch {
            return []
        }
    }
    
    func add_day(date:Date, weight:Double, sugarLevel:Double, bloodPressureDiastolic:Double, bloodPressureSystolic: Double)
    {
        var alreadyThere = false;
        let newDay = Day(context: persistentContainer.viewContext )
        
        for days in getDays()
        {
            if (days.date == date)
            {
                alreadyThere = true;
                
                days.date = date
                days.weight = weight
                days.sugarLevel = sugarLevel
                days.bloodPressureDiastolic = bloodPressureDiastolic
                days.bloodPressureSystolic = bloodPressureDiastolic
                
                do {
                    try persistentContainer.viewContext.save()
                    dayData = getDays()
                }
                catch {
                    print("failed to save \(error)")
                }
                
                
                break;
            }
        }
        
        if (alreadyThere == false)
        {
            let newDay = Day(context: persistentContainer.viewContext)
            
            newDay.id = UUID();
            newDay.date = date
            newDay.weight = weight
            newDay.sugarLevel = sugarLevel
            newDay.bloodPressureDiastolic = bloodPressureDiastolic
            newDay.bloodPressureSystolic = bloodPressureSystolic
            
            do {
                try persistentContainer.viewContext.save()
                dayData = getDays()
            }
            catch {
                print("failed to save \(error)")
            }
            
        }


    }
}
