Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB53603DF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748285; cv=none; b=hRGWzQDegtNru21xkB/RFhon5BiuXoKJZO8Vv21Xi9494kX+wY6UQNRKOikQsJp9KQEOzqdpPyVdTBgZo5Sx/aU2vi7cXOKSxfrnbYuKY62P6eCEHGu6NszTl7sxYm/FBzdIPGvmRTTZ4q6PWKH4cPebPnR3N589RexvvZW6O5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748285; c=relaxed/simple;
	bh=7di4N6BHKWNbEEME8l7rK7HDAh0MOoumdIO/inrPBfM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tovqu0g+bIIu+2VYHD3N4sbIx1bxijDktnauYpOGByjwfgI6jiYGpoCZC3Y+hu3r8U22Jj0CGaYbN0QTh3z+LhjYmUWwxber2DbZnE7i9kpAtuMzRXN4AW566skEmDUiQORpcXf9usoHcBGsPfa4rlork2NbXxm1TPqXB/bn7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWDjJTBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWDjJTBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67FA1F0089D;
	Sun, 11 Oct 2026 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748282;
	bh=hzyOm1ZlGNeivR8j1BwVkpv3QLr9HUZuWY/zNmsVwkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWDjJTBO8pU+1x4gPGUZEHA6A9iwJkF+s4fJVbs+hlPpC1Q0aKVyMUTeUuB2XXXgA
	 84Y95ApcXLfjEb8Fg6A5B315+a5I1dt+e8N/MBqoidQjEMz8sn1Prn1v3lzz/TtCAU
	 2pkrVL6Ascyt0XBRbxA4Mu/HCrWnn70g0SshRfCVL6hCbm9GILItpCM1aIeqzlX+0K
	 aBV7+TfXoZGCWCgzVD286TAWq4UuFsuevVMjtnYCP8m9VmUiKWHQNjemn7XQcpRCsp
	 s8vOlxVqR1BAM1/KmX8A3043z1uY6IZ747X/00OVh4kD85LYiE93wniOgOn10Tul84
	 hdt2EQsNeiL7g==
Message-ID: <sashiko-outbox-167422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/14] rv: Disarm HA timers on the storage free path
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <3d5a8a567f1c1921f725c31a780845ff23e5abb9.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <3d5a8a567f1c1921f725c31a780845ff23e5abb9.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:51:22 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rcu: missing rcu_barrier() on module unload causes kernel panic
- [Low] timers: teardown path uses timer_delete_sync() instead of timer_shu=
tdown_sync()
--

commit 659afa957e903e72b692e0af300f112338f0d03d
Author: Wen Yang <wen.yang@linux.dev>

    rv: Disarm HA timers on the storage free path
   =20
    This patch addresses a use-after-free issue where an HA timer can be qu=
eued
    on a storage object that is subsequently freed by kfree_rcu(). It adds a
    da_monitor_free_hook() callback just before the storage is freed to
    securely cancel the timer. To support this hook, kfree_rcu() is replaced
    with call_rcu() and a dedicated callback function.

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 6fc5ef8142aca..5d3468a7a12b7 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
[ ... ]
> @@ -543,6 +554,15 @@ static inline monitor_target da_get_target_by_id(da_=
id_type id)
>  	return mon_storage->target;
>  }
> =20
> +static void da_kfree_cb(struct rcu_head *head)
> +{
> +	struct da_monitor_storage *ms =3D
> +		container_of(head, struct da_monitor_storage, rcu);
> +
> +	da_monitor_free_hook(&ms->rv.da_mon);
> +	kfree(ms);
> +}
> +
>  /*
>   * da_destroy_storage - destroy the per-object storage
>   *
> @@ -564,7 +584,7 @@ static inline void da_destroy_storage(da_id_type id)
>  		return;
>  	da_monitor_reset_hook(&mon_storage->rv.da_mon);
>  	hash_del_rcu(&mon_storage->node);
> -	kfree_rcu(mon_storage, rcu);
> +	call_rcu(&mon_storage->rcu, da_kfree_cb);
>  }
> =20
>  static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
> @@ -607,6 +627,7 @@ static inline void da_monitor_destroy(void)
>  	 * pending, we can safely assume no concurrent user.
>  	 */
>  	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
> +		da_monitor_free_hook(&mon_storage->rv.da_mon);
>  		hash_del_rcu(&mon_storage->node);
>  		kfree(mon_storage);
>  	}

[Severity: High]
Can this code cause a kernel panic on module unload if a dynamically
monitored object was destroyed right before?

Since da_kfree_cb() is defined as a static function in da_monitor.h, it
will be compiled directly into the loadable monitor module's text segment.
If da_destroy_storage() calls call_rcu() just before the module is
unloaded, the RCU core could attempt to execute da_kfree_cb() after the
module's text has been unmapped, causing an instruction page fault.

Should da_monitor_destroy() call rcu_barrier() to wait for these
callbacks before the module unloads?

I noticed follow-up patches in the series add rcu_barrier() for the
pool allocation strategy, but the default auto allocation strategy seems
to be left vulnerable.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 499ce60779f9c..99b60d0d26b6d 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
[ ... ]
> @@ -467,8 +470,15 @@ static inline bool ha_cancel_timer(struct ha_monitor=
 *ha_mon)
>  {
>  	return timer_delete(&ha_mon->timer);
>  }
> +/* timer_setup() sets it; the cancel paths here never clear it. */
> +static inline bool ha_timer_ready(struct ha_monitor *ha_mon)
> +{
> +	return READ_ONCE(ha_mon->timer.function);
> +}
>  static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
>  {
> +	if (!ha_timer_ready(ha_mon))
> +		return;
>  	timer_delete_sync(&ha_mon->timer);

[Severity: Low]
Since this is the teardown path prior to freeing the storage object, should
this be timer_shutdown_sync() instead?

The kernel timer subsystem guidelines mandate the use of
timer_shutdown_sync() for teardown paths because it permanently prevents
the timer from being re-armed. While concurrent RCU readers cannot reach
the object at this point, using timer_delete_sync() for teardown is a
documented anti-pattern.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D4
