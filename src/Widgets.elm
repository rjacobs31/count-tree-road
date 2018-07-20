module Widgets exposing(..)

import Date exposing (Date, toTime)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)
import Time exposing (inHours)

daysSinceCounter : Date -> Date -> Html msg
daysSinceCounter eventDate currentDate =
    div [ class "widget widget--days-since" ]
        [ text <| toString <| daysSince eventDate currentDate
        ]

daysSince : Date -> Date -> Int
daysSince eventDate currentDate =
    (toTime eventDate) - (toTime currentDate)
    |> inHours
    |> floor

type alias DaysSinceCounter =
    { eventDate : Date
    , currentDate : Date
    }
