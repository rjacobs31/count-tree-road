module Widgets exposing(..)

import Html exposing (Attribute, Html, div, text)

daysSinceCounter : List (Attribute msg) -> Html msg
daysSinceCounter attributes =
    div attributes
    [ text "Counter widget"
    ]
