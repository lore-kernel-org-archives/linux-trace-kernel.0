Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795261661;
	b=vlcqXUHSLGF4OHUHaOZygdnueR/rgy5fBsWYfAy2ma6Wheghh5BCSTewI/1Zs60ssEZr
	 aOJv43daQ0Kad29eq4xRZ4vyWr/ml3AbSx6Cg99gOXU2IFCySqtcG1EiQkAuTmJSeHbqw
	 so76rwhDOkLhIICliO4AEDIUCzN2zNAGu0cqIi5P3NGExl/PC4vDJtVpEjVYNnrTG3TNN
	 oQHNRanvZUaZhE87zR2/inivKoI/nydLnBWxr39fH4lpOxsY05LZ3CPSmdzrTLm4fBOui
	 qdu5mPoS5fK42DfpwJH19JDEqcqmTSkxh+oa3bT/jeQlgIVZCL4dX9ii0Pt/sXKUk7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EsD4awn2CUnuGp0EGAPxe+0xwjr8tkASsj8g4Tld75s=;
	b=C7ojnh+QfhizKbeUKPsVyqoF+90jh//K9/thWbsbz/Qr71L9+LooFSG1PumwC6kCd5DS
	 9nAZ2JsRFaF5AKU1S1qaoVvcr8Yaa1Ag1Cd2Cjx/RNIIWYGCpOgeXmCTQ0ZtJKqCis9fB
	 AbtPfSHZ4UwxB4W7LSGslSncoSsqUt8JxbVFEQNPN0vXRZDvQ1p3oDzqFUEejfK/jKS9I
	 d/f5w115YGaMjl7Wk8fWxM6Qpa5ouvwIA1lGTH0pycmXncypma9hmeSH4yugxQZmJSFiz
	 cN4zomCLQxSwICwy+lq+a/EytXCBq8nWHO5MWCRMW9QFgy6lnD1DiMkQC2OIqQcFFlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLqE73b1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D3606A684
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLqE73b1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416D11F000CA;
	Sat, 21 Nov 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261661;
	bh=EsD4awn2CUnuGp0EGAPxe+0xwjr8tkASsj8g4Tld75s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PLqE73b1EKuwVaxkxan9senPsB15uEIhBoaRYF0Cg7SyLxRyXuMo0sjLClQS6yNKI
	 mG1E0uk08ymL5QdhCCk+q/fjgZoWIyxMUYLxqnlMIi77mradZdBgavHhrE7JgZsuLZ
	 GFO/0guc0xUaemBjCt27y/WPxvsxxnb3QnkyKnWh3rrpw2wfdkwSXdNJYF4mU0epsq
	 Yh7sJfXsZWOBwy/rAzq+AHBmGYxcNmpDoXn2db1EeqY/SnqJH0CzYKEU/eYpNrAm4C
	 W1nEYU/hrvfaKCZ0Lqhuh/Au3JogqVh9zHY/1QAylgRUYeaYUI/wZNzDTYO3r6Z4Rq
	 Y3yrw8bT5QMgQ==
Message-ID: <sashiko-outbox-226990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rtla/tests: cover cleanup on abnormal exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <4ffc1e5176e9534d39401670907b4bdd700989c3.1795258353.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
 <4ffc1e5176e9534d39401670907b4bdd700989c3.1795258353.git.chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:47:40 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] rtla/tests: CPU starvation from -P F:1 on all CPUs at 100%
  runtime
- [Medium] rtla/tests: signal startup race in wait_running() and
  unbounded wait
- [Medium] rtla/tests: false skip on broken binary and unchecked wait
  status
- [Low] rtla/tests: broken tracefs writability check via reset_osnoise()
- [Low] rtla/tests: wrong instance list in cleanup_all() and stale
  comments
--

commit 110e2919f0e6845113d98a17c558268bc9141671
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

rtla/tests: cover cleanup on abnormal exits

This commit adds a TAP test and helper script verifying that rtla removes
its tracefs instance on SIGINT, SIGTERM, duration timeout, and threshold
action failure.

> diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/test=
s/cleanup.t
> new file mode 100644
> index 0000000000000..176b1a96f87d5
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/cleanup.t

[ ... ]

> +	# check() normally does this before every test. Do the same here, both =
to
> +	# leave a clean tracer state and to make a hung helper terminate.
> +	reset_osnoise || {
> +		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure # SKIP tracefs is not writable"
> +		return
> +	}

[Severity: Low]
Does reset_osnoise() ever return non-zero when tracefs is searchable
(mode 0755) but not writable, or when CONFIG_OSNOISE_TRACER is disabled?

In tools/tracing/rtla/tests/engine.sh, reset_osnoise() only returns 1 if
"pushd /sys/kernel/tracing" fails; it ignores write and cd errors and
returns the exit status of the final popd (0).  When run as non-root or
without /sys/kernel/tracing/osnoise, reset_osnoise() emits uncaptured
stderr errors (and tries to create files like cpus and period_us inside
/sys/kernel/tracing/instances after "cd ../osnoise" fails) instead of
skipping cleanly.  Also, run_cleanup_cases() does not call
reset_osnoise() after check-cleanup.sh fails or times out to restore the
tracer state.

[ ... ]

> diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tr=
acing/rtla/tests/scripts/check-cleanup.sh
> new file mode 100755
> index 0000000000000..c27db96cd556a
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
> @@ -0,0 +1,211 @@

[ ... ]

> +# Requires: root, tracefs mounted at /sys/kernel/tracing, CONFIG_OSNOISE=
_TRACER.
> +# Usage: rtla_cleanup_test.sh /path/to/rtla
> +
> +RTLA=3D${1:-rtla}
> +TRACEFS=3D${TRACEFS:-/sys/kernel/tracing}
> +INSTANCES=3D$TRACEFS/instances
> +FAIL=3D0
> +PASS=3D0
> +
> +log()  { printf '%s\n' "$*"; }
> +pass() { PASS=3D$((PASS+1)); log "PASS: $*"; }
> +fail() { FAIL=3D$((FAIL+1)); log "FAIL: $*"; }
> +cleanup_all() {
> +	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist hwnoise_to=
p; do
> +		[ -d "$INSTANCES/$i" ] && rmdir "$INSTANCES/$i" 2>/dev/null
> +	done
> +}

[Severity: Low]
Does rtla ever create an instance named hwnoise_top, and should
cleanup_all() include osnoise_trace and timerlat_aa instead?

hwnoise_main() uses osnoise_top_ops and creates osnoise_top, while rtla
also creates auxiliary osnoise_trace and timerlat_aa instances that
cleanup_all() currently leaves behind.  Also, the usage comment above
names rtla_cleanup_test.sh instead of check-cleanup.sh, the comment on
--help below claims main() recognizes -usage and references an earlier
--version draft, and the comment on -S says it yields exit 2 when the
action fails whereas run_tool() exits 2 whenever -S stops tracing.

[ ... ]

> +cleanup_all
> +if [ ! -x "$RTLA" ]; then
> +	log "SKIP: $RTLA is not executable"
> +	exit 0
> +fi
> +help_out=3D$("$RTLA" --help 2>&1)
> +rtla_rc=3D$?
> +if [ "$rtla_rc" -ne 129 ] ||
> +   ! printf '%s\n' "$help_out" | grep -q 'rtla version'; then
> +	log "SKIP: $RTLA is not usable (--help exited $rtla_rc, no version bann=
er)"
> +	exit 0
> +fi

[Severity: Medium]
Should a missing or broken $RTLA binary fail the test rather than
exiting 0 with "SKIP:"?

Because cleanup.t turns any "SKIP:" line on exit 0 into a passing
"ok ... # SKIP" TAP result, a broken rtla build that crashes or fails on
--help is reported as a test skip instead of a failure.  In addition,
when check-cleanup.sh is run standalone with its default RTLA=3Drtla,
'[ ! -x "$RTLA" ]' checks only the current working directory rather than
PATH.

