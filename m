Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995567;
	b=OHHt/lxo9+5aXTlRL3LE0sVfWV76Eeka8ZVMp32f3kJaK7KQY0I/yVev3yo3g9ptyVpP
	 7QdAI1y1blbYz6Nc+J18JiZcGTGXwpY0sX+12JfpdRnjbmEZ+VByEHFOu9kEbdTOqbn4f
	 XlvkbCLNTWvDQoSA6QpBue61aVfpjE5NebQ8LFTpavvBv1ZP83AtA6F0i/9tgobtDW5iV
	 wysnCLADosEuQu9BqvT+LnPHMtIl0UQlqhVJwiv5fSTCA/BenQnqizzvKWlSjPXaFSnt5
	 +YUskRGv/ryAiySAozwATgbnINbbcNmHTavHS8ZORGuS77lzspKQOJLN5IKZBJoJR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995567;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1GFCElA8ujJH5+a0DpESzEtlksNsZNFkOHXOU6JLHLo=;
	b=RAaDBeVFqhEk/LfdsS/9Ki98wDU6uEMEKMMGVn5/hPcWxZN6weOZiKbFsWqZ+Nh0rI1x
	 KKFATYG79S59Mm/YRLtBG6Q3iNxnsp+iql3At8CdEnkLtqyGGReXnXQK68jCBVStkuiIR
	 ++51kEgZnY5lBnWH4wq7jDu5ypdMuO1nPUn5k68YhVr+v2yTfF5XyUu48FiCUhGR0ug3h
	 LCe/pAp4e64KUsqGjIfqNOnw7o32Ko1WDF04nwDVpLT72MYE4T5UtiDOi0sWm9FTVPtDY
	 AIjRqwDx52ha5SDVtvi7xIEJOQGqQjz9Eub2q05bwsmugUaZ3Ax2i+WEkPDIrj00rzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WfWyVUoK;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DF606A31A;
	Mon, 26 Oct 2026 06:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WfWyVUoK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=1GFCElA8ujJH5+a0DpESzEtlksNsZNFkOHXOU6JLHLo=;
	b=WfWyVUoKoX39jRJepDT1l2j3aFxU8RbWY0dkevwySfqO0RR06ORmYEcAzrMJ34
	dovPLt1i4YJ4uukGo5yD7ap6gqRWh/PIfsaOei2GqxQzLWp/ocefWhbHxEkjbrUC
	5aotJm5Zlo/ps9nusoWcx5AomDaFsI0egI6FeB04GqpN4=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: test that SIGINT unwinds cleanly
Date: Mon, 26 Oct 2026 14:17:18 +0800
Message-ID: <179299543892.294518.9833149213443549216@163.com>
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
X-CM-TRANSID:_____wD3H6bc8N5qbONyCw--.10009S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrW8Ar4xWFyfJr4DZF1kZrb_yoWxCF18pF
	WDCr9Fkr4jgFsIvr12kr48AryUCrZxCrWrK3Wktw4jvF9xWw4Iq3Wftry5ZF4UJrs5X3ya
	vay8uw1xKrW8Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Upc_fUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x3FO2re8N2lXQAA39

From: Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH] rtla: test that SIGINT unwinds cleanly
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
    linux-trace-kernel@vger.kernel.org,
    linux-kernel@vger.kernel.org

rtla's tests only ever run the tool to completion.  Nothing exercises the
path where the tool is interrupted, which is where the trace instance
teardown can go wrong: a run that leaves an instance behind makes the next
run fail for reasons that have nothing to do with the tool, and a run that
never returns is not detected at all.

Add check_with_action(), which runs the tool like check() does but performs
an action while it is running, and always reports LEFTOVER_INSTANCES=n so
that a test can assert the instance was removed.  The tool is started with
"eval exec" so that $! is the tool itself: the action signals $RTLA_PID
directly, and timeout(1) stays the direct parent so it forwards the signal.

Then use it for osnoise and timerlat: SIGINT must make the tool unwind and
remove its instance.  check-sigint.sh looks at the process state rather
than kill -0, because a tool that has exited but has not been reaped still
answers kill -0.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 4287cd6..3327e16 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -41,6 +41,86 @@ reset_osnoise() {
 	popd >/dev/null
 }
 
