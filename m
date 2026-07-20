Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27823C4573
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558968; cv=none; b=Nzr9D/3aXRfu3i1pGEH8halAEqoub/zwh+FCYQAz1R+HzjgBfV/WN2aAPHfNQlq5Ta7mmzpwmvaoOVZffzVP9ao7O69/yf9O+n8hTcd8s0ON3O9yap9eN1UIgMR7BM4aQT1DcNDoOZTgNIZErdij57loGq3CY+UcdS+RIkHMm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558968; c=relaxed/simple;
	bh=fgugN+i2TeVKyxgusMRac5JR3gvHOZ82v6PKQRDceMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGJ5tK3nuzJ38XgihrcIodMW920b7W96M1unrQf4MDO0c+2ybDBFznjZ95Xg8hVKGBpMt9MzzV/EJ46uUdQsL/hi2y/98FXeuppeZSgcziBrLII7+h9l3TqMqoBNJP8A7FrK33iYpRiqR5/QiumtsD1wdQhlC7JtFsLhZWw9El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKs4RmtG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKs4RmtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784558965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fgugN+i2TeVKyxgusMRac5JR3gvHOZ82v6PKQRDceMA=;
	b=QKs4RmtGZc7l6fUOT8HBRDRy5JPKaVvIel9+Qh0oG0K+KY9276+6m79XKgpWlB/NiLoKpu
	zzMALhCtEJYowlmM6jX94SgokvqYxmZ+5Mrf2nODnSQj8HNdTATU1m8MUMrZboxYryNk4V
	s5SJs+DmEc6Y0Y2mlTc85h4tLC0EndM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-daCZ9UbLP06vmk7VIe8ZRw-1; Mon, 20 Jul 2026 10:49:24 -0400
X-MC-Unique: daCZ9UbLP06vmk7VIe8ZRw-1
X-Mimecast-MFC-AGG-ID: daCZ9UbLP06vmk7VIe8ZRw_1784558963
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698accdb6beso9243960a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 07:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558963; x=1785163763;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lCZf4domhk8HN8iMmiCV6inNWpqnZI8IrFhg4kWyQcw=;
        b=MaJVvYoaTxN2uazieTizP9NoaR+tBicSP11T5yH4didESp/yCyrdPv27yq4vqmv9M8
         xiR/I7tg8bfclACbbAiRt9OOhuGcJL1Z0SGnMjbOOrRmQjFfUmHrgDmTxNSjwsIe2F+U
         fC2FCtwatjEbnzxG7PLj3VKGLTBDpBd+KHnxl2icpDSI7qX551TQdFkaaEYL8hpcPWmh
         PNRcjXjOhP+2QO1HtOJvsSn33dAQrI8FQbAOvvPQjN9/M3t2MpdXRbbx1cUnbZrvoqSC
         VJFKBDF4FYVD9f2x7AY2BTEXBG0FuaX+qZ0huCRRrw5t0P20YMFE5o8t4FkQBwy1dGZU
         2ZTw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1bzt31N26ZGAe7oMyLRrF6lEw3qwKyyn2pRIu833aTA98FFjnFTz5AxAVXKpK0LOcFsPi+8EDHGpAjrdYGexqExA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9icOFR/TQznTcgS+iieXfdxbZ5JNfW5Xsdmnt/eIYhrF3Qul3
	jvgszlyqnj1yBT3zwEaRNxB5sVFa51d+Z5D2+pLCUIrPlRBxUXW7/P+ORWfOWxJeQEuDs9a504V
	0ukDghcS2cBUZsd/H83Kvhh4V/zm35p/QYA1ZP6fjsppRnynXsjTHwjFFF8KDNQS3PeXyNrQ5Jq
	YzHNOr6b3e
X-Gm-Gg: AfdE7cklh841NyEtEvE50Rex4nrOk+MSpP5L7nFMyhQuOUg6UuQ+bzOAgErazeqOOpG
	rG2kBKTWHphsGUXcTN2vihXVexcQBpvpUTPs+t7D/v11okNhrrw3JeX8Jdu4im86SqJGBVfbpEq
	PD3QNZtCI55mq23ZcehMExMhe26kYEm4rZBthhcYxiaXeTcP3juRoQLqGyub9/Z9CkntZX+TUUy
	2/b2fd8blLlKGcWh3E2oHxhC5Mb17HrPpn/2RFMU4+WF7+Al8wLFk7Pt8iAgk9UdOJ8LdovNboo
	/bNOS8HUGHenJFfcx/wbRt1otvuR3flevIGzgeGPq8feTge1vecqXfP6Ya7zVM+BmTcMoqsWs2s
	rtJfRQKVWVhzlvhJcgKTEPJXdoSu0XPjomV7FYxqmViQYGfdt9ZlikQv7qBow6oYv7KCPww==
