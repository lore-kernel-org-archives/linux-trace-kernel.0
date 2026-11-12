Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479974;
	b=TArswfZY1m0SiSMYOuncicTwH6jE1DPvA2azA0nw4+vTypMT+fPdTsBKTS4+Ex+Smmz/
	 5Mh2kLNS//kFyh4phmWjuEZViMZWZpVzBkKTVwGIgT64QJSJcyQg0qsE0Fmt/vGa7352X
	 MpdlQcumYiQUtu1NEgZRXojDlukTqOVdv13FkxtiNxs55rXjaLFgYLDFBBX3Fm/cgzprP
	 hKODPZzDhUXaMLMA51T54+1RqzFktDwbTYEN3b5tfvybuCUtQIc1UIcIAMoYkdIB4s4Kf
	 4dkc/zvtBDNb2nhLRd4HKCjPQ5hNrHichtkkQYArB2e9Is8PFAmUUxYli7Mqhonx03A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479974;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ivq2eCtvCEMz9VmwdPf5X0BkLsD1+jno7eTpkGXUTGc=;
	b=nZM0siXYicAs/j2vO583H7GsY1jGef8HPZHRMWhTNP4qbnEAETSEdG7CRcRyfbFXuw5E
	 mUWOBBSbQaKmq7FTk8a/5xhTGLOWb4F8zx2cam6b8sIqUpoXCn2qofp06P/zHrfzQMIHZ
	 Cns3TVwkSVVgGXc3IOkd+jx7erjzwwNpFev3hbVYRTAvYV/uaDTHqDBRi8QlhIfUz+13U
	 RLM7YqNq9Eu2S3u3goRCD6OiBo3D8rfm05uxoU7v8CmRQsGYrH3Sou2aTvZJl3ecjfmaE
	 oEZgtK1BIIbkjkY6X0vC/41aWSUIhk1PZK+nl2vlrNMdhZCkqlJKwoVApaASUMZbh+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7GVtGyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4835606A339
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7GVtGyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5191F00A05;
	Thu, 12 Nov 2026 10:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479973;
	bh=ivq2eCtvCEMz9VmwdPf5X0BkLsD1+jno7eTpkGXUTGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7GVtGyXgI4taQ7/38B9vBQAxxmhltNDAAutQVoyYtGzrM/HajMrRfBhuoVn1jYiS
	 TO8ZJAtipI+xM5xw4YRroRMH6MXUOO/5gcLPkcccGLma0DreyCONA9mbkrh/gEAGgz
	 7OZ++qdfOFv4uMXvf7z25pJjipJoF9fJTDyinpGWUqshIH1nv7FVFTEuhcY6F2ilB8
	 I6OpRdUfmh+56UMpt444u6gefCvgJw78CsooS8RvY+XaZLrvVXWlDcgXfjA5IG9i3j
	 veVLxRkoh8AHk+DZ3bLlTDjTm0Fn3QX02KSjItLMKo1fG98RjDv2fvnz25hYjBjb9K
	 ltoyb4v7ndybg==
Message-ID: <sashiko-outbox-210967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtla/tests: cover a CPU hotplug cycle in user-space
 timerlat mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179447882047.254241.11597980544275717800@gmail.com>
References: <179447882047.254241.11597980544275717800@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:39:33 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] rtla/tests: check-hotplug.sh greps full dmesg for wrong
  WARNING: at pattern
- [Medium] rtla/tests: timerlat.t treats HOTPLUG_SKIP output as a test
  failure
- [Medium] rtla/tests: timerlat.t hotplug_cpu loop can select offline or
  rejected CPU
- [Medium] rtla/tests: check-hotplug.sh does not verify rtla is running
  before hotplug
- [Low] rtla/tests: check-hotplug.sh triggers crashing teardown and has
  wrong comments
- [Low] rtla/tests: timerlat.t hotplug block ignores SUBTESTS, TIMEOUT,
  and STOPONFAIL
--

commit ef61c7a50d675b6c73eff90d025428e60647852c
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

rtla/tests: cover a CPU hotplug cycle in user-space timerlat mode

This commit adds a test script and a timerlat.t test case that offline and
online a CPU during a user-space timerlat run to verify that no kernel
workload thread is spawned on hotplug.

> diff --git a/tools/tracing/rtla/tests/scripts/check-hotplug.sh b/tools/tr=
acing/rtla/tests/scripts/check-hotplug.sh
> new file mode 100755
> index 0000000000000..5287034cd665e
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-hotplug.sh
> @@ -0,0 +1,97 @@

