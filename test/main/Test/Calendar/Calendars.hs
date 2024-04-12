module Test.Calendar.Calendars (
    testCalendars,
) where

import Data.Time.Calendar
import Data.Time.Calendar.Julian
import Data.Time.Calendar.WeekDate
import Data.Time.LunarCalendar
import Test.Calendar.CalendarsRef
import Test.Tasty
import Test.Tasty.HUnit

showers :: [(String, Day -> String)]
showers =
    [ ("MJD", show . toModifiedJulianDay)
    , ("Gregorian", showGregorian)
    , ("Julian", showJulian)
    , ("ISO 8601", showWeekDate)
    , ("Lunar", showLunar)
    ]

days :: [Day]
days = [fromJulian 1752 9 2,
        fromGregorian 1752 9 14,
        fromGregorian 2005 1 23,

        fromGregorian 1900 1 1,
        fromGregorian 1910 5 15,
        fromGregorian 1930 10 29,
        fromGregorian 1950 03 23,
        fromGregorian 1970 08 16,
        fromGregorian 1985 12 02,
        fromGregorian 2000 2 29,
        fromGregorian 2015 8 14,
        fromGregorian 2020 11 11,
        fromGregorian 2023 04 05,

        fromLunar 1317 8 28,
        fromLunar 1328 05 05,
        fromLunar 1349 06 06,
        fromLunar 1369 06 03,
        fromLunar 1390 06 13,
        fromLunar 1406 03 19,
        fromLunar 1420 11 24,
        fromLunar 1436 10 28,
        fromLunar 1442 03 25,
        fromLunar 1444 09 14
        ]

testCalendars :: TestTree
testCalendars = testCase "testCalendars" $ assertEqual "" testCalendarsRef $ unlines $ map (\d -> showShowers d) days
  where
    showShowers day = concatMap (\(nm, shower) -> unwords [" ==", nm, shower day]) showers
