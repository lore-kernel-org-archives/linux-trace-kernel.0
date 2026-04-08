Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0623C9440;
	Wed,  8 Apr 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662418; cv=none; b=Qq0A49TjfPhcm9mYo+DwT/UxHmsyAkw7pvD3ALLiWgKkqWWwSFhtXYl+21CuZ1DGoFhJMDcWjnMmzyxu9ItllHGhKzvEv/2J4BL00o3DPoNymcUbDFqyED01n/PCWu+8YO1VOtKgLuz9FblVBMFEsfsg4swZ3OrGeQXWoizm57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662418; c=relaxed/simple;
	bh=HQwtVVjx7pAQNxVNLTdHqBAW5P9PDoSiACJN/K8atN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nl8kBYcupZLtco/nrc/wLyXceaWP99B2ak4hbMxLLAPH9vZA+dkQcKQBiITuJ/olct2Sx0UgLmVrEyY7kg5fc1YD9gGaecJKCGLE6r4tzb3tynCpMIPAXgVlz7noOHDSWHPdysZEIXFBB/eE9kbkw+1WofyqTDu4pJI30GRtE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F3bpG/ou; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F3bpG/ou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XW
	mUWW+OJ436vG5ieYdJVIGsZGcNZ+Bgh170BuUbu/0=; b=F3bpG/oulmjq2SBvis
	bztMjqNn985KTLH+TXII+L9yODePDasvXblZ9G0Rd1VVZzWXV2uwE66ICU6LXQ3m
	PJRXTP690FozJVhVBUEba7sOVHq/u5vcs29k76V6D9mPvHlKClpoDCjQrYIFLQ+D
	zWgoRKPQ7HDL6aUwmdy2YoWL8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3_rofddZpBIHhDg--.36317S3;
	Wed, 08 Apr 2026 23:32:52 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Check exact trace_marker_raw payload lengths
Date: Wed,  8 Apr 2026 23:32:41 +0800
Message-Id: <20260408153241.15391-2-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260408153241.15391-1-create0818@163.com>
References: <20260408153241.15391-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_rofddZpBIHhDg--.36317S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1UAr13Gr15ArW8Cr4Durg_yoWrWr48pa
	ySkFyktrZ3XF4jqw1fur42qr13A3ZxJ342gFykK34YvryDJrn2q3yxtFn0kry7JrZ5XryS
	va1F9FW0kF4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtrchUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCvwV2r2nWdSURUgAA3P

trace_marker_raw.tc currently depends on awk strtonum() and assumes
that the printed raw-data byte count is rounded up to four bytes.

Now that TRACE_RAW_DATA records keep the true payload length in the
event itself, update the testcase to validate the exact number of bytes
printed for a short sequence of writes. While doing that, make the test
portable to /bin/sh environments that use mawk by replacing strtonum()
and the lscpu endian probe with od-based checks.

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

