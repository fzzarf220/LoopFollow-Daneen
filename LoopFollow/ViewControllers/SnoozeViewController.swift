//
//  SecondViewController.swift
//  LoopFollow
//
//  Created by Jon Fawcett on 6/1/20.
//  Copyright © 2020 Jon Fawcett. All rights reserved.
//

import UIKit
import UserNotifications

class SnoozeViewController: UIViewController, UNUserNotificationCenterDelegate {
    var appStateController: AppStateController?
    var snoozeTabItem: UITabBarItem = UITabBarItem()
    var mainTabItem: UITabBarItem = UITabBarItem()
    var clockTimer: Timer = Timer()
    
   
    
    @IBOutlet weak var SnoozeButton: UIButton!

    @IBOutlet weak var BGLabel: UILabel!
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var DeltaLabel: UILabel!
    @IBOutlet weak var MinAgoLabel: UILabel!
    @IBOutlet weak var AlertLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var snoozeForMinuteLabel: UILabel!
    @IBOutlet weak var snoozeForMinuteStepper: UIStepper!
    @IBOutlet weak var debugTextView: UITextView!
    
    
    @IBAction func SnoozeButton(_ sender: Any) {
        AlarmSound.stop()
        
        guard let mainVC = self.tabBarController!.viewControllers?[0] as? MainViewController else { return }
        mainVC.startCheckAlarmTimer(time: mainVC.checkAlarmInterval)
        
        let tabBarControllerItems = self.tabBarController?.tabBar.items
        if let arrayOfTabBarItems = tabBarControllerItems as! AnyObject as? NSArray{
            snoozeTabItem = arrayOfTabBarItems[2] as! UITabBarItem
            
        }
        
        
        setSnoozeTime()
        AlertLabel.isHidden = true
        SnoozeButton.isHidden = true
        clockLabel.isHidden = false
        snoozeForMinuteStepper.isHidden = true
        snoozeForMinuteLabel.isHidden = true
        
    }
    
    @IBAction func snoozeForMinuteValChanged(_ sender: UIStepper) {
        snoozeForMinuteLabel.text = Int(sender.value).description
    }
    
