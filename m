Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515864;
	b=ccjRB7aLDAHo62hNc6uADAYx9ZPqNWTsL3kfbWENIfmgtTJzYttBcPIsSQsO4La637fa
	 /AqkY0C7tN9dFUyoytRFrapJtWeFOpacsi8iaA6IA5NmzcRgcSZwoIj5IHtP81UaMOhoK
	 30yDU+/4m3IaKQEm1RO8k/x/hf/rSAk3OiJRZMzh+iFGgpAQzjTAFWjc8aDQxpRN/WakL
	 UvY7K1LuSXoXu1ccYm1qM/q6yKajlUp1h0wBfusN5xAuf6JckZpGN2E/YM+EYevi8IQ7l
	 hc84P8NLlmLKTAvrLGBvLDoT+HoyQR4cljHC0mIkN6k4d3MhLKg71kF3rs1Lmtle0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KtLiidr5VBC14PgQKVf13G9N3QIxkXRWFwpONObXDvg=;
	b=3ebMbQPBTRRrdJMjN8HVe5f16n3w3BR7WPpPhyVEK7bKNHpgUSSR2qAEKMSUrwZqoR22
	 rZaw/fJQvZx1Kwu/AngfJr7BHVEyF9dcBdwKvWmERa/qL912giWOZRZL9RgQsmxggVELY
	 hBAv0aC6jnsayUupbkcYWV1yBdWBqpmVWxqZInbpqJwwb77jT0jYb7AT2GUAhWmMMY6Wn
	 7RS6DU382eEYTXOJ8eWtgHEh0NW8fd6QBHwC3hPxT3Ph8BpoJcjOGzmV/x8S01vdEs9K9
	 Zrzgf7qLwSXwH49tN9w/Tw0r2lzWpIr4GxMmFzDFos0g5mh+7aDqAOcqh+b7gMW2Zfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnvEyjYh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C5606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnvEyjYh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F4E1F000C4;
	Thu, 12 Nov 2026 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515864;
	bh=KtLiidr5VBC14PgQKVf13G9N3QIxkXRWFwpONObXDvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnvEyjYhH510uW4MKIXNvaU9dtuncx+lTjfCm23DYoH31UutWiVa9ZhdpjrV5z5vo
	 dHGoIUBMA4kJXoUrZV5aZXd/PhZtx9t7lI7AihbAdB17YJxlIrQWlNTq+8MUiTDIOw
	 PYluf7eiiCWUyZGZw/Wh8pBO1c9gBQXzszi2yiZjIiWnPPb5MSiWWsNnEaNkkjqO9o
	 uST0GOo0T78AJn4whWqdrOqFljsJHbUbBpyqhkhPl4Sk0Cj7o2bdeUwl4iFE8yGMUp
	 H/m3+EksQSs1UGP03oOa2L/s62YS8R015WDnFaAtecubtZd+VhqASudwmm2N5NfwxX
	 n8UrRz0AdqshQ==
Message-ID: <sashiko-outbox-211801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v25 06/14] lib: percpu_counter_tree: add lazy tree
 activation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David Hildenbrand" <david@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Dennis Zhou" <dennis@kernel.org>, "Tejun
 Heo" <tj@kernel.org>, "Christoph Lameter" <cl@gentwo.org>, "Martin Liu" <liumartin@google.com>, "David
 Rientjes" <rientjes@google.com>, christian.koenig@amd.com, "Shakeel Butt" <shakeel.butt@linux.dev>, "SeongJae
 Park" <sj@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Sweet
 Tea Dorminy" <sweettea-kernel@dorminy.me>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "Wei Yang" <richard.weiyang@gmail.com>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Yu Zhao" <yuzhao@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Mateusz Guzik" <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Aboorva
 Devarajan" <aboorvad@linux.ibm.com>, "David Carlier" <devnexen@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Harry
 Yoo" <harry@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Kees Cook" <kees@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, linux-trace-kernel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Oleg Nesterov" <oleg@redhat.com>, "Alan Stern" <stern@rowland.harvard.edu>, "Andrea
 Parri" <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Hugh Dickins" <hughd@google.com>
In-Reply-To: <20261111203626.95838-7-mathieu.desnoyers@efficios.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
 <20261111203626.95838-7-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:37:41 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] lib: percpu_counter_tree_kunit: lazy_race_fn() serializes
  remote updates
--

commit 5130476e081ef221464be8ba2bb48a1905d08dcd
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

lib: percpu_counter_tree: add lazy tree activation

This commit adds lazy tree initialization and activation for hierarchical
per-CPU counters, along with KUnit and userspace tests.

> diff --git a/lib/tests/percpu_counter_tree_kunit.c b/lib/tests/percpu_cou=
nter_tree_kunit.c
> index 5774278ea1403..12bd5a4bbb459 100644
> --- a/lib/tests/percpu_counter_tree_kunit.c
> +++ b/lib/tests/percpu_counter_tree_kunit.c
> @@ -796,6 +798,225 @@ static void hpcc_test_saturated_compare(struct kuni=
t *test)

[ ... ]

> +static void lazy_race_fn(struct work_struct *work)
> +{
> +	struct lazy_race_work *w =3D container_of(work, struct lazy_race_work, =
work);
> +	struct lazy_race_shared *sh =3D w->sh;
> +	long sum =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < LAZY_RACE_NR_INC; i++) {
> +		long inc =3D (long)(get_random_u32() % 65) - 32;
> +
> +		if (i =3D=3D LAZY_RACE_NR_FIRST) {
> +			/* Fully ordered: the first updates are visible before the pause. */
> +			atomic_long_add_return(sum, &sh->first_sum);
> +			atomic_inc_return(&sh->paused);
> +			/* Pairs with the test's release of go. */
> +			while (!smp_load_acquire(&sh->go))
> +				cond_resched();
> +			if (!w->owner) {
> +				mutex_lock(&sh->activate_lock);
> +				if (percpu_counter_tree_activate_many(sh->c, 1, GFP_KERNEL) ||
> +				    !percpu_counter_tree_active(sh->c))
> +					atomic_inc(&sh->activate_errors);
> +				mutex_unlock(&sh->activate_lock);
> +			}
> +		}
> +		if (w->owner)
> +			percpu_counter_tree_add_owner(sh->c, inc);
> +		else
> +			percpu_counter_tree_add(sh->c, inc);

[Severity: Medium]
Does acquiring sh->activate_lock in every non-owner worker right after
sh->go becomes true prevent percpu_counter_tree_add() from ever racing
with percpu_counter_tree_activate_many()?

Because both the main test thread and all non-owner workers serialize on
sh->activate_lock immediately upon release, the first caller to take the
mutex finishes activating and publishing the tree while the remaining
non-owner workers wait on the mutex.  None of the non-owner workers can
reach percpu_counter_tree_add() until activation is already complete, so
only the owner worker's percpu_counter_tree_add_owner() calls actually
race with tree publication.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203626.9583=
8-1-mathieu.desnoyers@efficios.com?part=3D6
