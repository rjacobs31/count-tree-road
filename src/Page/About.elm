module Page.About exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "page" ]
        [ text "Have a short story about how this page came to be."
        ]
