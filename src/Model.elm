--Model and all Types
module Model exposing (..)

--elm Packages
import Bootstrap.Tab as Tab
import Bootstrap.Dropdown as Dropdown
import Bootstrap.Modal as Modal
import Http

type alias Model =
    { enemy : Character -- The enemy displayed on the homepage
    , tmpEnemy : Character -- Will eventually be useless after refactor, I just have to get a better feel for let and in
    , showString : String
    , myDrop1State : Dropdown.State
    , damage : String
    , deathAlertVisibility : Modal.Visibility
    , tabState : Tab.State
    , characterList : List DungeonMap_Character
    , addCharacterIcon : AddCharacterIconState
    }

init : () -> (Model, Cmd Msg)
init _ =
    (
        { enemy = initEnemy
        , tmpEnemy = initEnemy
        , showString = ""
        , myDrop1State = Dropdown.initialState
        , damage = ""
        , deathAlertVisibility = Modal.hidden
        , tabState = Tab.initialState
        , characterList = []
        , addCharacterIcon = DrawingInactive
        }
    , Cmd.none
    )

initEnemy : Character
initEnemy =
    Enemy "none" 0 0


type Msg
    = LoadEnemy String -- call this with the name of the enemy to load its values into the enemy object
    | EnemyLoaded (Result Http.Error Character)
    | UpdateEnemy Character
    | UpdateTmp Character
    | CharacterDeath
    | MyDrop1Msg Dropdown.State
    | ChangeDamage String -- Will eventually be useless after refactor, I just have to get a better feel for let and in
    | CloseDeathAlert
    | DoNothing -- does nothing (yes, this IS necessary)
    | TabMsg Tab.State
    | AddCharacterIcon AddCharacterIconMsg

type Character
    = Enemy String Int Int
    -- can be expanded e.g. with a hero type with name, health, armor and a weapon

type AddCharacterIconState
    = DrawingInactive
    | DrawIcon CharacterIcon

type AddCharacterIconMsg
    = MouseDraw CharacterIcon
    | MouseClick CharacterIcon

type DungeonMap_Character
    = Player String String
    | Monster String String

type
    CharacterIcon
    = PlayerIcon String String
    | MonsterIcon String String

type alias MousePosition =
    { x : Float, y : Float }