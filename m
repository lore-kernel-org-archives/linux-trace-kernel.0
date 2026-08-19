Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7F3C1F45
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164214; cv=none; b=HqDK26tuOM0lwfz6YH1wtadqbJs8uUvucZFk4EXLPJuobzoS+WzOBrlbJ+zKeOVF/iacRn05Ardjv8D7LgRNadePKtgOif8xxHH1wfM7wuhluUr7Tih2Q4yi2hZEVIC3xCaFU3uz+g/uzpX7+AvHAPMlTnpO3IKNpQPrR0GQdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164214; c=relaxed/simple;
	bh=17sxEN0ZcB4b7i65rwGIvqItKc0jmkNSIfbpd30wAOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdDwl3udEdAyopFGyukeyTgdde/Of4yMTu3B8oYt+OG2n9+q8F0I2ETpD1/NfeRPfGARQT3TrdqhiRg5RcEG6mb0Q3gYd4Mo7VIv7WwKe2+60hbpAolEvGHLx4B63nbHaFw88sNzJkmGR3K05m+BDZgoup30WATTW10ZKVCQ1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIPVmygl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIPVmygl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F881F000E9;
	Wed, 19 Aug 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164212;
	bh=QVidbXbcXH6f6yzSS8txw9/aAMpZl2vTUBYVIiUzNtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lIPVmyglHtdszyjCo8B2zARBZP0HCyRHsIz6APKoHMdKiMuLcD3g90NqR4gZRU9OK
	 LmKL9R89dQ7zkJqUqR0cUhhtNo1/036yTA5TiaR2TECBQAUicGQZqhWUM3puN9/DTU
	 nlSCl9kQgNyfFM5gF8DMrbRzYUAOy9RQ76iwTnDEGpaSdJQb12ZDER49LueYEQyS7m
	 Gtom6EW9BnpZjgmsujs5sEYzSkBVi4T6Cb/8+EkAJIkULOa8jXQvWjXTjLzmZNBd4G
	 bRVOCcy/pROslLKl0nP3H0XtNZSjOyntTzWaExnz0NIpssjGWZrF/ajl+yUbPXYVoI
	 lX5q0fX40oL0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] rv: Make da_monitor_reset_hook and
 EVENT_NONE_LBL overridable
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <93c62b568c392352cb0a507c85f49c46cd49fbe0.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <93c62b568c392352cb0a507c85f49c46cd49fbe0.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:30:12 +0000
Message-Id: <20260819183012.C7F881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Overriding `da_monitor_reset_hook` to synchronously cancel timers =
deadlocks the system
- [Medium] Undocumented API change allowing `da_monitor_sync_hook` to be ov=
erridden

Pre-existing issues:
- [High] Monitor teardown sequence causes a Use-After-Free due to improper =
timer cancellation
- [High] Lockless update of discrete state and hybrid environment variables=
 allows concurrent events to evaluate inconsistent state
--

--- Patch [5]: [PATCH v5 5/9] rv: Make da_monitor_reset_hook and EVENT_NONE=
_LBL overridable ---
commit 367db4a7d614e2458fbdde565ff9b9fc8d92d1b1
Author: Wen Yang <wen.yang@linux.dev>

rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable

This commit wraps da_monitor_reset_hook and EVENT_NONE_LBL with #ifndef gua=
rds
to allow HA-based monitors to substitute their own implementations. It is
intended to help tools define custom reset hooks for per-task hrtimer clean=
up.

> rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
>=20
> Wrap both definitions with #ifndef guards so HA-based monitors can
> substitute their own implementations before including this header.

[Severity: Medium]
The commit message mentions wrapping both definitions (da_monitor_reset_hook
and EVENT_NONE_LBL), but the patch also silently wraps a third definition:
da_monitor_sync_hook(). Could the commit message be updated to reflect this
additional API change, or was this change unintentional?

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index e1738d199b289..807b981eb548a 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -36,8 +36,14 @@ static bool ha_monitor_handle_constraint(struct da_mon=
itor *da_mon,
>  					 da_id_type id);
>  #define da_monitor_event_hook ha_monitor_handle_constraint

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent events evalua=
te
inconsistent states here?

Looking at the event processing sequence, da_event() in
include/rv/da_monitor.h updates the monitor's discrete state using a lockle=
ss
try_cmpxchg() loop. Only after the state is successfully updated does it ca=
ll
da_monitor_event_hook(), which resolves to ha_monitor_handle_constraint(),
to update the environment variables.

Could a concurrent event on another CPU observe the newly updated discrete
state but still see the stale environment variables before the first CPU
finishes updating them?

>  #define da_monitor_init_hook ha_monitor_init_env
> +
> +/* Overrides must still call ha_monitor_reset_env() or cancel the timer.=
 */
> +#ifndef da_monitor_reset_hook
>  #define da_monitor_reset_hook ha_monitor_reset_env
> +#endif

[Severity: High]
Could following the documentation to cancel the timer here cause a deadlock?

If a developer overrides this hook to synchronously cancel their timers (su=
ch
as using hrtimer_cancel() or timer_delete_sync()), it appears this will
deadlock when called from the timer callback itself.

The timer callback __ha_monitor_timer_callback() calls da_monitor_reset(),
which unconditionally invokes da_monitor_reset_hook(). Would this result in
the timer callback attempting to synchronously cancel itself?


[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free ri=
sk
during monitor teardown due to improper timer cancellation?

When a per-object monitor is destroyed, da_destroy_storage() cancels timers
without waiting (using hrtimer_try_to_cancel() or timer_delete() via
ha_cancel_timer()) and then defers freeing the storage using call_rcu() or
kfree_rcu().

The timer callback __ha_monitor_timer_callback() relies on guard(rcu)() for
synchronization. However, if the timer callback thread is preempted before =
it
enters the RCU read-side critical section, the grace period could complete =
and
the monitor storage could be freed.

When the timer callback resumes, would it then dereference the freed monitor
pointer?

> +#ifndef da_monitor_sync_hook
>  #define da_monitor_sync_hook() synchronize_rcu()
> +#endif

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D5
