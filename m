Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91465361965
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295828; cv=none; b=UOGHyG1Y6+kFnQR054EZyUnhT40v4R8NW9vpxOHj/OJVs6kPshB2Hrn6YZaDI7wLanLmEfeLxBcLt1WnztIwqvFY31oGkArhxmvRQHN3u7LVQWjCIzx253/q3fz6CcN8w6UFbE3888vFDWF4pOsJbZXvF/TcDaM6cd4P0OFmTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295828; c=relaxed/simple;
	bh=vKXmvGH4vEciOuk5BeaTFH0K22FLaTDPMtAV+sW2fU8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DskEr6LfIOcoUtMp32CZsVr6iZAodahC7LN20pVsEvp/P96CfC2vK8mMeN4ywccQfF42gP1LvNRba0PFTqIxwka98LmpbofW52CZzHEDsUQFQY6mghACmbVSBzHquFm8Chnq9fMnqMKJruu97KAghZJkhOtaVf4IlOE/8f3sY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3wH4IkZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3wH4IkZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e987a2ba0cso8077895ad.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 20:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792295826; x=1792900626; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL4aQopdmIs47ah61J1ufmFu0cfRQ7EvXnqg/QTq0j8=;
        b=P3wH4IkZcmODdQmHroaMWawUbTC8Uyf1E30MqkgAUhGrVmIwbKayt8xQCgty9XJfhw
         dRwZ/0j3/X80+gjujZAL6/bmmv5YFZRkNKoZ/K++I8flC9nqApmjIIqDamOvf96Ua4nM
         Z3vcll6VNmJqHgAHhxK3IHDe9/u/zCLtCprtZhMa/c0xlIC0Dsag7AoNtQ0ZeoIHc+jw
         hjEtCC8z4FyIgvhOHYRjuoXu6EQ3GolD9+pNTFUIxbEw3Hr0w0vSRAWboV0qp5nM4RRq
         09et1+Or87VOX0IVCccBt7Y3n1xXzaup6TCWBQSFHG1ywgOjXXn/HX7ITvVIrI9El5hR
         XJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295826; x=1792900626;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL4aQopdmIs47ah61J1ufmFu0cfRQ7EvXnqg/QTq0j8=;
        b=cx3u0EAdqI+n7wq2hUifWA26cMXoFf03Ig6gdC15P8FPZl65IA9cJDF/lwAZfAmBwz
         Khu+l38+IfKA3JrtRGZlXu/g3n/8oVs7V1Uq5Zc8Pr1QdxOaisS1x+hXr+rPgW60ymES
         h38eJ2vBJhQBG/lIPa30IbMkSYD5Evvswsl8cO+4Pnr8+3LiEXn7WaSfy9SK89gjt9fM
         ZOOrfncsPY1rg0uwxmW+lGd8JfFW4aU16RupusoBqXB5VqOv+UIYXAUgnjfZtKBfDmrS
         0GH+ngNekCx9L8tAfDwPalIaDPixbyBcipqRjkd0Q/NWNO9CZ3cE+SnuRSqOXgFSTkZj
         BAdg==
X-Gm-Message-State: AFq9FYLzmYxgUTyRBrqWGPmF/qPT01ac+oQhRwakQVhtMHbip30ejzvO
	qONwPXA52rMFVkjtoi7Y0x/ktofrHDUYtHXpNTca3UDB4DAMZNSMkiYeUC/VOPxC
X-Gm-Gg: AYBFou0blu+I9gdlD+FlnXFUgWZxoR5WJMj6pjcNQUUGPneGaeDvZbN97NqS2VwjNuw
	53zW03kdhXv5KAlDS0xJaQP8KvgszFGRcCyz5iHQY2R37ZPbr3d/5t7neALS7BUsSYRzijCtcmr
	CVQ+fyKhdLTea8hdgK03U4nkRWzNUSeHQi/8k1gbfOagF3EJ1A8Azks+5Fila2mHmQmsPYJiSpi
	Z2o4ac8xSlKQ5Rv2FQ3qkPTds6s5j2No1u5TDCaEbUybKvV4D2Uzo64+FBi8qsHMq1li6dqo87T
	N4bc9gVPo7Eq+18NTt/6QQQBPETKzD47hf7UCwHqfmsu718QZvkrY777T6+me73pUnFJaOBAN3Y
	0TogD1XGTn0IntLw+OrvmlBQ8+B6ayYwg3ncVokEZR1+4Np/F3taB7ZaLvH0XLYOYa1TIUbpYJX
	2ODMBUaEfv8D06370RH6AZg99DRrA22/KrpeZsZfb9vP8Cmn08kQE8NpVae7ZbySVE2A==
