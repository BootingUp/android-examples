#!/bin/bash
# Written by Nishant Srivastava

#  Call as
# ./update_gradle_wrapper.sh

echo "Update gradle wrapper to which version?"
read version

echo ""
echo "Updating to Gradle Wrapper Version: $version"
echo ""

echo "> Updating apps:" 
# Iterate over each sub-directory inside the current directory
for DIR in ./*;
do
	# Check if gradlew exists inside the $DIR directory
	# If it does then it is an Gradle project
	if [ -f "$DIR/gradlew" ]; then
		# Navigate into the sub directory
		cd "$DIR"

		# Print the name of the sub directory
		echo "$DIR" | awk -F'/' '{print $2}'

		# Run command inside the sub-directory i.e Gradle project
		./gradlew clean | egrep 'FAILED|WARNING' 
		./gradlew wrapper --gradle-version $version --distribution-type all | grep "FAILED"

		# Go back to parent directory
		cd ../
	fi
done

# Delete all generated build folders, because they will eat up a lot of space on the disc
./delete_build_folder.sh
