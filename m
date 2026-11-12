Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478989;
	b=gQmGKlQMyhVrJ1SKbt91PIOwDXpGXbO7k3F6lVS4wtFYdsGUH/JL9xdakEF0nI3zDNm2
	 IltvlqszCYuDwAAR3HkznoegtseU4rRoWDr79A0xWACbz/SBFH+L0JyUuaCUKhu+q44M3
	 yqw4gKzoH4N9aiGPhRp1Rz9x2tyj0uW8iK/sGarzvhAYCEN7X+fNMawta8DOmGD2ZmGMV
	 4TH+lCyrWaGRXFCL6yl5czJ74BjMIa6rsTZ8lujJoe3gsgw47HUi047xJRNh1neDHc5DT
	 Xl1tlCg9q4Ubz9AvgzbnKY6R3fLdVKANXPNr1tR2V98vtcxF/JFdmMQCrUm42tqjlMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UADG3vmq5C1KIkj85ghY7NZmH8EiSUnubol4GthSqz0=;
	b=nYRSg1KNUrpkNB8ThZxuvlg2hyzb7DSft0xvC7pzbqUEd3r+dBLtgRwBrwAKWGd0Cey7
	 p9YSip0q8HM3GAsOYLMyomYoDKLWkpHK7W73IkA1K83X7kmE9btVNR392yrL3xT2ElkFb
	 P+aPY+BFO3+joiaL+2q78imiXkKLUOoHQJCJKejW5zDeEQRylCPCQrwKMu6XCWd8xvtEn
	 AnzB1yG+CbwrcXMH+DaVDYM91BMKNe7wtr7VE6R9xnwwNc1V4Hxx2+jsj1Zq7gDPXj+bK
	 6mCRAHrexZvp70WN+rsba5vUrX71h0SufgiEsxWM3x18ET7voqtF3B00zgmizduBvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMjtflkk;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC32606A335
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC32606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMjtflkk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso2126394a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 02:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478988; x=1795083788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UADG3vmq5C1KIkj85ghY7NZmH8EiSUnubol4GthSqz0=;
        b=sMjtflkk9JgcCMylRWRyELXcZD9Td95EICkLTfA2drvoYaX2RYcA9N+r5xPdmA4vAO
         ZyDAOzGVg4dwZX2ta8FeSuivYIB2SVSqZPJQwOFApAGSRL7tsF7VnJKRFcnQ5DVGfSRR
         iat9Bt0T8uHJxk0LdCBGn/gMLvpYpHCfwT5qlPuRVGrM/QNRdCnHxRt85tKbfUmIdDtP
         4sP3aptH/U9U0NcAaHzufoey/7KAl5/ZLpSAdWwLk36KMT+f/6CbFBRt6TPBGzLiruWp
         2Lmt3mWVfAmxH9Cfwlcd2RQHFWrkQ+ZwL2emMFn0ZJ838VeB74b3RS4UolR/6vNIfbCK
         GpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478988; x=1795083788;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UADG3vmq5C1KIkj85ghY7NZmH8EiSUnubol4GthSqz0=;
        b=VUbruKFu1PH3y9o9Bql6uvjKzFgvGLYokjlaStyrZ1BdkBa9cO90AXjv9NtxB3HKXe
         wGGbfydMQhs8Rch92534Z5H4LQMmN34+FQVNSQokWHW3o98mEET3M44Y9QoV2spMfta+
         srT7ZdBh1iqBR3DMxfHDhPJIXjxHLud5xomzT7q2r2Aja8Xnq67CJFER6KcsEuKufSCx
         MmWzWHzOvWF0hesnFEfQTHim2izPsxLgJ18N9PV6G0hI7kjs8ZeLwBKcmN4M5IpVIjPd
         Rxp658YToC+Gv09c+HXOeS2N4a3im9FgWteLB6Mq0gh03n8aMivCTbASoLQgwUUVfZnX
         ndFg==
X-Gm-Message-State: APuU4Z/mXvCtCM5fMj2ToFvs66CtzU6qyR1EteRcFdNR69ywhDx8hzqG
	5M0hT1UFr+K7AxEnW+z0x/4wSmj5VwgoxFsrnDMjakpOtlHK03TN1c2qur93pPeOCbg=