X-Received: by 2002:a17:902:d2c6:b0:2e9:3dd2:a90c with SMTP id d9443c01a7336-2e9a69f73b9mr36948785ad.20.1792295825697;
        Sat, 17 Oct 2026 20:57:05 -0700 (PDT)
Received: from localhost ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5c2f5asm25680295ad.9.2026.10.17.20.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:57:05 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: add tests for tracefs instance cleanup
Date: Sun, 18 Oct 2026 11:56:59 +0800
Message-ID: <179229581980.42222.4083144248804063295@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

rtla creates one of four tracefs instances per run (osnoise_top,
osnoise_hist, timerlat_top, timerlat_hist) and removes it on exit. A
cleanup failure only shows up as the next run failing with -EEXIST or
stale tracer state. tests/engine.sh already removes leftover instances
before each test, so the failure mode is known but not tested.

Add cleanup.t and a helper script covering the abnormal exits: SIGINT,
SIGTERM, the -d timer, a failing --on-threshold shell action, and three
interrupted runs followed by a normal run.

rtla did not handle SIGTERM, so killing it left the tracefs instance
behind. Install stop_trace as the SIGTERM handler, matching SIGINT and
the -d timer.

The helper needs to start rtla in the background and signal it, which
engine.sh's foreground check() cannot express. cleanup.t drives the
helper and emits the TAP result itself.

The test needs root, a writable tracefs and CONFIG_OSNOISE_TRACER. It
skips when any of those are missing. The action-failure case also skips
if the stop-total threshold is not crossed, since an idle machine may
never generate a sample above the limit.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/tracing/rtla/src/common.c               |   2 +
 tools/tracing/rtla/tests/cleanup.t            |  71 +++++++
 .../rtla/tests/scripts/check-cleanup.sh       | 197 ++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 tools/tracing/rtla/tests/cleanup.t
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cleanup.sh

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 8c7f5e75b2ec..b86a600769ed 100644
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
diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/tests/cl=
eanup.t
new file mode 100644
index 000000000000..f3b495b0aee4
--- /dev/null
+++ b/tools/tracing/rtla/tests/cleanup.t
@@ -0,0 +1,71 @@
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
+	local helper=3D"$testdir/scripts/check-cleanup.sh"
+	local out rc timeout_cmd skip
+
+	ctr=3D$((ctr + 1))
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
+		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failure=
 # SKIP tracefs is not writable"
