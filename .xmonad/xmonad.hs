import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Util.CustomKeys
import XMonad.Util.EZConfig

main = do
xmproc <- spawnPipe "xmobar"
xmonad $ defaultConfig
  { terminal = "xterm"
  , manageHook = manageDocks <+> manageHook defaultConfig
  , layoutHook = avoidStruts $ layoutHook defaultConfig
  , logHook = dynamicLogWithPP $ defaultPP { ppOutput = hPutStrLn xmproc, ppOrder = \(ws:_:t:_) -> [ws,t] }
  , borderWidth = 3
  }
  `additionalKeys`
  [ ((mod1Mask, xK_p), spawn "exe=`dmenu_path | /home/geohot/.cabal/bin/yeganesh -- -b -fn xft:Inconsolata:size=16` && eval \"exec $exe\"") ]
