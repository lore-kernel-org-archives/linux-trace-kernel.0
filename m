Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C10468C0C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245435; cv=none; b=Ww8wHKrkmu/QOgp5XK4o18+XObEET3rxWoFM3D1Ps9QLceKnLEy/cKsJxnJuQ9QYrTasFk1iqclwVuffS2uud8yO5ckbs6hTVBu2f87He0jSMzsSRdC5QU9ALAQS/IpCFnaVcvL8pzYw3yTKoqQKAucr85TkJEhYqLhHflf/ISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245435; c=relaxed/simple;
	bh=KesVBStf5TYBF1LElujVsGacTe+H7z1/xn1CJm+As6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsTS569euLnpbiTLyfzD+BZOt9p1Zi+QJhcNqIGBFhp1K6GDpDju3HnoLhkLL/ZsFZhdN0KtL2hjc6dUG5mjjD8i6IPwFbCQmiGwQexERRXrEt8BG6VACdEs//YfZledAA/2P2Ye2Kxiue9xVwZ35T7H8JoA/XIhscVH4ZHUq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUMI0gtf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUMI0gtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDF1F000E9;
	Thu, 20 Aug 2026 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245433;
	bh=Ye4gg43NJFlf3rCiIdE8UpZSCraGCblTpSZUWtJQ10o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUMI0gtfX4H7f/QTgN9WO1iMp5nX5PFmyAiFSZE+RAHO4WkXtfMs4k36yKmeZnMxd
	 xgyqLk5V/4WVWlY1DYDo/rR2fGYfScanMHz5NHwB1XxUy03kgPrwn/W8OFRaJ8JUCF
	 22XpH0WEtUIYML2W+eC17HMEKcwMYArshC7tQ2JUSVwyRthWE03CnsbbEDLcyhIMvv
	 6RGT41vi+Xpx7Ylpxs8swKPkhyG+j+sTwnakWUbWG6iv3d7PReYYYOawbC6DHmN4W4
	 JVgQoSvj0hmrEiDw+q8J16//atS186DQ3SCyu+CneObi+zlb086vaTfHJ2b3jL+ZV1
	 5ZFxZMjCIZ0Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] rv: Add tlob hybrid automaton monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:03:53 +0000
Message-Id: <20260820170353.92EDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Concurrent task exit causes Use-After-Free and list corruption=
 in `tlob_unbind_reap`.
- [High] Race between `tlob_stop_task` claiming the window and the HA timer=
 callback suppresses the detail trace and hides budget violations.
- [High] `tlob_ws_lock` is a `spinlock_t` acquired in tracepoint and uprobe=
 exception contexts, causing sleeping in atomic context on PREEMPT_RT.

Pre-existing issues:
- [Critical] Concurrent lockless calls to `hash_add_rcu` and `hash_del_rcu`=
 on `da_monitor_ht` corrupt the hash bucket lists.
--

--- Patch [6]: [PATCH v6 6/9] rv: Add tlob hybrid automaton monitor ---
commit ecef387f80f071ac66f0456fa83acfd88043286c
Author: Wen Yang <wen.yang@linux.dev>
Subject: rv: Add tlob hybrid automaton monitor

This patch introduces tlob (task latency over budget), a per-task hybrid
automaton RV monitor. It tracks wall-clock time across a user-delimited code
section using uprobes and emits warnings when the elapsed time exceeds a
configured threshold.

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monit=
ors/tlob/tlob.c
> new file mode 100644
> index 0000000000000..08b1bee884cc4
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c

[ ... ]

> +/* Serialises tlob_task_state ownership: restart, detach, unbind reap. */
> +static DEFINE_SPINLOCK(tlob_ws_lock);

[Severity: High]
Could this spinlock cause sleeping in atomic context warnings on PREEMPT_RT
kernels?

On PREEMPT_RT, spinlock_t maps to a sleepable rt_mutex. However, this lock
is acquired in atomic contexts. For example, in the tracepoint callback pat=
h:

handle_sched_process_exit()
  tlob_destroy_task()
    tlob_detach_from_binding()

