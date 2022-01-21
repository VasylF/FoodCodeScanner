if ! [ -f /usr/local/bin/SpellChecker ]; then
    echo "SpellChecker not installed"
    exit 0
fi

git_path=/usr/local/bin/git
files=$($git_path diff --diff-filter=d --name-only -- "*.swift" "*.h" "*.m")
if (test -z $files) || (test ${#files[@]} -eq 0); then
  echo "no files changed."
  exit 0
fi

options=""
for file in $files
do
  options="$options $SRCROOT/$file"
done

/usr/local/bin/SpellChecker -- $options
