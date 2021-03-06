//
//  MATParametersTests.m
//  MobileAppTracker
//
//  Created by John Bender on 12/18/13.
//  Copyright (c) 2013 HasOffers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AdSupport/AdSupport.h>
#import <MobileAppTracker/MobileAppTracker.h>
#import "MATTests.h"
#import "MATTestParams.h"
#import "../MobileAppTracker/Common/MATKeyStrings.h"
#import "../MobileAppTracker/Common/MATSettings.h" // move to new test class for internal params
#import "../MobileAppTracker/Common/MATTracker.h"

@interface MATParametersTests : XCTestCase <MobileAppTrackerDelegate>
{
    MATTestParams *params;
}

@end

@implementation MATParametersTests

- (void)setUp
{
    [super setUp];

    [MobileAppTracker initializeWithMATAdvertiserId:kTestAdvertiserId MATConversionKey:kTestConversionKey];
    [MobileAppTracker setDelegate:self];
    
    params = [MATTestParams new];

    emptyRequestQueue();
    
    networkOnline();
}

- (void)tearDown
{
    [MobileAppTracker setCurrencyCode:nil];
    [MobileAppTracker setPackageName:kTestBundleId];
    [MobileAppTracker setPluginName:nil];

    emptyRequestQueue();
    waitFor( 10. );

    [super tearDown];
}


#pragma mark - Age

- (void)testAgeValid
{
    static const NSInteger age = 35;
    NSString *expectedAge = [NSString stringWithFormat:@"%d", (int)age];
    
    [MobileAppTracker setAge:age];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );

    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_AGE, expectedAge );
}

- (void)testAgeYoung
{
    static const NSInteger age = 6;
    NSString *expectedAge = [NSString stringWithFormat:@"%d", (int)age];
    
    [MobileAppTracker setAge:age];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_AGE, expectedAge );
}

- (void)testAgeOld
{
    static const NSInteger age = 65536;
    NSString *expectedAge = [NSString stringWithFormat:@"%d", (int)age];
    
    [MobileAppTracker setAge:age];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_AGE, expectedAge );
}

- (void)testAgeZero
{
    static const NSInteger age = 0;
    NSString *expectedAge = [NSString stringWithFormat:@"%d", (int)age];
    
    [MobileAppTracker setAge:age];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_AGE, expectedAge );
}

- (void)testAgeNegative
{
    static const NSInteger age = -304;
    NSString *expectedAge = [NSString stringWithFormat:@"%d", (int)age];
    
    [MobileAppTracker setAge:age];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_AGE, expectedAge );
}


#pragma mark - Gender

- (void)testGenderMale
{
    static const MATGender gender = MATGenderMale;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)gender];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}

- (void)testGenderFemale
{
    static const MATGender gender = MATGenderFemale;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)gender];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}

- (void)testGenderMaleBackwardCompatible
{
    static const MATGender gender = MAT_GENDER_MALE;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)gender];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}

- (void)testGenderFemaleBackwardCompatible
{
    static const MATGender gender = MAT_GENDER_FEMALE;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)gender];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}

- (void)testGenderLarge
{
    static const MATGender gender = (MATGender)65536;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)MAT_GENDER_MALE];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}

- (void)testGenderNegative
{
    static const MATGender gender = (MATGender)-304;
    NSString *expectedGender = [NSString stringWithFormat:@"%d", (int)MAT_GENDER_MALE];
    
    [MobileAppTracker setGender:gender];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GENDER, expectedGender );
}


#pragma mark - Geolocation

