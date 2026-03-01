module DevicesHelper
  def device_icon_class(category_name)
    case category_name&.downcase
    when 'mouse', 'マウス'
      'mouse'
    when 'mousepad', 'マウスパッド'
      'square'
    when 'keyboard', 'キーボード'
      'keyboard'
    when 'monitor', 'モニター', 'display'
      'desktop'
    when 'headset', 'headphones', 'ヘッドセット'
      'headset'
    when 'microphone', 'マイク'
      'microphone'
    else
      'gamepad'
    end
  end
end