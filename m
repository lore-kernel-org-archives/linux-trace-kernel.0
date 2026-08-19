Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8D3B813A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164371; cv=none; b=UmDiFCo8GOg0TT2Tgg5lX25FIJ00lR56IMCpK+3Q+D1xTbx/ALuZ5BTuyDpqRePIrS3w6ZHHJaO/f94pxsO72uFQ9QEBWNHHU5UAxADihKBgdPJwzDdXbgelM08TqZhTVNyqRzTaraarLEBtKZ6OVvQaRT9S+yqbH5KHyTbPUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164371; c=relaxed/simple;
	bh=cAD26kPfVijaSNUmpKyzZI+WzSrmnCI1JfsPw8hDmvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ytf2K1q9O+gnr43MU5rptTPwOr/FDcq7t77SiJmHZnS+am4nUOMbX3SASdsMojG7hKXh7sYPDprGRAsVtHKTXHnbZ92Ms6ZXXPNXC9mfbO41BSW6eS2a06dG2WFf9A3rIp+/7yW95OYuhMJcr+ClcrPLxpopt9xBEgmWZHOSUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxn1H08y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxn1H08y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB2B1F000E9;
	Wed, 19 Aug 2026 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164369;
	bh=BXmwVqtYHRJa05l7SVGTKMI7PapkO6mA+tAl9BB5RFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sxn1H08yI9LgOkBLcO7GWCxTu3s4L/NlBm8unjdRf+9fFO4zC0GY5J7t+9f1iglrb
	 a/H1lcvkbAqtHl59F03nSbFBUCU2JiT0T8N8HJbvlJ7Z62hLU0dj/1nTeZEoG+pS+y
	 f2e08xhfkP3spG/M41185YCw5qir83sVsktZiaC+ESzxoDrD69aQ93v7CYk7dzoL0u
	 0RrUENm46f7+GHFEvI1I0rsIZymQhQNNjAU0fyDi6oeyB0FI5C9Q3ViKLP1tW8O4I+
	 Nz5RpphFG1P5By+0fet2+kMz3kwoYsyVvBIWZl5yj4DXxVaRb0ytU+snM90z5WD3IH
	 rtyK4E7UJqWqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] rv: Fix ha_invariant_passed_ns silent bypass of
 invariant check
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <0cab75f11e598ffb0137209e009d02e5705dc127.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <0cab75f11e598ffb0137209e009d02e5705dc127.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:32:49 +0000
Message-Id: <20260819183249.CBB2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch unmasks a preexisting integer underflow bug in `ha_check=
_invariant_ns` that will falsely trigger invariant violations during early =
boot when `time_ns < expire_ns`.
- [High] Per-object monitor destruction frees storage via `kfree_rcu` while=
 background timers can still be executing, leading to Use-After-Free.
- [High] New monitor storage is published to the RCU hash table before its =
fields are fully initialized, exposing readers to NULL dereferences.
- [High] Lockless updates to the monitor's state and environment variables =
allow concurrent events to evaluate constraints against stale environment d=
ata.
- [High] An integer underflow in `ha_start_timer_ns()` and `ha_start_timer_=
jiffy()` silently masks invariant violations if the elapsed time exceeds th=
e expiration limit upon state entry.
--

--- Patch [4]: [PATCH v5 4/9] rv: Fix ha_invariant_passed_ns silent bypass =
of invariant check ---
commit d0917ae23deee9db8a74a56834fa74dbc75f6b60
Author: Wen Yang <wen.yang@linux.dev>

rv: Fix ha_invariant_passed_ns silent bypass of invariant check