    // Update Time
    func startClockTimer(time: TimeInterval) {
        clockTimer = Timer.scheduledTimer(timeInterval: time,
                                           target: self,
                                           selector: #selector(clockTimerDidEnd(_:)),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    // Update Time Ended
    @objc func clockTimerDidEnd(_ timer:Timer) {
        let formatter = DateFormatter()
        if dateTimeUtils.is24Hour() {
            formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        } else {
            formatter.setLocalizedDateFormatFromTemplate("hh:mm a")
        }
        
        clockLabel.text = formatter.string(from: Date())
    }
    
    func updateDisplayWhenTriggered(bgVal: String, directionVal: String, deltaVal: String, minAgoVal: String, alertLabelVal: String){
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let person: String = infoDictionary["person"] as? String else { return }
        
        loadViewIfNeeded()
        BGLabel.text = bgVal
        DirectionLabel.text = directionVal
        DeltaLabel.text = deltaVal
        MinAgoLabel.text = minAgoVal
        AlertLabel.text = alertLabelVal + "\n" + person

        if alertLabelVal == "none" { return }

        sendNotification(self, bgVal: bgVal, directionVal: directionVal, deltaVal: deltaVal, minAgoVal: minAgoVal, alertLabelVal: alertLabelVal)
    }
    
    func sendNotification(_ sender: Any, bgVal: String, directionVal: String, deltaVal: String, minAgoVal: String, alertLabelVal: String) {
        
        UNUserNotificationCenter.current().delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = alertLabelVal
        content.subtitle += bgVal + " "
        content.subtitle += directionVal + " "
        content.subtitle += deltaVal
        content.categoryIdentifier = "category"
        // This is needed to trigger vibrate on watch and phone
        // TODO:
        // See if we can use .Critcal
        // See if we should use this method instead of direct sound player
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let action = UNNotificationAction(identifier: "snooze", title: "Snooze", options: [])
        let category = UNNotificationCategory(identifier: "category", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "snooze" {
            SnoozeButton(self)
        }
    }
    
    func setSnoozeTime()
    {
        if AlarmSound.whichAlarm == "Temporary Alert" {
            UserDefaultsRepository.alertTemporaryActive.value = false
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertTemporaryActive", value: false)
        } else if AlarmSound.whichAlarm == "Urgent Low Alert" {
            UserDefaultsRepository.alertUrgentLowIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentLowSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentLowSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "Low Alert" {
            UserDefaultsRepository.alertLowIsSnoozed.value = true
            UserDefaultsRepository.alertLowSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertLowSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "Predicted Urgent Low Alert" {
            UserDefaultsRepository.alertUrgentLowIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentLowSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentLowSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "High Alert" {
            UserDefaultsRepository.alertHighIsSnoozed.value = true
            UserDefaultsRepository.alertHighSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertHighSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "Urgent High Alert" {
            UserDefaultsRepository.alertUrgentHighIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentHighSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentHighSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "Fast Drop Alert" {
            UserDefaultsRepository.alertFastDropIsSnoozed.value = true
            UserDefaultsRepository.alertFastDropSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastDropIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastDropSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        } else if AlarmSound.whichAlarm == "Fast Rise Alert" {
            UserDefaultsRepository.alertFastRiseIsSnoozed.value = true
            UserDefaultsRepository.alertFastRiseSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastRiseIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastRiseSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
        }  else if AlarmSound.whichAlarm == "Missed Reading Alert" {
           UserDefaultsRepository.alertMissedReadingIsSnoozed.value = true
           UserDefaultsRepository.alertMissedReadingSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
           guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
           alarms.reloadIsSnoozed(key: "alertMissedReadingIsSnoozed", value: true)
           alarms.reloadSnoozeTime(key: "alertMissedReadingSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
       }  else if AlarmSound.whichAlarm == "Sensor Change Alert" {
                UserDefaultsRepository.alertSAGEIsSnoozed.value = true
                UserDefaultsRepository.alertSAGESnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
                guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
                alarms.reloadIsSnoozed(key: "alertSAGEIsSnoozed", value: true)
                alarms.reloadSnoozeTime(key: "alertSAGESnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       } else if AlarmSound.whichAlarm == "Pump Change Alert" {
        UserDefaultsRepository.alertCAGEIsSnoozed.value = true
        UserDefaultsRepository.alertCAGESnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertCAGEIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertCAGESnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       } else if AlarmSound.whichAlarm == "Not Looping Alert" {
        UserDefaultsRepository.alertNotLoopingIsSnoozed.value = true
        UserDefaultsRepository.alertNotLoopingSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertNotLoopingIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertNotLoopingSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
       } else if AlarmSound.whichAlarm == "Missed Bolus Alert" {
        UserDefaultsRepository.alertMissedBolusIsSnoozed.value = true
        UserDefaultsRepository.alertMissedBolusSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertMissedBolusIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertMissedBolusSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60)))
       } else if AlarmSound.whichAlarm == "Low Insulin Alert" {
        UserDefaultsRepository.alertPumpIsSnoozed.value = true
        UserDefaultsRepository.alertPumpSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertPumpIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertPumpSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       } else if AlarmSound.whichAlarm == "IOB Alert" {
        UserDefaultsRepository.alertIOBIsSnoozed.value = true
        UserDefaultsRepository.alertIOBSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertIOBIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertIOBSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       } else if AlarmSound.whichAlarm == "COB Alert" {
        UserDefaultsRepository.alertCOBIsSnoozed.value = true
        UserDefaultsRepository.alertCOBSnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
        guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
        alarms.reloadIsSnoozed(key: "alertCOBIsSnoozed", value: true)
        alarms.reloadSnoozeTime(key: "alertCOBSnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       } else if AlarmSound.whichAlarm == "Low Battery" {
           UserDefaultsRepository.alertBatteryIsSnoozed.value = true

           UserDefaultsRepository.alertBatterySnoozedTime.value = Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60))
           guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
           alarms.reloadIsSnoozed(key: "alertBatteryIsSnoozed", value: true)
           alarms.reloadSnoozeTime(key: "alertBatterySnoozedTime", setNil: false, value: Date().addingTimeInterval(TimeInterval(snoozeForMinuteStepper.value * 60 * 60)))
       }
    }
    
    func setPresnoozeNight(snoozeTime: Date)
    {
        if UserDefaultsRepository.alertUrgentLowAutosnoozeNight.value {
            UserDefaultsRepository.alertUrgentLowIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentLowSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentLowSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertLowAutosnoozeNight.value {
            UserDefaultsRepository.alertLowIsSnoozed.value = true
            UserDefaultsRepository.alertLowSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertLowSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertHighAutosnoozeNight.value {
            UserDefaultsRepository.alertHighIsSnoozed.value = true
            UserDefaultsRepository.alertHighSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertHighSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertUrgentHighAutosnoozeNight.value {
            UserDefaultsRepository.alertUrgentHighIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentHighSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentHighSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertMissedReadingAutosnoozeNight.value {
            UserDefaultsRepository.alertMissedReadingIsSnoozed.value = true
            UserDefaultsRepository.alertMissedReadingSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertMissedReadingIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertMissedReadingSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertFastDropAutosnoozeNight.value {
            UserDefaultsRepository.alertFastDropIsSnoozed.value = true
            UserDefaultsRepository.alertFastDropSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastDropIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastDropSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertFastRiseAutosnoozeNight.value {
            UserDefaultsRepository.alertFastRiseIsSnoozed.value = true
            UserDefaultsRepository.alertFastRiseSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastRiseIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastRiseSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertNotLoopingAutosnoozeNight.value {
            UserDefaultsRepository.alertNotLoopingIsSnoozed.value = true
            UserDefaultsRepository.alertNotLoopingSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertNotLoopingIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertNotLoopingSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertMissedBolusAutosnoozeNight.value {
            UserDefaultsRepository.alertMissedBolusIsSnoozed.value = true
            UserDefaultsRepository.alertMissedBolusSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertMissedBolusIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertMissedBolusSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertOverrideStartAutosnoozeNight.value {
            UserDefaultsRepository.alertOverrideStartIsSnoozed.value = true
            UserDefaultsRepository.alertOverrideStartSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertOverrideStartIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertOverrideStartSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertOverrideEndAutosnoozeNight.value {
            UserDefaultsRepository.alertOverrideEndIsSnoozed.value = true
            UserDefaultsRepository.alertOverrideEndSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertOverrideEndIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertOverrideEndSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertCAGEAutosnoozeNight.value {
            UserDefaultsRepository.alertCAGEIsSnoozed.value = true
            UserDefaultsRepository.alertCAGESnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertCAGEIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertCAGESnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertSAGEAutosnoozeNight.value {
            UserDefaultsRepository.alertSAGEIsSnoozed.value = true
            UserDefaultsRepository.alertSAGESnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertSAGEIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertSAGESnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertPumpAutosnoozeNight.value {
            UserDefaultsRepository.alertPumpIsSnoozed.value = true
            UserDefaultsRepository.alertPumpSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertPumpIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertPumpSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertIOBAutosnoozeNight.value {
            UserDefaultsRepository.alertIOBIsSnoozed.value = true
            UserDefaultsRepository.alertIOBSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertIOBIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertIOBSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertCOBAutosnoozeNight.value {
            UserDefaultsRepository.alertCOBIsSnoozed.value = true
            UserDefaultsRepository.alertCOBSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertCOBIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertCOBSnoozedTime", setNil: false, value: snoozeTime)
        }
        
    }
    
    func setPreSnoozeDay(snoozeTime: Date)
    {
        if UserDefaultsRepository.alertUrgentLowAutosnoozeDay.value {
            UserDefaultsRepository.alertUrgentLowIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentLowSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentLowSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertLowAutosnoozeDay.value {
            UserDefaultsRepository.alertLowIsSnoozed.value = true
            UserDefaultsRepository.alertLowSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertLowIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertLowSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertHighAutosnoozeDay.value {
            UserDefaultsRepository.alertHighIsSnoozed.value = true
            UserDefaultsRepository.alertHighSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertHighSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertUrgentHighAutosnoozeDay.value {
            UserDefaultsRepository.alertUrgentHighIsSnoozed.value = true
            UserDefaultsRepository.alertUrgentHighSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertUrgentHighIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertUrgentHighSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertMissedReadingAutosnoozeDay.value {
            UserDefaultsRepository.alertMissedReadingIsSnoozed.value = true
            UserDefaultsRepository.alertMissedReadingSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertMissedReadingIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertMissedReadingSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertFastDropAutosnoozeDay.value {
            UserDefaultsRepository.alertFastDropIsSnoozed.value = true
            UserDefaultsRepository.alertFastDropSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastDropIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastDropSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertFastRiseAutosnoozeDay.value {
            UserDefaultsRepository.alertFastRiseIsSnoozed.value = true
            UserDefaultsRepository.alertFastRiseSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertFastRiseIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertFastRiseSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertNotLoopingAutosnoozeDay.value {
            UserDefaultsRepository.alertNotLoopingIsSnoozed.value = true
            UserDefaultsRepository.alertNotLoopingSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertNotLoopingIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertNotLoopingSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertMissedBolusAutosnoozeDay.value {
            UserDefaultsRepository.alertMissedBolusIsSnoozed.value = true
            UserDefaultsRepository.alertMissedBolusSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertMissedBolusIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertMissedBolusSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertOverrideStartAutosnoozeDay.value {
            UserDefaultsRepository.alertOverrideStartIsSnoozed.value = true
            UserDefaultsRepository.alertOverrideStartSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertOverrideStartIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertOverrideStartSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertOverrideEndAutosnoozeDay.value {
            UserDefaultsRepository.alertOverrideEndIsSnoozed.value = true
            UserDefaultsRepository.alertOverrideEndSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertOverrideEndIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertOverrideEndSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertCAGEAutosnoozeDay.value {
            UserDefaultsRepository.alertCAGEIsSnoozed.value = true
            UserDefaultsRepository.alertCAGESnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertCAGEIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertCAGESnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertSAGEAutosnoozeDay.value {
            UserDefaultsRepository.alertSAGEIsSnoozed.value = true
            UserDefaultsRepository.alertSAGESnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertSAGEIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertSAGESnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertPumpAutosnoozeDay.value {
            UserDefaultsRepository.alertPumpIsSnoozed.value = true
            UserDefaultsRepository.alertPumpSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertPumpIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertPumpSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertIOBAutosnoozeDay.value {
            UserDefaultsRepository.alertIOBIsSnoozed.value = true
            UserDefaultsRepository.alertIOBSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertIOBIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertIOBSnoozedTime", setNil: false, value: snoozeTime)
        }
        if UserDefaultsRepository.alertCOBAutosnoozeDay.value {
            UserDefaultsRepository.alertCOBIsSnoozed.value = true
            UserDefaultsRepository.alertCOBSnoozedTime.value = snoozeTime
            guard let alarms = self.tabBarController!.viewControllers?[1] as? AlarmViewController else { return }
            alarms.reloadIsSnoozed(key: "alertCOBIsSnoozed", value: true)
            alarms.reloadSnoozeTime(key: "alertCOBSnoozedTime", setNil: false, value: snoozeTime)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultsRepository.forceDarkMode.value {
            overrideUserInterfaceStyle = .dark
        }
        SnoozeButton.layer.cornerRadius = 5
        SnoozeButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        clockLabel.text = ""
        startClockTimer(time: 1)
    }


    
}
