module View exposing (..)

import Html exposing (Html, a, div, h1, img, nav, program, text)
import Html.Attributes exposing (class, classList, href, style, src)
import Html.Events exposing (onClick)
import Page.About as About
import Page.Home as Home
import Route exposing (Route)
import Svg exposing (Svg, path, svg)
import Svg.Attributes
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
    let
        url =
            "https://github.com/rjacobs31/count-tree-road"

        description =
            "Find on GitHub"
    in
        div [ class "footer" ]
            [ a [ class "footer__link", href url ] [ githubLogo, text description ]
            ]


githubLogo : Svg Msg
githubLogo =
    svg
        [ --Svg.Attributes.height "32"
          Svg.Attributes.class "octicon octicon-mark-github"
        , Svg.Attributes.viewBox "0 0 16 16"
        , Svg.Attributes.version "1.1"

        --, Svg.Attributes.width "32"
        ]
        [ path
            [ Svg.Attributes.fillRule "evenodd"
            , Svg.Attributes.d "M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"
            ]
            []
        ]
