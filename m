Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8523BCF7
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748452; cv=none; b=EwAYw3vQh5DFTOMqHwM5kqrVgTXLxvM11CpqxOX99Pbjlvu+jzbOfzUJ3LUSReTyi5uTeJAHOxfH/jy9emYShCq0QF4h9GpGuyDq4rjZRoaP85OGeaw68ooeDfDV8HPTbaZRzkxe/w6I6cLNIb4q6A5DVc27s8feD7OZDvecH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748452; c=relaxed/simple;
	bh=hxsJjr3l7jmvtiBAhcN4OuiLwJD+b1Yt4Le7a00xNaw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=M38Y4wiMhXr7H14waCXrhFbQoUFl4jTjVB5EDRyWC33dgTfOh3YOoKm9M1gJWeclreKgYrRXOZiG8F/xCoVPbL0zL5eqrqGHc9AbBLaJCgdqmz0FW2NrKSEJOefBO7DeHz8pBDTS2cNYy9QgmAWzBdS+ry+zAVpYXS53/tZ7+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOVeGuPD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOVeGuPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB71F0089B;
	Sun, 11 Oct 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748450;
	bh=3XU2Hdv+tKHr6lusqEK+5hXImuiQfHxsG/WV0zdHarM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOVeGuPDwrAZfqV+9Jka0UtbkBZk3GvRhOg1aJyb6kmlcHxmByiDvtZr9BBjzap3/
	 YznUmwgP5b7LWGpuUzclQdB9KYjC7FMkvIGtHl9uW1+1Dqvf0xbCTgS4S136obCUIm
	 7JLuiTe2G821uyXxhcNPac+lx2uDjgwBf34p0r1qq/Av44kJDP0sCEl7cZXY4rvuZ3
	 PCezZVqLz97rTWYt+keBSHkRfYohlV0v9vbjwcZ7gp9Skl3fw5STbJnpqBx1cPbK0H
	 DvgFDlGehhOtPY1uOEBdFJaLQXO3e0XNTza5lgwSkiczMv04visW20gv1ImE+RxVSY
	 92APHLr18hkcg==
Message-ID: <sashiko-outbox-167428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/14] rv: Add per-object teardown hook
 da_extra_cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <68b2e41332eb12ebcd07383402ca6cac1a83b429.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <68b2e41332eb12ebcd07383402ca6cac1a83b429.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rv: missing rcu_barrier() for non-pool allocations causes UAF on m=
odule unload
--

commit f8013d6f70621f02511ed8a820d487338e72eed7
Author: Wen Yang <wen.yang@linux.dev>

rv: Add per-object teardown hook da_extra_cleanup

da_monitor_destroy() frees each per-object storage, but a monitor
whose target is allocated separately has no point to free it: the
target is still reachable from the storage until hash_del_rcu().
Add an optional da_extra_cleanup() hook, called for each storage after
da_monitor_free_hook() has disarmed its timer and before the storage is
unlinked. It defaults to a no-op. tlob, added later in this series,
uses it to retire and free its per-window record.

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 7d1026e9edbc6..04caaf529034b 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h

[ ... ]

> @@ -715,7 +725,9 @@ static inline void da_monitor_destroy(void)
>  	 * pending, we can safely assume no concurrent user.
>  	 */
>  	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
> +		/* Before da_extra_cleanup(): it frees what the timer reads. */
>  		da_monitor_free_hook(&mon_storage->rv.da_mon);
> +		da_extra_cleanup(&mon_storage->rv.da_mon);
>  		hash_del_rcu(&mon_storage->node);
>  		if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL)
>  			mempool_free(mon_storage, &da_monitor_pool);

[Severity: High]
Does this missing rcu_barrier() for non-pool allocations cause a use-after-=
free
on module unload?

Further down in da_monitor_destroy(), rcu_barrier() is only called for
DA_ALLOC_POOL allocations:

include/rv/da_monitor.h:da_monitor_destroy() {
	...
	if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL) {
		rcu_barrier();
		mempool_exit(&da_monitor_pool);
	}
}

When a monitor using DA_ALLOC_AUTO or DA_ALLOC_MANUAL is active and an event
calls da_destroy_storage(), it queues the da_kfree_cb() callback:

include/rv/da_monitor.h:da_destroy_storage() {
	...
	if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL)
		call_rcu(&mon_storage->rcu, da_pool_return_cb);
	else
		call_rcu(&mon_storage->rcu, da_kfree_cb);
}

Because da_kfree_cb() is a static function in this header, its code resides
in the loadable module of the specific monitor.

If the user unloads the monitor module immediately after a monitored object=
 is
destroyed, da_monitor_destroy() is called during the module exit path. Since
there is no rcu_barrier() for non-pool allocations, the module's text segme=
nt
is unmapped while da_kfree_cb() is still pending in the RCU queues.

This leads to a kernel panic when the RCU core attempts to execute the unma=
pped
callback.

Should the rcu_barrier() be called unconditionally so that all pending
RCU callbacks finish executing before the module exits and its memory is
unmapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D8
