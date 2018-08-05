module Page.About exposing (..)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "card" ]
        [ div [ class "card__header" ] [ text "HOW THIS APP CAME TO BE" ]
        , div [ class "card__body" ]
            [ p [] [ text "Have a short story about how this page came to be." ] ]
        ]
