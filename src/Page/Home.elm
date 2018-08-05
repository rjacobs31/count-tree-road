module Page.Home exposing (Model, Msg, init, subscriptions, update, view)

import Char
import Date exposing (Date, toTime)
import Html exposing (Attribute, Html, div, span, table, td, tr, text)
import Html.Attributes exposing (class)
import String exposing (padLeft)
import Task exposing (Task)
import Time exposing (Time, every, inHours, inMinutes, inSeconds, second)


type alias Model =
    { currentTime : Time
    , eventTime : Time
    }


type alias TimeSince =
    { days : Int
    , hours : Int
    , minutes : Int
    , seconds : Int
    }


type Msg
    = UpdateTime Time


init : Task String Model
init =
    Time.now
        |> Task.map
            (\currentTime -> Model currentTime eventDate)


eventDate : Time
eventDate =
    case Date.fromString "2018-07-09T11:00" of
        Ok date ->
            toTime date

        Err _ ->
            0



-- View


view : Model -> Html msg
view model =
    daysSinceCounter model.eventTime model.currentTime


daysSinceCounter : Time -> Time -> Html msg
daysSinceCounter eventDate currentDate =
    let
        elapsed =
            timeSince eventDate currentDate
    in
        div [ class "card card--days-since" ]
            [ div [ class "card__header" ]
                [ text "TIME SINCE LAST DESK POP" ]
            , div [ class "card__body" ]
                [ table [ class "card__counter-list" ]
                    [ tr []
                        [ td [ class "lcd-display" ] [ text <| intPadLeft5 elapsed.days ]
                        , td [ class "card__label" ] [ text "DAYS" ]
                        ]
                    , tr []
                        [ td [ class "lcd-display" ] [ text <| intPadLeft5 elapsed.hours ]
                        , td [ class "card__label" ] [ text "HOURS" ]
                        ]
                    , tr []
                        [ td [ class "lcd-display" ] [ text <| intPadLeft5 elapsed.minutes ]
                        , td [ class "card__label" ] [ text "MINUTES" ]
                        ]
                    , tr []
                        [ td [ class "lcd-display" ] [ text <| intPadLeft5 elapsed.seconds ]
                        , td [ class "card__label" ] [ text "SECONDS" ]
                        ]
                    ]
                ]
            ]


intPadLeft5 : Int -> String
intPadLeft5 num =
    toString num
        |> padLeft 5 (Char.fromCode 160)


timeSince : Time -> Time -> TimeSince
timeSince eventTime currentTime =
    let
        timeDelta =
            currentTime - eventTime

        daysSince =
            timeDelta |> inHours |> flip (/) 24 |> floor

        hoursSince =
            timeDelta |> inHours |> floor

        minutesSince =
            timeDelta |> inMinutes |> floor

        secondsSince =
            timeDelta |> inSeconds |> floor
    in
        { days = daysSince
        , hours = hoursSince - 24 * daysSince
        , minutes = minutesSince - 60 * hoursSince
        , seconds = secondsSince - 60 * minutesSince
        }



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    every second UpdateTime



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTime time ->
            ( { model | currentTime = time }, Cmd.none )
