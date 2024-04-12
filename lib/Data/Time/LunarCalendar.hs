{-# LANGUAGE Safe #-}

module Data.Time.LunarCalendar (
    module Data.Time.Calendar.Days,
    module Data.Time.Calendar.CalendarDiffDays,
    module Data.Time.Calendar.Lunar.Lunar,
    module Data.Time.Calendar.Week,
    formatLunarDate
) where

import Data.Time.Calendar.CalendarDiffDays
import Data.Time.Calendar.Days
import Data.Time.Calendar.Lunar.Lunar
import Data.Time.Calendar.Week
import Data.Time.Format (formatTime, lunarTimeLocale)
import Data.Time.Calendar (fromGregorian)

-- | Formats given date to Lunar date, i.e Al-Khamis Ramadan 16, 1445
formatLunarDate :: Day -> String
formatLunarDate d = formatTime lunarTimeLocale "%A %B %Y" $ fromGregorian (fromIntegral $ y) m d'
    where (y, m, d') = toLunar d
