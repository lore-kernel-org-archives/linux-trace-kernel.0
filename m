Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860093563F6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748689; cv=none; b=bBZlqdyp0Eugkxf735k9xs5maOa76JDQkJ0fPER1ZQXuT6vhS9e0NeYilzVEL5O8LV6UcHU7aFZPyZoaIaDJMLrJ3D8KUPHrK215mshgnrbpaoI+j7wWiQ1+G7hVafx6jtyF71TgiJ5npjIdq4y/08b5A4OTy5ysZ+NfqqQxC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748689; c=relaxed/simple;
	bh=vRs8lee5WTj5ZCxm6tL/eKdjEQ9XhPZEc5CTdN5rxoM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oiJdD6MD9KEAHMaZv5Q+g2u3p0nDaApOsXfbnpuilbqREBkaiX3qPsnfrPNgkjwsydzozZfZLBthlKyEw4U12C9C2fxSfwSKlZNxu3dRBEpq4wPB8XhOSAdtEkI/Lj1Ls54BzRSZ71DES2Wz0Yjf6vXTBiPgJhjvOdniknUEsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG6l+Hjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG6l+Hjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7901F0089B;
	Sun, 11 Oct 2026 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748688;
	bh=papPPLHWTKAp0Uzu/mbIXce+i5R4kKODrDSyQEASJK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SG6l+HjgWNpwf26IX/b/yo6DU9e0ilmqF49AFe0JqEVGS4TFgwNLxvscF0SQnOXRr
	 bmp4EVZAjXykqv7OG6j4MxGSU3LfkZNQuPvPfkWtIrhAy4anfJdVGXuEhaAD1vIhNa
	 +RKIdHOVC3aqXBFYMPm0gGJ1lUQgULo2qamnHCv1sNCq5JYh9/4UZdYUqaAYUDG5CE
	 3kGJVV+smwqWYBzJN+4PvYaUx7rQK7Nq0k59pkqfrPiWeCDNn8lJSC1h8bJPxvMy0/
	 OIOG49fiMU6rQQrK7uMD3+jlrVIqTrrM/84dhe7EnqCuc8/SJ5Q1UyT2CAzRKBbL6s
	 csNK8rLUpHIew==
Message-ID: <sashiko-outbox-167433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/14] rv: Add tlob hybrid automaton monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <96c7ee8abbe9b9b840ca6e112744b5c74f0e9b8f.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <96c7ee8abbe9b9b840ca6e112744b5c74f0e9b8f.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:58:07 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] rv: TOCTOU race in ha_setup_invariants allows hrtimer Use-Afte=
r-Free
- [High] rv: deadlock in tlob_binding_lock between process context and RCU =
softirq
- [High] rv: tlob: list corruption due to lockless da_destroy_storage() cal=
ls
- [Medium] rv: race between tlob_stop_task and timer callback causes INVALI=
D_STATE error
--

commit 90ea80dda3503cc5ac796d8401bafbbd97a373b9
Author: Wen Yang <wen.yang@linux.dev>

rv: Add tlob hybrid automaton monitor

tlob (task latency over budget) is a per-task hybrid automaton RV
monitor that tracks wall-clock time across a user-delimited code
section and emits an error when the elapsed time exceeds a configurable
budget.

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monit=
ors/tlob/tlob.c
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
[ ... ]
> +static inline void tlob_detach_from_binding(struct tlob_record *rec)
> +{
> +	guard(spinlock)(&tlob_binding_lock);
> +
> +	if (!rec->binding)
> +		return;
> +	rec->binding =3D NULL;
> +	list_del_init(&rec->started_node);
> +}
> +
> +/*
> + * Per-record teardown during monitor disable.  TLOB_RETIRED claims it, =
so an
> + * exit or unbind racing disable frees the record once.
> + */
> +static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
> +{
> +	struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> +	struct tlob_record *rec =3D ha_get_target(ha_mon);
> +
> +	if (!rec)
> +		return;
> +
> +	if (atomic_xchg(&rec->state, TLOB_RETIRED) =3D=3D TLOB_RETIRED)
> +		return;
> +
> +	tlob_detach_from_binding(rec);
> +	call_rcu(&rec->rcu, tlob_rec_return_cb);
> +}

[Severity: High]
Does this lock acquisition risk a deadlock between process context and RCU
softirq?

The tlob_binding_lock is acquired in process context functions like
tlob_start_task() using scoped_guard(spinlock, &tlob_binding_lock), which
does not disable softirqs.

During monitor teardown, the RV framework's da_destroy_storage() frees the
monitor record via call_rcu(). The RCU callback executes in RCU_SOFTIRQ
context and invokes tlob_extra_cleanup(), which calls
tlob_detach_from_binding() and acquires the same lock.

If a process holding the lock is interrupted by the RCU softirq on the same
CPU, the softirq will deadlock attempting to acquire it. Should
tlob_binding_lock be acquired using spin_lock_bh() in all process-context
paths?

