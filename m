Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263400;
	b=dRzJIKRe4H93aa0ZoqDwjHelbbtYd6XjYiELfnrm3EPuq9PrQeXBNq/7R2fAPnkUT3QK
	 8LQDS+wi3vX4HnTzKar+WvFxNJkTBlNONJtw+gzrbLYzDiIIo2xsxK5h240GGF8TzszLl
	 gJsLxCCc4iXbeF3+f15K1mVcS+nqL7V2emuMEgTkzALqNkRIWYLEM34ow+tP+MfJ9Bvpt
	 skWOYl9k8Y8NMCUiF81o1gza2XikTQz5BaXUnUJKx0JLO1rKhJNio2sPKRHbDWiYcuhRm
	 pqNESmCRTPdH9KhoGK2PnbC/Hp++iCiTS7Y5acEQEd6XAWANZQytVnEv2TrHA8MiLdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qU76iCXtUi8AuGMUogNNRiOIA4ALiw7dV8ASZlaSDYg=;
	b=hQ8c3pI5QJMJ37H9FMFq2NDlaFR1ouBKTLH791QgnQfQdScY1V8qdVSZyehrmpdmZE5S
	 dtSYILkH6F+5C0uL4QFQyyDFIdCGqgsrv81ArbJPdlRPHGRUMPOMAqUo4wCQzFbY1kSuf
	 uTiHY4lOJh9roEvny9/+7lVXUSD9qYUvjoFW5QWFK1vvP5LNHSoBhYFVG1SK2pH14AQyV
	 X1ero4uCnSUKbv5GkUE6Ftpm1a+SLIDD3LXkqiTuZvD8r3KV00A/AZtQecmlOMJPbVEeo
	 SdTQu7HpslMsMu1+toFfjG44RI8G8UowsRnWSvTEIvP/VQu1njhNay887A1QnwGaXDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAZ2ROpe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEA606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAZ2ROpe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616071F000C4;
	Sat, 21 Nov 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795263399;
	bh=qU76iCXtUi8AuGMUogNNRiOIA4ALiw7dV8ASZlaSDYg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cAZ2ROpejeaPCWoUK2T68I02o82t53TSQ4FMfqDmnUrkRFkSm20y8ErTTK02XagNN
	 n0bdlrJ3eyeStNgtMrbMjjlKZ1efh3LNr4yYUAGCbSvS61FWjOEvCf1pclGgOtzXB7
	 49UeizosKHxABIeOHvoYEnkttRRGNNWSyqKMRap/fkUckmOuQg9+87TigU80/rvNbY
	 cEfDsTeZkKhpBb47w1x9jQmL1+woSYJgZJFR9O4O5+w8zmsSc0TDrolljMGuz9nJ4u
	 CjNiqCj1e8y9aa6i30bRhfOlxiqBWwkWbUUb24bastT2mihottgSARsfewn9o8ZTAl
	 36KyztqcCnp9w==
Message-ID: <sashiko-outbox-227010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] rtla/tests: cover cleanup on abnormal exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <b52251473d0f5f87e7041d2d2de7a7db8319cff2.1795262546.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
 <b52251473d0f5f87e7041d2d2de7a7db8319cff2.1795262546.git.chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 12:16:38 +0000
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
- [Medium] rtla/tests: unbounded wait before wait_gone() masks broken
  signal handling
- [Medium] rtla/tests: false passes, broken-binary skip, and leaked
  child on timeout
- [Low] rtla/tests: broken tracefs writability check via reset_osnoise()
- [Low] rtla/tests: wrong instance list in cleanup_all() and stale
  comments
--

commit 21104c6464d760e35be422c6be02a2de02526282
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

rtla/tests: cover cleanup on abnormal exits

This commit adds a TAP test and helper script to verify that rtla removes
its tracefs instances when interrupted by signals, stopped by its duration
timer, or terminated by a threshold action.

> diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/test=
s/cleanup.t
> new file mode 100644
> index 0000000000000..176b1a96f87d5
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/cleanup.t
> @@ -0,0 +1,70 @@

[ ... ]

