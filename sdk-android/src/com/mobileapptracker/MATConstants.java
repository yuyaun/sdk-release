package com.mobileapptracker;

public class MATConstants {
    // SharedPreferences filename for referrer
    static final String PREFS_REFERRER = "mat_referrer";
    // SharedPreferences filename for Facebook re-engagement intent
    static final String PREFS_FACEBOOK_INTENT = "mat_fb_intent";
    // SharedPreferences filename for a MAT install
    static final String PREFS_INSTALL = "mat_install";
    // SharedPreferences filename for date of last log ID request
    static final String PREFS_LAST_LOG_ID = "mat_last_log_id";
    // Key for PREFS_LOG_ID
    static final String PREFS_LAST_LOG_ID_KEY = "lastLogIdDate";
    // SharedPreferences filename for date of last tracked app open
    static final String PREFS_LAST_OPEN = "mat_last_open";
    // Key for PREFS_LAST_OPEN
    static final String PREFS_LAST_OPEN_KEY = "lastOpenDate";
    // SharedPreferences filename for install log ID
    static final String PREFS_LOG_ID_INSTALL = "mat_log_id_install";
    // SharedPreferences filename for update log ID
    static final String PREFS_LOG_ID_UPDATE = "mat_log_id_update";
    // Key for PREFS_LOG_ID_INSTALL, PREFS_LOG_ID_UPDATE
    static final String PREFS_LOG_ID_KEY = "logId";
    // SharedPreferences filename for MAT ID
    static final String PREFS_MAT_ID = "mat_id";
    // SharedPreferences filename for queued events
    static final String PREFS_NAME = "mat_queue";
    // SharedPreferences filename for previously seen app version
    static final String PREFS_VERSION = "mat_app_version";
    
    // Server domain
    static final String MAT_DOMAIN = "engine.mobileapptracking.com";
    // Server domain for debug
    static final String MAT_DOMAIN_DEBUG = "debug.engine.mobileapptracking.com";
    
    // Date format for sending event date
    static final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
    // Date format for checking opens date
    static final String DATE_ONLY_FORMAT = "MM-dd-yyyy";
    // MAT Android SDK version number
    static final String SDK_VERSION = "2.4";
    // Debug log tag
    static final String TAG = "MobileAppTracker";
    // Max number of events to dump when queued
    static final int MAX_DUMP_SIZE = 50;
    // Set a network timeout time of 60s
    static final int TIMEOUT = 60000;
    // Time in milliseconds to wait for INSTALL_REFERRER before tracking
    static final int DELAY = 5000;
}