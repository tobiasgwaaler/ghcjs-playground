{-# LANGUAGE OverloadedStrings #-}

import GHCJS.DOM (
    currentDocument
    )
import GHCJS.DOM.Types(
    castToHTMLElement
    )
import GHCJS.DOM.Document (
    documentCreateElement,
    documentSetTitle,
    documentGetBody,
    documentGetElementById
    )
import GHCJS.DOM.Types (
    castToHTMLElement,
    castToHTMLHeadingElement,
    )
import GHCJS.DOM.HTMLElement (
    htmlElementSetInnerHTML
    )
import GHCJS.DOM.Element (
    elementOnclick
    )


import Lucid
import Data.Text.Lazy (toStrict)
import Data.Text (Text)
import Control.Monad.Trans ( liftIO )

title :: String
title = "GHCJS Adventures"

buttonId = "button"

template :: Html ()
template = do 
    h1_ "Hey"
    p_ [id_ buttonId] "Click me!"

renderText' :: Html () -> Text
renderText' = toStrict . renderText

main :: IO ()
main = do
    Just doc <- currentDocument
    documentSetTitle doc title

    Just body <- documentGetBody doc
    htmlElementSetInnerHTML body $ renderText' template

    Just button <- documentGetElementById doc buttonId
    elementOnclick button $ do
        liftIO $ putStrLn "clicked!"

    return ()