And in the uprobe exception path:

tlob_uprobe_entry_handler()
  tlob_start_task()

Should this use a raw_spinlock_t instead to avoid violating PREEMPT_RT
rules?

[ ... ]

> +static int tlob_stop_task(struct task_struct *task, void *binding)
> +{
> +	struct ha_monitor *ha_mon;
> +	struct tlob_task_state *ws;
> +	bool budget_exceeded;
> +
> +	scoped_guard(rcu) {
> +		ha_mon =3D ha_get_monitor(task->pid, NULL);
> +		if (!ha_mon)
> +			return -ESRCH;
> +
> +		ws =3D ha_get_target(ha_mon);
> +		if (WARN_ON_ONCE(!ws))
> +			return -ESRCH;
> +
> +		/* Only the binding that opened the window may end it; NULL
> +		 * (task exit) skips the check.  Symmetric with the restart
> +		 * check in tlob_start_task(). */
> +		if (binding && ws->binding !=3D binding)
> +			return -EALREADY;
> +
> +		/* cmpxchg (0->1) claims the window under RCU; _release pairs
> +		 * with the acquire in ha_setup_invariants(). */
> +		if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0)
> +			return -EAGAIN;

[Severity: High]
Is there a race condition here if the latency budget expires at the exact
same time the task hits the stop uprobe?

If tlob_stop_task() wins the cmpxchg, it claims the window. The hrtimer
callback could then run concurrently and call tlob_reset_notify(), which
checks the stopping flag and returns early. This would skip emitting the
detail tracepoint and skip setting budget_exceeded to true.=20

Since tlob_stop_task() then reads budget_exceeded as false and returns 0,
could this silently hide genuine budget violations?

[ ... ]

> +static void tlob_destroy_task(struct task_struct *task)
> +{

[ ... ]

> +	tlob_detach_from_binding(ws);
> +
> +	/* Force the window ended: @task may never have reached STOP or a timer=
. */
> +	atomic_set(&ws->stopping, 1);
> +	ha_cancel_timer_sync(ha_mon);
> +
> +	scoped_guard(rcu) {
> +		da_monitor_reset(&ha_mon->da_mon);
> +	}
> +	da_destroy_storage(task->pid);

[Severity: Critical]
This is a pre-existing issue, but is it safe to call da_destroy_storage()
here without holding a lock?=20

Looking at da_destroy_storage() in include/rv/da_monitor.h, it calls
hash_del_rcu(&mon_storage->node). If multiple monitored tasks whose PIDs
map to the same hash bucket exit concurrently, or one exits while another
starts, calling hash_del_rcu() and hash_add_rcu() concurrently without
mutual exclusion on the same bucket can corrupt the hlist pointers.

[ ... ]

> +static void tlob_unbind_reap(struct tlob_uprobe_binding *b)
> +{
> +	struct tlob_task_state *ws, *tmp;
> +	LIST_HEAD(to_destroy);
> +
> +	scoped_guard(spinlock, &tlob_ws_lock) {
> +		list_for_each_entry_safe(ws, tmp, &b->started_list, started_node) {
> +			list_del_init(&ws->started_node);
> +			ws->binding =3D NULL;
> +			if (atomic_read(&ws->stopping))
> +				list_add_tail(&ws->started_node, &to_destroy);
> +		}
> +	}
> +
> +	list_for_each_entry_safe(ws, tmp, &to_destroy, started_node) {

[Severity: Critical]
Can this iteration trigger a use-after-free if a parked task exits
concurrently?

When tlob_unbind_reap() moves parked windows to the local to_destroy list
and drops the spinlock, it iterates the list without holding rcu_read_lock(=
).

If handle_sched_process_exit() invokes tlob_destroy_task() concurrently,
it skips detaching from the binding list (since ws->binding is already NULL)
and calls call_rcu() to free the task state. Without RCU read protection
here, the grace period could expire and free the memory while it is still
linked on the local to_destroy list.

> +		list_del_init(&ws->started_node);
> +		tlob_destroy_task(ws->task);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D6
