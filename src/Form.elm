module Form exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Bitwise exposing (and)

-- MAIN

main = 
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { name : String, 
    password : String,
    passwordConf : String
  }

init : Model
init =
  Model "" "" ""

-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordConf String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    
    Password password ->
      { model | password = password }
    
    PasswordConf passwordConf ->
      { model | passwordConf = passwordConf }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Confirm Password" model.passwordConf PasswordConf
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model = 
  if (String.length(model.password) == 0) then
    div [ style "color" "green" ] [ text "" ]
  else if ( String.length(model.password) < 9 ) then
    div [ style "color" "red" ] [ text "Minimum 9 characters" ]
    else if ( complexityValidation(model.password) ) then
        div [ style "color" "red" ] [ text "Complexity requirement" ]
      else if (String.length(model.passwordConf) == 0) then
        div [ style "color" "green" ] [ text "" ]
        else if (model.password == model.passwordConf) then
          div [ style "color" "green" ] [ text "Passwords match" ]
          else
            div [ style "color" "red" ] [ text "Passwords do not match!" ]

noLowerCase : String -> Bool
noLowerCase str = 
  (String.toUpper(str) == str)

noUpperCase : String -> Bool
noUpperCase str =
  (String.toLower(str) == str)

complexityValidation : String -> Bool
complexityValidation password =
  (noUpperCase password || noLowerCase password || containsNumber password)

containsNumber : String -> Bool
containsNumber str =
  String.filter Char.isDigit str
    |> \s -> (String.length s > 0)
    |> not

