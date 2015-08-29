//
//  ViewController.swift
//  PermissionScope-example
//
//  Created by Nick O'Neill on 4/5/15.
//  Copyright (c) 2015 That Thing in Swift. All rights reserved.
//

import UIKit
import PermissionScope

class ViewController: UIViewController {
    let singlePscope = PermissionScope()
    let multiPscope = PermissionScope()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        singlePscope.addPermission(NotificationsPermission(notificationCategories: nil),
            message: "We use this to send you\r\nspam and love notes")
        
        multiPscope.addPermission(ContactsPermission(),
            message: "We use this to steal\r\nyour friends")
        multiPscope.addPermission(NotificationsPermission(notificationCategories: nil),
            message: "We use this to send you\r\nspam and love notes")
        multiPscope.addPermission(LocationWhileInUsePermission(),
            message: "We use this to track\r\nwhere you live")
//        multiPscope.addPermission(HealthPermission(
//            healthTypesToShare: [
//                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!,
//                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
//                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
//                ],
//            healthTypesToRead: [
//                HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!,
//                HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)!,
//                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
//                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
//                ]), message: "We need your health data\r\nto know you better")
        
        // Other example permissions
        //        multiPscope.addPermission(BluetoothPermission(), message: "We use this to drain your battery")
        
    }
    
    // an example of how to use the unified permissions API
    func checkContacts() {
        switch PermissionScope().statusContacts() {
        case .Unknown:
            // ask
            PermissionScope().requestContacts()
        case .Unauthorized, .Disabled:
            // bummer
            return
        case .Authorized:
            // thanks!
            return
        }
    }
    
    @IBAction func singlePerm() {
        singlePscope.show(
            { (finished, results) -> Void in
                print("got results \(results)")
            },
            cancelled: { (results) -> Void in
                print("thing was cancelled")
            }
        )
    }
    
    @IBAction func multiPerms() {
        multiPscope.show(
            { (finished, results) -> Void in
                print("got results \(results)")
            },
            cancelled: { (results) -> Void in
                print("thing was cancelled")
            }
        )
    }
}