- (void)testLatLongValid
{
    static const double lat = 47.;
    static const double lon = -122.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongZero
{
    static const CGFloat lat = 0.;
    static const CGFloat lon = 0.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongSmall
{
    static const CGFloat lat = -190.;
    static const CGFloat lon = -190.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongVerySmall
{
    static const CGFloat lat = -370.;
    static const CGFloat lon = -370.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongOneSmall
{
    static const CGFloat lat = -190.;
    static const CGFloat lon = 1.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongLarge
{
    static const CGFloat lat = 190.;
    static const CGFloat lon = 190.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongVeryLarge
{
    static const CGFloat lat = 370.;
    static const CGFloat lon = 370.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
}

- (void)testLatLongAltValid
{
    static const CGFloat lat = 47.;
    static const CGFloat lon = -122.;
    static const CGFloat alt = 41.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    NSString *expectedAlt = [@(alt) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
    ASSERT_KEY_VALUE( MAT_KEY_ALTITUDE, expectedAlt );
}

- (void)testLatLongAltZero
{
    static const CGFloat lat = 47.;
    static const CGFloat lon = -122.;
    static const CGFloat alt = 0.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    NSString *expectedAlt = [@(alt) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
    ASSERT_KEY_VALUE( MAT_KEY_ALTITUDE, expectedAlt );
}

- (void)testLatLongAltVeryLarge
{
    static const CGFloat lat = 47.;
    static const CGFloat lon = -122.;
    static const CGFloat alt = 999999.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    NSString *expectedAlt = [@(alt) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
    ASSERT_KEY_VALUE( MAT_KEY_ALTITUDE, expectedAlt );
}

- (void)testLatLongAltVerySmall
{
    static const CGFloat lat = 47.;
    static const CGFloat lon = -122.;
    static const CGFloat alt = -999999.;
    NSString *expectedLat = [@(lat) stringValue];
    NSString *expectedLon = [@(lon) stringValue];
    NSString *expectedAlt = [@(alt) stringValue];
    
    [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_LATITUDE, expectedLat );
    ASSERT_KEY_VALUE( MAT_KEY_LONGITUDE, expectedLon );
    ASSERT_KEY_VALUE( MAT_KEY_ALTITUDE, expectedAlt );
}


#pragma mark - Currency code

- (void)testCurrencyCode
{
    static NSString* const currency = @"CAD";
    
    [MobileAppTracker setCurrencyCode:currency];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_CURRENCY_CODE, currency );
}

- (void)testCurrencyCodeDefault
{
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    // fails because we have no real way to reset sharedManager
    //ASSERT_KEY_VALUE( KEY_CURRENCY_CODE, @"USD" );
}

- (void)testCurrencyCodeEmpty
{
    static NSString* const currency = @"";
    
    [MobileAppTracker setCurrencyCode:currency];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_CURRENCY_CODE, currency );
}

- (void)testCurrencyCodeNil
{
    [MobileAppTracker setCurrencyCode:nil];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:@"currency_code"], @"should not have set currency code" );
}

- (void)testCurrencyCodeLong
{
    static NSString* const currency = @"0000000000000000000000000000000000000000000";
    
    [MobileAppTracker setCurrencyCode:currency];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_CURRENCY_CODE, currency );
}


#pragma mark - Package name

- (void)testPackageName
{
    static NSString* const package = @"yourMom";
    
    [MobileAppTracker setPackageName:package];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_PACKAGE_NAME, package );
}

- (void)testPackageNameEmpty
{
    static NSString* const package = @"";
    
    [MobileAppTracker setPackageName:package];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_PACKAGE_NAME, package );
}

- (void)testPackageNil
{
    [MobileAppTracker setPackageName:nil];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:@"package_name"], @"should not have set package name" );
}

- (void)testPackageName256
{
    static NSString* const package = @"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    
    [MobileAppTracker setPackageName:package];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_PACKAGE_NAME, package );
}

- (void)testPackageName257
{
    static NSString* const package = @"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    
    [MobileAppTracker setPackageName:package];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_PACKAGE_NAME, package );
}

- (void)testPackageName1000
{
    static NSString* const package = @"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    [MobileAppTracker setPackageName:package];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertFalse( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_PACKAGE_NAME, package );
}

#pragma mark - Event parameters

- (void)testContentType
{
    static NSString* const contentType = @"atrnoeiarsdneiofphyou";
    
    [MobileAppTracker setEventContentType:contentType];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_CONTENT_TYPE, contentType );
}

- (void)testContentId
{
    static NSString* const contentId = @"atrnoeiarsdneiofphyou";
    
    [MobileAppTracker setEventContentId:contentId];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_CONTENT_ID, contentId );
}

- (void)testLevel
{
    static const NSInteger level = 13;
    
    [MobileAppTracker setEventLevel:level];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_LEVEL, [@(level) stringValue] );
}

- (void)testQuantity
{
    static const NSInteger quantity = 13;
    
    [MobileAppTracker setEventQuantity:quantity];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_QUANTITY, [@(quantity) stringValue] );
}

- (void)testSearchString
{
    static NSString* const searchString = @"atrnoeiarsdneiofphyou";
    
    [MobileAppTracker setEventSearchString:searchString];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_SEARCH_STRING, searchString );
}

- (void)testRating
{
    static const CGFloat rating = 3.14;
    
    [MobileAppTracker setEventRating:rating];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_RATING, [@(rating) stringValue] );
}

- (void)testDates
{
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:234098];
    NSString *date1String = [NSString stringWithFormat:@"%ld", (long)round( [date1 timeIntervalSince1970] )];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:890945.23];
    NSString *date2String = [NSString stringWithFormat:@"%ld", (long)round( [date2 timeIntervalSince1970] )];
    
    [MobileAppTracker setEventDate1:date1];
    [MobileAppTracker setEventDate2:date2];
    [MobileAppTracker measureAction:@"purchase"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_DATE1, date1String );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_DATE2, date2String );
}


#pragma mark - Event Attributes