+		return
+	}
+	timeout_cmd=3D${TIMEOUT:-timeout -v -k 15s 2m}
+
+	out=3D$($timeout_cmd "$helper" "$RTLA" 2>&1)
+	rc=3D$?
+	if [ $rc -eq 0 ]; then
+		# The helper may skip individual cases; a group-level SKIP means it
+		# could not run at all.
+		skip=3D$(printf '%s\n' "$out" | sed -n 's/^SKIP: //p' | head -n 1)
+		if [ -n "$skip" ]; then
+			echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failur=
e # SKIP $skip"
+			return
+		fi
+		printf '%s\n' "$out" | grep '^SKIP: ' | while read -r line; do
+			echo "# ${line}"
+		done
+		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action failure"
+	elif [ $rc -eq 124 ] || [ $rc -eq 137 ]; then
+		echo "not ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure"
+		echo "# helper timed out after 2m"
+	else
+		echo "not ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure"
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
diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tracin=
g/rtla/tests/scripts/check-cleanup.sh
new file mode 100755
index 000000000000..1b4397123708
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
@@ -0,0 +1,197 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that rtla removes the tracefs instances it created, even when it is
+# interrupted (SIGINT/SIGTERM), killed by its own timeout, or when a shell
+# action fails.
+#
+# This is a *test* for tools/tracing/rtla; it does not change rtla behaviour.
+#
+# Requires: root, tracefs mounted at /sys/kernel/tracing, CONFIG_OSNOISE_TRA=
CER.
+# Usage: rtla_cleanup_test.sh /path/to/rtla
+
+RTLA=3D${1:-rtla}
+TRACEFS=3D${TRACEFS:-/sys/kernel/tracing}
+INSTANCES=3D$TRACEFS/instances
+FAIL=3D0
+PASS=3D0
+
+log()  { printf '%s\n' "$*"; }
+pass() { PASS=3D$((PASS+1)); log "PASS: $*"; }
+fail() { FAIL=3D$((FAIL+1)); log "FAIL: $*"; }
+cleanup_all() {
+	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist hwnoise_top; do
+		[ -d "$INSTANCES/$i" ] && rmdir "$INSTANCES/$i" 2>/dev/null
+	done
+}
+
+# Wait up to $2 ms for $1 to disappear.
+wait_gone() {
+	_path=3D$1
+	_ms=3D${2:-5000}
+	_i=3D0
+	while [ -d "$_path" ] && [ $_i -lt $_ms ]; do
+		sleep 0.05
+		_i=3D$((_i+50))
+	done
+	[ ! -d "$_path" ]
+}
+
+# Wait until $1 exists (up to $2 ms).
+wait_present() {
+	_path=3D$1
+	_ms=3D${2:-10000}
+	_i=3D0
+	while [ ! -d "$_path" ] && [ $_i -lt $_ms ]; do
+		sleep 0.05
+		_i=3D$((_i+50))
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
+cleanup_all
+if ! "$RTLA" --version >/dev/null 2>&1; then
+	log "SKIP: $RTLA is not usable"
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
+	_path=3D$1
+	_pid=3D$2
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
+pid=3D$!
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
+pid=3D$!
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
+rc=3D$?
+if [ "$rc" -ne 0 ]; then
+	fail "self-timeout: rtla failed to start or run (exit=3D$rc)"
+elif wait_gone "$INSTANCES/osnoise_top"; then
+	pass "self-timeout: instance removed (exit=3D$rc)"
+else
+	fail "self-timeout: instance still present (exit=3D$rc)"
+fi
+
+# ---------------------------------------------------------------------------
+# 4. shell action failure (-a / --on-threshold shell,command=3D...)
+# ---------------------------------------------------------------------------
+# -S is the stop-total threshold and yields exit 2 when the action fails.
+# A shell action only runs if that threshold is crossed; an idle machine may
+# never do so.  Do not call the no-threshold case a pass.
+cleanup_all
+action_rc=3D0
+for n in 1 2 3; do
+	$RTLA osnoise top -q -d 5s -P F:1 -r 900000 -S 1 \
+		--on-threshold 'shell,command=3D"/bin/false"' >/dev/null 2>&1
+	rc=3D$?
+	action_rc=3D$rc
+	[ "$rc" -eq 2 ] && break
+done
+if [ "$action_rc" -eq 0 ]; then
+	log "SKIP: action-failure: stop-total threshold was not crossed"
+elif [ "$action_rc" -ne 2 ]; then
+	fail "action-failure: unexpected exit=3D$action_rc (wanted 2)"
+elif wait_gone "$INSTANCES/osnoise_top"; then
+	pass "action-failure: instance removed (exit=3D$action_rc)"
+else
+	fail "action-failure: instance still present (exit=3D$action_rc)"
+fi
+
+# ---------------------------------------------------------------------------
+# 5. repeated interrupted runs must not poison the next run
+# ---------------------------------------------------------------------------
+cleanup_all
+for n in 1 2 3; do
+	$RTLA osnoise top -q -d 20s -P F:1 >/dev/null 2>&1 &
+	pid=3D$!
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
+rc=3D$?
+if [ "$rc" -eq 0 ]; then
+	pass "repeated interrupts: following run still succeeds"
+else
+	fail "repeated interrupts: following run failed (exit=3D$rc)"
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
--=20
2.43.0

