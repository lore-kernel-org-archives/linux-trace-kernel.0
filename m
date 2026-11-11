Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379501;
	b=SQG1LTsPZv+2T1B2bdXI589v74ALqnzHYGT8XnRHBoOi6W3sHhkVHnWLBoe6h1Rj+v3Y
	 Oa//ysPBopiK9zrxVv1NtFAw2QCb01lGdTzet9FjezB/JPHQHta0OyhgdTmYrTCOC1yyC
	 Tl2JYrQNxJ5xLV0KaRlHr/xUpu351IXj/wXBNFdWUPWyZVOdarHPexXwCTRlC+IHhftiC
	 oHTrv/MNasDpFU8RcUNvT4DVQC9C7S+zeOwJ6hS/p5Ih3VbTZjjZjLXZ820inKSwMbqty
	 yjdtueOakvwHjwKLFkXwXaNucED1PSatPCm1MjSjYPbQH6biPJcW0RGX2BaDz5RIQ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379501;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OkSnCJ3oiyzYUGrI88Xv37IQxj+JSul1iQV4TtXaeis=;
	b=DRkoIy9qsLrnH71uaQ5fv8twGQE5+xDzezw8jpcIpX43NI8gMkEM8Axdi9SliqvjBUyq
	 qNhatIEk9g7h/ZcIsrwTcRwD0MbNf1efP1lr2DO1iu5djGNMbILOztJNFIv5HXJJO1PQh
	 ymJkwTADK7YHViO51mC6gGeQOIB75AS/06qqHFD7XqnbamYes8L5steAeshUbGxVn2F4C
	 c+0w5B66U1Yw9KkPqXuvfXXIZ25R1+Ch0bnCDykJAqNMB7CGS0gQch4DLbaVWzkXp7gKi
	 6vNjUnHulWT4zm23ObQM39iKRfXwPgx5ghSLrpg7dgHmrIWZJxQU0+xYlwl7hdnULdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaaQCh2w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E64606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaaQCh2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4332C1F00A05;
	Wed, 11 Nov 2026 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379501;
	bh=OkSnCJ3oiyzYUGrI88Xv37IQxj+JSul1iQV4TtXaeis=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GaaQCh2wUM5iwPktgt5m1SJTzeoe9Mrz+28wmEj3OtOznED70QcAum+A3JYiR7bO9
	 ip6PYizyqWnB1iOq89K9EeWnEXdyjSMPS/ZeXwb5WAZ27jDn7CvNnGkWnqcKtpzxbD
	 xr7cBY2znm6ZFWG7vyiFaVrC5CtSfkeTBtOV5JEKe+MFrSG+1QVFE31jFw7RMos2Iq
	 wfYJiAQyrb6sDme5M1q3v4BWTUI5oKmkrI6CUhqYndTKbwnHzFHoKyalPKtQLS6k3d
	 azZuZ97viRQQMb98exHIZoN7e3J/plMn5HOmZMZmh6OqCD/h2XxnVwstiNjdvK/2ti
	 w0fyVbsk4M79Q==
Message-ID: <sashiko-outbox-208457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtla: clean up tracefs instances on SIGTERM, and
 test the abnormal exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <1794300001.11111.1234567890@gmail.com>
References: <1794300001.11111.1234567890@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:45:00 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] rtla: late set_signals() in run_tool() leaks instances on
  startup signals
- [Medium] rtla/tests: false passes and leaked child processes in
  check-cleanup.sh
- [Low] rtla/tests: run_cleanup_cases() relies on reset_osnoise() return
  status
- [Low] rtla: inaccurate commit log and test comments, and wrong
  instance names
--

commit 7feddf6b326eb1b197836a5ea9675a50618c3123
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

> rtla: clean up tracefs instances on SIGTERM, and test the abnormal exits
>
> rtla: clean up tracefs instances on SIGTERM, and test the abnormal exits
>
> rtla creates a tracefs instance for each run and removes it on the normal
> exit path. If the process is interrupted, killed by its own -d timer, or =
if
> an --on-threshold shell action fails, the instance is left behind and the
> next invocation finds it in use.
>
> Install a SIGTERM handler next to the existing SIGINT one, so the same
> cleanup runs for both, and add a test that walks each of those paths and
> checks that the instance is gone afterwards.
>
> The test harness had two bugs, both reported by sashiko:
>
>   - The availability probe ran "$RTLA" --version. rtla has no --version:
>     main() only understands -h/--help and the three subcommands, and
>     anything else falls through to rtla_usage(), which exits 129. The pro=
be
>     therefore always failed and the whole suite reported SKIP, so none of
>     these cases ever ran. Probe --help instead, require exit 129 and the
>     version banner, which is what the other rtla tests already do.
>
>   - The TAP wrapper treated any line starting with "SKIP: " from the help=
er
>     as a group-level skip. A subtest that could not cross the threshold on
>     an idle machine printed one of those, which marked the entire test as
>     skipped and left the loop below it unreachable. Per-case skips now say
>     "note:", and only real group-level skips keep the SKIP: prefix.
>
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

[Severity: Low]
Does the commit message accurately describe the problem being fixed?

The subject line is repeated at the top of the commit body, and the first
paragraph states that SIGINT, the -d timer, and failing --on-threshold shell
actions previously left the tracefs instance behind.  Prior to this patch,
set_signals() already handled SIGINT and SIGALRM (-d), and failing
--on-threshold shell actions already returned through common_threshold_hand=
ler()
to the out_free cleanup path in run_tool(); only SIGTERM lacked a handler.
Should this also include:

  Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerl=
at and hist/top")