X-Received: by 2002:a17:906:7947:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c16b46aa27amr514319966b.6.1784558962981;
        Mon, 20 Jul 2026 07:49:22 -0700 (PDT)
X-Received: by 2002:a17:906:7947:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c16b46aa27amr514318366b.6.1784558962460;
        Mon, 20 Jul 2026 07:49:22 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbc8acsm4683223a12.18.2026.07.20.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:49:22 -0700 (PDT)
Message-ID: <9fab4d73b21d588d216d57079d34455deb211a88.camel@redhat.com>
Subject: Re: [PATCH v4 6/8] rv/tlob: add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 16:49:20 +0200
In-Reply-To: <09d656759685edcb0fbeead775300094e7ca5002.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <09d656759685edcb0fbeead775300094e7ca5002.1783524627.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sONVWU-U45Y6GnvL5OdAP14WILLgfIiCuwb04m0xQHM_1784558963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>
> +/* Uprobe binding list; protected by tlob_uprobe_mutex. */
> +static LIST_HEAD(tlob_uprobe_list);
> +static DEFINE_MUTEX(tlob_uprobe_mutex);
> +
> +/*
> + * Serialises duplicate-check + da_handle_start_run_event() per pid.
> + * spinlock_t not raw_spinlock_t: uprobe handlers run under Tasks Trace
> + * SRCU (rcu_read_lock_trace()), which permits sleeping on PREEMPT_RT.
> + */

I don't think these comments add much value. spinlock_t is allowed in
RCU critical sections anyway (it's some sort of preemption and RCU is
preemptible under PREEMPT_RT).

Of course if it isn't really required we don't use a raw spinlock, you
don't need a justification here.

> +static DEFINE_SPINLOCK(tlob_start_lock);
> +
> +/* Per-uprobe-binding state: a start + stop probe pair for one binary re=
gion.
> */
> +struct tlob_uprobe_binding {
> +=09struct list_head=09list;
> +=09u64=09=09=09threshold_ns;
> +=09char=09=09=09binpath[TLOB_MAX_PATH];
> +=09loff_t=09=09=09offset_start;
> +=09loff_t=09=09=09offset_stop;
> +=09DECLARE_RV_UPROBE(start_probe);
> +=09DECLARE_RV_UPROBE(stop_probe);
> +};
> +
> +/*
> + * Per-task teardown invoked by da_monitor_destroy() for each hash entry=
.
> + * CAS on stopping (0->1) claims exclusive cleanup ownership.

I find reading acronyms extremely annoying, since non-locking algorithms
are already complex on their own, why don't you just say cmpxchg (which
is searchable) instead of CAS. Sure CAS isn't an obscure acronym but I
could find at least another 4 different definitions in the kernel tree.

> + *
> + * No per-entry ha_cancel_timer_sync(): da_monitor_destroy() calls
> + * da_monitor_reset_all() + synchronize_rcu() before this hook, and
> + * ha_mon_destroying prevents new timer callbacks from running.
> + */
> +static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
> +{
> +=09struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> +=09struct tlob_task_state *ws =3D ha_get_target(ha_mon);
> +
> +=09if (!ws)
> +=09=09return;
> +
> +=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0)
> +=09=09return;
> +
> +=09put_task_struct(ws->task);
> +=09/*
> +=09 * da_monitor_destroy() has already called synchronize_rcu(); no
> +=09 * reader holds ws.=C2=A0 Return the slot directly without call_rcu.
> +=09 */
> +=09llist_add(&ws->free_node, &tlob_ws_free_list);
> +}
> +
> +static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum tlob_acc_idx idx)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +
> +=09guard(rcu)();
> +=09ws =3D da_get_target_by_id(task->pid);
> +=09if (!ws)
> +=09=09return false;
> +=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09ws->accs_ns[idx] +=3D ktime_to_ns(ktime_sub(now, ws->last_ts));
> +=09ws->last_ts =3D now;
> +=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09return true;
> +}
> +
> +/* Accumulate running_ns for prev; returns true if prev is monitored. */
> +static inline bool tlob_acc_running(struct task_struct *task, ktime_t no=
w)
> +{
> +=09return __tlob_acc(task, now, TLOB_ACC_RUNNING);
> +}
> +
> +/* Accumulate waiting_ns for next; returns true if next is monitored. */

There's no next and prev here, plus you're describing __tlob_acc()'s
behaviour 3 times, I'd say just document that (even if it isn't the
primary facing function) and that's all.

