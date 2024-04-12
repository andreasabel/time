{-# LANGUAGE Safe #-}
{-# LANGUAGE TypeSynonymInstances #-}

{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

-- | Module created based off of "Calendrical Calculations by Nachum Dershowitz"
module Data.Time.Calendar.Lunar.Lunar (
  -- * Year, month and day
  Year,
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

  -- * Lunar calendar
  toLunar,
  fromLunar,
  pattern YearMonthDay,
  --fromLunarValid, -- Need to fix YearDay module for Lunar dates
  showLunar,
  lunarMonthLength,
  -- calendrical arithmetic
  -- e.g. "one month after Muharram 1st"
  addLunarMonthsClip,
  addLunarMonthsRollOver,
  addLunarYearsClip,
  addLunarYearsRollOver,
  addLunarDurationClip,
  addLunarDurationRollOver,
  diffLunarDurationClip,
  diffLunarDurationRollOver,

  isLunarLeapYear, -- Should be defined in YearDay, here temporarily
) where

import Data.Time.Calendar.CalendarDiffDays
import Data.Time.Calendar.Days
import Data.Time.Calendar.Private
import Data.Time.Calendar.Lunar.MonthDay
import Data.Time.Calendar.Lunar.Types

-- | Convert to Lunar calendar.
toLunar :: Day -> (Year, MonthOfYear, DayOfMonth)
toLunar date@(ModifiedJulianDay mjd) = (year, month, fromIntegral day)
  where
    year                      = floor ( (30 * (fromIntegral mjd - fromIntegral islamicEpoch) + 10645) / 10631)
    priorDays                 = diffDays date (fromLunar year 1 1)
    month                     = floor ( (11 * fromIntegral priorDays + 330) / 325)
    day                       = diffDays date (fromLunar year month 1) + 1
    islamicEpoch = -451561

-- | Convert from Lunar calendar.
-- Invalid values will be clipped to the correct range, month first, then day.
fromLunar :: Year -> MonthOfYear -> DayOfMonth -> Day
fromLunar year month day = ModifiedJulianDay
  (
    fromIntegral day + 29
    * (fromIntegral month - 1)
    + floor (fromIntegral (6*month-1) / 11)
    + (year - 1) * 354
    + floor ( (4+11* fromIntegral year)/ 30)
    + islamicEpoch - 1
  )
  where islamicEpoch = -451561

-- | Bidirectional abstract constructor for the Lunar calendar.
-- Invalid values will be clipped to the correct range, month first, then day.
pattern YearMonthDay :: Year -> MonthOfYear -> DayOfMonth -> Day
pattern YearMonthDay y m d <-
    (toLunar -> (y, m, d))
    where
        YearMonthDay y m d = fromLunar y m d

{-# COMPLETE YearMonthDay #-}

-- | Show in ISO 8601 format (yyyy-mm-dd)
showLunar :: Day -> String
showLunar date = (show4 y) ++ "-" ++ (show2 m) ++ "-" ++ (show2 d)
  where
    (y, m, d) = toLunar date

-- | The number of days in a given month according to the Lunar calendar.
lunarMonthLength :: Year -> MonthOfYear -> DayOfMonth
lunarMonthLength year = monthLength (isLunarLeapYear year)

rolloverMonths :: (Year, Integer) -> (Year, MonthOfYear)
rolloverMonths (y, m) = (y + div (m - 1) 12, fromIntegral $ mod (m - 1) 12 + 1)

addLunarMonths :: Integer -> Day -> (Year, MonthOfYear, DayOfMonth)
addLunarMonths n day = (y', m', d)
  where
    (y, m, d) = toLunar day
    (y', m')  = rolloverMonths (y, fromIntegral m + n)

-- | Add months, with days past the last day of the month clipped to the last day.
-- For instance, 1440-01-29 + 1 month = 1440-02-29.
addLunarMonthsClip :: Integer -> Day -> Day
addLunarMonthsClip n day = fromLunar y m d
  where
    (y, m, d) = addLunarMonths n day

-- | Add months, with days past the last day of the month rolling over to the next month.
-- For instance, 1440-01-29 + 1 month = 1440-03-01.
addLunarMonthsRollOver :: Integer -> Day -> Day
addLunarMonthsRollOver n day = addDays (fromIntegral d - 1) (fromLunar y m 1)
  where
    (y, m, d) = addLunarMonths n day

-- | Add years, matching month and day, with last month of year clipped if necessary.
addLunarYearsClip :: Integer -> Day -> Day
addLunarYearsClip n = addLunarMonthsClip (n * 12)

-- | Add years, matching month and day, with Dhu al-Qidah 30th rolled over to Muharram 1st if necessary.
addLunarYearsRollOver :: Integer -> Day -> Day
addLunarYearsRollOver n = addLunarMonthsRollOver (n * 12)

-- | Add months (clipped to last day), then add days
addLunarDurationClip :: CalendarDiffDays -> Day -> Day
addLunarDurationClip (CalendarDiffDays m d) day = addDays d $ addLunarMonthsClip m day

-- | Add months (rolling over to next month), then add days
addLunarDurationRollOver :: CalendarDiffDays -> Day -> Day
addLunarDurationRollOver (CalendarDiffDays m d) day = addDays d $ addLunarMonthsRollOver m day

-- | Calendrical difference, with as many whole months as possible
diffLunarDurationClip :: Day -> Day -> CalendarDiffDays
diffLunarDurationClip day2 day1 =
      let
        (y1, m1, d1) = toLunar day1
        (y2, m2, d2) = toLunar day2
        ym1 = y1 * 12 + toInteger m1
        ym2 = y2 * 12 + toInteger m2
        ymdiff = ym2 - ym1
        ymAllowed =
            if day2 >= day1
                then
                    if d2 >= d1
                        then ymdiff
                        else ymdiff - 1
                else
                    if d2 <= d1
                        then ymdiff
                        else ymdiff + 1
        dayAllowed = addLunarDurationClip (CalendarDiffDays ymAllowed 0) day1
    in
        CalendarDiffDays ymAllowed $ diffDays day2 dayAllowed

-- | Calendrical difference, with as many whole months as possible.
diffLunarDurationRollOver :: Day -> Day -> CalendarDiffDays
diffLunarDurationRollOver day2 day1 =
    let
        (y1, m1, _) = toLunar day1
        (y2, m2, _) = toLunar day2
        ym1 = y1 * 12 + toInteger m1
        ym2 = y2 * 12 + toInteger m2
        ymdiff = ym2 - ym1
        findpos mdiff =
            let
                dayAllowed = addLunarDurationRollOver (CalendarDiffDays mdiff 0) day1
                dd = diffDays day2 dayAllowed
            in
                if dd >= 0 then CalendarDiffDays mdiff dd else findpos (pred mdiff)
        findneg mdiff =
            let
                dayAllowed = addLunarDurationRollOver (CalendarDiffDays mdiff 0) day1
                dd = diffDays day2 dayAllowed
            in
                if dd <= 0 then CalendarDiffDays mdiff dd else findpos (succ mdiff)
    in
        if day2 >= day1
            then findpos ymdiff
            else findneg ymdiff

-- | Is this year a leap year according to the Lunar calendar?
isLunarLeapYear :: Year -> Bool
isLunarLeapYear year = ((15 + 11 * year) `mod` 30) < 11

instance DayPeriod Year where
    periodFirstDay y = YearMonthDay y Muharram 1
    periodLastDay y = YearMonthDay y DhuAlHijjah 29
    dayPeriod (YearMonthDay y _ _) = y
