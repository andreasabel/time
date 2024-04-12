module Data.Time.Calendar.Lunar.Types where

type Year = Integer

-- | Month of year, in range 1 (Muharram) to 12 (Dhu al-Hijjah).
type MonthOfYear = Int

pattern Muharram :: MonthOfYear
pattern Muharram = 1

pattern Safar :: MonthOfYear
pattern Safar = 2

pattern Rabi'AlAwwal :: MonthOfYear
pattern Rabi'AlAwwal = 3

pattern Rabi'AlThani :: MonthOfYear
pattern Rabi'AlThani = 4

pattern JumadaAlAwwal :: MonthOfYear
pattern JumadaAlAwwal = 5

pattern JumadaAlThani :: MonthOfYear
pattern JumadaAlThani = 6

pattern Rajab :: MonthOfYear
pattern Rajab = 7

pattern Sha'ban :: MonthOfYear
pattern Sha'ban = 8

pattern Ramadan :: MonthOfYear
pattern Ramadan = 9

pattern Shawwal :: MonthOfYear
pattern Shawwal = 10

pattern DhuAlQi'dah :: MonthOfYear
pattern DhuAlQi'dah = 11


-- | The twelve 'MonthOfYear' patterns form a @COMPLETE@ set.
pattern DhuAlHijjah :: MonthOfYear
pattern DhuAlHijjah = 12

{-# COMPLETE Muharram, Safar, Rabi'AlAwwal, Rabi'AlThani, JumadaAlAwwal, JumadaAlThani, Rajab, Sha'ban, Ramadan, Shawwal, DhuAlQi'dah, DhuAlHijjah #-}

-- | Day of month in Lunar calendar, in range 1 to 30.
type DayOfMonth = Int

-- | Day of year, in range 1 (Muharram 1st) to 355 (Dhu al-Hijjah 29st).
--  354 in a common year, 355 in a leap year.
type DayOfYear = Int

-- | Week of year, by various reckonings, generally in range 0-50 depending on reckoning.
type WeekOfYear = Int