> +static inline bool tlob_acc_waiting(struct task_struct *task, ktime_t no=
w)
> +{
> +=09return __tlob_acc(task, now, TLOB_ACC_WAITING);
> +}
> +
> +/*
> + * handle_sched_switch - advance the DA on every context switch.
> + *
> + * Generates three DA events:
> + *=C2=A0=C2=A0 prev, prev_state !=3D 0=C2=A0 -> sleep_tlob=C2=A0=C2=A0=
=C2=A0 (running -> sleeping)
> + *=C2=A0=C2=A0 prev, prev_state =3D=3D 0=C2=A0 -> preempt_tlob=C2=A0 (ru=
nning -> waiting)
> + *=C2=A0=C2=A0 next=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> switch_in_tlob=
 (waiting -> running)
> + *
> + * A single ktime_get() at handler entry is shared by both acc calls so =
that
> + * prev's running_ns and next's waiting_ns share the same context-switch
> + * timestamp; neither absorbs handler overhead into its accumulator.
> + *
> + * No waiting->sleeping edge exists: a task can only block voluntarily
> + * (call schedule()) while it is executing on CPU, which corresponds to
> + * the running DA state.=C2=A0 A task in the waiting state is TASK_RUNNI=
NG in
> + * kernel terms (on the runqueue) and cannot block itself.
> + *
> + * da_handle_event() is called unconditionally: it skips tasks that have=
 no
> + * monitor entry in the hash table.
> + */
> +static void handle_sched_switch(void *data, bool preempt_unused,
> +=09=09=09=09struct task_struct *prev,
> +=09=09=09=09struct task_struct *next,
> +=09=09=09=09unsigned int prev_state)
> +{
> +=09ktime_t now =3D ktime_get();
> +=09bool prev_preempted =3D (prev_state =3D=3D 0);
> +
> +=09if (tlob_acc_running(prev, now))
> +=09=09da_handle_event(prev->pid, NULL,
> +=09=09=09=09prev_preempted ? preempt_tlob : sleep_tlob);
> +=09if (tlob_acc_waiting(next, now))
> +=09=09da_handle_event(next->pid, NULL, switch_in_tlob);
> +}
> +
> +/* Accumulate sleeping_ns on wakeup; returns true if task is monitored. =
*/
> +static inline bool tlob_acc_sleeping(struct task_struct *task, ktime_t n=
ow)
> +{
> +=09return __tlob_acc(task, now, TLOB_ACC_SLEEPING);
> +}
> +
> +/*
> + * handle_sched_wakeup - sleeping -> waiting transition.
> + *
> + * try_to_wake_up() skips TASK_RUNNING tasks, so this never fires for a
> + * task already in running or waiting state.
> + */
> +static void handle_sched_wakeup(void *data, struct task_struct *p)
> +{
> +=09ktime_t now =3D ktime_get();
> +
> +=09if (tlob_acc_sleeping(p, now))
> +=09=09da_handle_event(p->pid, NULL, wakeup_tlob);
> +}
> +
> +/*
> + * handle_sched_process_exit - clean up if a task exits without TRACE_ST=
OP.
> + *
> + * Called in do_exit() context; the task still has a valid pid here.
> + * tlob_stop_task() returns -ESRCH if the task is not monitored, which i=
s
> fine.
> + */
> +static void handle_sched_process_exit(void *data, struct task_struct *p,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool group_dead)
> +{
> +=09tlob_stop_task(p);
> +}
> +
> +/**
> + * tlob_start_task - begin monitoring @task with budget @threshold_ns ns=
.
> + * @task:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Task to monito=
r; may be current or another task.
> + * @threshold_ns: Latency budget in nanoseconds (wall-clock; running +
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 waiting + sleeping).
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Must be in [1000, TLOB_MAX_THRESHOLD_NS].
> + *
> + * Returns 0, -ENODEV, -ERANGE, -EALREADY, or -ENOSPC (pool at capacity)=
.
> + */
> +int tlob_start_task(struct task_struct *task, u64 threshold_ns)
> +{
> +=09struct tlob_task_state *ws;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;
> +
> +=09if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
> +=09=C2=A0=C2=A0=C2=A0 threshold_ns > TLOB_MAX_THRESHOLD_NS)
> +=09=09return -ERANGE;
> +
> +=09/* Serialise duplicate-check + pool-slot claim; see tlob_start_lock.
> */
> +=09guard(spinlock)(&tlob_start_lock);
> +
> +=09/*
> +=09 * __da_get_mon_storage() uses hash_for_each_possible_rcu(), which
> +=09 * requires an RCU read-side critical section.=C2=A0 On PREEMPT_RT,
> +=09 * spinlock_t is an rt_mutex and does not satisfy this requirement.
> +=09 */

Also this is probably misleading, getting the monitor requires RCU, then
the fact some in some configuration something other than read_lock_rcu()
would work too (e.g. disabling preemption) is irrelevant.

