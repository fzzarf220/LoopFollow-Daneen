//
//  UserDefaults.swift
//  LoopFollow
//
//  Created by Jon Fawcett on 6/4/20.
//  Copyright © 2020 Jon Fawcett. All rights reserved.
//
//
//
//
//



import Foundation
import UIKit


class UserDefaultsRepository {
    var userId: String?

    private static func get<T>(key: String, default defaultValue: T, onChange: ((T) -> Void)? = nil, validation: ((T) -> T?)? = nil) -> UserDefaultsValue<T> {
        let keyComposite: String = {
            if let profile:UserProfile = UserProfiles.get() {
                let k = "\(key)_\(profile.id)"
                print("(!) NOTE: a compsite key: \(k)")
                return k
            }
            
            print ("(!) NOTE: NOT a composite key: \(key)")
            return key
        }()
        
        return UserDefaultsValue<T>(key: keyComposite, default: defaultValue, onChange: onChange, validation: validation)
    }
    
    // DisplayValues total
    static let infoDataTotal:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "infoDataTotal", default: 0)
    static let infoNames:UserDefaultsValue<[String]> = UserDefaultsRepository.get(key: "infoNames", default: [
        "IOB",
        "COB",
        "Basal",
        "Override",
        "Battery",
        "Pump",
        "SAGE",
        "CAGE",
        "Rec. Bolus",
        "Pred.",
        "Carbs today",
        "Autosens"])
    static let infoSort:UserDefaultsValue<[Int]> = UserDefaultsRepository.get(key: "infoSort", default: [0,1,2,3,4,5,6,7,8,9,10,11])
    static let infoVisible:UserDefaultsValue<[Bool]> = UserDefaultsRepository.get(key: "infoVisible", default: [true,true,true,true,true,true,true,true,true,true,true,false])
    static let hideInfoTable:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "hideInfoTable", default: false)
    
    // Nightscout Settings
    static let showNS:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showNS", default: false)
    static let url:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "url", default: "")
    static let token:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "token", default: "")
    static let units:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "units", default: "mg/dL")
    static let loopUser:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "loopUser", default: false)
    
    // Dexcom Share Settings
    static let showDex:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showDex", default: false)
    static let shareUserName:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "shareUserName", default: "")
    static let sharePassword:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "sharePassword", default: "")
    static let shareServer:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "shareServer", default: "US")
    
    // Graph Settings
    static let chartScaleX:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "chartScaleX", default: 18.0)
    static let showDots:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showDots", default: true)
    static let smallGraphTreatments:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "smallGraphTreatments", default: true)
    static let showValues:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showValues", default: true)
    static let showAbsorption:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showAbsorption", default: true)
    static let showLines:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showLines", default: true)
    static let hoursToLoad:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "hoursToLoad", default: 24)
    static let predictionToLoad:UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "predictionToLoad", default: 1)
    static let minBasalScale:UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "minBasalScale", default: 5.0)
    static let minBGScale:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "minBGScale", default: 250.0)
    static let showDIALines:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showDIAMarkers", default: true)
    static let show30MinLine:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "show30MinLine", default: false)
    static let show90MinLine:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "show90MinLine", default: false)
    static let showMidnightLines:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showMidnightMarkers", default: false)
    static let lowLine:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "lowLine", default: 70.0)
    static let highLine:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "highLine", default: 180.0)
    static let smallGraphHeight:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "smallGraphHeight", default: 40)
    
    
    // General Settings
    static let colorBGText:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "colorBGText", default: true)
    static let showStats:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showStats", default: true)
    static let useIFCC:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "useIFCC", default: false)
    static let showSmallGraph:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "showSmallGraph", default: true)
    static let speakBG:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "speakBG", default: false)
    static let backgroundRefreshFrequency:UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "backgroundRefreshFrequency", default: 1)
    static let backgroundRefresh:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "backgroundRefresh", default: true)
    static let appBadge:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "appBadge", default: true)
    static let dimScreenWhenIdle:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "dimScreenWhenIdle", default: 0)
    static let forceDarkMode:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "forceDarkMode", default: true)
    static let persistentNotification:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "persistentNotification", default: false)
    static let persistentNotificationLastBGTime:UserDefaultsValue<TimeInterval> = UserDefaultsRepository.get(key: "persistentNotificationLastBGTime", default: 0)
    static let screenlockSwitchState:UserDefaultsValue<Bool> = UserDefaultsRepository.get(
        key: "screenlockSwitchState",
        default: UIApplication.shared.isIdleTimerDisabled,
        onChange: { screenlock in
            UIApplication.shared.isIdleTimerDisabled = screenlock
        })
    
    // Advanced Settings
    //static let onlyDownloadBG:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "onlyDownloadBG", default: false)
    static let downloadTreatments:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "downloadTreatments", default: true)
    static let downloadPrediction:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "downloadPrediction", default: true)
    static let graphOtherTreatments:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "graphOtherTreatments", default: true)
    static let graphBasal:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "graphBasal", default: true)
    static let graphBolus:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "graphBolus", default: true)
    static let graphCarbs:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "graphCarbs", default: true)
    static let debugLog:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "debugLog", default: false)
    static let alwaysDownloadAllBG:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alwaysDownloadAllBG", default: true)
    static let bgUpdateDelay:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "bgUpdateDelay", default: 10)
    static let downloadDays:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "downloadDays", default: 1)
    
    
    // Watch Calendar Settings
    static let calendarIdentifier:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "calendarIdentifier", default: "")
    static let savedEventID:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "savedEventID", default: "")
    static let lastCalendarStartDate:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "lastCalendarStartDate", default: nil)
    static let writeCalendarEvent:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "writeCalendarEvent", default: false)
    static let watchLine1:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "watchLine1", default: "%BG% %DIRECTION% %DELTA% %MINAGO%")
    static let watchLine2:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "watchLine2", default: "C:%COB% I:%IOB% B:%BASAL%")
    static let saveImage:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "saveImage", default: false)
    
    // Alarm Settings
    static let systemOutputVolume:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "systemOutputVolume", default: 0.5)
    static let fadeInTimeInterval:UserDefaultsValue<TimeInterval> = UserDefaultsRepository.get(key: "fadeInTimeInterval", default: 0)
    static let vibrate:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "vibrate", default: true)
    static let overrideSystemOutputVolume:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "overrideSystemOutputVolume", default: true)
    static let forcedOutputVolume:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "forcedOutputVolume", default: 0.5)
    
    
    // Alerts
    
    let components = DateComponents(hour: 20, minute: 0)
    static let quietHourStart:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "quietHourStart", default: nil) //eventually need to adjust this to night time instead of quiet hour to clean up
    static let quietHourEnd:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "quietHourEnd", default: nil) //eventually need to adjust this to night time instead of quiet hour to clean up
    static let nightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "nightTime", default: false)
    
    static let snoozedBGReadingTime:UserDefaultsValue<TimeInterval?> = UserDefaultsRepository.get(key: "snoozedBGReadingTime", default: 0)
    
    static let alertIgnoreZero:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIgnoreZero", default: true)
    static let alertAudioDuringPhone:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertAudioDuringPhone", default: true)
    static let alertAutoSnoozeCGMStart:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertAutoSnoozeCGMStart", default: false)
    
    static let alertCageInsertTime:UserDefaultsValue<TimeInterval> = UserDefaultsRepository.get(key: "alertCageInsertTime", default: 0)
    static let alertSageInsertTime:UserDefaultsValue<TimeInterval> = UserDefaultsRepository.get(key: "alertSageInsertTime", default: 0)
    
    static let alertSnoozeAllTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertSnoozeAllTime", default: nil)
    static let alertSnoozeAllIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSnoozeAllIsSnoozed", default: false)
    static let alertMuteAllTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertMuteAllTime", default: nil)
    static let alertMuteAllIsMuted:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMuteAllIsMuted", default: false)
    
    static let alertUrgentLowActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowActive", default: false)
    static let alertUrgentLowBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertUrgentLowBG", default: 55.0)
    static let alertUrgentLowPredictiveMinutes:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertUrgentLowPredictiveMinutes", default: 0)
    static let alertUrgentLowSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertUrgentLowSnooze", default: 5)
    static let alertUrgentLowSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertUrgentLowSnoozedTime", default: nil)
    static let alertUrgentLowIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowIsSnoozed", default: false)
    static let alertUrgentLowRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentLowRepeat", default: "Always")
    static let alertUrgentLowDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowDayTime", default: true) // need to change all DayTime to DayTimeRepeat
    static let alertUrgentLowNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowNightTime", default: true) // need to change all NightTime to NightTimeRepeat
    static let alertUrgentLowSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentLowSound", default: "Emergency_Alarm_Siren")
    static let alertUrgentLowAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentLowAudible", default: "Always")
    static let alertUrgentLowDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowDayTimeAudible", default: true)
    static let alertUrgentLowNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowNightTimeAudible", default: true)
    static let alertUrgentLowAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentLowAutosnooze", default: "Never")
    static let alertUrgentLowAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowAutosnoozeDay", default: false)
    static let alertUrgentLowAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentLowAutosnoozeNight", default: false)
    
    static let alertLowActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowActive", default: false)
    static let alertLowBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertLowBG", default: 70.0)
    static let alertLowPersistent:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertLowPersistent", default: 0)
    static let alertLowPersistenceMax:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertLowPersistenceMax", default: 5.0)
    static let alertLowSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertLowSnooze", default: 5)
    static let alertLowSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertLowSnoozedTime", default: nil)
    static let alertLowIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowIsSnoozed", default: false)
    static let alertLowRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertLowRepeat", default: "Always")
    static let alertLowDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowDayTime", default: true)
    static let alertLowNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowNightTime", default: true)
    static let alertLowSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertLowSound", default: "Indeed")
    static let alertLowAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertLowAudible", default: "Always")
    static let alertLowDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowDayTimeAudible", default: true)
    static let alertLowNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowNightTimeAudible", default: true)
    static let alertLowAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertLowAutosnooze", default: "Never")
    static let alertLowAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowAutosnoozeDay", default: false)
    static let alertLowAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertLowAutosnoozeNight", default: false)
    
    static let alertHighActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighActive", default: false)
    static let alertHighBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertHighBG", default: 180.0)
    static let alertHighPersistent:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertHighPersistent", default: 60)
    static let alertHighSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertHighSnooze", default: 60)
    static let alertHighSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertHighSnoozedTime", default: nil)
    static let alertHighIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighIsSnoozed", default: false)
    static let alertHighRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertHighRepeat", default: "Always")
    static let alertHighDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighDayTime", default: true)
    static let alertHighNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighNightTime", default: true)
    static let alertHighSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertHighSound", default: "Time_Has_Come")
    static let alertHighAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertHighAudible", default: "Always")
    static let alertHighDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighDayTimeAudible", default: true)
    static let alertHighNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighNightTimeAudible", default: true)
    static let alertHighAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertHighAutosnooze", default: "Never")
    static let alertHighAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighAutosnoozeDay", default: false)
    static let alertHighAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertHighAutosnoozeNight", default: false)
    
    static let alertUrgentHighActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighActive", default: false)
    static let alertUrgentHighBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertUrgentHighBG", default: 250.0)
    static let alertUrgentHighSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertUrgentHighSnooze", default: 30)
    static let alertUrgentHighSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertUrgentHighSnoozedTime", default: nil)
    static let alertUrgentHighIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighIsSnoozed", default: false)
    static let alertUrgentHighRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentHighRepeat", default: "Always")
    static let alertUrgentHighDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighDayTime", default: true)
    static let alertUrgentHighNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighNightTime", default: true)
    static let alertUrgentHighSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentHighSound", default: "Pager_Beeps")
    static let alertUrgentHighAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentHighAudible", default: "Always")
    static let alertUrgentHighDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighDayTimeAudible", default: true)
    static let alertUrgentHighNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighNightTimeAudible", default: true)
    static let alertUrgentHighAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertUrgentHighAutosnooze", default: "Never")
    static let alertUrgentHighAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighAutosnoozeDay", default: false)
    static let alertUrgentHighAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertUrgentHighAutosnoozeNight", default: false)
    
    static let alertFastDropActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropDeltaActive", default: false)
    static let alertFastDropSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertFastDropDeltaSnooze", default: 10)
    static let alertFastDropDelta:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertFastDropDelta", default: 10.0)
    static let alertFastDropReadings:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertFastDropReadings", default: 3)
    static let alertFastDropUseLimit:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropUseLimit", default: false)
    static let alertFastDropBelowBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertFastDropBelowBG", default: 120.0)
    static let alertFastDropSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertFastDropSnoozedTime", default: nil)
    static let alertFastDropIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropIsSnoozed", default: false)
    static let alertFastDropRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastDropRepeat", default: "Never")
    static let alertFastDropDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropDayTime", default: false)
    static let alertFastDropNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropNightTime", default: false)
    static let alertFastDropSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastDropSound", default: "Big_Clock_Ticking")
    static let alertFastDropAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastDropAudible", default: "Always")
    static let alertFastDropDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropDayTimeAudible", default: true)
    static let alertFastDropNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropNightTimeAudible", default: true)
    static let alertFastDropAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastDropAutosnooze", default: "Never")
    static let alertFastDropAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropAutosnoozeDay", default: false)
    static let alertFastDropAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastDropAutosnoozeNight", default: false)
    
    static let alertFastRiseActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseDeltaActive", default: false)
    static let alertFastRiseSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertFastRiseDeltaSnooze", default: 10)
    static let alertFastRiseDelta:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertFastRiseDelta", default: 10.0)
    static let alertFastRiseReadings:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertFastRiseReadings", default: 3)
    static let alertFastRiseUseLimit:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseUseLimit", default: false)
    static let alertFastRiseAboveBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertFastRiseAboveBG", default: 200.0)
    static let alertFastRiseSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertFastRiseSnoozedTime", default: nil)
    static let alertFastRiseIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseIsSnoozed", default: false)
    static let alertFastRiseRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastRiseRepeat", default: "Never")
    static let alertFastRiseDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseDayTime", default: false)
    static let alertFastRiseNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseNightTime", default: false)
    static let alertFastRiseSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastRiseSound", default: "Cartoon_Fail_Strings_Trumpet")
    static let alertFastRiseAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastRiseAudible", default: "Always")
    static let alertFastRiseDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseDayTimeAudible", default: true)
    static let alertFastRiseNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseNightTimeAudible", default: true)
    static let alertFastRiseAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertFastRiseAutosnooze", default: "Never")
    static let alertFastRiseAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseAutosnoozeDay", default: false)
    static let alertFastRiseAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertFastRiseAutosnoozeNight", default: false)
    
    
    static let alertMissedReadingActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingActive", default: false)
    static let alertMissedReading:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedReading", default: 30)
    static let alertMissedReadingSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedReadingSnooze", default: 30)
    static let alertMissedReadingSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertMissedReadingSnoozedTime", default: nil)
    static let alertMissedReadingIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingIsSnoozed", default: false)
    static let alertMissedReadingRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedReadingRepeat", default: "Never")
    static let alertMissedReadingDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingDayTime", default: false)
    static let alertMissedReadingNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingNightTime", default: false)
    static let alertMissedReadingSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedReadingSound", default: "Cartoon_Tip_Toe_Sneaky_Walk")
    static let alertMissedReadingAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedReadingAudible", default: "Always")
    static let alertMissedReadingDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingDayTimeAudible", default: true)
    static let alertMissedReadingNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingNightTimeAudible", default: true)
    static let alertMissedReadingAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedReadingAutosnooze", default: "Never")
    static let alertMissedReadingAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingAutosnoozeDay", default: false)
    static let alertMissedReadingAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedReadingAutosnoozeNight", default: false)
    
    
    static let alertNotLoopingActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingActive", default: false)
    static let alertNotLooping:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertNotLooping", default: 30)
    static let alertNotLoopingSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertNotLoopingSnooze", default: 30)
    static let alertNotLoopingUseLimits:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingUseLimits", default: false)
    static let alertNotLoopingLowerLimit:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertNotLoopingBelowBG", default: 100.0)
    static let alertNotLoopingUpperLimit:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertNotLoopingAboveBG", default: 160.0)
    static let alertNotLoopingSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertNotLoopingSnoozedTime", default: nil)
    static let alertNotLoopingIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingIsSnoozed", default: false)
    static let alertNotLoopingRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertNotLoopingRepeat", default: "Never")
    static let alertNotLoopingDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingDayTime", default: false)
    static let alertNotLoopingNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingNightTime", default: false)
    static let alertNotLoopingSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertNotLoopingSound", default: "Sci-Fi_Engine_Shut_Down")
    static let alertLastLoopTime:UserDefaultsValue<TimeInterval> = UserDefaultsRepository.get(key: "alertLastLoopTime", default: 0)
    static let alertNotLoopingAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertNotLoopingAudible", default: "Always")
    static let alertNotLoopingDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingDayTimeAudible", default: true)
    static let alertNotLoopingNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingNightTimeAudible", default: true)
    static let alertNotLoopingAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertNotLoopingAutosnooze", default: "Never")
    static let alertNotLoopingAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingAutosnoozeDay", default: false)
    static let alertNotLoopingAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertNotLoopingAutosnoozeNight", default: false)
    
    static let alertMissedBolusActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusActive", default: false)
    static let alertMissedBolus:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedBolus", default: 10)
    static let alertMissedBolusSnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedBolusSnooze", default: 10)
    static let alertMissedBolusPrebolus:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedBolusPrebolus", default: 20)
    static let alertMissedBolusIgnoreBolus:UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "alertMissedBolusIgnoreBolus", default: 0.5)
    static let alertMissedBolusLowGrams:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertMissedBolusLowGrams", default: 10)
    static let alertMissedBolusLowGramsBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertMissedBolusLowGramsBG", default: 70.0)
    static let alertMissedBolusSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertMissedBolusSnoozedTime", default: nil)
    static let alertMissedBolusIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusIsSnoozed", default: false)
    static let alertMissedBolusQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusQuiet", default: false)
    static let alertMissedBolusRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedBolusRepeat", default: "Never")
    static let alertMissedBolusDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusDayTime", default: false)
    static let alertMissedBolusNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusNightTime", default: false)
    static let alertMissedBolusSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedBolusSound", default: "Dhol_Shuffleloop")
    static let alertMissedBolusAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedBolusAudible", default: "Always")
    static let alertMissedBolusDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusDayTimeAudible", default: true)
    static let alertMissedBolusNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusNightTimeAudible", default: true)
    static let alertMissedBolusAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertMissedBolusAutosnooze", default: "Never")
    static let alertMissedBolusAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusAutosnoozeDay", default: false)
    static let alertMissedBolusAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertMissedBolusAutosnoozeNight", default: false)
    
    static let alertSAGEActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEActive", default: false)
    static let alertSAGE:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertSAGE", default: 8) //Hours
    static let alertSAGEQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEQuiet", default: false)
    static let alertSAGERepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertSAGERepeat", default: "Never")
    static let alertSAGEDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEDayTime", default: false)
    static let alertSAGENightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGENightTime", default: false)
    static let alertSAGEAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertSAGEAudible", default: "Always")
    static let alertSAGEDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEDayTimeAudible", default: true)
    static let alertSAGENightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGENightTimeAudible", default: true)
    static let alertSAGESnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertSAGESnooze", default: 2) //Hours
    static let alertSAGESnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertSAGESnoozedTime", default: nil)
    static let alertSAGEIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEIsSnoozed", default: false)
    static let alertSAGESound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertSAGESound", default: "Wake_Up_Will_You")
    static let alertSAGEAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertSAGEAutosnooze", default: "At night")
    static let alertSAGEAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEAutosnoozeDay", default: false)
    static let alertSAGEAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertSAGEAutosnoozeNight", default: true)
    
    static let alertCAGEActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEActive", default: false)
    static let alertCAGE:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertCAGE", default: 4) //Hours
    static let alertCAGEQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEQuiet", default: false)
    static let alertCAGERepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCAGERepeat", default: "Never")
    static let alertCAGEDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEDayTime", default: false)
    static let alertCAGENightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGENightTime", default: false)
    static let alertCAGEAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCAGEAudible", default: "Always")
    static let alertCAGEDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEDayTimeAudible", default: true)
    static let alertCAGENightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGENightTimeAudible", default: true)
    static let alertCAGESnooze:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertCAGESnooze", default: 2) //Hours
    static let alertCAGESnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertCAGESnoozedTime", default: nil)
    static let alertCAGEIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEIsSnoozed", default: false)
    static let alertCAGESound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCAGESound", default: "Wake_Up_Will_You")
    static let alertCAGEAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCAGEAutosnooze", default: "At night")
    static let alertCAGEAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEAutosnoozeDay", default: false)
    static let alertCAGEAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCAGEAutosnoozeNight", default: true)
    
    static let alertAppInactive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertAppInactive", default: false)
    
    static let alertTemporaryActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertTemporaryActive", default: false)
    static let alertTemporaryBelow:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertTemporaryBelow", default: true)
    static let alertTemporaryBG:UserDefaultsValue<Float> = UserDefaultsRepository.get(key: "alertTemporaryBG", default: 90.0)
    static let alertTemporaryBGRepeat:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertTemporaryBGRepeat", default: false)
    static let alertTemporaryBGAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertTemporaryBGRepeatAudible", default: true)
    static let alertTemporarySound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertTemporarySound", default: "Indeed")
    
    static let alertOverrideStart:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStart", default: false)
    static let alertOverrideStartQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartQuiet", default: false)
    static let alertOverrideStartRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideStartRepeat", default: "Never")
    static let alertOverrideStartDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartDayTime", default: false)
    static let alertOverrideStartNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartNightTime", default: false)
    static let alertOverrideStartAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideStartRepeatAudible", default: "Always")
    static let alertOverrideStartDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartDayTimeAudible", default: true)
    static let alertOverrideStartNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartNightTimeAudible", default: true)
    static let alertOverrideStartSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideStartSound", default: "Ending_Reached")
    static let alertOverrideStartSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertOverrideStartSnoozedTime", default: nil)
    static let alertOverrideStartIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartIsSnoozed", default: false)
    static let alertOverrideStartAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideStartAutosnooze", default: "Never")
    static let alertOverrideStartAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartAutosnoozeDay", default: false)
    static let alertOverrideStartAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideStartAutosnoozeNight", default: false)
    
    static let alertOverrideEnd:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEnd", default: false)
    static let alertOverrideEndQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndQuiet", default: false)
    static let alertOverrideEndRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideEndRepeat", default: "Never")
    static let alertOverrideEndDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndDayTime", default: false)
    static let alertOverrideEndNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndNightTime", default: false)
    static let alertOverrideEndAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideEndRepeatAudible", default: "Always")
    static let alertOverrideEndDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndDayTimeAudible", default: true)
    static let alertOverrideEndNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndNightTimeAudible", default: true)
    static let alertOverrideEndSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideEndSound", default: "Alert_Tone_Busy")
    static let alertOverrideEndSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertOverrideEndSnoozedTime", default: nil)
    static let alertOverrideEndIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndIsSnoozed", default: false)
    static let alertOverrideEndAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertOverrideEndAutosnooze", default: "Never")
    static let alertOverrideEndAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndAutosnoozeDay", default: false)
    static let alertOverrideEndAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertOverrideEndAutosnoozeNight", default: false)
    
    static let alertPump:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPump", default: false)
    static let alertPumpAt:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertPumpAt", default: 10) //Units
    static let alertPumpQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpQuiet", default: false)
    static let alertPumpRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertPumpRepeat", default: "Never")
    static let alertPumpDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpDayTime", default: false)
    static let alertPumpNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpNightTime", default: false)
    static let alertPumpAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertPumpAudible", default: "Always")
    static let alertPumpDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpDayTimeAudible", default: true)
    static let alertPumpNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpNightTimeAudible", default: true)
    static let alertPumpSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertPumpSound", default: "Marimba_Descend")
    static let alertPumpSnoozeHours:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertPumpSnoozeHours", default: 5) //Hours
    static let alertPumpIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpIsSnoozed", default: false)
    static let alertPumpSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertPumpSnoozedTime", default: nil)
    static let alertPumpAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertPumpAutosnooze", default: "Never")
    static let alertPumpAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpAutosnoozeDay", default: false)
    static let alertPumpAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertPumpAutosnoozeNight", default: false)
    
    static let alertIOB:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOB", default: false)
    static let alertIOBAt:UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "alertIOBAt", default: 1.5) //Units
    static let alertIOBNumber:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertIOBNumber", default: 3) //Number
    static let alertIOBBolusesWithin:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertIOBBolusesWithin", default: 60) //Minutes
    static let alertIOBMaxBoluses:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertIOBMaxBoluses", default: 10) //Units
    static let alertIOBQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBQuiet", default: false)
    static let alertIOBRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertIOBRepeat", default: "Always")
    static let alertIOBDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBDayTime", default: true)
    static let alertIOBNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBNightTime", default: true)
    static let alertIOBAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertIOBAudible", default: "Always")
    static let alertIOBDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBDayTimeAudible", default: true)
    static let alertIOBNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBNightTimeAudible", default: true)
    static let alertIOBSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertIOBSound", default: "Alert_Tone_Ringtone_1")
    static let alertIOBSnoozeHours:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertIOBSnoozeHours", default: 1) //Hours
    static let alertIOBIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBIsSnoozed", default: false)
    static let alertIOBSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertIOBSnoozedTime", default: nil)
    static let alertIOBAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertIOBAutosnooze", default: "Never")
    static let alertIOBAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBAutosnoozeDay", default: false)
    static let alertIOBAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertIOBAutosnoozeNight", default: false)
    
    static let alertCOB:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOB", default: false)
    static let alertCOBAt:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertCOBAt", default: 50) //Units
    static let alertCOBQuiet:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBQuiet", default: false)
    static let alertCOBRepeat:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCOBRepeat", default: "Always")
    static let alertCOBDayTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBDayTime", default: true)
    static let alertCOBNightTime:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBNightTime", default: true)
    static let alertCOBAudible:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCOBAudible", default: "Always")
    static let alertCOBDayTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBDayTimeAudible", default: true)
    static let alertCOBNightTimeAudible:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBNightTimeAudible", default: true)
    static let alertCOBSound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCOBSound", default: "Alert_Tone_Ringtone_2")
    static let alertCOBSnoozeHours:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertCOBSnoozeHours", default: 1) //Hours
    static let alertCOBIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBIsSnoozed", default: false)
    static let alertCOBSnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertCOBSnoozedTime", default: nil)
    static let alertCOBAutosnooze:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertCOBAutosnooze", default: "Never")
    static let alertCOBAutosnoozeDay:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBAutosnoozeDay", default: false)
    static let alertCOBAutosnoozeNight:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertCOBAutosnoozeNight", default: false)
    
    static let alertBatteryActive:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertBatteryActive", default: false)
    static let alertBatteryLevel:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertBatteryLevel", default: 25)
    static let alertBatterySound:UserDefaultsValue<String> = UserDefaultsRepository.get(key: "alertBatterySound", default: "Machine_Charge")
    static let alertBatteryRepeat:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertBatteryRepeat", default: true)
    static let alertBatteryIsSnoozed:UserDefaultsValue<Bool> = UserDefaultsRepository.get(key: "alertBatteryIsSnoozed", default: false)
    static let alertBatterySnoozedTime:UserDefaultsValue<Date?> = UserDefaultsRepository.get(key: "alertBatterySnoozedTime", default: nil)
    static let alertBatterySnoozeHours:UserDefaultsValue<Int> = UserDefaultsRepository.get(key: "alertBatterySnoozeHours", default: 1)
    static var deviceBatteryLevel: UserDefaultsValue<Double> = UserDefaultsRepository.get(key: "deviceBatteryLevel", default: 100.0)
}
