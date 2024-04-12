module Test.Calendar.CalendarsRef where

testCalendarsRef :: String
testCalendarsRef =
    unlines
        [ " == MJD -38780 == Gregorian 1752-09-13 == Julian 1752-09-02 == ISO 8601 1752-W37-3 == Lunar 1165-11-04"
        , " == MJD -38779 == Gregorian 1752-09-14 == Julian 1752-09-03 == ISO 8601 1752-W37-4 == Lunar 1165-11-05"
        , " == MJD 53393 == Gregorian 2005-01-23 == Julian 2005-01-10 == ISO 8601 2005-W03-7 == Lunar 1425-12-12"
        -- Additional tests generated for illustration
        , " == MJD 15020 == Gregorian 1900-01-01 == Julian 1899-12-20 == ISO 8601 1900-W01-1 == Lunar 1317-08-28"
        , " == MJD 18806 == Gregorian 1910-05-15 == Julian 1910-05-02 == ISO 8601 1910-W19-7 == Lunar 1328-05-05"
        , " == MJD 26278 == Gregorian 1930-10-29 == Julian 1930-10-16 == ISO 8601 1930-W44-3 == Lunar 1349-06-06"
        , " == MJD 33363 == Gregorian 1950-03-23 == Julian 1950-03-10 == ISO 8601 1950-W12-4 == Lunar 1369-06-03"
        , " == MJD 40814 == Gregorian 1970-08-16 == Julian 1970-08-03 == ISO 8601 1970-W33-7 == Lunar 1390-06-13"
        , " == MJD 46401 == Gregorian 1985-12-02 == Julian 1985-11-19 == ISO 8601 1985-W49-1 == Lunar 1406-03-19"
        , " == MJD 51603 == Gregorian 2000-02-29 == Julian 2000-02-16 == ISO 8601 2000-W09-2 == Lunar 1420-11-24"
        , " == MJD 57248 == Gregorian 2015-08-14 == Julian 2015-08-01 == ISO 8601 2015-W33-5 == Lunar 1436-10-28"
        , " == MJD 59164 == Gregorian 2020-11-11 == Julian 2020-10-29 == ISO 8601 2020-W46-3 == Lunar 1442-03-25"
        , " == MJD 60039 == Gregorian 2023-04-05 == Julian 2023-03-23 == ISO 8601 2023-W14-3 == Lunar 1444-09-14"

        , " == MJD 15020 == Gregorian 1900-01-01 == Julian 1899-12-20 == ISO 8601 1900-W01-1 == Lunar 1317-08-28"
        , " == MJD 18806 == Gregorian 1910-05-15 == Julian 1910-05-02 == ISO 8601 1910-W19-7 == Lunar 1328-05-05"
        , " == MJD 26278 == Gregorian 1930-10-29 == Julian 1930-10-16 == ISO 8601 1930-W44-3 == Lunar 1349-06-06"
        , " == MJD 33363 == Gregorian 1950-03-23 == Julian 1950-03-10 == ISO 8601 1950-W12-4 == Lunar 1369-06-03"
        , " == MJD 40814 == Gregorian 1970-08-16 == Julian 1970-08-03 == ISO 8601 1970-W33-7 == Lunar 1390-06-13"
        , " == MJD 46401 == Gregorian 1985-12-02 == Julian 1985-11-19 == ISO 8601 1985-W49-1 == Lunar 1406-03-19"
        , " == MJD 51603 == Gregorian 2000-02-29 == Julian 2000-02-16 == ISO 8601 2000-W09-2 == Lunar 1420-11-24"
        , " == MJD 57248 == Gregorian 2015-08-14 == Julian 2015-08-01 == ISO 8601 2015-W33-5 == Lunar 1436-10-28"
        , " == MJD 59164 == Gregorian 2020-11-11 == Julian 2020-10-29 == ISO 8601 2020-W46-3 == Lunar 1442-03-25"
        , " == MJD 60039 == Gregorian 2023-04-05 == Julian 2023-03-23 == ISO 8601 2023-W14-3 == Lunar 1444-09-14"
        ]
