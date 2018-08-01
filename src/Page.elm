module Page exposing (..)

import Html exposing (Html, div, h1, program, text)
import Html.Attributes exposing (class)


type ActivePage
    = Other
    | Home
    | About


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
        ]


viewFooter : Html msg
viewFooter =
    div [ class "footer" ]
        [ text "Find on GitHub"
        ]
