Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625B3C108D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688299; cv=none; b=LN2dQrFPPLTbQdGFZ2QhJVPiQNuct+fSDNuiN+odqpA43B0cRMaJrpY8365tYpA7aidw4XrrsVKqLYezpWUH9tQBXOt0iWcENxwDFLxB35oO3VnxxxGQRrZPdFySpVwHRJhEftuGpx0BT6X0HN3bqXrFLmTLd2cQvK/9CLQfIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688299; c=relaxed/simple;
	bh=9seQ1vxdvH0DIkMpe6MbcyoHvW2wf7KmrA4YUZgmBLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6t2/0MKQ32/u7iknDzw7YiRocXN6TRw/mjtnr1XUn98G6U2Zpsla8Zu9VuSBAVfL52OtqpTrmD2q6w4rWdh5iLjGqp7ZitCSF9y+Pjei9kIfclv2R16+SLYQGGzKxIzOJGOFk6Y2ZYA6AfhhlAaQR429Y5M0HuQ5NBgVZf1f7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3D/WY0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3D/WY0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF7A1F00893;
	Tue, 29 Sep 2026 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688298;
	bh=Wd5kmk4lTKytrwvuXI0obkDAw5RtpHe8P9lwEk1CeRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3D/WY0r1ogg9t6s8lyb89Q7ZPJFLNdYqefMyUSBCzQX8VgEq5g5SkRHZlAYZE5+x
	 fdcGgBWCnsD2VRvzC1fplWxm5EcCwT3zDExejS0mfUfKoPY7xScuMn5KDgPLRjoAdP
	 pDGqC90tpeTdkbKUrJKqm1nJAnjXgz5z5k8uTB2qPYhf7B+DIPwvSB0razE/hwPKY0
	 cEcDTFeATAXiSaZMotem4stPvrv1jAkX2ipHKLFMfLKeQj1R56BRuN3s9DoEdY15fO
	 OFiTba+TF6V1Vt3mQu0Yo24VUf5XFYOtQeaycyrk6mjaU4M72/A3zNSMuKbC2k82aw
	 IW+dCd2/QNsHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] rv: Add dl_server specific monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929124908.177676-9-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
 <20260929124908.177676-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:24:57 +0000
Message-Id: <20260929132457.BFF7A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] rv/boost: false positive deadline violation on priority change
- [Medium] rv/laxity: unhandled dl_server_stop from zero_laxity_wait panics=
 monitor
- [Medium] rv/laxity: unhandled dl_replenish_running from idle_wait panics =
monitor
--

commit c4d2df85586e4b58ec40171970939b56d0e05ab9
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Add dl_server specific monitors
   =20
Add monitors to validate the behaviour of the deadline server.

The currently implemented monitors are:
* boost
    fair tasks run either independently or boosted
* laxity
    deferrable servers wait for zero-laxity and run

> diff --git a/kernel/trace/rv/monitors/boost/boost.c b/kernel/trace/rv/mon=
itors/boost/boost.c
> index 0000000000000..3533d23279eeb 100644
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/boost/boost.c
[ ... ]
> +static void handle_sched_enqueue(void *data, struct task_struct *tsk, in=
t cpu)
> +{
> +	struct sched_dl_entity *dl_se =3D NULL;
> +	u8 type =3D get_server_type(tsk);
> +
> +	if (is_server_type(type))
> +		dl_se =3D get_server(tsk, type);
> +	if (dl_se) {
> +		da_handle_event(EXPAND_ID(dl_se, cpu, type),
> +				dl_se->runtime > 0 && !idle_cpu(cpu) ?
> +					dl_server_resume_boost :
> +					dl_server_resume_throttled_boost);
> +	}
> +}

[Severity: Medium]
Will this lead to a false positive deadline violation if a task changes
priority?  If a running task changes its priority (e.g., via set_user_nice(=
)),
it is dequeued and re-enqueued, which triggers handle_sched_enqueue() and
transitions the monitor to ready_boost.

