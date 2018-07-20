module Main exposing (..)

import Date exposing (Date)
import Html exposing (Html, div, h1, program, text)
import Html.Attributes exposing (class)
import Result exposing (withDefault)
import Time exposing (Time, every, second)
import Widgets  exposing (daysSinceCounter)


-- MODEL


type alias Model =
    { currentDate : Date }


init : ( Model, Cmd Msg )
init =
    ( Model (Date.fromTime 0), Cmd.none )



-- MESSAGES


type Msg
    = NoOp
    | Tick Time



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [ class "main-title" ] [ text "Count Tree Road" ]
        , daysSinceCounter deskPopDate model.currentDate
        ]


deskPopDate : Date
deskPopDate =
    Date.fromString "2018-07-09"
    |> withDefault (Date.fromTime 0)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Tick time ->
            ({ model | currentDate = Date.fromTime time }, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
