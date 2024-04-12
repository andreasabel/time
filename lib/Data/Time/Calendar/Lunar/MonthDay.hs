module Data.Time.Calendar.Lunar.MonthDay (
    MonthOfYear,
    pattern Muharram,
    pattern Safar,
    pattern Rabi'AlAwwal,
    pattern Rabi'AlThani,
    pattern JumadaAlAwwal,
    pattern JumadaAlThani,
    pattern Rajab,
    pattern Sha'ban,
    pattern Ramadan,
    pattern Shawwal,
    pattern DhuAlQi'dah,
    pattern DhuAlHijjah,
    DayOfMonth,
    DayOfYear,
    monthAndDayToDayOfYear,
    monthAndDayToDayOfYearValid,
    dayOfYearToMonthAndDay,
    monthLength,
) where

import Data.Time.Calendar.Private
import Data.Time.Calendar.Lunar.Types

-- | Convert month and day in the Lunar calendar to day of year.
-- First arg is leap year flag.
monthAndDayToDayOfYear :: Bool -> MonthOfYear -> DayOfMonth -> DayOfYear
monthAndDayToDayOfYear isLeap month day = (div (356 * month'' - 351) 12) + k + day'
    where
        month'  = clip 1 12 month
        day'    = fromIntegral (clip 1 (monthLength' isLeap month') day)
        month'' = fromIntegral month'
        k = if isLeap
                then -1
                else -2

-- | Convert month and day in the Lunar calendar to day of year.
-- First arg is leap year flag.
monthAndDayToDayOfYearValid :: Bool -> MonthOfYear -> DayOfMonth -> Maybe DayOfYear
monthAndDayToDayOfYearValid isLeap month day = do
    month' <- clipValid 1 12 month
    day' <- clipValid 1 (monthLength' isLeap month') day
    let
        day'' = fromIntegral day'
        month'' = fromIntegral month'
        k =
            if isLeap
                then -1
                else -2
    return $ (div (356 * month'' - 351) 12) + k + day''

-- | Convert day of year in the Lunar calendar to month and day.
-- First arg is leap year flag.
dayOfYearToMonthAndDay :: Bool -> DayOfYear -> (MonthOfYear, DayOfMonth)
dayOfYearToMonthAndDay isLeap yd =
    findMonthDay
    (monthLengths isLeap)
    ( clip
        1
        (if isLeap
            then 355
            else 354
        )
        yd
        )

findMonthDay :: [Int] -> Int -> (Int, Int)
findMonthDay (n : ns) yd
    | yd > n = (\(m, d) -> (m + 1, d)) (findMonthDay ns (yd - n))
findMonthDay _ yd = (1, yd)

-- | The length of a given month in the Lunar calendar.
-- First arg is leap year flag.
monthLength :: Bool -> MonthOfYear -> DayOfMonth
monthLength isLeap month' = monthLength' isLeap (clip 1 12 month')

monthLength' :: Bool -> MonthOfYear -> DayOfMonth
monthLength' isLeap month' = (monthLengths isLeap) !! (month' - 1)

monthLengths :: Bool -> [DayOfMonth]
monthLengths isleap =
    [ 30
    , 29
    , 30
    , 29
    , 30
    , 29
    , 30
    , 29
    , 30
    , 29
    , 30
    , if isleap
        then 30
        else 29
    ]
