module Page.Home exposing (Model, Msg, init, subscriptions, update, view)

import Date exposing (Date, toTime)
import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class)
import Task exposing (Task)
import Time exposing (Time, every, inHours, second)


type alias Model =
    { currentTime : Time
    , eventTime : Time
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
    case Date.fromString "2018-07-09" of
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
    div [ class "card card--days-since" ]
        [ div [ class "card__header" ]
            [ span [ class "lcd-display" ] [ text <| daysSince eventDate currentDate ]
            , text " days"
            ]
        ]


daysSince : Time -> Time -> String
daysSince eventTime currentTime =
    currentTime
        - eventTime
        |> inHours
        |> flip (/) 24
        |> floor
        |> toString



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
