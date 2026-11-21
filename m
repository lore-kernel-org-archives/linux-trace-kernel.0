Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262629;
	b=jnJ9K0B2Tm0GpZ8qf5ZcFtfgo9a+GSQQiVfkKkiO1ibPjcyjjQy+OuaMvMZyqCEOKo1W
	 YLMrv1CVVAqIaGWzawq8O7jZ2UlaqARc1NV6J+kuUn4O4wAiJmdL+19KA5CtYJfJOtapp
	 k4ajsvSq+lTizkQvtXG3OKf+4QHv7uW9DJA6nEEXkPnGUM/IdnkTNUvIngL/eOAZ8GFRP
	 eTRaubOeuyXXE1EFu/pYKDsmw3POs0fj9QP436oUjvvXQhdse7BkO4eO/XBG/9OLpzp60
	 8W4GWX/4JlII437V9FFjunyFVyBAh8QdVTdwRam5Z/BmYs88ane8vZJZlJWHMpgjE3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xlERfHkwv+Eq27YYXsuIGMemTUjwXXg/4bcGMx9ZKIs=;
	b=2nQyTfWRSDYkCLSwigyBO9p6kRK7ZzOB0AU45mnSAfo1XnMBfU4xMBR+RBDBDqiBNfaO
	 J17jARC1GUgoo/1XX5FTGu3AK09xAfRVlGtOrp2VqnocvhGVwb1aq+lOls8yoAiT0aurw
	 dkt+h47sPfUGMgvUWk0Dfj55AunzEbMKmkN05YCQsjKo55ODPfgZMXi2yP5drqvTLYCqT
	 n4V+p09u42itfIhzz7TKQYeMo31N/Ff+CwnbWuIUbYQNkjcqKrS4hWjR4J51jBMiRmVI4
	 rTkCvfmQcyFAIbOjBGZMddA8VtlbSCfhgnKKfhqmm6te4U783Q0bLWxHfqyDjpYsDdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjK+S5Ua;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AE606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 12:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 679AE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjK+S5Ua
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so863651a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262629; x=1795867429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlERfHkwv+Eq27YYXsuIGMemTUjwXXg/4bcGMx9ZKIs=;
        b=gjK+S5Ua1jtiQGqKlMw4wr6DfWGqn0c6QBCz2tuauevl6W/3kSJ4jJIiTstdgUXrII
         Chda75Z8Tubl+j6HqY0xof9G+q917nW8KCrPuYEuGV8j+oXiRIz9Xq32VCYzF29nQSgi
         PHTFK3Lv6ofHoGNKyfIjXobRTpgy7aij47uG8W2uEdn4cBv7l53AwsLyAJ7osn5L9S54
         4+Rcc0qNxUtURafdrwPfrE5owBYpKiE6kkChhvMMPGKXHAjiitpgZ9w06YDuxK4FJqhu
         sNIMQKb+8ivxXe0MnlpdNzjUc9H3+kSJDDAmPiBmjrSd1Iz/otMsbix6rDo7NlrxWF4o
         ruHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262629; x=1795867429;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlERfHkwv+Eq27YYXsuIGMemTUjwXXg/4bcGMx9ZKIs=;
        b=V8NmwLij7zYbClPLDLcAH2woNWUYsEtpigfiEV2qM572WC6/zdkNCOZ04MDTjHw43P
         glfl9bIdxB1YzKgZCTFwh5MAP2Gv9CFQ83OYOOyWZIO1KoMQQiUSgqpKk15fR1nfy+hi
         ++EF/JvV6hNy8/b7rYr+7GfgXvOCr0eZneWZGzUVgm1LDfBmO9T/9AEVsBMiBKU+u68J
         LN/mrz28E0HGHGbPRSBTjL7BEPlmjshCWX0UoPXeqZbjharnDgR/rezXghoK9lnFJsPQ
         8T3NUXEtPs5YoFGls0vNS1gfqfTtuQOPocZ1pzumxmbXmVOMuNoU4cb/lc+n6tl39d72
         a8DQ==
X-Gm-Message-State: APuU4Z9LMAuHQYXPGq1wsBncHF4nG6hZFM/Zn1RVHf7zkIxv6ISDcMB8
	NMLntKlleyq5M11gL53hHSVKgLwhmcpY1TPxCjBla+0r1BYrittEi0FI5lB2gQ==
