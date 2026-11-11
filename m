Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378568;
	b=CxQLIQN7T6mKKUnOclxsLljLEgwe0oauwteN77qZS5Dd4wi0bCGfWb2gmLxJ1SsZ5Sut
	 hkFhnK+T7R81Afx3ExavEa8XvK8fBgeH0JYrFW/0zm0h3KLf3R9+FgPIRyf5389yJJKxg
	 ThXxx6n/H04VZkZuRRFMV2D7ALt6zBiNZjpXuxAUPNwLM6UIslqIWqsxBeA5ZoNrk9XFa
	 8Y+jWmZJ+mGPLnzduRrc2wj/Q3IVZTKf43+x2iw8PM4eiCqlKLbFo0FmolC+RFo2WWf/P
	 6S0f/G1/H4hrIy7VsPWmjpECYhed6l2zw4/YzTNHyM71IKWdGRaxG60E45h+0IPuxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=29lrC8bgDl0asZcXETXCpInEQQnGtGzK8+PnFUeH/0U=;
	b=HM5Zel0alpvUcONp2E8W9QAOTfWyj//1+KiwONmuaxmr5bWN53FLgSo3qE6pDv9KD2du
	 I4J7RbR1RzDWRrVkdZO8ZRK9I3kaT2DDToNHYYtAHnPVgX1So33WIg/H01bVE+2mMXauq
	 D72PlaDkhquwnpK0TZ1Bo3kx/fvwjqpIThRIyzIVbc4ABG+ZITEtUTFb5++9vbkP13azU
	 20a11eWiRuY1kA/FybCGIxzV9s1pxqeSCKpJRbhTVR0muky1tBQjTI7xKgEHydKQiU43Q
	 g4ZilxubpODEGXBLRFrB78DUMrcb3i5cN4E7bHymhvpJ7xPAFVhc9trtVtkLvLjW+yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UuuPy5+h;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39E606A333
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 06:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA39E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UuuPy5+h
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36e795af1d4so2396758eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 22:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378567; x=1794983367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29lrC8bgDl0asZcXETXCpInEQQnGtGzK8+PnFUeH/0U=;
        b=UuuPy5+hNF86O2JNZmFe8f/FXhxLltUhrt+zCn1z0YbE1SSVTBC5ek7hzRhwqx9s5Z
         MVFS410HupyAUkJOGfqkwdvRj7GLSrQjaFJC+eSCU8LfkC0WZmo6RR4lvv4dttW2m2Br
         AiqgQaqJZIsFfZEebVasM8n6SYTOmSCTbvFWoW0BduMx60q+7ac+/1RdULDc/5v/52Hm
         JNZwAATLhSIw0nC+rX2AdkJ1OqYp9/AK/R5Lmtta6ukI8/s1ohRzBc/mh6ABpqmRQc51
         IKirqnkFKuSpFiy72INVOzo528f3aybVASzE1wE48GgeLCsVJ+zwpSsax/wAtQ8NAmy4
         JogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378567; x=1794983367;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=29lrC8bgDl0asZcXETXCpInEQQnGtGzK8+PnFUeH/0U=;
        b=TRDTLvM+1/LGGLbDCgZCw947lcPyI3vORtESKcGuTDdmYk1wwmz9sFs+7qjSB2NIYX
         qy3mS5DQCwaY8mo66SimSzGUo/QV4/KWw5wfKhvPOA9aBK73ecik0PR/KgrZoG+OmOhB
         qtvXr7PKJHtWdEDTUL8c6uerIUlWY4WdizaOYLzdbdcZXTa3L0aZHkDZpkSbkastn0NY
         mtWyyvsXrBwJ0AEyhOcMtKeoG6S19qaWSIwMd3ZEh/MbBB7RHyrfrMlgI72XLDeIVsLr
         af+moOVvnbUwXRHXnbjUbHAgy9omkyu42XPYyw/xIyMV4MKjaXcoCqWbIe6zhcA/eAqe
         f6og==
X-Gm-Message-State: APuU4Z/LvHPeiuu/hz6449I7jUbXNXBkKH8aG2kNgGbaNofwW57cr3ST
	BH+XE6W6QIk4Zi4Z5IxtSb5vm/k2gCRlK6Z51Yd0Z6fs1jsxLOli9DlY45Of64cA
