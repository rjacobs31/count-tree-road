module View exposing (..)

import Html exposing (Html, a, div, h1, nav, program, text)
import Html.Attributes exposing (class, classList, href)
import Html.Events exposing (onClick)
import Page.About as About
import Page.Home as Home
import Route exposing (Route)
import Types exposing (..)


type ActivePage
    = Other
    | HomePage
    | AboutPage


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage model False page

        TransitioningFrom page ->
            viewPage model True page


viewPage : Model -> Bool -> Page -> Html Msg
viewPage model isLoading page =
    div [ class "page-frame" ]
        [ viewHeader (getActivePage page)
        , viewContent page
        , viewFooter
        ]


getActivePage : Page -> ActivePage
getActivePage page =
    case page of
        Home _ ->
            HomePage

        About ->
            AboutPage

        Blank ->
            Other


viewHeader : ActivePage -> Html Msg
viewHeader activePage =
    div [ class "header" ]
        [ h1 [ class "main-title" ] [ text "Count Tree Road" ]
        , nav [ class "top-nav" ]
            [ navLink Route.Home (Just HomePage) activePage "HOME"
            , navLink Route.About (Just AboutPage) activePage "ABOUT"
            ]
        ]


navLink : Route -> Maybe ActivePage -> ActivePage -> String -> Html Msg
navLink route activeOn activePage label =
    let
        isActivePage =
            case activeOn of
                Just active ->
                    active == activePage

                _ ->
                    False
    in
        a
            [ classList
                [ ( "top-nav__nav-link", True )
                , ( "top-nav__nav-link--active", isActivePage )
                ]
            , href "javascript:void(0)"
            , onClick <| GoTo route
            ]
            [ text label ]


viewContent : Page -> Html Msg
viewContent page =
    case page of
        Home submodel ->
            Home.view submodel
                |> Html.map HomeMsg

        About ->
            About.view

        Blank ->
            text ""


viewFooter : Html Msg
viewFooter =
    div [ class "footer" ]
        [ a [ href "" ] [ text "Find on GitHub" ]
        ]
