# Public: Install Kaleidoscope.app into /Applications
#
# Examples
#
#    include kaleidoscope
class kaleidoscope (
  $enable_cli = true,
  $make_default = true
) {

  if $enable_cli {
    file { "${boxen::config::bindir}/ksdiff":
      ensure  => link,
      target  => '/Applications/Kaleidoscope.app/Contents/Resources/bin/ksdiff',
      mode    => 0755,
      require => Package['Kaleidoscope'],
    }
  }

  if $make_default {
    include git

    # Set diff tool
    git::config::global { "diff \"Kaleidoscope\".cmd":
      value => "ksdiff --partial-changeset --relative-path \"$MERGED\" -- \"$LOCAL\" \"$REMOTE\""
    }
    git::config::global { "diff.tool":
      value => "Kaleidoscope"
    }

    # Set merge tool
    git::config::global { "merge \"Kaleidoscope\".cmd":
      value => "ksdiff --merge --output \"$MERGED\" --base \"$BASE\" -- \"$LOCAL\" --snapshot \"$REMOTE\" --snapshot"
    }
    git::config::global { "diff \"Kaleidoscope\".trustExitCode":
      value => "true"
    }
    git::config::global { "merge.tool":
      value => "Kaleidoscope"
    }
  }

  package { 'Kaleidoscope':
    provider  => 'compressed_app',
    source    => 'http://cdn.kaleidoscopeapp.com/releases/Kaleidoscope-2.0.0-107.zip',
  }
}