Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997459;
	b=jpGMm54FPQRkS74L6CYCVcKkIgqaq4iOuwnhA94fqvqbHtirVrQS/Z/wBQTnpwI3JhCF
	 sHiveJXT3Z/eeQGy1Sop3pKzh+pgxvEyKT1Os3u3a3cvZ1M4z7T9h6hZ5rqbRPy3vTGhK
	 J56WfdC72LFrGQk0y8leo8Mcx87G1B0f7sXPiJeMWDueLSQzgLILtyKISIqkbc5jErot9
	 voGm9K6bb4MJmu75BHM6OWSeHJ3kwShmcDxsxq6Pck+jtZvE8A/dOSUJJY4Gejl0u1hhm
	 594EAIoOxunZtr2BhPZ7XMb8vqvN04OWUpq0Zvo2kkj//OkKKVxwwb9YIXf0jX2r0EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BWYW9Jgrcl2gGnqyPsWBDQDSCZ0rVrf6t2LCxBUN6Ak=;
	b=tYCFfiU7uwwg9tX4YVmJ7WzDyHxWKQomjeqN9YR6AG/Y2rct/2u6RWOE3zHWACXobjlp
	 qam+nALyknkMSYXwsZjuBStGlgf3IAmxzDctf6glG8rAlP6zbZkeD7HTqocNAlkSk5oBS
	 YqeDxLMhZ6ITsG1t5UFL3CfOwSe/N7M7OKBTUqnfO8j+uIYiZ0uUZIBDByTjwmrnljSPh
	 8UamTct8/oj/EmAH2m+Ezzw9pRQrWjzKCLnJ190qaaKicM8+To0dNnZIb81ULfKeuU+PR
	 PRALr3/okw5OmkWzVfE4xhcclKCDDl6GpvWgxi8JxY6jOh4QAR81tEyUjMZlEVdgJXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP4yg95p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BF606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP4yg95p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65201F0089F;
	Fri,  6 Nov 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997458;
	bh=BWYW9Jgrcl2gGnqyPsWBDQDSCZ0rVrf6t2LCxBUN6Ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP4yg95pp77J9I3+9dIx6Id5Ggm8gNQIz2izKKVMHv0vw7kDx8VIfyKmqJHnmsCug
	 hBZ5jehsIN4zS1HxdMHTb2p08EmTIKk6z5HQjqEcu8vrBe6xOX1Cp5sD+z2AER2fTZ
	 Cm8aOaSbqLkt4mvsx6fnENUDZUfTfae+9fFcilrGWl3T1hFky87QuPueb+qv0P5iHW
	 Eco9wj6XjPSK5kqya9tZKw/Y6W4JDvHVqTOAW0xuqdpFBU+Lgf0Q3bDpIxI8ZWo1ES
	 CHrrTz8MyLffHaqT88/W/aqyuzDiephCvxHY3m/KUFs2FJikGqQ2oN2SVWF4CXZcTU
	 oOzvxVP2TAlJg==
Message-ID: <sashiko-outbox-202244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v24 06/10] lib: percpu_counter_tree: add lazy tree
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
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Kees Cook" <kees@kernel.org>, linux-trace-kernel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Oleg Nesterov" <oleg@redhat.com>
In-Reply-To: <20261105203639.1459524-7-mathieu.desnoyers@efficios.com>
References: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
 <20261105203639.1459524-7-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:37:36 +0000
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
- [Low] lib: percpu_counter_tree_kunit: missing release barrier on sh.go
--

commit badb1aea7bc81016992df61a32943f786fc44dcf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

lib: percpu_counter_tree: add lazy tree activation

This commit introduces lazy tree initialization and activation for
percpu_counter_tree so counters can remain exact without allocating per-CPU
or tree memory until activated. It also adds KUnit and userspace tests for
lazy counter updates and concurrent activation.

