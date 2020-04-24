#!/bin/bash
echo "ls"
ls
echo "pwd"
pwd

# download detekt jar
curl -sSLO https://github.com/arturbosch/detekt/releases/download/v1.8.0/detekt && chmod a+x detekt

# download detekt-hint jar
curl -sSL https://oss.sonatype.org/service/local/artifact/maven/redirect?r=releases&g=io.github.mkohm&a=detekt-hint&v=0.1.5&e=jar -o detekt-hint-0.1.5.jar 

# Run detekt with the detekt-hint plugin, requiring a config file to be set up in the repository
java -jar detekt.jar --plugin detekt-hint-0.1.5.jar --config config/detekt-hint-config.yml --input / -cp . --report xml:detekt-hint-report.xml --includes '**/src/**/*.kt'

# Install danger-kotlin
bash <(curl -s https://raw.githubusercontent.com/danger/kotlin/master/scripts/install.sh)
source ~/.bash_profile

npx --package danger danger-kotlin ci --dangerfile /Dangerfile.df.kts
