module Page.About exposing (..)

import Html exposing (Html, div, h2, p, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "page" ]
        [ h2 [ class "page__heading" ] [ text "HOW THIS APP CAME TO BE" ]
        , div [ class "page__body" ]
            [ p [] [ text "Have a short story about how this page came to be." ] ]
        ]
