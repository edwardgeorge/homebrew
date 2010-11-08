require 'formula'

class Jack <Formula
  homepage 'http://jackaudio.org'
  version '0.87'
  if MACOS_VERSION < 10.6
    url 'http://downloads.sourceforge.net/project/jackosx/JackOSX/0.87/JackOSX.0.87_32bits.zip'
    md5 '431b35cab4b3928e66e8accb2a1dee80'
  else
    url 'http://downloads.sourceforge.net/project/jackosx/JackOSX/0.87/JackOSX.0.87_64-32bits.zip'
    md5 'e1cb49d14659db0ce23f00977542a28e'
  end

  def install
    if MACOS_VERSION < 10.6
      system "xar -xf JackOSX.0.87_32bits.pkg"
    else
      system "xar -xf JackOSX.0.87_64-32bits.pkg"
    end
    system "pax -rz -f jack.pkg/Payload"
    Dir['usr/local/bin/jack_*',
        'Library/Audio/Plug-Ins/HAL/JackRouter.plugin/Contents/MacOS/JackRouter',
        'Library/Audio/Plug-Ins/Components/JACK-insert.component/Contents/MacOS/JACK-insert',
        'Library/Audio/Plug-Ins/VST/JACK-insert.vst/Contents/MacOS/JACK-insert',
        'Library/Frameworks/Jackmp.framework/Jackmp',
        'Library/Frameworks/Jackmp.framework/Versions/A/Jackmp'].each do |f|
      system "install_name_tool", "-change",
        "/Library/Frameworks/Jackmp.framework/Versions/A/Jackmp",
        prefix+"Frameworks/Jackmp.framework/Versions/A/Jackmp", f
    end
    Dir['usr/local/bin/jackd*', 'usr/local/lib/jackmp/*.so',
        '/Library/Frameworks/Jackservermp.framework/Versions/A/Jackservermp',
        '/Library/Frameworks/Jackservermp.framework/Jackservermp'].each do |f|
      system "install_name_tool", "-change",
        "/Library/Frameworks/Jackservermp.framework/Versions/A/Jackservermp",
        prefix+"Frameworks/Jackservermp.framework/Versions/A/Jackservermp", f
    end
    lib.install Dir['usr/local/lib/*']
    bin.install Dir['usr/local/bin/*']
    include.install Dir['usr/local/include/*']
    prefix.install 'Library/Frameworks'
    prefix.install 'Library/Audio'
    ln_s prefix+'Frameworks/Jackmp.framework/Jackmp',
         lib+'libjack.0.dylib', :force => true
    ln_s prefix+'Frameworks/Jackmp.framework/Jackmp',
         lib+'libjack.dylib', :force => true
    ln_s prefix+'Frameworks/Jackservermp.framework/Jackservermp',
         lib+'libjackserver.0.dylib', :force => true
    ln_s prefix+'Frameworks/Jackservermp.framework/Jackservermp',
         lib+'libjackserver.dylib', :force => true
  end

  def caveats; <<-EOS
The JackRouter CoreAudio device is located in jack/0.87/Audio/Plug-Ins/HAL/JackRouter.plugin
within the Homebrew Cellar. Link this into /Library/Audio to install (requires restart.)

ie: sudo ln -s #{HOMEBREW_PREFIX}/Cellar/jack/0.87/Audio/Plug-Ins/HAL/JackRouter.plugin /Library/Audio/Plug-Ins/HAL/
(you make need to make the parent directories first.)

Also included within the Audio subfolder are an AudioUnit and VST plugin.
  EOS
  end
end
