Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA5275A2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687929; cv=none; b=I2N0evC0sxsnbkLLtFn3vcINk8bcmciLkDmu1BURwDLe0lEnEqdxM4kBxCuEBpXGjgHN6c2eqK7yodaCEY1EKPpX1N/gpROTfOtR49j7aYbb/xQ3ByQS5MxvPZZQ97eW/KpZ4VUqXP2z+T/0zBwtzvm/QtxUNTxIgdhlp5ZpZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687929; c=relaxed/simple;
	bh=DX27k9nWFqrUx76CgFEVEnNRSAI8BFEvz9wEf48BHuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRsMTvc2OU1jSb1LqVGnzYntSViVGvr2zD0nMlcI5I7bsuovL8XnTER/slkbvqbYQCLyGIj/kvxacuqQS6Xrexr4jvb56g0duc0ynDRhYqeYWo0HPpJANqwevb1Tluj+Or7c6oFHUE4ReRspOAixQ84w/qzxOdGLjR27MJGWvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3CQXTBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3CQXTBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B1D1F00893;
	Tue, 29 Sep 2026 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687927;
	bh=pRkoo6HJJ9xsKPyndxkeXBMZ211d1Rwjt+J9GEfuT6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3CQXTBvVS8ZDAmtLZ7U79nvfIuJjkISEL5wECeN4EVs/mVl+eGYEP1bfkivqPUW3
	 4ByheEWuCEu8nCpdGlJkgRcJ14gni7MJqmctM4VuWPMl5DKgbNDEaoeh90ZGuIcZ/+
	 ppdOZpZ9krbCI02PYfy6KZHqOW4v0u8UrOsUvL8FbQ9tKXutpjwzCXt+DT5fzAy7bI
	 eYDrkkMTU0y7FP3c3qKljuusA0Fdgsi7N0WI0lWcud9bcL6MOLz7XP6QDTqHmxBRrZ
	 B9uvFqHhxKu+EDtF1ise9b4mKrI7dQx5S8Sr5DOqmaE9G2W+iAI5ZO9ZnLaEME3BC7
	 uugHzPp4BBq2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] rv: Add throttle deadline monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929124908.177676-8-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
 <20260929124908.177676-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:18:46 +0000
Message-Id: <20260929131847.32B1D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] rv: timer overflow in runtime_left_ns() allows monitor evasion
- [High] rv: speculative monitor allocation causes memory leak and Use-Afte=
r-Free
- [High] rv: concurrent hash table modifications in tracepoints corrupt mon=
itor lists
- [Medium] rv: handle_sched_switch() skips switch-out events for background=
 servers
- [Medium] rv: monitor timer is cancelled before syscall validation allowin=
g evasion
--

commit 59f095bf10c27a9ddbf78eaa030f99a4df14f9eb
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Add throttle deadline monitor
   =20
This commit adds a monitor to validate the behavior of the deadline
scheduler, specifically ensuring that deadline entities are throttled when
they use up their runtime.

> --- /dev/null
> +++ b/kernel/trace/rv/monitors/throttle/throttle.c
[ ... ]
> +static inline u64 runtime_left_ns(struct ha_monitor *ha_mon)
> +{
> +	return ha_get_target(ha_mon)->runtime + RUNTIME_THRESH;
> +}

[Severity: High]
Can the implicit conversion to u64 here cause a timer overflow?=20

ha_get_target(ha_mon)->runtime is a signed 64-bit value that can be
negative when a task overruns its budget. Returning it as a u64 casts it
to a huge positive value, which is then passed to ha_start_timer_ns().=20

Will this push the enforcement timer far into the future and effectively
blind the monitor to task overruns?

[ ... ]
> +static void handle_sched_switch(void *data, bool preempt,
> +				struct task_struct *prev,
> +				struct task_struct *next,
> +				unsigned int prev_state)
> +{
[ ... ]
> +	/*
> +	 * The server is available in next only if the next task is boosted,
> +	 * otherwise we need to retrieve it.
> +	 * Here the server continues in the state running/armed until actually
> +	 * stopped, this works since we continue expecting a throttle.
> +	 */
> +	if (next->dl_server) {
> +		da_handle_start_event(EXPAND_ID(next->dl_server, cpu,
> +						get_server_type(next)),
> +				      sched_switch_in_throttle);
> +	} else {
> +		handle_server_switch(next, cpu, DL_SERVER_FAIR);
> +		if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
> +			handle_server_switch(next, cpu, DL_SERVER_EXT);
> +	}
> +}

[Severity: Medium]
Does this skip switch-out events for background servers?

If next->dl_server is non-NULL, we enter this branch and send a switch-in
event. However, this skips the else block entirely, meaning the preempted
fair or ext server on that CPU never receives its sched_switch_out_throttle
event.

Won't this leave the fair server incorrectly armed or running, potentially
causing false positive timer failures?

[ ... ]
> +static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *p;
> +	int new_policy =3D -1;
> +	pid_t pid =3D 0;
> +
> +	new_policy =3D extract_params(regs, id, &pid);
> +	if (new_policy < 0)
> +		return;
> +	guard(rcu)();
> +	p =3D pid ? find_task_by_vpid(pid) : current;
> +	if (unlikely(!p) || new_policy =3D=3D p->policy)
> +		return;
> +
> +	if (p->policy =3D=3D SCHED_DEADLINE)
> +		da_reset(EXPAND_ID_TASK(p));

[Severity: Medium]
Can a user evade the monitor by spamming invalid syscalls?

Calling da_reset() permanently cancels the enforcement timer via
ha_cancel_timer() before the syscall is validated. If the syscall fails
and returns an error code, the task remains in SCHED_DEADLINE but the
monitor's timer stays disabled for the remainder of the execution slice.

> +	else if (new_policy =3D=3D SCHED_DEADLINE)
> +		da_create_or_get(EXPAND_ID_TASK(p));
> +}

[Severity: High]
Does this speculative allocation create a memory leak and use-after-free?

da_create_or_get() is called here before the sched_setscheduler syscall
completes or validates permissions. If the syscall fails, the task's
policy remains unchanged.

When the task eventually exits, handle_exit() only destroys storage if
the task's current policy is SCHED_DEADLINE, leaving the speculatively
allocated monitor storage permanently leaked.

Furthermore, if the PID is later reused and the new task enters
SCHED_DEADLINE, da_create_or_get() will find the leaked storage without
updating the target pointer, potentially causing a use-after-free when
the monitor accesses target->runtime.

[Severity: High]
Is it safe to concurrently modify the RCU hash table here?

da_create_or_get() adds to the hash table via hash_add_rcu(), but it is
called directly from a tracepoint protected only by a read-side lock
(guard(rcu)()).=20

Since tracepoints can trigger concurrently on different CPUs, won't this
race on the hlist pointers and corrupt the monitor lists? The same concern
applies to the hash_del_rcu() call in handle_exit() registered to the
sched_process_exit tracepoint below.

[ ... ]
> +static int enable_throttle(void)
> +{
[ ... ]
> +	rv_attach_trace_probe("throttle", sched_switch, handle_sched_switch);
> +	if (!should_skip_syscall_handle())
> +		rv_attach_trace_probe("throttle", sys_enter, handle_sys_enter);
> +	rv_attach_trace_probe("throttle", task_newtask, handle_newtask);
> +	rv_attach_trace_probe("throttle", sched_dl_server_stop_tp, handle_dl_se=
rver_stop);
> +	rv_attach_trace_probe("throttle", sched_process_exit, handle_exit);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929124908.1776=
76-1-gmonaco@redhat.com?part=3D7