X-Gm-Gg: AYBFou0yiwisYnxAh0Eik/6eFBZV2vDhiD2ziw+1niO8AUeGtEdhZ/Ev1aZ4v8VD96/
	7Mv71SKvrBvfoXZZ3WVzZfXhqGwGEjIGJF47NLjDaUkEnCkUAcplAd4CaiqYhcGKSCx4jop5I5Y
	czfuZjZG0fOIICfBvDDKa30IOiy7WC8U8z8e3HEdz555j5QnuYTLfLflDz58Y5LyWKypckv1VSg
	944FKPNBWre4HTGTOiFaEWLsGdRdPnRox2ZbtSz0Ud5zhK/9xZCFYuxLlzulK5oicRYfeJQmPRt
	+EkYX0pteOClDVsB7aZPYIVtVYxTh1vgzF1IEmf4aEwRxpMz0u5vntZDCCwZVVjWxFILzeLmwUP
	lALvBdw8FX3MgCdAACCnv+t8OqWgqad02htKgHlcOrHbmjAComGFfuFzxRsnW9hcxmxfaaXYCTT
	OtMWSHybtqJknxo4+Fu9IVOPmritA2rMvmcGzxd4Xba5xYcbR471oooP7iVoem3uCV4VQGvCNqG
	5PysI9EvqBh7E2m+dWsLS8HmLyV/2Y8ztEc9s5WOSUKOA+wfl5wYfWPoXluN/Xm7uAdhxBnrRLT
	wKWU2+Wx5lsvz0x2nfqbnzIYFDPv/5QTqDLx6Gi5ag==
X-Received: by 2002:a17:90b:2d8b:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b182edaee6mr5061893a91.28.1794478988475;
        Thu, 12 Nov 2026 02:23:08 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d697799sm2575525a12.16.2026.11.12.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:23:08 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla/tests: cover a CPU hotplug cycle in user-space timerlat mode
Date: Thu, 12 Nov 2026 18:20:20 +0800
Message-ID: <179447882047.254241.11597980544275717800@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From 1cd99268c2352aff3196d01773c0c2f93c521e33 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Thu, 12 Nov 2026 18:12:35 +0800
Subject: [PATCH] rtla/tests: cover a CPU hotplug cycle in user-space timerlat
 mode

timerlat samples either from a "timerlat/<cpu>" kernel thread, when
OSN_WORKLOAD is set, or from the user thread reading timerlat_fd.  Only
one may exist for a CPU.

Onlining a CPU during a user-space run installs the kernel thread anyway,
because osnoise_hotplug_workfn() calls start_kthread() without the check
that start_per_cpu_kthreads() makes.  When the trace stops, stop_kthread()
picks the teardown path from the current OSN_WORKLOAD, takes the
user-thread branch for that kthread and releases it with put_task_struct()
although kthread_stop() owns it.

Add a test that offlines and onlines a CPU while timerlat runs, and checks
that no timerlat workload kthread appeared.  The helper drives rtla
itself: the kthread is only torn down after rtla exits, so there is no
"rtla arguments" string to hand to check().

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Assisted-by: LLM
---
 .../rtla/tests/scripts/check-hotplug.sh       | 97 +++++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t           | 42 ++++++++
 2 files changed, 139 insertions(+)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-hotplug.sh

