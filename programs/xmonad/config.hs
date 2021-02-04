import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Util.EZConfig
import           XMonad.Hooks.FadeInactive             ( fadeInactiveLogHook )
import           XMonad.Hooks.ManageDocks              ( avoidStruts
                                                       , manageDocks
                                                       , docksEventHook )
import           XMonad.Hooks.ManageHelpers            ( (-?>)
                                                       , composeOne
                                                       , doCenterFloat )

-- Imports for Polybar --
import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D
import           XMonad.Hooks.DynamicLog

main :: IO()
main = mkDbusClient >>= main'

main' :: D.Client -> IO()
main' dbus = xmonad $ desktopConfig
             { terminal        = "alacritty"
             , logHook         = myPolybarLogHook dbus
             , layoutHook      = myLayoutHook
             , manageHook      = myManageHook
             , handleEventHook = myEventHook
             }
        `additionalKeysP`
        [ ("M-p", spawn "rofi -show run")
        , ("<Print>", spawn "scrot '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'")
        , ("C-<Print>", spawn "sleep 0.2; scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 2%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 2%-")
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        ]

mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = (D.signal opath iname mname)
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#2E9AFE"
      gray   = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red    = "#722222"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = shorten 100 . wrapper purple
          }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)

myLogHook = fadeInactiveLogHook 0.9

myLayoutHook = avoidStruts $ layoutHook desktopConfig
myManageHook = manageApps <+> manageDocks <+> manageHook desktopConfig
  where
    isRole              = stringProperty "WM_WINDOW_ROLE"
    isFileChooserDialog = isRole =? "GtkFileChooserDialog"
    manageApps = composeOne [ isFileChooserDialog -?> doCenterFloat ]
      
myEventHook = docksEventHook