When env_store is U64_MAX, ha_invariant_passed_ns() returns 0 immediately
without initializing env_store to the current clock. Subsequent calls find
env_store still at U64_MAX, causing the elapsed comparison to wrap and alwa=
ys
report the invariant as satisfied, silently masking any violations. This co=
mmit
fixes it by calling ha_reset_clk_ns() to establish the guard on the first
invocation.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 6e1c7fe5449a3..e1738d199b289 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -355,7 +355,7 @@ static inline u64 ha_invariant_passed_ns(struct ha_mo=
nitor *ha_mon, enum envs en
>  	if (env < 0 || env >=3D ENV_MAX_STORED)
>  		return 0;
>  	if (ha_monitor_env_invalid(ha_mon, env))
> -		return 0;
> +		ha_reset_clk_ns(ha_mon, env, time_ns);

[Severity: High]
This is a pre-existing issue, but does this subtraction underflow during ea=
rly
boot, which is now exposed by this initialization?

Looking at ha_check_invariant_ns():

include/rv/ha_monitor.h:ha_check_invariant_ns() {
    return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
}

If an ns-based monitor is started during early boot, time_ns can be smaller
than expire_ns, causing time_ns - expire_ns to underflow to a huge unsigned
value.

Since this patch now correctly initializes env_store to time_ns, the check
env_store >=3D huge_value will evaluate to false, spuriously failing the in=
variant
immediately.

>  	return ha_get_env(ha_mon, env, time_ns);
>  }
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this calculation underflow if the
timeout has already been violated?

Looking at ha_start_timer_ns() in include/rv/ha_monitor.h:

include/rv/ha_monitor.h:ha_start_timer_ns() {
    ...
	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);

	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
    ...
}

If passed > expire, the subtraction expire - passed underflows to a massive
value, which gets converted to a huge positive delay. Could this schedule t=
he
verification timer billions of years in the future instead of failing immed=
iately,
silently masking the violation?

This same pattern appears in ha_start_timer_jiffy():

include/rv/ha_monitor.h:ha_start_timer_jiffy() {
    ...
	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);

	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
			  jiffies_to_nsecs(expire - passed), time_ns);
    ...
}


[Severity: High]
This is a pre-existing issue, but can this sequence lead to a use-after-free
if a background timer is still executing?

Looking at da_destroy_storage() in include/rv/da_monitor.h:

include/rv/da_monitor.h:da_destroy_storage() {
    ...
	da_monitor_reset_hook(&mon_storage->rv.da_mon);
	hash_del_rcu(&mon_storage->node);
	if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL)
		call_rcu(&mon_storage->rcu, da_pool_return_cb);
	else
		kfree_rcu(mon_storage, rcu);
    ...
}

da_monitor_reset_hook() cancels the timer via non-synchronous timer_delete(=
) or
hrtimer_try_to_cancel(), then the storage is immediately queued for freeing=
 via
kfree_rcu().

If the timer callback (__ha_monitor_timer_callback) is preempted before it =
calls
guard(rcu)(), the RCU grace period could complete and free the memory. When=
 the
timer thread resumes, it reads the ha_mon_destroying flag from freed memory.


[Severity: High]
This is a pre-existing issue, but are new monitor objects published to the =
RCU
hash table before they are fully initialized?

Looking at da_create_empty_storage() and da_create_storage() in
include/rv/da_monitor.h:

include/rv/da_monitor.h:da_create_empty_storage() {
    ...
	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
	mon_storage->id =3D id;
	return mon_storage;
}

include/rv/da_monitor.h:da_create_storage() {
    ...
	mon_storage =3D da_create_empty_storage(id);
	if (!mon_storage)
		return NULL;

	mon_storage->target =3D target;
    ...
}

hash_add_rcu() makes the node visible to concurrent RCU readers before
mon_storage->id is assigned, and before mon_storage->target is populated in
da_create_storage(). Can a concurrent lookup find the node with a NULL targ=
et,
leading to a NULL pointer dereference in the caller?


[Severity: High]
This is a pre-existing issue, but can the state machine and environment gua=
rds
fall out of sync during concurrent events?

Looking at da_event() in include/rv/da_monitor.h:

include/rv/da_monitor.h:da_event() {
    ...
		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
				return false;
    ...
}

The new state is published locklessly via try_cmpxchg() before
da_monitor_event_hook() executes to update the environment variables.

For global monitors, if multiple CPUs execute da_event() concurrently, coul=
d CPU
2 observe the new state and process a subsequent event before CPU 1 finishes
updating the environment variables, causing CPU 2 to evaluate constraints u=
sing
stale clock values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D4