diff --git a/tools/tracing/rtla/tests/scripts/check-hotplug.sh b/tools/tracing/rtla/tests/scripts/check-hotplug.sh
new file mode 100755
index 000000000..5287034cd
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-hotplug.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Offline and online a CPU while rtla timerlat runs, and check that the
+# CPU coming back did not install a workload kthread.
+#
+# timerlat can sample in two ways.  With OSN_WORKLOAD set the sampling is
+# done by a "timerlat/<cpu>" kernel thread; with it clear (what rtla's
+# user-space mode uses) the sampling is done by the user thread itself,
+# named "timerlatu/<cpu>".  Only one of the two may exist for a CPU.
+#
+# Onlining a CPU used to install the kernel thread even in user-space mode,
+# because the hotplug worker called start_kthread() without the check that
+# start_per_cpu_kthreads() does.  stop_kthread() then picked the teardown
+# path from the current OSN_WORKLOAD, treated that kthread as a user thread
+# and freed it with put_task_struct() although kthread_stop() owns it, which
+# ends in warnings from stop_kthread, __put_task_struct and free_task, and
+# then in NULL pointer faults.
+#
+# The stray kthread shows up within a fraction of a second of the CPU coming
+# back, well before the teardown that crashes, so asserting on it gives a
+# clean failure instead of taking the kernel down.
+#
+# Usage: check-hotplug.sh <rtla> <cpu>
+#
+# Prints "HOTPLUG_FAIL: ..." on failure, "HOTPLUG_SKIP: ..." when the system
+# cannot run the test, and "HOTPLUG_OK" otherwise.
+
+RTLA=${1:?usage: check-hotplug.sh <rtla> <cpu>}
+CPU=${2:?usage: check-hotplug.sh <rtla> <cpu>}
+ONLINE=/sys/devices/system/cpu/cpu$CPU/online
+
+[ -x "$RTLA" ] || { echo "HOTPLUG_SKIP: $RTLA is not executable"; exit 0; }
+[ -w "$ONLINE" ] || { echo "HOTPLUG_SKIP: $ONLINE is not writable"; exit 0; }
+
+# Names of the timerlat workload threads that currently exist, one per line.
+timerlat_threads() {
+	for c in /proc/[0-9]*/comm; do
+		read -r name <"$c" 2>/dev/null || continue
+		case "$name" in
+		timerlat/*) echo "$name" ;;
+		esac
+	done
+}
+
+"$RTLA" timerlat top -q -d 20s -c 0,"$CPU" -P F:1 >/dev/null 2>&1 &
+pid=$!
+
+# Let rtla create its instance and settle into user-space sampling.
+sleep 3
+
+if ! echo 0 >"$ONLINE"; then
+	echo "HOTPLUG_SKIP: could not offline cpu$CPU"
+	kill -INT $pid 2>/dev/null; wait $pid 2>/dev/null; exit 0
+fi
+if ! echo 1 >"$ONLINE"; then
+	echo "HOTPLUG_SKIP: could not online cpu$CPU"
+	kill -INT $pid 2>/dev/null; wait $pid 2>/dev/null; exit 0
+fi
+
+# The hotplug work is queued on the CPU that just came up, and the damage is
+# done as part of bringing it up: stop_kthread() runs before this point and
+# the log is already tainted.  Check both, so that a build where the stray
+# kthread is gone but the teardown still misbehaves does not slip through.
+stray=''
+i=0
+while [ $i -lt 20 ]; do
+	stray=$(timerlat_threads)
+	[ -n "$stray" ] && break
+	sleep 0.2
+	i=$((i + 1))
+done
+
+# Give the run time to reach its own stop path, which is where the kthread
+# gets torn down, and then let it finish.
+sleep 2
+kill -INT $pid 2>/dev/null
+wait $pid 2>/dev/null
+sleep 1
+
+warn=$(dmesg 2>/dev/null | grep -c 'WARNING: at')
+fault=$(dmesg 2>/dev/null | grep -c 'BUG: kernel NULL pointer')
+
+if [ -n "$stray" ]; then
+	echo "stray workload kthread(s): $(echo $stray)"
+	echo "HOTPLUG_FAIL: cpu$CPU came back online and a timerlat" \
+		"workload kthread was started in user-space mode"
+	exit 1
+fi
+
+if [ "$fault" -gt 0 ] || [ "$warn" -gt 0 ]; then
+	dmesg | grep -A12 'WARNING: at' | tail -30
+	echo "HOTPLUG_FAIL: the kernel warned ($warn) or faulted ($fault) during the hotplug run"
+	exit 1
+fi
+
+echo "HOTPLUG_OK"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 5116857d7..a1af962ad 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -6,6 +6,18 @@ test_begin
 set_timeout 2m
 timerlat_sample_event='/sys/kernel/tracing/events/osnoise/timerlat_sample'
 
+# Pick a CPU that can be offlined without taking cpu0 down.  A hotplug test
+# needs one whose "online" file is writable, plus at least one other CPU so
+# the tool can still run; otherwise skip the case.
+hotplug_cpu=''
+for c in /sys/devices/system/cpu/cpu[1-9]*/online; do
+	[ -w "$c" ] || continue
+	hotplug_cpu=${c#/sys/devices/system/cpu/cpu}
+	hotplug_cpu=${hotplug_cpu%/online}
+	[ "$(cat /sys/devices/system/cpu/online)" != "$hotplug_cpu" ] || continue
+	break
+done
+
 if ldd $RTLA | grep libbpf >/dev/null && [ -d "$timerlat_sample_event" ]
 then
 	# rtla build with BPF and system supports BPF mode
@@ -153,4 +165,34 @@ else
 fi
 done
 
+# Hotplug test: timerlat in user-space mode samples from the user thread and
+# has no workload kthread.  Onlining a CPU mid-run must not install one; if
+# it does, stopping the trace tears that kthread down through the
+# user-thread path, which warns and then faults.
+#
+# The helper drives rtla itself, because the kthread is only torn down after
+# rtla exits, so there is no "rtla arguments" string to hand to check().
+if [ -n "$hotplug_cpu" ]; then
+	ctr=$((ctr + 1))
+	if [ -n "$TEST_COUNT" ]; then
+		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
+		tmpdir=$(mktemp -d)
+		pushd "$tmpdir" >/dev/null
+
+		result=$("$testdir"/scripts/check-hotplug.sh "$RTLA" "$hotplug_cpu" 2>&1)
+		exitcode=$?
+
+		if [ "$exitcode" -eq 0 ] && grep -q '^HOTPLUG_OK' <<< "$result"; then
+			echo "ok $ctr - top survives a CPU hotplug cycle"
+		else
+			echo "not ok $ctr - top survives a CPU hotplug cycle"
+			echo "$result" | while read -r line; do echo "# $line"; done
+			printf "#\n# exit code %s\n" "$exitcode"
+		fi
+
+		popd >/dev/null
+		rm -r "$tmpdir"
+	fi
+fi
+
 test_end
-- 
2.43.0


