module Main where

import System.Directory
import Text.HandsomeSoup
import Text.XML.HXT.Core
import Data.Char (isSpace)

main :: IO ()
main = do
	files <- getDirectoryContents "html"
	mapM_ processFile files


processFile :: FilePath -> IO()
processFile url =
	let suburl = takeWhile (/= '.') url in
		let txtUrl = "text/" ++ suburl ++ ".txt" in
			if (take 1 url) == "." then return () else 
				do
					appendFile txtUrl $ "http://www.nadota.com/" ++ url ++ "\n"
					title <- getPageTitle $ "html/" ++ url
					mapM_ (\f -> appendFile txtUrl $ (trim f) ++ "\n\n") $ filter(not . null) title
					contents <- getFileContents $ "html/" ++ url
					mapM_ (\f -> appendFile txtUrl $ (trim f) ++ "\n\n") $ filter(not . null) contents

getFileContents :: String -> IO [String]
getFileContents url = do   
	let doc = fromUrl url
   	runX $ doc >>> css ".postcontent" /> getText

getPageTitle :: String -> IO [String]
getPageTitle url = do
	let doc = fromUrl url
	runX $ doc >>> css "title" /> getText

-- from http://stackoverflow.com/questions/6270324/in-haskell-how-do-you-trim-whitespace-from-the-beginning-and-end-of-a-string
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

