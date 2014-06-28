#!/bin/bash

function setup_directory {
    SET_LANG=$1
    shift
    for BOOK_DIR in "$@" ; do
        echo "   $BOOK_DIR"
        openstack-generate-docbook -l $SET_LANG -b $BOOK_DIR -r ./
    done
}


function setup_lang {
    SET_LANG=$1
    shift
    echo "Setting up files for $SET_LANG"
    echo "======================="
    echo "  Directories:"
    setup_directory $SET_LANG 'security-guide'
}

function test_security_guide {
    SET_LANG=$1
    shift
    setup_lang "$SET_LANG"

    case "$PURPOSE" in
        test)
            openstack-doc-test -v --check-build -l "$SET_LANG" \
                --only-book security-guide
            RET=$?
            ;;
        publish)
            openstack-doc-test -v --publish --check-build "$SET_LANG" \
                --only-book security-guide
            RET=$?
            ;;
    esac
    if [ "$RET" -eq "0" ] ; then
        echo "... succeeded"
    else
        echo "... failed"
        BUILD_FAIL=1
    fi
}

function test_language () {

    case "$language" in
        all)
            test_security_guide "ja"
            ;;
        ja)
            test_security_guide "$language"
            ;;
        *)
            BUILD_FAIL=1
            echo "Language $language not handled"
            ;;
    esac
}

function usage () {
    echo "Call the script as: "
    echo "$0 PURPOSE LANGUAGE1 LANGUAGE2..."
    echo "PURPOSE is either 'test', 'publish' or 'publish-install'"
    echo "LANGUAGE can also be 'all'."
}

if [ "$#" -lt 2 ] ; then
    usage
    exit 1
fi
if [ "$1" = "test" ] ; then
   PURPOSE="test"
elif [ "$1" = "publish" ] ; then
   PURPOSE="publish"
else
    usage
    exit 1
fi
shift
BUILD_FAIL=0
for language in "$@" ; do
  echo
  echo "Building for language $language"
  echo
  test_language "$language"
done

exit $BUILD_FAIL