[ ... ]
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +				       enum states curr_state,
> +				       enum events event,
> +				       enum states next_state,
> +				       u64 time_ns)
> +{
> +	struct tlob_record *rec =3D ha_get_target(ha_mon);
> +
> +	if (next_state =3D=3D stopped_tlob)
> +		return;
> +
> +	if (next_state >=3D state_max_tlob) {
> +		ha_cancel_timer(ha_mon);
> +		return;
> +	}
> +
> +	if (event !=3D start_tlob) {
> +		/* A sched event racing the window end must not re-arm. */
> +		if (atomic_read_acquire(&rec->state) !=3D TLOB_OPEN)
> +			return;
> +		ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> +				  BUDGET_NS(ha_mon), time_ns);
> +		return;
> +	}
> +
> +	ha_reset_clk_ns(ha_mon, clk_elapsed_tlob, time_ns);
> +	ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> +			  time_ns);
> +	/* Reopen only a closed record; a teardown claim keeps it closed. */
> +	atomic_cmpxchg_release(&rec->state, TLOB_CLOSED, TLOB_OPEN);
> +}

[Severity: Critical]
Can this sequence allow a use-after-free of the hrtimer?

There appears to be a race between the state check and arming the timer.
A teardown path can concurrently claim the record by setting its state to
TLOB_RETIRED, cancel the timer, and queue the record for freeing via
call_rcu().

If the teardown occurs between ha_setup_invariants() checking the state and
calling ha_start_timer_ns(), the timer will be freshly re-armed on a record
that has already been queued for destruction.

Even in the start_tlob path, ha_start_timer_ns() is called unconditionally
before atomic_cmpxchg_release(). If the cmpxchg fails because of a
concurrent teardown, the armed timer is never rolled back.

Once the RCU grace period elapses, the record is freed. The still-armed
timer remains on the hrtimer rbtree, leading to a use-after-free when it
expires.

[ ... ]
> +static void tlob_stop_task(struct task_struct *task,
> +			   struct tlob_uprobe_binding *binding)
> +{
> +	struct ha_monitor *ha_mon;
> +	struct tlob_record *rec;
> +
> +	scoped_guard(rcu) {
> +		ha_mon =3D ha_get_monitor(task->pid, NULL);
> +		if (!ha_mon)
> +			return;
> +
> +		rec =3D ha_get_target(ha_mon);
> +		if (WARN_ON_ONCE(!rec))
> +			return;
> +
> +		/* Only the opener may end it; NULL (task exit) skips. */
> +		if (binding && READ_ONCE(rec->binding) !=3D binding)
> +			return;
> +
> +		/* Claim the window end; the timer may have taken it first. */
> +		if (atomic_cmpxchg_release(&rec->state, TLOB_OPEN,
> +					   TLOB_CLOSED) !=3D TLOB_OPEN)
> +			return;
> +
> +		ha_cancel_timer_sync(ha_mon);
> +	}
> +
> +	/* The DA returns to stopped; the record stays closed. */
> +	da_handle_event(task->pid, NULL, stop_tlob);
> +}

[Severity: Medium]
Will this result in an invalid state error if tlob_stop_task() races with
the timer callback?

tlob_stop_task() claims the window closure and then calls
ha_cancel_timer_sync(). If the hrtimer just expired and its callback is
running concurrently on another CPU, ha_cancel_timer_sync() spin-waits for
it to complete.

The generic timer callback will unconditionally emit a budget violation err=
or
and reset the automaton to stopped_tlob. After ha_cancel_timer_sync()
returns, tlob_stop_task() injects the stop_tlob event.

Since the automaton defines stop_tlob from the stopped_tlob state as
invalid, this causes the framework to incorrectly flag an invalid transition
despite tlob_stop_task() legitimately ending the window.

[ ... ]
> +static void tlob_destroy_claimed(struct tlob_record *rec)
> +{
> +	pid_t id =3D rec->id;
> +
> +	tlob_detach_from_binding(rec);
> +
> +	scoped_guard(rcu) {
> +		struct ha_monitor *ha_mon =3D ha_get_monitor(id, NULL);
> +
> +		if (!WARN_ON_ONCE(!ha_mon))
> +			da_monitor_reset(&ha_mon->da_mon);
> +	}
> +	da_destroy_storage(id);
> +
> +	/* Readers may still hold rec; the pool slot returns after a GP. */
> +	call_rcu(&rec->rcu, tlob_rec_return_cb);
> +}

[Severity: High]
Does this code corrupt the hash table list pointers?

da_monitor_ht is a global hash table without internal locking. The function
da_destroy_storage() uses hash_del_rcu(), which modifies hlist pointers and
requires the caller to hold a writer lock to serialize against concurrent
writers.

While tlob_start_task() acquires tlob_binding_lock to serialize additions,
tlob_destroy_claimed() and the error path of tlob_start_task() call
da_destroy_storage() without holding tlob_binding_lock or any other
bucket-level lock.

Concurrent task exits or unbind operations that map to the same hash bucket
could corrupt the hash table's linked list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D11
