#!/bin/bash -xv
# SPDX-FileCopyrightText: 2026 Taisei Yamazaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
        echo ${1}行目のテスト失敗
        res=1
}

res=0

### NORMAL INPUT ###
out=$(echo "Hello, WSL!" | ./kryptos)
[ "${out}" = "Khoor, ZVO!" ] || ng "$LINENO"

out=$(echo "Khoor, ZVO!" | ./kryptos -d)
[ "${out}" = "Hello, WSL!" ] || ng "$LINENO"

out=$(echo "明日の15時に東京駅で待ち合わせしましょう。" | ./kryptos)
[ "${out}" = "dvklwdqr15wrnlqlwrxnbrxhnlghpdfkldzdvhvklpdvkrx." ] || ng "$LINENO"

out=$(echo "明日の15時に東京駅で待ち合わせしましょう。" | ./kryptos | ./kryptos -d)
[ "${out}" = "ashitano15tokinitoukyouekidemachiawaseshimashou." ] || ng "$LINENO"

out=$(echo "Test Message 123" | ./kryptos -s 10 | ./kryptos -d -s 10)
[ "${out}" = "Test Message 123" ] || ng "$LINENO"

tmpfile=$(mktemp)
echo "Secret File Content" > "${tmpfile}"
out=$(./kryptos "${tmpfile}" | ./kryptos -d)
[ "${out}" = "Secret File Content" ] || ng "$LINENO"
rm -f "${tmpfile}"

### STRANGE INPUT ###
./kryptos no_such_file_99999.txt 2>/dev/null
[ "$?" -ne 0 ] || ng "$LINENO"

echo "abc" | ./kryptos -s not_a_number 2>/dev/null
[ "$?" -ne 0 ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "OK"
exit $res