X-Gm-Gg: AZFdTZdLWYWzNmY9K1ob+2AUhjlOmd0z5xZKkeEFTgAMMGnD4Rk5PSj6q53iOZlvU4s
	Fmkh74Udx7R192xZSjch2uxfQmILGIOjY/OKD83GwY2CT03CbkndCIqdbNAk5YKi3y+UkEDP50+
	YCEkkQqDRdqkIHaxk7Y3N1d/FEl5rHreCrqX2nY/dwKCGWLD/jclUxjzqmbSCeXua9CtCijytbs
	c6aPxe5DLsySkUJI28FRV0wrznUZ8fvxCCEnDDXFKcQvBS+Vvo5kbTV0+xH16U36IlEvQS4/C3o
	yWWNC/88fOwQ5JwEdJ62BOrzeFVqlTNMWM7IwIdI/xwkh+efeZ3QaTxaymUHkPkf8O00/DEO2El
	GNdWAa2agleh09AuipP71aSEwuV2+V8XqifuqwlFsL8cm/u4DwLEzypATJB25UZ11VBxxjWNO4p
	zZS4rxtBwCtVniOMdFYq4+mnJO031wMf9aee+RNozxeRFz57HbGTOHbi4H2O7uAQwsnRxOYrcVl
	4sEuvCVY/lVAVp1CmJKnpvMhJ1I7NMPmRyqADA5s3prLX2KehXUximXYVRhaXqJrx2YzeROHeep
	A1Q9LjhVof9JW5nbrxLenYjGJQT+rVzHeXBCuvf68g==
X-Received: by 2002:a17:90b:4b85:b0:3ac:9d26:5532 with SMTP id 98e67ed59e1d1-3b41c7b5fa8mr6071117a91.3.1795262628636;
        Sat, 21 Nov 2026 04:03:48 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm8767549a91.1.2026.11.21.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:03:48 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] rtla/tests: cover cleanup on abnormal exits
Date: Sat, 21 Nov 2026 20:03:22 +0800
Message-ID: <b52251473d0f5f87e7041d2d2de7a7db8319cff2.1795262546.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
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

rtla creates a tracefs instance for each run and removes it on the way
out.  Nothing verifies that, and a leaked instance only shows up as a
confusing failure of the next run.

Add a test for the paths users actually hit: SIGINT, SIGTERM, rtla's own
-d timer, a failing --on-threshold action, and several interrupted runs
followed by a normal one.  These need rtla running in the background
while the test signals it, which engine.sh's check() cannot express, so
cleanup.t drives a helper script and emits TAP itself.

The instance directory is created before set_signals() runs, so the
helper waits until /proc/<pid>/status reports SIGTERM in SigCgt before it
signals; waiting for the directory alone races startup.

The test needs root, tracefs and CONFIG_OSNOISE_TRACER, and skips when
tracefs is not writable.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/tracing/rtla/tests/cleanup.t            |  70 ++++++
 .../rtla/tests/scripts/check-cleanup.sh       | 219 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 tools/tracing/rtla/tests/cleanup.t
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cleanup.sh

diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/tests/cleanup.t
new file mode 100644
index 000000000..176b1a96f
--- /dev/null
+++ b/tools/tracing/rtla/tests/cleanup.t
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that rtla removes the tracefs instance it created on the abnormal
+# exit paths users actually hit:
+#
+#   - SIGINT during a run            (interactive Ctrl-C)
+#   - SIGTERM during a run
+#   - rtla's own -d/--duration timer
+#   - a failing --on-threshold shell action
+#   - several interrupted runs in a row, followed by a normal run
+#
+# A leaked instance pollutes the next invocation.
+source tests/engine.sh
+test_begin
+
+set_timeout 2m
+
+#
+# These cases need to run rtla in the background and signal it, which
+# engine.sh's check() (one foreground command) cannot express.
+#
+run_cleanup_cases() {
+	local helper="$testdir/scripts/check-cleanup.sh"
+	local out rc timeout_cmd skip
+
+	ctr=$((ctr + 1))
+	[ -z "$TEST_COUNT" ] && return
+
+	if [ ! -x "$helper" ]; then
+		echo "not ok $ctr - cleanup helper is not executable"
+		return
+	fi
+
+	# check() normally does this before every test. Do the same here, both to
+	# leave a clean tracer state and to make a hung helper terminate.
+	reset_osnoise || {
+		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failure # SKIP tracefs is not writable"
+		return
+	}
+	timeout_cmd=${TIMEOUT:-timeout -v -k 15s 2m}
+
+	out=$($timeout_cmd "$helper" "$RTLA" 2>&1)
+	rc=$?
+	if [ $rc -eq 0 ]; then
+		# "SKIP:" is what the helper prints when it could not run at all
+		# (no writable tracefs, or the binary is unusable); a per-case skip
+		# says "note:" instead. So the first SKIP: line means nothing ran.
+		skip=$(printf '%s\n' "$out" | sed -n 's/^SKIP: //p' | head -n 1)
+		if [ -n "$skip" ]; then
+			echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failure # SKIP $skip"
+			return
+		fi
+		printf '%s\n' "$out" | sed -n 's/^note: /# note: /p'
+		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failure"
+	elif [ $rc -eq 124 ] || [ $rc -eq 137 ]; then
+		echo "not ok $ctr - instances cleaned up on SIGINT, timeout and action failure"
+		echo "# helper timed out after 2m"
+	else
+		echo "not ok $ctr - instances cleaned up on SIGINT, timeout and action failure"
+		echo "# helper exited $rc"
+		printf '%s\n' "$out" | while read -r line; do
+			echo "# $line"
+		done
+	fi
+}
+
+run_cleanup_cases
+
+test_end
diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
new file mode 100755
index 000000000..7bd5b1233
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
@@ -0,0 +1,219 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that rtla removes the tracefs instances it created, even when it is
+# interrupted (SIGINT/SIGTERM), killed by its own timeout, or when a shell
+# action fails.
+#
+# This is a *test* for tools/tracing/rtla; it does not change rtla behaviour.
+#
+# Requires: root, tracefs mounted at /sys/kernel/tracing, CONFIG_OSNOISE_TRACER.
+# Usage: rtla_cleanup_test.sh /path/to/rtla
+
+RTLA=${1:-rtla}
+TRACEFS=${TRACEFS:-/sys/kernel/tracing}
+INSTANCES=$TRACEFS/instances
+FAIL=0
+PASS=0
+
+log()  { printf '%s\n' "$*"; }
+pass() { PASS=$((PASS+1)); log "PASS: $*"; }
+fail() { FAIL=$((FAIL+1)); log "FAIL: $*"; }
+cleanup_all() {
+	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist hwnoise_top; do
+		[ -d "$INSTANCES/$i" ] && rmdir "$INSTANCES/$i" 2>/dev/null
+	done
+}
+
+# Wait up to $2 ms for $1 to disappear.
+wait_gone() {
+	_path=$1
+	_ms=${2:-5000}
+	_i=0
+	while [ -d "$_path" ] && [ $_i -lt $_ms ]; do
+		sleep 0.05
+		_i=$((_i+50))
+	done
+	[ ! -d "$_path" ]
+}
+
+# Wait until $1 exists (up to $2 ms).
+wait_present() {
+	_path=$1
+	_ms=${2:-10000}
+	_i=0
+	while [ ! -d "$_path" ] && [ $_i -lt $_ms ]; do
+		sleep 0.05
+		_i=$((_i+50))
+	done
+	[ -d "$_path" ]
+}
+
+if [ ! -d "$INSTANCES" ] || [ ! -w "$INSTANCES" ] ||
+   [ ! -d "$TRACEFS/osnoise" ]; then
+	log "SKIP: tracefs, writable instances or CONFIG_OSNOISE_TRACER unavailable"
+	exit 0
+fi
+
+# Leave nothing behind from the test before it starts, and make sure the
+# command under test is actually usable.
+#
+# rtla has no --version: main() only knows -h/--help and -usage, and anything
+# else falls through to rtla_usage(), which exits 129 after printing the
+# version banner. Probing --version therefore always failed and the whole test
+# suite silently reported SKIP. Accept 129 as "this binary works".
+cleanup_all
+if [ ! -x "$RTLA" ]; then
+	log "SKIP: $RTLA is not executable"
+	exit 0
+fi
+help_out=$("$RTLA" --help 2>&1)
+rtla_rc=$?
+if [ "$rtla_rc" -ne 129 ] ||
+   ! printf '%s\n' "$help_out" | grep -q 'rtla version'; then
+	log "SKIP: $RTLA is not usable (--help exited $rtla_rc, no version banner)"
+	exit 0
+fi
+
+# Kill a background rtla if a case fails before reaping it.
+stop_pid() {
+	[ -n "$1" ] || return
+	kill -KILL "$1" 2>/dev/null
+	wait "$1" 2>/dev/null
+}
+
+# Wait until rtla has installed its SIGTERM handler.  The instance directory
+# appears before set_signals() runs, so signalling as soon as the directory
+# exists races startup; the signal disposition is visible in /proc.
+wait_running() {
+	_path=$1
+	_pid=$2
+
+	wait_present "$_path" 10000 || return 1
+	_i=0
+	while [ "$_i" -lt 200 ]; do
+		_cgt=$(sed -n 's/^SigCgt:[[:space:]]*//p' "/proc/$_pid/status" 2>/dev/null)
+		[ -n "$_cgt" ] && [ $((0x$_cgt & 0x4000)) -ne 0 ] && return 0
+		kill -0 "$_pid" 2>/dev/null || return 1
+		sleep 0.05
+		_i=$((_i + 1))
+	done
+	return 1
+}
+
+# ---------------------------------------------------------------------------
+# 1. SIGINT during a long run
+# ---------------------------------------------------------------------------
+cleanup_all
+$RTLA osnoise top -q -d 30s -P F:1 >/dev/null 2>&1 &
+pid=$!
+if ! wait_running "$INSTANCES/osnoise_top" "$pid"; then
+	fail "SIGINT: instance was never created (rtla did not start?)"
+	stop_pid "$pid"
+else
+	kill -INT "$pid" 2>/dev/null
+	wait "$pid" 2>/dev/null
+	if wait_gone "$INSTANCES/osnoise_top"; then
+		pass "SIGINT: instance removed after interrupt"
+	else
+		fail "SIGINT: instance still present after interrupt"
+	fi
+fi
+
+# ---------------------------------------------------------------------------
+# 2. SIGTERM during a long run
+# ---------------------------------------------------------------------------
+cleanup_all
+$RTLA osnoise top -q -d 30s -P F:1 >/dev/null 2>&1 &
+pid=$!
+if ! wait_running "$INSTANCES/osnoise_top" "$pid"; then
+	fail "SIGTERM: instance was never created (rtla did not start)"
+	stop_pid "$pid"
+else
+	kill -TERM "$pid" 2>/dev/null
+	wait "$pid" 2>/dev/null
+	if wait_gone "$INSTANCES/osnoise_top"; then
+		pass "SIGTERM: instance removed after terminate"
+	else
+		fail "SIGTERM: instance still present after terminate"
+	fi
+fi
+
+# ---------------------------------------------------------------------------
+# 3. rtla's own -d timeout path
+# ---------------------------------------------------------------------------
+cleanup_all
+$RTLA osnoise top -q -d 2s -P F:1 >/dev/null 2>&1
+rc=$?
+if [ "$rc" -ne 0 ]; then
+	fail "self-timeout: rtla failed to start or run (exit=$rc)"
+elif wait_gone "$INSTANCES/osnoise_top"; then
+	pass "self-timeout: instance removed (exit=$rc)"
+else
+	fail "self-timeout: instance still present (exit=$rc)"
+fi
+
+# ---------------------------------------------------------------------------
+# 4. shell action failure (-a / --on-threshold shell,command=...)
+# ---------------------------------------------------------------------------
+# -S is the stop-total threshold and yields exit 2 when the action fails.
+# A shell action only runs if that threshold is crossed; an idle machine may
+# never do so.  Do not call the no-threshold case a pass.
+cleanup_all
+action_rc=0
+for n in 1 2 3; do
+	$RTLA osnoise top -q -d 5s -P F:1 -r 900000 -S 1 \
+		--on-threshold 'shell,command="/bin/false"' >/dev/null 2>&1
+	rc=$?
+	action_rc=$rc
+	[ "$rc" -eq 2 ] && break
+done
+if [ "$action_rc" -eq 0 ]; then
+	# Not a group-level skip: the other cases still ran. Prefix it so the
+	# TAP wrapper does not report the whole test as skipped.
+	log "note: action-failure: stop-total threshold was not crossed"
+elif [ "$action_rc" -ne 2 ]; then
+	fail "action-failure: unexpected exit=$action_rc (wanted 2)"
+elif wait_gone "$INSTANCES/osnoise_top"; then
+	pass "action-failure: instance removed (exit=$action_rc)"
+else
+	fail "action-failure: instance still present (exit=$action_rc)"
+fi
+
+# ---------------------------------------------------------------------------
+# 5. repeated interrupted runs must not poison the next run
+# ---------------------------------------------------------------------------
+cleanup_all
+for n in 1 2 3; do
+	$RTLA osnoise top -q -d 20s -P F:1 >/dev/null 2>&1 &
+	pid=$!
+	if ! wait_running "$INSTANCES/osnoise_top" "$pid"; then
+		fail "repeated interrupts: run $n never created an instance"
+		stop_pid "$pid"
+		continue
+	fi
+	kill -INT "$pid" 2>/dev/null
+	wait "$pid" 2>/dev/null
+	if ! wait_gone "$INSTANCES/osnoise_top"; then
+		fail "repeated interrupts: run $n left an instance behind"
+		cleanup_all
+	fi
+done
+
+$RTLA osnoise top -q -d 2s -P F:1 >/dev/null 2>&1
+rc=$?
+if [ "$rc" -eq 0 ]; then
+	pass "repeated interrupts: following run still succeeds"
+else
+	fail "repeated interrupts: following run failed (exit=$rc)"
+fi
+if wait_gone "$INSTANCES/osnoise_top"; then
+	pass "repeated interrupts: no leftover instance"
+else
+	fail "repeated interrupts: leftover instance"
+fi
+
+cleanup_all
+log ""
+log "SUMMARY: $PASS passed, $FAIL failed"
+[ "$FAIL" -eq 0 ]
-- 
2.43.0


