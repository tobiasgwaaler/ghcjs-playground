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
import GHCJS.DOM.EventM (
    preventDefault
    )


import Lucid
import Data.Text.Lazy (toStrict)
import Data.Text (Text)
import Control.Monad.Trans ( liftIO )

title :: Text
title = "GHCJS Adventures"

buttonId :: Text
buttonId = "button"

template :: Html ()
template = do 
    h1_ (toHtml title)
    a_ [id_ buttonId, href_ "#"] "Click me!"

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
        preventDefault
        liftIO $ putStrLn "clicked!"

    return ()

