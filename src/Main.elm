module Main exposing (..)

import Html exposing (Html, div, h1, nav, program, text)
import Html.Attributes exposing (class)
import Page
import Page.About as About
import Page.Home as Home


-- MODEL


type Page
    = Blank
    | About
    | Home Home.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


type alias Model =
    { pageState : PageState }


init : ( Model, Cmd Msg )
init =
    ( Model (Loaded Blank), Cmd.none )



-- MESSAGES


type Msg
    = NoOp
    | HomeMsg Home.Msg



-- VIEW


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage model False page

        TransitioningFrom page ->
            div [ class "content" ]
                [ h1 [ class "main-title" ] [ text "Loading..." ] ]


viewPage : Model -> Bool -> Page -> Html Msg
viewPage model isLoading page =
    let
        frame =
            Page.frame isLoading
    in
        case page of
            Home submodel ->
                Home.view submodel
                    |> frame Page.Home
                    |> Html.map HomeMsg

            About ->
                About.view
                    |> frame Page.About

            _ ->
                text ""
                    |> frame Page.Other



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        HomeMsg subMsg ->
            ( model, Cmd.none )


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    case ( page, msg ) of
        ( Home innerModel, HomeMsg innerMsg ) ->
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
