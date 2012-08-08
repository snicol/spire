module Spire
  class Mime
    def self.return_mimes
       return {
          ".html" => "text/html",
          ".text" => "text/plain",
          ".js" => "text/javascript",
          ".css" => "text/css",
          ".ics" => "text/calendar",
          ".csv" => "text/csv",
          
          ".png" => "image/png",
          ".jpeg" => "image/jpeg",
          ".gif" => "image/gif",
          ".bmp" => "image/bmp",
          ".tiff" => "image/tiff",
          ".ico" => "image/x-icon",

          ".mpeg" => "video/mpeg",

          ".xml" => "application/xml",
          ".rss" => "application/rss+xml",
          ".atom" => "application/atom+xml",
          ".yaml" => "application/x-yaml",

          ".json" => "application/json",
          ".pdf" => "application/pdf",
          ".zip" => "application/zip"
      }
    end
  end
end