In addition, the "The test harness had two bugs" section in the commit mess=
age
and the matching --version comment in check-cleanup.sh describe fixes to an
earlier unmerged draft of this patch rather than pre-existing repository co=
de
(which belongs below the --- separator).  In check-cleanup.sh, the header
comment also refers to the script as rtla_cleanup_test.sh, the --help comme=
nt
says main() knows -usage (main() only checks -h and --help), the action-fai=
lure
comment says -S yields exit 2 when the action fails (run_tool() exits with 2
whenever -S stops tracing regardless of whether actions_perform() succeeded=
),
and cleanup_all() checks hwnoise_top (hwnoise uses osnoise_top) while omitt=
ing
osnoise_trace and timerlat_aa.

> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/com=
mon.c
> index ac4172bcc4444..e91d718c728b6 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -38,6 +38,7 @@ static void stop_trace(int sig)
>  static void set_signals(struct common_params *params)
>  {
>  	signal(SIGINT, stop_trace);
> +	signal(SIGTERM, stop_trace);
>  	if (params->duration) {
>  		signal(SIGALRM, stop_trace);
>  		alarm(params->duration);

[Severity: Medium]
Can a SIGTERM or SIGINT delivered during startup still terminate rtla before
set_signals() is installed and leak the tracefs instances?

In run_tool(), ops->init_tool() creates the primary tracefs instance before
tracefs_local_events() parses tracefs events, ops->apply_config() modifies
global osnoise settings, enable_tracer_by_name() spawns per-CPU kernel
threads, set_comm_sched_attr() scans /proc, osnoise_init_trace_tool() creat=
es
osnoise_trace, and ops->enable() creates timerlat_aa and sleeps for
params->common.warmup seconds:

tools/tracing/rtla/src/common.c:run_tool() {
	tool =3D ops->init_tool(params);
	...
	retval =3D ops->enable(tool);
	if (retval)
		goto out_trace;

	tool->start_time =3D time(NULL);
	set_signals(params);
}

Because set_signals() is only called after ops->enable() returns, any SIGTE=
RM
or SIGINT during initialization or the warmup sleep (where osnoise_enable()
and timerlat_enable() check stop_tracing) hits the default signal dispositi=
on
and exits without running out_free cleanup.

In check-cleanup.sh, wait_running() only waits for $INSTANCES/osnoise_top to
appear and sleeps 1 second before signaling rtla.  Because the instance
directory is created at the start of trace_instance_init() before event
parsing and kthread startup finish, on slower or loaded systems kill -TERM =
can
arrive before set_signals() and leak osnoise_top, while in a non-interactive
shell background jobs inherit SIG_IGN for SIGINT until set_signals() runs, =
so
an early kill -INT is ignored until the -d timer expires.

[ ... ]

> diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/test=
s/cleanup.t
> new file mode 100644
> index 0000000000000..176b1a96f87d5
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/cleanup.t
> @@ -0,0 +1,70 @@

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
Does reset_osnoise return a non-zero status when tracefs is not writable or
when CONFIG_OSNOISE_TRACER is disabled?

In tests/engine.sh, reset_osnoise() only fails if pushd /sys/kernel/tracing
fails:

tools/tracing/rtla/tests/engine.sh:reset_osnoise() {
	pushd /sys/kernel/tracing >/dev/null || return 1
	...
	cd ../osnoise
	echo all > cpus
	...
	popd >/dev/null
}

When /sys/kernel/tracing is searchable by an unprivileged user or
/sys/kernel/tracing/osnoise is absent, the writes and cd ../osnoise fail wi=
th
stderr errors (and redirect into /sys/kernel/tracing/instances if cd fails),
while popd still returns 0.

> +	timeout_cmd=3D${TIMEOUT:-timeout -v -k 15s 2m}
> +
> +	out=3D$($timeout_cmd "$helper" "$RTLA" 2>&1)
> +	rc=3D$?

[ ... ]

> diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tr=
acing/rtla/tests/scripts/check-cleanup.sh
> new file mode 100755
> index 0000000000000..c27db96cd556a
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
> @@ -0,0 +1,211 @@

[ ... ]

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
> +
> +# Kill a background rtla if a case fails before reaping it.
> +stop_pid() {
> +	[ -n "$1" ] || return
> +	kill -KILL "$1" 2>/dev/null
> +	wait "$1" 2>/dev/null
> +}

[ ... ]

> +	kill -INT "$pid" 2>/dev/null
> +	wait "$pid" 2>/dev/null
> +	if wait_gone "$INSTANCES/osnoise_top"; then
> +		pass "SIGINT: instance removed after interrupt"
> +	else
> +		fail "SIGINT: instance still present after interrupt"
> +	fi

[Severity: Medium]
Can check-cleanup.sh report false passes or leave background rtla processes
running after a timeout?

First, when $RTLA is missing, not executable, or fails the --help check,
check-cleanup.sh logs SKIP: and exits 0, which cleanup.t turns into a skipp=
ed
test rather than a failure when the binary under test is broken.

Second, the SIGINT, SIGTERM, and repeated-interrupt cases ignore the exit
status of wait "$pid", so if rtla exits with an error (which also removes t=
he
instance via out_free) instead of cleanly handling the signal and exiting 0,
wait_gone still reports PASS.

Third, check-cleanup.sh installs no EXIT/INT/TERM trap to kill a live
background $pid and run cleanup_all, and cleanup.t does not print $out when
timeout exits with 124 or 137; if the helper times out, the diagnostic outp=
ut
is lost and the orphaned rtla child and its tracefs instance remain active
during subsequent tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1794300001.11111.12=
34567890@gmail.com?part=3D1