> diff --git a/lib/tests/percpu_counter_tree_kunit.c b/lib/tests/percpu_cou=
nter_tree_kunit.c
> index 5774278ea1403..156bb63de3466 100644
> --- a/lib/tests/percpu_counter_tree_kunit.c
> +++ b/lib/tests/percpu_counter_tree_kunit.c
> @@ -796,6 +798,220 @@ static void hpcc_test_saturated_compare(struct kuni=
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
> +			while (!READ_ONCE(sh->go))
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
> +		sum +=3D inc;
> +		if (!(i & 1023))
> +			cond_resched();
> +	}
> +	atomic_long_add(sum, &sh->expect);
> +	kfree(w);
> +	complete_work();
> +}
> +
> +static void hpcc_test_lazy_activation_race(struct kunit *test)
> +{
> +	struct percpu_counter_tree pct;
> +	int round;
> +
> +	if (num_online_cpus() < 2)
> +		kunit_skip(test, "needs at least 2 online CPUs");
> +	for (round =3D 0; round < 4; round++) {
> +		struct lazy_race_shared sh =3D { .c =3D &pct };
> +		unsigned long timeout =3D jiffies + 10 * HZ;
> +		int cpu, nr_workers =3D 0;
> +
> +		KUNIT_ASSERT_EQ(test, 0, percpu_counter_tree_init_many_lazy(&pct, 1, 3=
2));
> +		mutex_init(&sh.activate_lock);
> +		init_kthreads();
> +		cpus_read_lock();
> +		for_each_online_cpu(cpu) {
> +			struct lazy_race_work *w;
> +
> +			if (nr_workers > LAZY_RACE_MAX_REMOTE)
> +				break;
> +			w =3D kzalloc_obj(*w);
> +			KUNIT_EXPECT_NOT_NULL(test, w);
> +			if (!w)
> +				break;
> +			INIT_WORK(&w->work, lazy_race_fn);
> +			w->sh =3D &sh;
> +			/* The first worker is the owner, the others update remotely. */
> +			w->owner =3D !nr_workers;
> +			atomic_inc(&kernel_threads_to_run);
> +			queue_work_on(cpu, hpcc_test_wq, &w->work);
> +			nr_workers++;
> +		}
> +		cpus_read_unlock();
> +		while (atomic_read(&sh.paused) < nr_workers && time_before(jiffies, ti=
meout))
> +			usleep_range(100, 200);
> +		smp_mb();	/* Read the counter after the first updates of the workers. =
*/
> +		/* Every worker, the owner included, has updates left for after the ac=
tivation. */
> +		KUNIT_EXPECT_EQ(test, atomic_read(&sh.paused), nr_workers);
> +		/* Before activation, the owner and atomic updates are exact. */
> +		check_lazy_counter(test, &pct, atomic_long_read(&sh.first_sum));
> +		WRITE_ONCE(sh.go, true);

[Severity: Low]
In hpcc_test_lazy_activation_race(), can a weakly ordered CPU reorder the
relaxed WRITE_ONCE(sh.go, true) before the loads of pct.bias and
pct.atomic_bias inside check_lazy_counter()?

Before activation, pct.level0 is NULL, so
percpu_counter_tree_precise_sum_unbiased() returns early after
smp_load_acquire(&counter->level0) and atomic_long_read(&counter->atomic_bi=
as)
without issuing a barrier after reading atomic_bias and bias.

Once sh.go becomes true in lazy_race_fn(), the owner worker immediately cal=
ls
percpu_counter_tree_add_owner(sh->c, inc) without acquiring sh->activate_lo=
ck,
and remote workers proceed to activate and update sh->c.

Should sh.go be set with smp_store_release(&sh.go, true) (or preceded by
smp_mb()) so the pre-activation reads in check_lazy_counter() complete befo=
re
the paused workers resume modifying pct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105203639.1459=
524-1-mathieu.desnoyers@efficios.com?part=3D6
