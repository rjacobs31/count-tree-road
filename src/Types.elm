module Types exposing (..)

import Page.Home as Home
import Route


type alias Model =
    { pageState : PageState }


type PageState
    = Loaded Page
    | TransitioningFrom Page


type Page
    = Blank
    | About
    | Home Home.Model


type Msg
    = GoTo Route.Route
    | HomeLoaded (Result String Home.Model)
    | HomeMsg Home.Msg
