module Widgets exposing (..)

import Date exposing (Date, toTime)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)
import Time exposing (Time, inHours)


daysSinceCounter : Maybe Time -> Maybe Time -> Html msg
daysSinceCounter eventDate currentDate =
    div [ class "card card--days-since" ]
        [ div [ class "card__header" ]
            [ text <| daysSince eventDate currentDate ++ " days" ]
        ]


daysSince : Maybe Time -> Maybe Time -> String
daysSince eventTime currentTime =
    case ( eventTime, currentTime ) of
        ( Just event, Just current ) ->
            current
                - event
                |> inHours
                |> flip (/) 24
                |> floor
                |> toString

        _ ->
            "N\\A"


type alias DaysSinceCounter =
    { eventDate : Date
    , currentDate : Date
    }
