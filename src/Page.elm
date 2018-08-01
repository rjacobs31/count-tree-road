module Page exposing (..)

import Html exposing (Html, a, div, h1, nav, program, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Route exposing (Route)


type ActivePage
    = Other
    | Home
    | About


type Msg
    = Navigation Route


frame : Bool -> ActivePage -> Html msg -> Html msg
frame isLoading page content =
    div [ class "page-frame" ]
        [ viewHeader
        , content
        , viewFooter
        ]


viewHeader : Html msg
viewHeader =
    div [ class "header" ]
        [ h1 [ class "main-title" ] [ text "Count Tree Road" ]
        , nav [ class "top-nav" ]
            [ navLink Route.Home "Home"
            , navLink Route.About "About"
            ]
        ]


navLink : Route -> String -> Html msg
navLink route label =
    a [ class "top-nav__nav-link", href "javascript:void(0)" ] [ text label ]


viewFooter : Html msg
viewFooter =
    div [ class "footer" ]
        [ text "Find on GitHub"
        ]