+leftover_instances() {
+	# Count the trace instances rtla should have removed on exit.
+	local d count=0
+	for d in osnoise_top osnoise_hist timerlat_top timerlat_hist osnoise_trace
+	do
+		[ -d "/sys/kernel/tracing/instances/$d" ] && count=$((count + 1))
+	done
+	echo $count
+}
+
+check_with_action() {
+	# Same as "check", but run ACTION while rtla is running, so that a test
+	# can interrupt the tool mid-run.
+	# Arguments: test_name rtla_args action exit_code [expected [unexpected]]
+	# The output of ACTION is appended to rtla's output, and the number of
+	# leftover trace instances is always reported as LEFTOVER_INSTANCES=n.
+	# ACTION can use $RTLA_PID to signal the tool.
+	local test_name=$1 tested_command=$2 action=$3
+	local expected_exitcode=${4:-0}
+	local expected_output=$5 unexpected_output=$6
+	local result exitcode fail failbuf pid
+
+	ctr=$(($ctr + 1))
+	[ -z "$TEST_COUNT" ] && return
+
+	[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
+
+	tmpdir=$(mktemp -d)
+	pushd $tmpdir >/dev/null
+
+	# eval so that the test can use shell syntax in its arguments, and exec
+	# so that $! is the tool itself and not an intermediate shell: tests
+	# signal $RTLA_PID directly.  timeout forwards the signal to its child.
+	# The arguments are re-parsed by the same eval as in check(), so quoting
+	# behaves identically; only exec and the quoted $RTLA are added.
+	( eval "exec stdbuf -oL $TIMEOUT \"$RTLA\" $tested_command" ) > rtla.txt 2>&1 &
+	pid=$!
+	# The ACTION runs as a separate process, so RTLA_PID has to be exported
+	# or the helper scripts see it as unset.
+	export RTLA_PID=$pid
+
+	sleep "${ACTION_DELAY:-3}"
+	eval "$action" >> rtla.txt 2>&1
+
+	wait $pid
+	exitcode=$?
+	echo "LEFTOVER_INSTANCES=$(leftover_instances)" >> rtla.txt
+
+	result=$(cat rtla.txt)
+	failbuf=''
+	fail=0
+
+	if [ -n "$expected_output" ] && ! grep -qE "$expected_output" <<< "$result"
+	then
+		fail=1
+		failbuf+=$(printf "# Output match failed: \"%s\"" "$expected_output")
+		failbuf+=$'\n'
+	fi
+
+	if [ -n "$unexpected_output" ] && grep -qE "$unexpected_output" <<< "$result"
+	then
+		fail=1
+		failbuf+=$(printf "# Output non-match failed: \"%s\"" "$unexpected_output")
+		failbuf+=$'\n'
+	fi
+
+	if [ $exitcode -eq $expected_exitcode ] && [ $fail -eq 0 ]
+	then
+		echo "ok $ctr - $test_name"
+	else
+		echo "not ok $ctr - $test_name"
+		echo -n "$failbuf"
+		echo "$result" | col -b | while read line; do echo "# $line"; done
+		printf "#\n# exit code %s\n" $exitcode
+	fi
+
+	popd >/dev/null
+	rm -r $tmpdir
+}
+
 check() {
 	test_name=$0
 	tested_command=$1
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 214fd40..df260e9 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -99,4 +99,11 @@ check_top_q_hist "with conditional continue" \
 check_top_hist "with trace output at end" \
 	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 
+# Cleanup test: the tool must unwind on SIGINT without leaving its trace
+# instance behind.
+check_with_action "top exits on SIGINT" \
+	"osnoise top -q" \
+	"$testdir/scripts/check-sigint.sh" \
+	0 "SIGINT handled OK" "LEFTOVER_INSTANCES=[1-9]"
+
 test_end
diff --git a/tools/tracing/rtla/tests/scripts/check-sigint.sh b/tools/tracing/rtla/tests/scripts/check-sigint.sh
new file mode 100755
index 0000000..7f63424
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-sigint.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Interrupt the tool with SIGINT and check that it unwinds instead of
+# hanging.  The caller reports LEFTOVER_INSTANCES separately.
+# Usage: check-sigint.sh
+# Output: "SIGINT handled OK" on success, an error otherwise.
+#
+# The tool is a child of the test shell, so once it has exited it stays
+# visible as a zombie until it is reaped -- and kill -0 still succeeds on a
+# zombie.  Check the process state instead, or a clean exit looks like a hang.
+
+pid=$RTLA_PID
+[ -n "$pid" ] || { echo "RTLA_PID not set"; exit 1; }
+
+kill -INT "$pid" 2>/dev/null || { echo "Failed to signal rtla"; exit 1; }
+
+# rtla's SIGINT handler stops tracing and lets the main loop return.  Give it
+# a few seconds before declaring it stuck.
+for _ in $(seq 30)
+do
+	[ -r "/proc/$pid/stat" ] || break
+	[ "$(awk '{print $3}' "/proc/$pid/stat" 2>/dev/null)" = "Z" ] && break
+	sleep 0.2
+done
+
+if [ -r "/proc/$pid/stat" ] && [ "$(awk '{print $3}' "/proc/$pid/stat")" != "Z" ]
+then
+	echo "rtla still running 6s after SIGINT"
+	exit 1
+fi
+
+echo "SIGINT handled OK"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 5116857..fe9c9da 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -153,4 +153,11 @@ else
 fi
 done
 
+# Cleanup test: the tool must unwind on SIGINT without leaving its trace
+# instance behind.
+check_with_action "top exits on SIGINT" \
+	"timerlat top -q" \
+	"$testdir/scripts/check-sigint.sh" \
+	0 "SIGINT handled OK" "LEFTOVER_INSTANCES=[1-9]"
+
 test_end

