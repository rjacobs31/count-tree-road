module Main exposing (..)

import Html exposing (Html, program, text)
import Page.Home as Home
import Route exposing (Route)
import Task
import Types exposing (..)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    setRoute (Just Route.Root)
        { pageState = Loaded Blank }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage (getPage model.pageState) msg model


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    let
        transition toMsg task =
            ( { model | pageState = TransitioningFrom (getPage model.pageState) }
            , Task.attempt toMsg task
            )
    in
        case maybeRoute of
            Just Route.Root ->
                setRoute (Just Route.Home) model

            Just Route.Home ->
                transition HomeLoaded Home.init

            Just Route.About ->
                ( { model | pageState = Loaded About }, Cmd.none )

            _ ->
                ( model, Cmd.none )


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    case ( msg, page ) of
        ( GoTo newRoute, _ ) ->
            setRoute (Just newRoute) model

        ( HomeLoaded (Ok subModel), _ ) ->
            ( { model | pageState = Loaded (Home subModel) }, Cmd.none )

        ( HomeLoaded (Err _), _ ) ->
            ( model, Cmd.none )

        ( HomeMsg innerMsg, Home innerModel ) ->
            let
                ( newModel, _ ) =
                    Home.update innerMsg innerModel
            in
                ( { model | pageState = Loaded (Home newModel) }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    pageSubscriptions <| getPage model.pageState


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


pageSubscriptions : Page -> Sub Msg
pageSubscriptions page =
    case page of
        Home model ->
            Home.subscriptions model
                |> Sub.map (\subMsg -> HomeMsg subMsg)

        _ ->
            Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