> +=09scoped_guard(rcu) {
> +=09=09if (da_get_target_by_id(task->pid))
> +=09=09=09return -EALREADY;
> +=09}
> +
> +=09/*
> +=09 * Both tlob_ws_alloc() and da_handle_start_run_event() pop from
> +=09 * pre-allocated pools of size TLOB_MAX_MONITORED; NULL return means
> +=09 * the pool is at capacity.
> +=09 */
> +=09ws =3D tlob_ws_alloc();
> +=09if (!ws)
> +=09=09return -ENOSPC;
> +
> +=09ws->task =3D task;
> +=09get_task_struct(task);
> +=09ws->threshold_ns =3D threshold_ns;
> +=09ws->last_ts =3D ktime_get();
> +=09raw_spin_lock_init(&ws->entry_lock);
> +
> +=09/*
> +=09 * da_handle_start_run_event() claims a pool slot via
> da_prepare_storage(),
> +=09 * initialises the monitor, and delivers start_tlob in one step: the
> +=09 * generated ha_setup_invariants() resets clk_elapsed and arms the
> timer.
> +=09 * Returns 0 if the da_monitor_storage pool is exhausted.
> +=09 */

And try not to be too specific about the internal implementation of the
library, that can change without notice, we don't want to have to update
all comments.

Here it is indeed non-trivial to assume no space if
da_handle_start_run_event() fails, but that's only consequence of the
fact that this ws is certainly new (by construction) and the monitor is
enabled: da_handle_start_run_event() can only fail if allocation failed.

da_handle_start_* functions return 1 if an event was handled, this is
by the way not documented..

You could simply say something like:

 da_handle_start_run_event() returns false if no event was handled, in
this case it can happen only if memory allocation failed

> +=09if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
> +=09=09put_task_struct(task);
> +=09=09tlob_ws_direct_return(ws);
> +=09=09return -ENOSPC;
> +=09}
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(tlob_start_task);
> +
> +/**
> + * tlob_stop_task - stop monitoring @task.
> + * @task: Task to stop.
> + *
> + * CAS on ws->stopping (0->1) under RCU claims cleanup ownership;
> + * the winner cancels the timer synchronously and frees all resources.
> + *
> + * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
> + * or -EAGAIN (concurrent caller claimed cleanup).
> + */
> +int tlob_stop_task(struct task_struct *task)
> +{
> +=09struct da_monitor *da_mon;
> +=09struct ha_monitor *ha_mon;
> +=09struct tlob_task_state *ws;
> +=09bool budget_exceeded;
> +
> +=09scoped_guard(rcu) {
> +=09=09ws =3D da_get_target_by_id(task->pid);
> +=09=09if (!ws)
> +=09=09=09return -ESRCH;
> +
> +=09=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09=09if (unlikely(WARN_ON_ONCE(!da_mon)))
> +=09=09=09return -ESRCH;
> +
> +=09=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09=09/*
> +=09=09 * CAS (0->1) claims cleanup ownership under RCU (ws
> guaranteed valid).
> +=09=09 * _release pairs with atomic_read_acquire in
> ha_setup_invariants.
> +=09=09 */
> +=09=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0)
> +=09=09=09return -EAGAIN;
> +=09}
> +=09/*
> +=09 * ws and ha_mon are used below outside the RCU guard.=C2=A0 This is =
safe:
> +=09 * the winning CAS (stopping: 0->1) is the only path that frees ws,
> +=09 * and da_destroy_storage() below is the only call that returns the
> +=09 * pool slot.=C2=A0 No concurrent path can free either object.
> +=09 */
> +
> +=09/* Wait for in-flight timer callback before reading da_monitoring. */
> +=09ha_cancel_timer_sync(ha_mon);
> +
> +=09/* Timer fired first -> budget exceeded; otherwise reset normally. */
> +=09scoped_guard(rcu) {
> +=09=09budget_exceeded =3D !da_monitoring(da_mon);
> +=09=09if (!budget_exceeded)
> +=09=09=09da_monitor_reset(da_mon);
> +=09}
> +=09da_destroy_storage(task->pid);

Here you're playing with the state machine, that looks fragile from a
monitor code.
You could probably have budget_exceeded as part of your target and set
it from tlob_reset_notify() when you know there was an expiration.

Perhaps "stop" could be yet another event in the state machine, bringing
to the "stopped" state, which would automatically call reset(), you only
need to grab ws->stopping before handling the event for
tlob_reset_notify() to work as expected.
Though you'd probably still need ha_cancel_timer_sync() for the rare but
not impossible in-flight timer not yet in RCU critical section..

I'd rather avoid as much as possible bringing in ha_mon/da_mon, but you
probably cannot do better here, just you could avoid relying on
da_monitoring().

What do you think?

Thanks,
Gabriele

