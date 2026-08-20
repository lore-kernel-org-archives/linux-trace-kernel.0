Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0747DD42
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245163; cv=none; b=cEmLorCzZvbVOxEVSIwN82geVmZWlNIxbaimXUU4iBUqd8pMPjeytJsk3fQjc0bRZtKlXYdBsODiYAqqeJdxZ+sik1AsjzNPA8kueUYy3bektGUSXxnWd2x1vgyXaUePsajFvvfYvicoLCwpg2WMh5qwMAqWEu9UUwGIksozDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245163; c=relaxed/simple;
	bh=nhPohUFGEvBRa0lDjAiEr6DLQoBHOg7MU8t9AU2gxTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlkhTseCFx81757BxnjvuAXaQoL8kD9TTnXCdH+zpj/HzriaeM4d7k2Obg99F+B1Wk27yLFgz8dmxkdk7VJuuVnMv0bnrZfrq07/N//1aEnrgMv+8OBWEIpqMNbLBReggN3nK3fWzpmGLPAvoqmaC4+xpCEaKATyWvZDuwODufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYwlWzJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYwlWzJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C1E1F000E9;
	Thu, 20 Aug 2026 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245161;
	bh=Ova75fkAJZhnAQliHPRmupzMeLADyml68aZ6bkH2UqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYwlWzJL7J3tJvFcp5x+Ng1sAiBqRbiDYWTuV/aSIBcEwOSPjQMgmRppiMupjd2iO
	 hGDAmouijpgrT51neD5ve750m3/SJ4ZwqtqT3TinCob7KOHFXWwuV0qoCS5aYFDsx2
	 V9lwrxGFyb29D6S6pe/1bCvrxocV3W5x3vqqyl6NpgLzqcFFfh8iVayvzVsirPheWE
	 Bnhr6kiRbejqVk/P3UG//DbAQoPLBVsx8G0/2e8Qdo2NshqCgGzlx0/SvGRTtS+p0K
	 UYcEQ7ukCkUwavVISZVJ9yVIgQ40QiQzZocE2A87aqcHCCkHrPC5HQ3hbvUA9s8HRL
	 hRM7p9P5cfZRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] rv: Make da_monitor_reset_hook and
 EVENT_NONE_LBL overridable
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <1e8c3b3b8bb6bc3243eb6e4f2bfd3a61dd41cc35.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <1e8c3b3b8bb6bc3243eb6e4f2bfd3a61dd41cc35.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:59:21 +0000
Message-Id: <20260820165921.66C1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-synchronous timer cancellation combined with `synchronize_rcu(=
)` or `kfree_rcu()` leads to a Use-After-Free during monitor teardown.
--

--- Patch [5]: [PATCH v6 5/9] rv: Make da_monitor_reset_hook and EVENT_NONE=
_LBL overridable ---
commit 693c5f5465506e090a4b8b44d5e3c72769ec0685
Author: Wen Yang <wen.yang@linux.dev>

rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable

This commit wraps da_monitor_reset_hook and EVENT_NONE_LBL with ifndef guar=
ds
to allow HA-based monitors to provide their own implementations. It enables
monitors like tlob to define custom reset hooks for tasks such as cancelling
per-task hrtimers.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index e1738d199b289..807b981eb548a 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -36,8 +36,14 @@ static bool ha_monitor_handle_constraint(struct da_mon=
itor *da_mon,
>  					 da_id_type id);
>  #define da_monitor_event_hook ha_monitor_handle_constraint
>  #define da_monitor_init_hook ha_monitor_init_env
> +
> +/* Overrides must still call ha_monitor_reset_env() or cancel the timer.=
 */
> +#ifndef da_monitor_reset_hook
>  #define da_monitor_reset_hook ha_monitor_reset_env
> +#endif
> +#ifndef da_monitor_sync_hook
>  #define da_monitor_sync_hook() synchronize_rcu()
> +#endif

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to rely on
synchronize_rcu() to wait for cancelled timers during monitor teardown?

Looking at the global teardown path:

include/rv/da_monitor.h:da_monitor_destroy() {
    ...
    da_monitor_reset_all();
    da_monitor_sync_hook();
    ...
}

And per-object teardown:

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

Both paths cancel timers non-synchronously in ha_monitor_reset_env():

include/rv/ha_monitor.h:ha_monitor_reset_env() {
    ...
    ha_cancel_timer(ha_mon);
    ...
}

They then rely on RCU grace periods to wait for executing callbacks,
assuming the callbacks execute within an RCU read-side critical section:

include/rv/ha_monitor.h:__ha_monitor_timer_callback() {
    ...
    guard(rcu)();
    ...
}

If the timer callback is dispatched but preempted or delayed before
entering its RCU read-side critical section, synchronize_rcu() will not
wait for it. When the callback resumes, couldn't it access the freed
monitor storage and cause a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D5