X-Gm-Gg: AYBFou2nS8qSNBwXxQobtCpME/mYKrMsBZgQhg7zC3u4ZAn+IhrtqVHOH026+dy57aW
	RnvzUUHwIa0z4EOqFj8uSIGKlFK90mEJptDsrNns9mfUkSTQKI5ctl+OjTJvuKFhNWwfRUR2d3s
	AVDXembhbHH9vIBppiB3ahOSnppkbCKAEyyCQiH36eg9HUp7ukozQ6plZo6kWcDSzyrN+Pd5Iz0
	lBt62a8BbkIwtAsggPerH3wnmzVHIPo3BneNQ5nf8Y9BXCTbrxWmbFekdfi3Uk7WfMrLKyUNVIu
	X7HEv/f3TZgEczY14fiagEQuusnbImm5gUmGUtUq+dBunzLSDGb1FAY0/kZq+GUw5YUl0pUl1oo
	wPXCFTvJdGsRD/6IJxfQ9JxPLd5wlPbP535ci6dGO5wrF9qBYOJ7dnHiu3HDzcwuYEqrsGoOMaY
	BZCIRvKdMIpr9powRFo3bBt90/6UaQDIjlM/3Lu5RP7RklsfaeXeA36fASxnDSqzDVUSoKfP7Zx
	Oodg1OeKpQ0kyE6DUTG7/p5qhA5K8QZyNqFSnleDQFTSa6ZvtzuGjygKRzNGpVL3vZGzPKUbxHK
	iWTyb1I07vYudwgKsW++mzK2ClVyOeH7cbheIcDexw==
X-Received: by 2002:a05:7300:560d:b0:361:a195:c46e with SMTP id 5a478bee46e88-3766763b79emr2353464eec.1.1794378566704;
        Tue, 10 Nov 2026 22:29:26 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe07dsm12963137eec.20.2026.11.10.22.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:29:26 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtla: clean up tracefs instances on SIGTERM, and test the abnormal exits
Date: Wed, 11 Nov 2026 12:10:00 +0800
Message-ID: <1794300001.11111.1234567890@gmail.com>
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

rtla: clean up tracefs instances on SIGTERM, and test the abnormal exits

rtla creates a tracefs instance for each run and removes it on the normal
exit path. If the process is interrupted, killed by its own -d timer, or if
an --on-threshold shell action fails, the instance is left behind and the
next invocation finds it in use.

Install a SIGTERM handler next to the existing SIGINT one, so the same
cleanup runs for both, and add a test that walks each of those paths and
checks that the instance is gone afterwards.

The test harness had two bugs, both reported by sashiko:

  - The availability probe ran "$RTLA" --version. rtla has no --version:
    main() only understands -h/--help and the three subcommands, and
    anything else falls through to rtla_usage(), which exits 129. The probe
    therefore always failed and the whole suite reported SKIP, so none of
    these cases ever ran. Probe --help instead, require exit 129 and the
    version banner, which is what the other rtla tests already do.

  - The TAP wrapper treated any line starting with "SKIP: " from the helper
    as a group-level skip. A subtest that could not cross the threshold on
    an idle machine printed one of those, which marked the entire test as
    skipped and left the loop below it unreachable. Per-case skips now say
    "note:", and only real group-level skips keep the SKIP: prefix.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

---
diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 8c7f5e7..b86a600 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,7 @@ static void stop_trace(int sig)
 static void set_signals(struct common_params *params)
 {
 	signal(SIGINT, stop_trace);
+	signal(SIGTERM, stop_trace);
 	if (params->duration) {
 		signal(SIGALRM, stop_trace);
 		alarm(params->duration);
@@ -51,6 +52,7 @@ static void set_signals(struct common_params *params)
 static void unset_signals(struct common_params *params)
 {
 	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (params->duration) {
 		alarm(0);
 		signal(SIGALRM, SIG_DFL);
diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/tests/cleanup.t
new file mode 100644
index 0000000..176b1a9
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
index 0000000..c27db96
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
@@ -0,0 +1,211 @@
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
+# Wait for an rtla instance and its signal handler.  The instance appears
+# before set_signals() runs, so wait for rtla to start its workload (or at
+# least for it to survive a short grace period) before sending SIGINT.
+wait_running() {
+	_path=$1
+	_pid=$2
+	wait_present "$_path" 10000 || return 1
+	sleep 1
+	kill -0 "$_pid" 2>/dev/null
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

