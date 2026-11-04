Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760562;
	b=Nco//YRiAcs2wk2cKcfnSoTeI74KIkYl1KKdlHF21JVfvROKn7wp/PnywvNF33oFlGPc
	 Z0l4dQLV5vnnAbdB5Ck7JOEGqy42Rr6kkElOgOCZ3SJHs/j5uFCTFzGTmnS4TyQ/FVS7m
	 vnXLsy5HAZO9OOlQTN0op5yWR3u872s/e5eIPkrMftYGx8fpGud2vbE+w9ED25PUf11Bs
	 l+Jm+gdGXDZUrrhz5/tiOQxKYtwRi17789neBlY/BylIKVuYLA+NHn4svei5lFSDwRfft
	 AqxDCEINednSJYEIKElFKJItusQMJlyv61Rz4jpA6RdorKnFhuXKwtTziWlMW9OgLlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cGl7bC3fWAoAUhJbWEmSTM5Y06Elv8KWXkaBb9P48hA=;
	b=siXFu3VX/qvNyNNbx+uAcWZ7LuVskfCFriP49/DnmYSxt108WHegK1xayUWxzZ1unr8e
	 PpkaP+NN1NO7XNFo+CjctYrsc3ZQJsKOicGfRbw4e83iR5d38j3rvQNfioh4hjv2bdvLd
	 Ft1zaVfWV1DimiVVmxnZIqMxbMr2hRnmnxhwGe4zkRNrvWXDf3QYQ5n8K9joNr9ZqCEUg
	 0S4+u9kjCge6z4k6g02eVkbNj8qPSLjgI7qXs6eSGPnWO6lchqIaJ0129w6MsHP3632kr
	 Lvz5GgO8YYoiwZeOL15cQVLRypvXXMoINy3Zb9lnRi2y7swgehpQTqpte6YBTUeOINw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb96h4h0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3813606A31B;
	Wed,  4 Nov 2026 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb96h4h0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657D51F00919;
	Wed,  4 Nov 2026 02:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760561;
	bh=cGl7bC3fWAoAUhJbWEmSTM5Y06Elv8KWXkaBb9P48hA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jb96h4h0oM3x4HuMId9uj2LqKZoeAZgCuatFL0X+g/wCJ7W3yMOe0X+dGWF5LZ1Bh
	 RJgMrUz3AHHIUC+Z4+HAGKWnlgwAZ9sGm1hChg1XwsbZwTUL/TrZPNINyYw/XIX/ZG
	 G30TzK2SZ8L+TUdKRouOFuOavuK9HgEczJgXAsaU0LjsPd6BEZYiIs9ndCujj6YC3M
	 74rzfop9P769vcC6l+1fnC6yfgQwNV3B8wKFg0bvJLdTiJ6mZxinQL54u8rpdtn6et
	 ThQeKLK7GDRuz9JleE7CZdoIlyEP2yoD0Isb0vVwMAbdqEsQGFhpadeotBCvbBSezs
	 SepM0zq9kLE7w==
Message-ID: <sashiko-outbox-196525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/5] mm/show_mem: Avoid blocking on zone->lock
 during Oops or panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103024453.922373-3-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:19 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/show_mem: false lock contention warning in show_free_areas()
--

commit e1c6e11316c0b99b2f700b8251c5ed2b76aad84a
Author: Aaron Tomlin <atomlin@atomlin.com>

mm/show_mem: Avoid blocking on zone->lock during Oops or panic

This commit updates show_free_areas() in mm/show_mem.c to avoid uncondition=
ally calling spin_lock_irqsave() on zone->lock during Oops, panic, or NMI/a=
tomic contexts, skipping zones when acquiring the lock is unsafe or contend=
ed.

> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index b938cbcd774a1..77098077523a9 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -367,10 +367,17 @@ static void show_free_areas(unsigned int filter, co=
nst nodemask_t *nodemask,
>  			continue;
>  		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
>  			continue;
> -		show_node(zone);
> -		printk(KERN_CONT "%s: ", zone->name);
> =20
> -		spin_lock_irqsave(&zone->lock, flags);
> +		if (!can_spin_trylock() || in_nmi() ||
> +		    oops_in_progress || panic_in_progress()) {
> +			if (!can_spin_trylock() ||
> +			    !spin_trylock_irqsave(&zone->lock, flags)) {
> +				pr_warn("zone %s lock contended\n", zone->name);
> +				continue;
> +			}
> +		} else {
> +			spin_lock_irqsave(&zone->lock, flags);
> +		}

[Severity: Medium]
In show_free_areas(), when can_spin_trylock() returns false (such as in NMI=
 or
hardirq context under CONFIG_PREEMPT_RT, or in NMI context under !CONFIG_SM=
P):

mm/internal.h:can_spin_trylock() {
	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
		return false;

	/* On UP, spin_trylock() always succeeds even when it is locked */
	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
		return false;

	return true;
}

the inner !can_spin_trylock() check short-circuits before
spin_trylock_irqsave() is ever called, yet still prints "zone %s lock
contended" for every populated zone even when zone->lock is completely
uncontended.

The commit message also states:

  Check can_spin_trylock() and use spin_trylock_irqsave() when
  !can_spin_trylock(), in_nmi(), oops_in_progress, or panic_in_progress()
  is active

Additionally, because show_node(zone) is moved after spin_unlock_irqrestore=
()
below, skipping a zone here only logs zone->name (for example, Normal or
DMA32) without the NUMA node ID on CONFIG_NUMA systems.

Should the !can_spin_trylock() case avoid claiming that zone->lock is
contended (and match the commit message description), and should the skipped
zone message include the node ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D2