If the task continues running without being preempted, __schedule() will
bypass the sched_switch tracepoint:

kernel/sched/core.c:__schedule() {
    ...
    if (likely(prev !=3D next)) {
        trace_sched_switch(preempt, prev, next, prev_state);
        ...
    }
    ...
}

Could this leave the monitor trapped in the ready_boost state until its
timer expires, causing an unwarranted violation?

[ ... ]
> diff --git a/kernel/trace/rv/monitors/laxity/laxity.c b/kernel/trace/rv/m=
onitors/laxity/laxity.c
> index 0000000000000..751d318224366 100644
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/laxity/laxity.c
[ ... ]
> +static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_s=
e,
> +				int cpu, u8 type)
> +{
> +	if (!is_server_type(type))
> +		return;
> +	/* Special replenish happening after throttle, ignore it */
> +	if (dl_se->dl_defer_running && dl_se->dl_throttled)
> +		return;
> +	if (dl_se->dl_defer_running)
> +		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_running_laxi=
ty);

[Severity: Medium]
Is it possible for dl_replenish_running_laxity to be emitted while the moni=
tor
is in the idle_wait state, causing an INVALID_STATE panic?

When the CPU is idle, the monitor enters idle_wait_laxity. If a fair task w=
akes
up, dl_server_start() clears dl_defer_idle but returns without emitting a
tracepoint because dl_server_active is already true.

If the dl_timer fires before update_curr_idle() advances exec_start
significantly, dl_server_timer() proceeds with dl_defer_idle =3D=3D 0, sets
dl_defer_running =3D 1, and emits dl_replenish_running.

Since the generated automaton lacks a transition for dl_replenish_running f=
rom
idle_wait_laxity, won't this cause a state machine panic?

> +	else if (idle_cpu(cpu))
> +		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_idle_laxity);
> +	else
> +		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_laxity);
> +}
[ ... ]
> +static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl=
_se,
> +				  int cpu, u8 type)
> +{
> +	if (is_server_type(type))
> +		da_handle_start_event(EXPAND_ID(dl_se, cpu, type), dl_server_stop_laxi=
ty);
> +}

[Severity: Medium]
Can dl_server_stop_laxity be emitted while the monitor is in zero_laxity_wa=
it,
resulting in an INVALID_STATE panic?

The monitor enters zero_laxity_wait when the server starts. If all fair tas=
ks
on the runqueue are dequeued (e.g., they sleep) before the server runs,
dl_server_active is cleared and dl_server_stop is called.

The generated automaton for the laxity monitor lacks a transition for
dl_server_stop from zero_laxity_wait. Does this cause a crash?

[ ... ]
> diff --git a/kernel/trace/rv/monitors/laxity/laxity.h b/kernel/trace/rv/m=
onitors/laxity/laxity.h
> index 0000000000000..69a818c0f6cfe 100644
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/laxity/laxity.h
[ ... ]
> +	.function =3D {
[ ... ]
> +		{
> +			zero_laxity_wait_laxity,
> +			idle_wait_laxity,
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			stopped_laxity,
> +			INVALID_STATE,
> +			zero_laxity_wait_laxity,
> +			INVALID_STATE,
> +		},

[Severity: Medium]
The transition for dl_replenish_running_laxity (index 2) is missing
(INVALID_STATE) from idle_wait_laxity (index 1), which causes the panic
described above in handle_dl_replenish().

[ ... ]
> +		{
> +			zero_laxity_wait_laxity,
> +			idle_wait_laxity,
> +			running_laxity,
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			zero_laxity_wait_laxity,
> +			INVALID_STATE,
> +		},

[Severity: Medium]
The transition for dl_server_stop_laxity (index 5) is missing
(INVALID_STATE) from zero_laxity_wait_laxity (index 4), which causes
the panic described above in handle_dl_server_stop().

> +	},
> +	.initial_state =3D stopped_laxity,
> +	.final_states =3D { 1, 0, 0, 0, 0 },
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929124908.1776=
76-1-gmonaco@redhat.com?part=3D8
