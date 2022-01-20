module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement
  | Increment10
  | Decrement10
  | Reset


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Increment10 ->
      model + 10

    Decrement ->
      if model > 0 then
        model - 1
      else
        model

    Decrement10 ->
      if model > 9 then
        model - 10
      else
        model
    
    Reset ->
      0 



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Increment ] [ text "+" ]
    , button [ onClick Increment10 ] [ text "++" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Decrement10 ] [ text "--" ]
    , button [ onClick Reset ] [ text "Reset" ]
    ]