[ ... ]

> +# The stray kthread shows up within a fraction of a second of the CPU co=
ming
> +# back, well before the teardown that crashes, so asserting on it gives a
> +# clean failure instead of taking the kernel down.

[ ... ]

> +"$RTLA" timerlat top -q -d 20s -c 0,"$CPU" -P F:1 >/dev/null 2>&1 &
> +pid=3D$!
> +
> +# Let rtla create its instance and settle into user-space sampling.
> +sleep 3

[Severity: Medium]
Can check-hotplug.sh report HOTPLUG_OK even when rtla fails to start?

Stdout and stderr are discarded, -u is not passed to require user-space
mode, and the script never checks that $pid is still alive (or that
timerlatu/$CPU exists) after sleep 3 before toggling the CPU.  If rtla
exits at startup, the hotplug cycle runs with no active tracer, finds no
timerlat/* kthreads, and passes.

> +
> +if ! echo 0 >"$ONLINE"; then
> +	echo "HOTPLUG_SKIP: could not offline cpu$CPU"
> +	kill -INT $pid 2>/dev/null; wait $pid 2>/dev/null; exit 0
> +fi
> +if ! echo 1 >"$ONLINE"; then
> +	echo "HOTPLUG_SKIP: could not online cpu$CPU"
> +	kill -INT $pid 2>/dev/null; wait $pid 2>/dev/null; exit 0
> +fi
> +
> +# The hotplug work is queued on the CPU that just came up, and the damag=
e is
> +# done as part of bringing it up: stop_kthread() runs before this point =
and
> +# the log is already tainted.  Check both, so that a build where the str=
ay
> +# kthread is gone but the teardown still misbehaves does not slip throug=
h.
> +stray=3D''
> +i=3D0
> +while [ $i -lt 20 ]; do
> +	stray=3D$(timerlat_threads)
> +	[ -n "$stray" ] && break
> +	sleep 0.2
> +	i=3D$((i + 1))
> +done
> +
> +# Give the run time to reach its own stop path, which is where the kthre=
ad
> +# gets torn down, and then let it finish.
> +sleep 2
> +kill -INT $pid 2>/dev/null
> +wait $pid 2>/dev/null
> +sleep 1

[Severity: Low]
Does stopping rtla here still trigger the crashing teardown when a stray
kthread is detected, and is the comment above the loop accurate about when
stop_kthread() runs?

Bringing the CPU online runs osnoise_hotplug_workfn() -> start_kthread(),
not stop_kthread().  Although the header comment notes that asserting on
the stray kthread avoids taking the kernel down during teardown, the script
still sends SIGINT to rtla while OSN_WORKLOAD is cleared, which runs
stop_kthread() down the user-thread path anyway unless OSNOISE_WORKLOAD is
re-enabled before stopping rtla.

> +
> +warn=3D$(dmesg 2>/dev/null | grep -c 'WARNING: at')
> +fault=3D$(dmesg 2>/dev/null | grep -c 'BUG: kernel NULL pointer')
> +
> +if [ -n "$stray" ]; then
> +	echo "stray workload kthread(s): $(echo $stray)"
> +	echo "HOTPLUG_FAIL: cpu$CPU came back online and a timerlat" \
> +		"workload kthread was started in user-space mode"
> +	exit 1
> +fi
> +
> +if [ "$fault" -gt 0 ] || [ "$warn" -gt 0 ]; then
> +	dmesg | grep -A12 'WARNING: at' | tail -30
> +	echo "HOTPLUG_FAIL: the kernel warned ($warn) or faulted ($fault) durin=
g the hotplug run"
> +	exit 1
> +fi

[Severity: Medium]
Does grepping dmesg for 'WARNING: at' miss warnings when
CONFIG_DEBUG_BUGVERBOSE=3Dy?

kernel/panic.c:__warn() {
	...
	if (file) {
		pr_warn("WARNING: %s:%d at %pS, CPU#%d: %s/%d\n",
			file, line, caller,
			raw_smp_processor_id(), current->comm, current->pid);
	} else {
		pr_warn("WARNING: at %pS, CPU#%d: %s/%d\n",
			caller,
			raw_smp_processor_id(), current->comm, current->pid);
	}
	...
}

When CONFIG_DEBUG_BUGVERBOSE=3Dy (the default), the file and line number sit
between "WARNING:" and "at", so grep -c 'WARNING: at' always returns 0.
In addition, querying the full dmesg buffer without a pre-test baseline
fails the test if any unrelated warning or fault occurred earlier since
boot, and only grepping for 'WARNING: at' when printing context outputs
nothing when $fault is non-zero and $warn is 0.

> diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tes=
ts/timerlat.t
> index 1d317c851a0fa..e521fc7183c56 100644
> --- a/tools/tracing/rtla/tests/timerlat.t
> +++ b/tools/tracing/rtla/tests/timerlat.t
> @@ -6,6 +6,18 @@ test_begin
>  set_timeout 2m
>  timerlat_sample_event=3D'/sys/kernel/tracing/events/osnoise/timerlat_sam=
ple'
> =20
> +# Pick a CPU that can be offlined without taking cpu0 down.  A hotplug t=
est
> +# needs one whose "online" file is writable, plus at least one other CPU=
 so
> +# the tool can still run; otherwise skip the case.
> +hotplug_cpu=3D''
> +for c in /sys/devices/system/cpu/cpu[1-9]*/online; do
> +	[ -w "$c" ] || continue
> +	hotplug_cpu=3D${c#/sys/devices/system/cpu/cpu}
> +	hotplug_cpu=3D${hotplug_cpu%/online}
> +	[ "$(cat /sys/devices/system/cpu/online)" !=3D "$hotplug_cpu" ] || cont=
inue
> +	break
> +done

[Severity: Medium]
Can this loop pick a CPU that is already offline, or keep a rejected value
in hotplug_cpu?

An offline CPU still has a writable sysfs online file (containing 0).  If
that CPU is selected, rtla's user-space thread on $hotplug_cpu fails
sched_setaffinity() at startup, and check-hotplug.sh leaves the previously
offline CPU online when it finishes.  Also, because hotplug_cpu is assigned
before the continue check, a rejection on the last iteration leaves
hotplug_cpu non-empty after the loop ends.

[ ... ]

> @@ -155,4 +167,34 @@ else
>  fi
>  done
> =20
> +# Hotplug test: timerlat in user-space mode samples from the user thread=
 and
> +# has no workload kthread.  Onlining a CPU mid-run must not install one;=
 if
> +# it does, stopping the trace tears that kthread down through the
> +# user-thread path, which warns and then faults.
> +#
> +# The helper drives rtla itself, because the kthread is only torn down a=
fter
> +# rtla exits, so there is no "rtla arguments" string to hand to check().
> +if [ -n "$hotplug_cpu" ]; then
> +	ctr=3D$((ctr + 1))
> +	if [ -n "$TEST_COUNT" ]; then
> +		[ "$NO_RESET_OSNOISE" =3D=3D 1 ] || reset_osnoise
> +		tmpdir=3D$(mktemp -d)
> +		pushd "$tmpdir" >/dev/null
> +
> +		result=3D$("$testdir"/scripts/check-hotplug.sh "$RTLA" "$hotplug_cpu" =
2>&1)
> +		exitcode=3D$?

[Severity: Low]
Does open-coding this test block bypass SUBTESTS, TIMEOUT, and STOPONFAIL
from engine.sh?

Unlike check() in tools/tracing/rtla/tests/engine.sh, this block only tests
[ -n "$TEST_COUNT" ], so running timerlat.t with SUBTESTS set to select an
unrelated test still runs the hotplug test, check-hotplug.sh is not
bounded by $TIMEOUT, and $STOPONFAIL is ignored on failure.

> +
> +		if [ "$exitcode" -eq 0 ] && grep -q '^HOTPLUG_OK' <<< "$result"; then
> +			echo "ok $ctr - top survives a CPU hotplug cycle"
> +		else
> +			echo "not ok $ctr - top survives a CPU hotplug cycle"
> +			echo "$result" | while read -r line; do echo "# $line"; done
> +			printf "#\n# exit code %s\n" "$exitcode"
> +		fi

[Severity: Medium]
Does this treat HOTPLUG_SKIP from check-hotplug.sh as a test failure?

When check-hotplug.sh cannot offline or online the CPU at runtime, it
prints "HOTPLUG_SKIP: ..." and exits with 0.  Because only ^HOTPLUG_OK is
matched here, a skip falls into the else branch and emits "not ok".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179447882047.254241=
.11597980544275717800@gmail.com?part=3D1