> +run_cleanup_cases() {
> +	local helper=3D"$testdir/scripts/check-cleanup.sh"
> +	local out rc timeout_cmd skip
> +
> +	ctr=3D$((ctr + 1))
> +	[ -z "$TEST_COUNT" ] && return
> +
> +	if [ ! -x "$helper" ]; then
> +		echo "not ok $ctr - cleanup helper is not executable"
> +		return
> +	fi
> +
> +	# check() normally does this before every test. Do the same here, both =
to
> +	# leave a clean tracer state and to make a hung helper terminate.
> +	reset_osnoise || {
> +		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure # SKIP tracefs is not writable"
> +		return
> +	}

[Severity: Low]
Does reset_osnoise() actually return non-zero when tracefs is not writable
or when CONFIG_OSNOISE_TRACER is disabled?

In tools/tracing/rtla/tests/engine.sh, reset_osnoise() runs without set -e
and only returns 1 if pushd /sys/kernel/tracing fails; every subsequent
echo and cd ignores errors, and the function returns the 0 exit status of
popd.  When /sys/kernel/tracing is searchable by an unprivileged user or
mounted read-only, reset_osnoise() succeeds while printing write errors to
stderr, and if /sys/kernel/tracing/osnoise is absent, cd ../osnoise fails
and the redirections attempt to create files inside
/sys/kernel/tracing/instances.  Also, neither cleanup.t nor
check-cleanup.sh calls reset_osnoise() after the helper finishes (or after
stop_pid() kills rtla with SIGKILL) to restore /sys/kernel/tracing/osnoise
settings.

> diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tr=
acing/rtla/tests/scripts/check-cleanup.sh
> new file mode 100755
> index 0000000000000..7bd5b1233b607
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
> @@ -0,0 +1,219 @@

[ ... ]

> +cleanup_all() {
> +	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist hwnoise_to=
p; do
> +		[ -d "$INSTANCES/$i" ] && rmdir "$INSTANCES/$i" 2>/dev/null
> +	done
> +}

[Severity: Low]
This isn't a bug in the test cases themselves, but cleanup_all() checks for
hwnoise_top (hwnoise_main() uses osnoise_top_ops and creates osnoise_top)
while omitting the auxiliary osnoise_trace and timerlat_aa instances that
rtla creates.

A few comments in check-cleanup.sh also appear stale: the header usage names
rtla_cleanup_test.sh instead of check-cleanup.sh, the comment above the
--help check says main() accepts -usage and refers to --version probing from
an earlier draft, and the comment above the threshold case attributes exit
code 2 to action failure.  In addition, run_cleanup_cases() in cleanup.t
collapses all five cases into a single TAP test point and does not check
$subtests or $STOPONFAIL from tests/engine.sh.

[ ... ]

> +# ----------------------------------------------------------------------=
-----
> +# 1. SIGINT during a long run
> +# ----------------------------------------------------------------------=
-----
> +cleanup_all
> +$RTLA osnoise top -q -d 30s -P F:1 >/dev/null 2>&1 &

[Severity: Medium]
Can running osnoise top with -P F:1 across all CPUs at the default 100%
runtime starve user-space tasks and hang the test?

When -c and -r are omitted, common_apply_config() places osnoise threads on
every online CPU without moving rtla to a housekeeping CPU, and
osnoise_apply_config() sets DEFAULT_SAMPLE_RUNTIME equal to
DEFAULT_SAMPLE_PERIOD (1000000 us).  Promoting every per-CPU osnoise/N
kernel thread to SCHED_FIFO priority 1 with -P F:1 leaves SCHED_OTHER tasks
such as check-cleanup.sh and rtla completely starved on systems with RT
throttling disabled (sched_rt_runtime_us =3D -1), and consumes 95% of all C=
PU
time even with default RT throttling.  Existing tests in osnoise.t and
hwnoise.t pair -P F:1 with -c 0 -r 900000 so a housekeeping CPU and period
headroom remain available.

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
Does the unbounded wait "$pid" before wait_gone() mask broken SIGINT or
SIGTERM handling?

If rtla ignores SIGINT (or SIGTERM in the next case), wait "$pid" blocks
for 30 seconds until rtla's -d duration timer expires via SIGALRM and
removes the tracefs instance on normal timeout exit.  By the time
wait_gone() runs, the directory is already gone and the test reports PASS.
Waiting for the instance or process to exit with a timeout shorter than -d
(and killing the process if it is still alive) would verify that the signal
actually stopped rtla.

[ ... ]

> +# ----------------------------------------------------------------------=
-----
> +# 4. shell action failure (-a / --on-threshold shell,command=3D...)
> +# ----------------------------------------------------------------------=
-----
> +# -S is the stop-total threshold and yields exit 2 when the action fails.
> +# A shell action only runs if that threshold is crossed; an idle machine=
 may
> +# never do so.  Do not call the no-threshold case a pass.
> +cleanup_all
> +action_rc=3D0
> +for n in 1 2 3; do
> +	$RTLA osnoise top -q -d 5s -P F:1 -r 900000 -S 1 \
> +		--on-threshold 'shell,command=3D"/bin/false"' >/dev/null 2>&1
> +	rc=3D$?
> +	action_rc=3D$rc
> +	[ "$rc" -eq 2 ] && break
> +done

[Severity: Medium]
Does this case actually test a failing --on-threshold shell action, and can
other failure paths in check-cleanup.sh pass or skip silently?

In tools/tracing/rtla/src/common.c, common_threshold_handler() ignores the
return value of actions_perform(), and run_tool() exits with FAILED (2)
whenever tracing stops on -S without a subsequent --on-threshold continue
action (as used in tests/osnoise.t), even if the shell command succeeds.

There are three related issues in the helper and wrapper:
- In the SIGINT, SIGTERM, and repeated-interrupt cases, wait "$pid" discards
  rtla's exit status, so if rtla hits a runtime error and removes its
  instance on the error path (exiting 1 instead of 0), the test still
  reports PASS.
- When $RTLA is missing, not executable (including when check-cleanup.sh is
  run standalone with default RTLA=3Drtla, since [ -x "rtla" ] checks ./rtla
  rather than PATH), or fails the --help probe, check-cleanup.sh logs SKIP:
  and exits 0, which cleanup.t reports as a passing TAP skip instead of
  failing on a broken binary.
- check-cleanup.sh installs no EXIT/INT/TERM trap to kill $pid and run
  cleanup_all() if terminated by timeout, and cleanup.t does not print $out
  when the helper times out (exit codes 124 and 137), discarding the output
  showing which case hung.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795262546.gi=
t.chaosheng.qu.linux@gmail.com?part=3D2
