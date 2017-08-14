module PrayerHelper
  def prayer_html(prayer)
    prayer.text.gsub("\n", "<br />")
  end
end