Also, in the SIGINT, SIGTERM, and repeated-interrupt cases below,
'wait "$pid"' ignores rtla's exit status, so an error exit (status 1)
that cleans up the instance on the error-unwind path is reported as PASS.
Finally, check-cleanup.sh sets no EXIT/INT/TERM trap to kill a background
$pid and run cleanup_all() if killed by timeout, and cleanup.t discards
$out when timeout exits with 124 or 137.

> +
> +# Kill a background rtla if a case fails before reaping it.
> +stop_pid() {
> +	[ -n "$1" ] || return
> +	kill -KILL "$1" 2>/dev/null
> +	wait "$1" 2>/dev/null
> +}
> +
> +# Wait for an rtla instance and its signal handler.  The instance appears
> +# before set_signals() runs, so wait for rtla to start its workload (or =
at
> +# least for it to survive a short grace period) before sending SIGINT.
> +wait_running() {
> +	_path=3D$1
> +	_pid=3D$2
> +	wait_present "$_path" 10000 || return 1
> +	sleep 1
> +	kill -0 "$_pid" 2>/dev/null
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# 1. SIGINT during a long run
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +$RTLA osnoise top -q -d 30s -P F:1 >/dev/null 2>&1 &

[Severity: Medium]
Can running "osnoise top ... -P F:1" without -c or -r starve SCHED_OTHER
tasks across all CPUs?

When -r and -p are omitted, osnoise_apply_config() configures a 100%
duty cycle (1000000 us runtime per 1000000 us period), and omitting -c
places SCHED_FIFO:1 osnoise/N kernel threads on every online CPU without
moving rtla to a housekeeping CPU.  On a kernel with RT throttling or the
fair DL server disabled this hangs the system until the 2-minute timeout
fires, and even with default RT throttling it consumes 95% of every CPU.
Existing tests in osnoise.t and hwnoise.t pass "-c 0 -r 900000" when
using "-P F:1" so a CPU and period headroom remain available for user
tasks.

> +pid=3D$!
> +if ! wait_running "$INSTANCES/osnoise_top" "$pid"; then
> +	fail "SIGINT: instance was never created (rtla did not start?)"
> +	stop_pid "$pid"
> +else
> +	kill -INT "$pid" 2>/dev/null
> +	wait "$pid" 2>/dev/null
> +	if wait_gone "$INSTANCES/osnoise_top"; then
> +		pass "SIGINT: instance removed after interrupt"
> +	else
> +		fail "SIGINT: instance still present after interrupt"
> +	fi
> +fi

[Severity: Medium]
Can wait_running() return before run_tool() calls set_signals(), and
does the unbounded 'wait "$pid"' mask broken SIGINT or SIGTERM handling?

In tools/tracing/rtla/src/common.c, run_tool() creates the
instances/osnoise_top directory inside ops->init_tool() at the start of
initialization, then parses all tracefs events, configures osnoise,
spawns per-CPU osnoise kernel threads, scans /proc/*/comm for "-P F:1",
and enables tracing before installing signal handlers:

tools/tracing/rtla/src/common.c:run_tool() {
	...
	retval =3D ops->enable(tool);
	if (retval)
		goto out_trace;

	tool->start_time =3D time(NULL);
	set_signals(params);
	...
}

If initialization takes longer than the 1-second sleep in wait_running(),
SIGTERM hits SIG_DFL and kills rtla before set_signals() runs (leaking
osnoise_top), while SIGINT is ignored because background jobs in a
non-interactive shell inherit SIG_IGN for SIGINT until set_signals()
overrides it.  Then, because 'wait "$pid"' runs without a timeout before
wait_gone, an ignored or broken signal simply blocks for 20-30 seconds
until rtla's own "-d 30s" SIGALRM timer stops tracing and removes the
instance, causing wait_gone to report a false PASS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795258353.gi=
t.chaosheng.qu.linux@gmail.com?part=3D2
