
eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/calvinkhor/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/calvinkhor/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<
#
PATH=$PATH:$(which pygmentize)
