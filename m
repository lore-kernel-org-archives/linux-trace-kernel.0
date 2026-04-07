Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9939B96A;
	Tue,  7 Apr 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556815; cv=none; b=XzS/f5Dly5R1dro3QUc6m7yu6Q91+dZ5sNKNDx9Sz8e17dlRK1Ch8rUheRaYRQymVuCPxEV4SmcPvk84cLapyUgSDGCN17o2kIYWXpXuBuKrFN/1buswRshc6KzzV1fgBGtrHRlTVK9GET2LrGGffZCVni01yYtascwBNdcPT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556815; c=relaxed/simple;
	bh=8TB9mhnV+UDsCsa+YJUBkm3RCqmydCAOpwWNNY7zJos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRA3B9y16gcVcEaXKS3J9/8yp5kprHtBrxoX+AwkvtwbKgkxZEc9oqoR4tls4NXTWzy2oWvRillSMOJBhfw0ym4kBHURLrWBbSHVSd5ZOskgeiiOfZYg6HNkhOaEAR7f5ScQYzVNkMjBpsJgHbuBAk9aFrV8gO8eZmhdSvVMpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mCyc29DT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mCyc29DT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jg
	vPZT0q9a4EzsqYIeRi2BoE4Kq1WDUldFLiTe+/xqg=; b=mCyc29DTWA7y2KKig2
	qB2AmBPEUbxsN3HEXlMFUkToiahTo1dkBwx2mQDQrERXJxN3YvlgIrfwJcRMmBX4
	0rwkxxd4+LfeEQCXZlK5nqF6+bqO/59FvDHsLLY/lQ4khtDaKxVmLB8ybWpApceC
	EfpKoibtN+u8WWDlSglO2qrv0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXOySj2NRpl+1ZDg--.20426S2;
	Tue, 07 Apr 2026 18:12:53 +0800 (CST)
From: CaoRuichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Cao Ruichuang <create0818@163.com>
Subject: [PATCH] selftests/ftrace: Check exact trace_marker_raw payload lengths
Date: Tue,  7 Apr 2026 18:12:45 +0800
Message-Id: <20260407101245.78988-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXOySj2NRpl+1ZDg--.20426S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDGr4UWw4xCrWDtry8Grg_yoWrAFyfpa
	ySkFyktrWrJF4jqw1fCw12qryfJ3ZxJ342gFykK34YyryUJrn2q34xKFn0kry7ArZ8JryS
	va1F9FW8GFs8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9Z2xUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCvwbuKGnU2KbiEAAA3O

From: Cao Ruichuang <create0818@163.com>

trace_marker_raw.tc currently depends on awk strtonum() and
assumes that the printed raw-data byte count is rounded up to four
bytes.

That makes the test fail on systems that use mawk, and it no longer
matches the raw_data trace output we want to validate after preserving
true payload lengths for long records.

Rewrite the test to capture a small sequence of raw marker writes and
check the exact number of printed payload bytes in order. While doing
that, use od for the endian probe, switch to a fixed raw marker id so
the test only varies payload length, and disable pause-on-trace while
streaming trace_pipe.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc | 93 ++++++++++++-------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index a2c42e13f..3b37890f8 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -1,11 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Basic tests on writing to trace_marker_raw
-# requires: trace_marker_raw
+# requires: trace_marker_raw od:program
 # flags: instance
 
 is_little_endian() {
-	if lscpu | grep -q 'Little Endian'; then
+	if [ "$(printf '\001\000\000\000' | od -An -tu4 | tr -d '[:space:]')" = "1" ]; then
 		echo 1;
 	else
 		echo 0;
@@ -34,7 +34,7 @@ make_str() {
 
 	data=`printf -- 'X%.0s' $(seq $cnt)`
 
-	printf "${val}${data}"
+	printf "%b%s" "${val}" "${data}"
 }
 
 write_buffer() {
@@ -47,36 +47,68 @@ write_buffer() {
 
 
 test_multiple_writes() {
+	out_file=$TMPDIR/trace_marker_raw.out
+	match_file=$TMPDIR/trace_marker_raw.lines
+	wait_iter=0
+	pause_on_trace=
+
+	if [ -f options/pause-on-trace ]; then
+		pause_on_trace=`cat options/pause-on-trace`
+		echo 0 > options/pause-on-trace
+	fi
+
+	: > trace
+	cat trace_pipe > $out_file &
+	reader_pid=$!
+	sleep 1
+
+	# Write sizes that cover both the short and long raw-data encodings
+	# without overflowing the trace buffer before we can verify them.
+	for i in `seq 1 12`; do
+		write_buffer 0x12345678 $i
+	done
 
-	# Write a bunch of data where the id is the count of
-	# data to write
-	for i in `seq 1 10` `seq 101 110` `seq 1001 1010`; do
-		write_buffer $i $i
+	while [ "`grep -c ' buf:' $out_file 2> /dev/null || true`" -lt 12 ]; do
+		wait_iter=$((wait_iter + 1))
+		if [ $wait_iter -ge 10 ]; then
+			kill $reader_pid 2> /dev/null || true
+			wait $reader_pid 2> /dev/null || true
+			if [ -n "$pause_on_trace" ]; then
+				echo $pause_on_trace > options/pause-on-trace
+			fi
+			return 1
+		fi
+		sleep 1
 	done
 
 	# add a little buffer
 	echo stop > trace_marker
+	sleep 1
+	kill $reader_pid 2> /dev/null || true
+	wait $reader_pid 2> /dev/null || true
+	if [ -n "$pause_on_trace" ]; then
+		echo $pause_on_trace > options/pause-on-trace
+	fi
 
-	# Check to make sure the number of entries is the id (rounded up by 4)
-	awk '/.*: # [0-9a-f]* / {
-			print;
-			cnt = -1;
-			for (i = 0; i < NF; i++) {
-				# The counter is after the "#" marker
-				if ( $i == "#" ) {
-					i++;
-					cnt = strtonum("0x" $i);
-					num = NF - (i + 1);
-					# The number of items is always rounded up by 4
-					cnt2 = int((cnt + 3) / 4) * 4;
-					if (cnt2 != num) {
-						exit 1;
-					}
-					break;
-				}
-			}
-		}
-	// { if (NR > 30) { exit 0; } } ' trace_pipe;
+	grep ' buf:' $out_file > $match_file || return 1
+	if [ "`wc -l < $match_file`" -ne 12 ]; then
+		cat $match_file
+		return 1
+	fi
+
+	# Check to make sure the number of byte values matches the id exactly.
+	for expected in `seq 1 12`; do
+		line=`sed -n "${expected}p" $match_file`
+		if [ -z "$line" ]; then
+			return 1
+		fi
+		rest=${line#* buf: }
+		set -- $rest
+		if [ "$#" -ne "$expected" ]; then
+			echo "$line"
+			return 1
+		fi
+	done
 }
 
 
@@ -107,13 +139,6 @@ test_buffer() {
 
 ORIG=`cat buffer_size_kb`
 
-# test_multiple_writes test needs at least 12KB buffer
-NEW_SIZE=12
-
-if [ ${ORIG} -lt ${NEW_SIZE} ]; then
-	echo ${NEW_SIZE} > buffer_size_kb
-fi
-
 test_buffer
 if ! test_multiple_writes; then
 	echo ${ORIG} > buffer_size_kb
-- 
2.39.5 (Apple Git-154)

