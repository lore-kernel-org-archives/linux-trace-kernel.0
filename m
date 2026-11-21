Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260767;
	b=pDaAN/lOlFMSjUDSXb+PrCnNCUkPm2+4BXPk+oeI5U0VqquoKTsuP7MdlcM0hj4PWvop
	 1gSwd0ePsLBmlLHg3Q+thVdO5IRJIi9Cb7I1wgrVMCkHYJD3lTGVAs1cwy9x2b2Q7hJnK
	 V9hHdA1jp5wUWSILoWKw9bAy5WvY2vM1rMVIlUND4yM+syexxyurb6DGZFODpyhCMpvGU
	 EI6xMyv4rkxdOORIWQqcnBcLp0oKVGSLR/ksXfp05Czs8D0the7QG8ob3iOjcJf7UHr7G
	 SN7GfBcGFCm5rFZDBcr2QMdMH8/JK0TvHbk+/g0vMGEVZ7+zBlcAcqGJKlqUlVzAzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lysjra+VOPbhlR222yNxSQpcBXCtffSf2ZjTahRujcQ=;
	b=2xIJ6bR+Cu3qcO9YXtrj6Nws3gWnK2oNVJlgzdlqi6viGafuTejyo2GXFmD5nDuLX5ih
	 HvAjDbAe/YJjwVlI3zsaQuV8wnAn+tACOYdF4jpu8aAc2wiFVj+tRo6RlRF1FcE+YdZqo
	 UHa9ne9dLogQ9X5iNG+cBI3otNK6Je7o8wd3gP4S4KlCoL72110sxnPUvtClTHs4VKBHV
	 a+Vq4VIUpt6iuaORcrO4m4SzvHIVnNpsfTxRkrlRmthaUzzytWdFe2dmk91ijDp0bt1a+
	 X8TchzOstOhdip32ykSog/UStK1uEhef3hONq0n3rVh5wGP7FnmakydIBtNhCKpts2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CsjPOwlM;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656E606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4656E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CsjPOwlM
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2461317a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260767; x=1795865567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lysjra+VOPbhlR222yNxSQpcBXCtffSf2ZjTahRujcQ=;
        b=CsjPOwlMtyZ0snxemxi0/GG7ghVJ33snXWXHwQyyLiYEXu9TLyhjiRjR3GrDEmKfRD
         7Tc/rFIsR8qUBdFQVDY1oAqR9bCAA6lXOMWLQ8a4qVzj5hTgzvNlODrfiGiB4wn7IU4y
         D9RJCreg5RiEUx2HmjYlP4LduuNZhphZD3nYT3r7F0sLVkY+2xVj6StsdtqS50pGkgot
         QIrBaZRgHQ4JQ4sSio8vmWIYNRUtgNBpwizwwb/72WWU/v1xoCPF8PXjZWJ9/FCsr32Q
         zHuJCb9ueM+NN/LI//cQuF0v3/HuqQPrBjLFeYEu5IgdugUUjSTrDqddJUg7iVOYclVA
         dAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260767; x=1795865567;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lysjra+VOPbhlR222yNxSQpcBXCtffSf2ZjTahRujcQ=;
        b=qM8C6UJY5CpZz8Zl5IOToyv/DIkfajMZniFYloZ61GYDSnkYzUoc/0mBGqGA56G8hz
         iiqBU3kJMbGkqrRGWd+tfrdoyR+ocry+Qzzp/P4lEac09jmxzQdv/8J8OvZ6kfhekjTV
         hB5SMIEYWXurQ09g540Kh39Rx/LQGd5K5gz0aqDGlpi/beshzyC23TUygG2Aj8gz6NOJ
         5g4YdbD6zUYXmq6qX6D0FWqQwwxZ72Ut4eYQMbXG2L7lRpURa5NRc0dLzT7TdGKDyNT7
         kuFtzvTgKTYGiqBeNssiK1tKBAi4BOvAs9Aa3CMh4aOTeXfI3WNTY25rVDg/uNA2LKkQ
         K0ug==
X-Gm-Message-State: APuU4Z95bSOY/LodhT6bKoQPryKcUAdpXGiQs0s6E131aj65Koyk6rEg
	/1okopsCw4oLOoYtdeRBTEtQ+8/rz5o4bRkvn6FjgThUy9AaAVAO//Tn1+WLGw==
X-Gm-Gg: AZFdTZcJijYI3r5yj4pBXXYuubrtuPduxGcsWaOpFltVKrARyFNiHSql6KQSsETDiTO
	TcC1YNNcGDBpzgkkZ6VowkYp9kbtjQgnKEwFhOIr8Np8ZQXB3dEsoj2sU9h/cNJxhVPVbJMV9CK
	iS77FL3L3SE/VCMkw40uPl9iiLmS9lqR7tMHi9yqLZl6mU1OljvAaClJs2N3+tc7n58G63VvvET
	9tQjwclRt9aOBK8oGvO4fsyg8qBSUCvoHRUuF1SnHHBRhZWkOUM0tObWV9KZy6EnmRO1qpY0qRI
	Fz19zzdK5Z1yBgr9DnbgSdW9VmJIowH7MlDbfpU6Ezw1xFwyGSRw6dIbpk7+mpsaTajX+NUE4ni
	SMFsKU/COOtndpwMrO7i1U8oyLbmE7edMj5t2nt23kJ+WMsnZhOYyPzXnOMthlOEtemo43EOICZ
	kgv+skoDA/R/75N//b2hLqhjawRzOV7XVxxiv9JQtrSczmBQNyz0mJNz0UrxbSeq4hIkMFxHWza
	5xLaiGQ1A3jhrKm2NysZ29IarvX03sMuxY6Q23Wbx8I2qB5lnEH2aKllAzP7qAXpnz8Bt/5UYNJ
	i0I++hnRSTfaXLAH70ndRoib02vlQirT7+6gG/e97tBhYBVfSeOx7fRpjtA0V6xw/g==
X-Received: by 2002:a17:90b:2e0e:b0:3b3:b9dc:7dcb with SMTP id 98e67ed59e1d1-3b40a5a4829mr5270772a91.13.1795260766477;
        Sat, 21 Nov 2026 03:32:46 -0800 (PST)
Received: from [127.0.1.1] ([2408:840d:6830:46f1:7c60:7a01:9164:e1a0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea748csm2458663a12.4.2026.11.21.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:32:46 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rtla/tests: cover cleanup on abnormal exits
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <4ffc1e5176e9534d39401670907b4bdd700989c3.1795258353.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
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

The test needs root, tracefs and CONFIG_OSNOISE_TRACER, and skips when
tracefs is not writable.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/tracing/rtla/tests/cleanup.t            |  70 ++++++
 .../rtla/tests/scripts/check-cleanup.sh       | 211 ++++++++++++++++++
 2 files changed, 281 insertions(+)
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
index 000000000..c27db96cd
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
-- 
2.43.0


