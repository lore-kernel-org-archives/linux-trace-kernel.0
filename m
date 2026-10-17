Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05234750F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240655; cv=none; b=gQyHc5xKuDK31k7e6npjd3oRjPQn4rsgpscceqmW+AsoInTzbWULAXqUaBKMlK5a6e9dnQsQ3cgMdM0krAKR/gWAqNukIorN8QGx86xnZGnnfYb/24ALp2Hevowz68DiZh9GsZxdqnbstThZKbdIEQMEmNMRvEyPDZZ7gxI5Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240655; c=relaxed/simple;
	bh=kSDRZmvRLvA1pXSvTLqTnveZMTjpWlsJMz2TU7CVUyg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Fekw62BDH/QQdRJ1MQe7dh3NYuV52lb7t+vwOvPf2nmf+lK5dR7uMajxefQ7HRM9EHoM6opXxfAhn8ICxXJr15p4GubBLWX5aufcrWNAejJvBp6qyXK/EdBpWP2lbkKMK4ANmOGUMQr91xXvTr7G2FsqQ4y55WA03K1GutVTHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzmXkclt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzmXkclt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718561F000C4;
	Sat, 17 Oct 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792240653;
	bh=KC/Eny303IHa1SpdaGd8/QMTrpW3Gn9RQurDBYMGgmo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FzmXkcltlFtp/UgeAlY42SJ/sOYTe1GeSbVCdHP3CCyLpJszfAhIrnyZQrEcO5cj4
	 933hOX+XMSGWelF5Zj9SujRhLAwDXeR4bz9q0uBUKPoRm8WVEBHVi4fqtn6SggVTxy
	 6y7Yi89PdOPhVuEfTCoZrRl9Gbkqd3aTSarFHOd1A4npUmtB/yuKioAcFgeEccb99p
	 tcbH6tlbP3hO5Js4vGHGDJwVBVYWDXzbqUeW9hVZm7WIIDVvDktHow0tu1nsFr2dZL
	 6pc7fyqgzC6Jy+uCclWA1jZEpbcZEytXWejIzqRs3ANWWWBYmMY7qKyEEkdkF83P/X
	 cyC5rOr+oVbFg==
Message-ID: <sashiko-outbox-175505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtla: add tests for tracefs instance cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261017122359.402696-1-chaosheng.qu.linux@gmail.com>
References: <20261017122359.402696-1-chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 12:37:32 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] rtla/tests: missing prerequisite checks and swallowed SKIP in cl=
eanup.t
- [Medium] rtla/tests: SIGINT race with set_signals() and leaked process in=
 check-cleanup.sh
- [Medium] rtla/tests: missing exit code checks and flawed action-failure t=
est in check-cleanup.sh
- [Low] rtla/tests: unused TIMEOUT, skipped reset_osnoise(), and dead code =
in cleanup test
--

commit 5c3de0149491a2031a1d6a6944918bec1fa8f6ee
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

rtla: add tests for tracefs instance cleanup

This commit adds cleanup.t and a helper script check-cleanup.sh to verify
that rtla removes its tracefs instances on SIGINT, timeout, action failure,
and repeated interrupted runs.

> diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/test=
s/cleanup.t
> new file mode 100755
> index 0000000000000..46e69c1917924
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/cleanup.t
> @@ -0,0 +1,55 @@
[ ... ]
> +source tests/engine.sh
> +test_begin
> +
> +set_timeout 2m
> +
> +#
> +# These cases need to run rtla in the background and signal it, which
> +# engine.sh's check() (one foreground command) cannot express.
> +#
> +run_cleanup_cases() {
> +	local helper=3D"$testdir/scripts/check-cleanup.sh"
> +	local out rc
> +
> +	ctr=3D$((ctr + 1))
> +	[ -z "$TEST_COUNT" ] && return
> +
> +	if [ ! -x "$helper" ]; then
> +		echo "not ok $ctr - cleanup helper is not executable"
> +		return
> +	fi
> +
> +	out=3D$("$helper" "$RTLA" 2>&1)

[Severity: Low]
Calling set_timeout 2m sets the TIMEOUT variable in tests/engine.sh, and
engine.sh's check() normally runs reset_osnoise before executing each test
under $TIMEOUT.

Because run_cleanup_cases() bypasses check() and invokes $helper directly,
$TIMEOUT is never applied (allowing wait "$pid" in check-cleanup.sh to hang
indefinitely if rtla does not exit) and global osnoise settings and
tracing_thresh are not reset before the test runs. Should run_cleanup_cases=
()
call reset_osnoise and prefix the helper invocation with $TIMEOUT?

> +	rc=3D$?
> +	if [ $rc -eq 0 ]; then
> +		# Surface known issues as TAP comments so they stay visible
> +		# even when the case passes.
> +		printf '%s\n' "$out" | grep '^TODO: ' | while read -r line; do
> +			echo "# ${line#TODO: }"
> +		done
> +		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure"

[Severity: Medium]
When check-cleanup.sh prints "SKIP: ..." and exits with 0, run_cleanup_case=
s()
only greps for '^TODO: ' and emits a plain "ok $ctr" line instead of a TAP
"# SKIP" directive. Should run_cleanup_cases() detect '^SKIP: ' in $out and
emit "ok $ctr - ... # SKIP ..."?

> +	else
> +		echo "not ok $ctr - instances cleaned up on SIGINT, timeout and action=
 failure"
[ ... ]
> diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tr=
acing/rtla/tests/scripts/check-cleanup.sh
> new file mode 100755
> index 0000000000000..1ead5ce3c5177
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
> @@ -0,0 +1,187 @@
[ ... ]
> +check_instances_absent() {
> +	_desc=3D$1
> +	_left=3D""
> +	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist; do
> +		[ -d "$INSTANCES/$i" ] && _left=3D"$_left $i"
> +	done
> +	if [ -z "$_left" ]; then
> +		pass "$_desc: no leftover instance"
> +	else
> +		fail "$_desc: leftover instance(s):$_left"
> +	fi
> +}

[Severity: Low]
check_instances_absent() is defined here, but it is never called anywhere in
check-cleanup.sh. Should this unused function be removed or used in the test
cases below?

> +
> +if [ ! -d "$INSTANCES" ]; then
> +	log "SKIP: tracefs not mounted at $TRACEFS"
> +	exit 0
> +fi

[Severity: Medium]
The commit message states:

  The test needs root, tracefs and CONFIG_OSNOISE_TRACER, and skips cleanly
  when tracefs is not mounted writable.

However, this check only tests whether $INSTANCES is a directory. If the te=
st
runs without root privileges, with a read-only tracefs mount, or on a kernel
without CONFIG_OSNOISE_TRACER ($TRACEFS/osnoise), [ ! -d "$INSTANCES" ] can
still be false, causing all test cases to run and fail instead of skipping.
Should this also verify [ -w "$INSTANCES" ] and [ -d "$TRACEFS/osnoise" ]?

> +
> +# ----------------------------------------------------------------------=
-----
> +# 1. SIGINT during a long run
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +$RTLA osnoise top -q -d 30s -P F:1 >/dev/null 2>&1 &
> +pid=3D$!
> +wait_present "$INSTANCES/osnoise_top" 10000
> +sleep 5
> +
> +if [ ! -d "$INSTANCES/osnoise_top" ]; then
> +	fail "SIGINT: instance was never created (rtla did not start?)"

[Severity: Medium]
If $INSTANCES/osnoise_top is not present here, the failure branch logs a
failure without killing or waiting on $pid (unlike Case 2 below). Can this
leave the background rtla process running while the remaining test cases
execute?

> +else
> +	pass "SIGINT: instance created while running"
[ ... ]
> +# ----------------------------------------------------------------------=
-----
> +# 3. rtla's own -d timeout path
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +$RTLA osnoise top -q -d 2s -P F:1 >/dev/null 2>&1
> +rc=3D$?
> +if wait_gone "$INSTANCES/osnoise_top"; then
> +	pass "self-timeout: instance removed (exit=3D$rc)"
> +else
> +	fail "self-timeout: instance still present (exit=3D$rc)"
> +fi
> +
> +# ----------------------------------------------------------------------=
-----
> +# 4. shell action failure (-a / --on-threshold shell,command=3D...)
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +$RTLA osnoise top -q -d 5s -P F:1 -r 1000 -S 1 \
> +	--on-threshold 'shell,command=3D"/bin/false"' >/dev/null 2>&1
> +rc=3D$?
> +if wait_gone "$INSTANCES/osnoise_top"; then
> +	pass "action-failure: instance removed (exit=3D$rc)"
> +else
> +	fail "action-failure: instance still present (exit=3D$rc)"
> +fi

[Severity: Medium]
Can Cases 3 and 4 pass without exercising their intended cleanup paths?

First, neither Case 3 nor Case 4 verifies $rc or checks that osnoise_top was
actually created. Because cleanup_all removes $INSTANCES/osnoise_top before
running $RTLA, if $RTLA fails during startup before creating the instance,
wait_gone "$INSTANCES/osnoise_top" immediately succeeds and reports a pass.

Second, in Case 4, -r 1000 sets a 1ms runtime per 1s period (0.1% duty cycl=
e)
with SCHED_FIFO:1. On an idle system, 5 periods can finish without
accumulating 1us of noise, so rtla exits via the 5s duration timeout (rc=3D=
0)
rather than hitting the stop-tracing threshold (rc=3D2) and never runs the
shell action.

Third, in tools/tracing/rtla/src/common.c:common_threshold_handler():

	actions_perform(&tool->params->threshold_actions);

	if (!should_continue_tracing(tool->params))
		/* continue flag not set, break */
		return 0;

common_threshold_handler() ignores the return value of actions_perform() and
stops tracing whenever continue_flag is not set, which is only set if a
subsequent "--on-threshold continue" action is reached after the shell acti=
on
succeeds. Without "--on-threshold continue" and checking [ "$rc" -eq 2 ],
Case 4 does not distinguish a failing shell action from a succeeding one or
from a normal timeout.

> +
> +# ----------------------------------------------------------------------=
-----
> +# 5. repeated interrupted runs must not poison the next run
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +for n in 1 2 3; do
> +	$RTLA osnoise top -q -d 20s -P F:1 >/dev/null 2>&1 &
> +	pid=3D$!
> +	sleep 1
> +	kill -INT "$pid" 2>/dev/null
> +	wait "$pid" 2>/dev/null
> +done

[Severity: Medium]
In tools/tracing/rtla/src/common.c:run_tool(), the tracefs instance is
created at the beginning of ops->init_tool(params) -> trace_instance_init(),
before tracefs_local_events(NULL), ops->apply_config(tool),
enable_tracer_by_name(), set_comm_sched_attr(), and ops->enable(tool), while
set_signals(params) only installs the SIGINT handler afterward:

	tool =3D ops->init_tool(params);
	...
	retval =3D ops->enable(tool);
	if (retval)
		goto out_trace;

	tool->start_time =3D time(NULL);
	set_signals(params);

In Case 5, each background invocation of $RTLA is sent SIGINT after a fixed
"sleep 1" without wait_present or waiting for set_signals() to complete:

1. Under non-interactive POSIX /bin/sh, background jobs started with '&'
   inherit SIG_IGN for SIGINT until set_signals() overrides it. If rtla is
   still initializing after 1 second (for example while parsing tracefs eve=
nt
   formats or setting per-CPU osnoise kthreads to SCHED_FIFO:1), kill -INT =
is
   ignored and wait "$pid" blocks for the full 20s duration timer without
   testing SIGINT interruption.
2. If SIGINT is not ignored in the caller's environment and arrives after
   create_instance() but before set_signals(), rtla is terminated by the
   default SIGINT disposition before stop_trace() is installed, leaking the
   instance.

Should this loop wait for $INSTANCES/osnoise_top to be present and for
set_signals() to be active before sending SIGINT, and verify wait_gone on
each iteration?

> +
> +$RTLA osnoise top -q -d 2s -P F:1 >/dev/null 2>&1
[ ... ]

 base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
--=20
2.51.0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017122359.4026=
96-1-chaosheng.qu.linux@gmail.com?part=3D1
