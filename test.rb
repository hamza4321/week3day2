require "google_drive"

session = GoogleDrive::Session.from_config("config.json")

p session


session.files.each do |file|
  p file.title
end

src = {
  name: "hello.txt",
  path: "."
}
src[:rpath] = File.join(src[:path], src[:name])

dst = {
  name: src[:name],
  path: "/tmp"
}
dst[:rpath] = File.join(dst[:path], dst[:name])



src = session.file_by_title(src[:name])
src.download_to_file(dst[:rpath])