- (void)testEventAttributes
{
    static NSString* const attr1 = @"eventAttr1";
    static NSString* const attr2 = @"eventAttr2";
    static NSString* const attr3 = @"eventAttr3";
    static NSString* const attr4 = @"eventAttr4";
    static NSString* const attr5 = @"eventAttr5";
    
    [MobileAppTracker setEventAttribute1:attr1];
    [MobileAppTracker setEventAttribute2:attr2];
    [MobileAppTracker setEventAttribute3:attr3];
    [MobileAppTracker setEventAttribute4:attr4];
    [MobileAppTracker setEventAttribute5:attr5];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB1, attr1 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB2, attr2 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB3, attr3 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB4, attr4 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB5, attr5 );
}

- (void)testEventAttributesEmpty
{
    static NSString* const attr = @"";
    
    [MobileAppTracker setEventAttribute1:attr];
    [MobileAppTracker setEventAttribute2:attr];
    [MobileAppTracker setEventAttribute3:attr];
    [MobileAppTracker setEventAttribute4:attr];
    [MobileAppTracker setEventAttribute5:attr];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB1, attr );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB2, attr );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB3, attr );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB4, attr );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB5, attr );
}

- (void)testEventAttributesNil
{
    [MobileAppTracker setEventAttribute1:nil];
    [MobileAppTracker setEventAttribute2:nil];
    [MobileAppTracker setEventAttribute3:nil];
    [MobileAppTracker setEventAttribute4:nil];
    [MobileAppTracker setEventAttribute5:nil];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_ATTRIBUTE_SUB1 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_ATTRIBUTE_SUB2 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_ATTRIBUTE_SUB3 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_ATTRIBUTE_SUB4 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_ATTRIBUTE_SUB5 );
    
}

- (void)testEventAttributesLong
{
    static NSString* const attr1 = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
    static NSString* const attr2 = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002";
    static NSString* const attr3 = @"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003";
    static NSString* const attr4 = @"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004";
    static NSString* const attr5 = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005";
    
    [MobileAppTracker setEventAttribute1:attr1];
    [MobileAppTracker setEventAttribute2:attr2];
    [MobileAppTracker setEventAttribute3:attr3];
    [MobileAppTracker setEventAttribute4:attr4];
    [MobileAppTracker setEventAttribute5:attr5];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB1, attr1 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB2, attr2 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB3, attr3 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB4, attr4 );
    ASSERT_KEY_VALUE( MAT_KEY_ATTRIBUTE_SUB5, attr5 );
}

- (void)testEventAttributesCleared
{
    static NSString* const attr1 = @"eventAttr1";
    static NSString* const attr2 = @"eventAttr2";
    static NSString* const attr3 = @"eventAttr3";
    static NSString* const attr4 = @"eventAttr4";
    static NSString* const attr5 = @"eventAttr5";
    
    [MobileAppTracker setEventAttribute1:attr1];
    [MobileAppTracker setEventAttribute2:attr2];
    [MobileAppTracker setEventAttribute3:attr3];
    [MobileAppTracker setEventAttribute4:attr4];
    [MobileAppTracker setEventAttribute5:attr5];
    [MobileAppTracker measureAction:@"search"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_ATTRIBUTE_SUB1, attr1 );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_ATTRIBUTE_SUB2, attr2 );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_ATTRIBUTE_SUB3, attr3 );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_ATTRIBUTE_SUB4, attr4 );
    ASSERT_KEY_VALUE( MAT_KEY_EVENT_ATTRIBUTE_SUB5, attr5 );
    
    params = [MATTestParams new];
    [MobileAppTracker measureAction:@"search"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_EVENT_ATTRIBUTE_SUB1 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_EVENT_ATTRIBUTE_SUB2 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_EVENT_ATTRIBUTE_SUB3 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_EVENT_ATTRIBUTE_SUB4 );
    ASSERT_NO_VALUE_FOR_KEY( MAT_KEY_EVENT_ATTRIBUTE_SUB5 );
}


#pragma mark - Plugin name

- (void)testPluginNameInvalid
{
    static NSString* const plugin = @"yourMom";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:MAT_KEY_SDK_PLUGIN], @"should have no value for sdk_plugin" );
}

- (void)testPluginNameEmpty
{
    static NSString* const plugin = @"";

    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:MAT_KEY_SDK_PLUGIN], @"should have no value for sdk_plugin" );
}

- (void)testPluginNameNil
{
    [MobileAppTracker setPluginName:nil];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:MAT_KEY_SDK_PLUGIN], @"should have no value for sdk_plugin" );
}

- (void)testPluginNameAir
{
    static NSString* const plugin = @"air";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNameAirUppercase
{
    static NSString* const plugin = @"AIR";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertFalse( [params checkKeyHasValue:MAT_KEY_SDK_PLUGIN], @"should have no value for sdk_plugin" );
}

- (void)testPluginNameCocos
{
    static NSString* const plugin = @"cocos2dx";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNameMarmalade
{
    static NSString* const plugin = @"marmalade";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNamePhoneGap
{
    static NSString* const plugin = @"phonegap";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNameTitanium
{
    static NSString* const plugin = @"titanium";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNameUnity
{
    static NSString* const plugin = @"unity";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}

- (void)testPluginNameXamarin
{
    static NSString* const plugin = @"xamarin";
    
    [MobileAppTracker setPluginName:plugin];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SDK_PLUGIN, plugin );
}


#pragma mark - User identifiers

- (void)testSiteId
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setSiteId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SITE_ID, ID );
}

- (void)testTrusteTPID
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setTRUSTeId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_SITE_ID, ID );
}

- (void)testExistingUser
{
    [MobileAppTracker setExistingUser:YES];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_EXISTING_USER, [@TRUE stringValue] );
}

- (void)testUserEmail
{
    static NSString* const EMAIL_ID = @"tempUserEmail@tempUserCompany.com";
    
    [MobileAppTracker setUserEmail:EMAIL_ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_USER_EMAIL, EMAIL_ID );
}

- (void)testUserId
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setUserId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_USER_ID, ID );
}

- (void)testUserName
{
    static NSString* const USER_NAME = @"testName";
    
    [MobileAppTracker setUserName:USER_NAME];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_USER_NAME, USER_NAME );
}

- (void)testFacebookUserId
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setFacebookUserId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_FACEBOOK_USER_ID, ID );
}

- (void)testTwitterUserId
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setTwitterUserId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_TWITTER_USER_ID, ID );
}

- (void)testGoogleUserId
{
    static NSString* const ID = @"testId";
    
    [MobileAppTracker setGoogleUserId:ID];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_GOOGLE_USER_ID, ID );
}

- (void)testPayingUser
{
    [MobileAppTracker setPayingUser:YES];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_IS_PAYING_USER, [@TRUE stringValue] );
    XCTAssertTrue( [MobileAppTracker isPayingUser], @"should be a paying user" );
}

- (void)testPayingUserAutomatic
{
    [MobileAppTracker setPayingUser:NO];
    [MobileAppTracker measureAction:@"testEvent" eventItems:nil referenceId:nil revenueAmount:1. currencyCode:@"USD"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_IS_PAYING_USER, [@TRUE stringValue] );
    XCTAssertTrue( [MobileAppTracker isPayingUser], @"should be a paying user" );
}

- (void)testPayingUserFalse
{
    [MobileAppTracker setPayingUser:NO];
    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_IS_PAYING_USER, [@FALSE stringValue] );
    XCTAssertFalse( [MobileAppTracker isPayingUser], @"should not be a paying user" );
}


// TODO: move this to new class for internal params testing
#pragma mark - iAd attribution

- (void)testiAdAttribution
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    id mat = [[MobileAppTracker class] performSelector:@selector(sharedManager)];
    MATSettings *sharedParams = [mat performSelector:@selector(parameters)];
#pragma clang diagnostic pop
    
    sharedParams.iadAttribution = @(TRUE);

    [MobileAppTracker measureAction:@"registration"];
    waitFor( MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    ASSERT_KEY_VALUE( MAT_KEY_IAD_ATTRIBUTION, [@(TRUE) stringValue] );
}


- (void)testiAdAttributionAppendTrue
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    id mat = [[MobileAppTracker class] performSelector:@selector(sharedManager)];
    MATSettings *settings = [mat performSelector:@selector(parameters)];
#pragma clang diagnostic pop
    
    double iAdCallbackDelay = 2.;
    
    settings.iadAttribution = nil;
    [MobileAppTracker measureSession];
    waitFor( iAdCallbackDelay );
    
    settings.iadAttribution = @TRUE;
    waitFor( MAT_SESSION_QUEUING_DELAY - iAdCallbackDelay + MAT_TEST_NETWORK_REQUEST_DURATION );
    
    XCTAssertTrue( [params checkDefaultValues], @"default value check failed: %@", params );
    XCTAssertTrue( [params checkKey:MAT_KEY_IAD_ATTRIBUTION isEqualToValue:[@(TRUE) stringValue]],
                   @"should have set iad_attribution to true" );
}


#pragma mark - MAT delegate

// secret functions to test server URLs
- (void)_matSuperSecretURLTestingCallbackWithURLString:(NSString*)trackingUrl andPostDataString:(NSString*)postData
{
    XCTAssertTrue( [params extractParamsString:trackingUrl], @"couldn't extract params from URL: %@", trackingUrl );
    if( postData )
        XCTAssertTrue( [params extractParamsJSON:postData], @"couldn't extract POST JSON: %@", postData );
}

@end
