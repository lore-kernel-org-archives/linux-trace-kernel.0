Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732878;
	b=5ecvyVP36kDvDP9w3BZjBYfRbIKenwgU9Df5x5U/H7taBEXzwZUGwuMzpghNNs6MMRxM
	 luQP0OYlTm965Ayl0b/G418h3q8VnKChqScxT7iCMPtv4hc5sK88LNpAT/VuNCQ9eeVUx
	 CH1nBI8XpcDromB4CqCPG5aNXdNWQu+v+ynkaWc0Q19/BE05MxQR2VBVOYdpUstw77SWu
	 ZHbUShlwmc0NW6QDgr3TLVgPTg3x4vJsivYrWSjfPz3Rf5sPe4m++blDXMFqRWO2TEW0N
	 4L6YaJ/0WqHqKdHwEabQmjRLDF4vWcucORB/cG1f6FPTF6Lwc5Y+vR+/dYlO4kfOTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lmbd2zINdcFJEsKttels94/lSvSKbYVRhf8W4gVvI0M=;
	b=ChjBvLc2PTs6d64A/gnXzHx1RRARBLb6+Yz07yfR1YAy5yEpRo967qD75ILn7WM2QPss
	 zDhSjXMn/jHzYe2+pMR9pnaXJBC2+mwyUpvbHfNjmxWln7XmlKopygZb5lgAUSyZAJPYD
	 oFGWMz5/Hgh3rmSf5oRGRcAztW+rcayjlunMgvYF76twtzxCNmmkRoRoOg/8WZD84AQxc
	 qyH4YvZ2tw6Ys3azpRJFVj3zHO3U082c5eaOyFCZu1RLDSbG1jUldd1WC1f4wHt081/Yk
	 OXPHr8znA1yQFftOjG1XbZP5rDeExmQq1gJ5xhy2nfy5LYYAr2qN3jesJeazAWGfd+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1PUiHki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF7606A331
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1PUiHki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB51F0093A;
	Tue,  3 Nov 2026 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732878;
	bh=Lmbd2zINdcFJEsKttels94/lSvSKbYVRhf8W4gVvI0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1PUiHkiuD66i9itoKJxIYkyzDAK6zu7VDkvdc50PUOnlxFunr5pBcD4FVxjXxouL
	 Z1dp8U35zueBMTTlphtnvBi4Tor463tYtZAlB6LT+rv+XG3Lk10OfxOquRMwLrW/Ow
	 /IhV6pS8GAteyqGLnAhMTlPFZusubLD8OKs+US5UJU/lXR40VtEzHa5PVr+3kXFScn
	 3xN6T+iBY9fB57SaRPL+JYtkcrJJ06HYsTfAMEqWtRl0fFIewzAdlZGyv8euY4Xe/g
	 FN3RLZRvJs0RYzFrB2ItlFrIIHo3E99ldcv/h8xio85KHzdFAjHOdSM1sdFrWCTDBy
	 y7fMmb812dzdA==
Message-ID: <sashiko-outbox-195892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v23 10/10] lib: add a benchmark of hierarchical
 per-cpu counters
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
 Devarajan" <aboorvad@linux.ibm.com>, "David Carlier" <devnexen@gmail.com>, "Josh
 Law" <objecting@objecting.org>, "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Kees Cook" <kees@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, linux-trace-kernel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Oleg Nesterov" <oleg@redhat.com>
In-Reply-To: <20261102190708.1287100-11-mathieu.desnoyers@efficios.com>
References: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
 <20261102190708.1287100-11-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:07:55 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] lib: stack-allocated percpu_counter in bench triggers debugobjec=
ts WARN_ON
- [Low] lib: missing kernel-parameters.txt entry for percpu_counter_tree_be=
nch.batch
--

commit a1a6611650e4e4f4d5279cc3d46fb8ab12ea614c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

lib: add a benchmark of hierarchical per-cpu counters

This commit adds a KUnit benchmark comparing hierarchical per-CPU counters
with struct percpu_counter across update, lifecycle, and churn workloads.
It introduces CONFIG_PERCPU_COUNTER_TREE_BENCH and the batch module
parameter to configure the hierarchical counter batch size.

> diff --git a/lib/tests/percpu_counter_tree_bench.c b/lib/tests/percpu_cou=
nter_tree_bench.c
> new file mode 100644
> index 0000000000000..bf260bef196a5
> --- /dev/null
> +++ b/lib/tests/percpu_counter_tree_bench.c

[ ... ]

> +/* Like the RSS counters by default. */
> +static unsigned int batch =3D 32;
> +module_param(batch, uint, 0444);
> +MODULE_PARM_DESC(batch, "Batch size of the hierarchical counters (power =
of 2, 2 to 128)");

[Severity: Low]
Should percpu_counter_tree_bench.batch=3D also be documented in
Documentation/admin-guide/kernel-parameters.txt?

Both the commit message and the CONFIG_PERCPU_COUNTER_TREE_BENCH help text =
in
lib/Kconfig advertise passing percpu_counter_tree_bench.batch=3D on the ker=
nel
command line alongside percpu_counter_tree.arity=3D, which is documented th=
ere.

[ ... ]

> +static int bench_lifecycle_fn(void *data)
> +{
> +	struct bench_thread *t =3D data;
> +	struct percpu_counter_tree c[LIFECYCLE_NR];
> +	struct percpu_counter pc[LIFECYCLE_NR];
> +	u64 t0;
> +	int i;
> +
> +	if (bench_wait_go(t->sh))
> +		return 0;
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; t->sh->impl =3D=3D IMPL_PERCPU_COUNTER && i < LIFECYCLE_I=
TER; i++) {
> +		if (percpu_counter_init_many(pc, 0, GFP_KERNEL, LIFECYCLE_NR))
> +			break;
> +		percpu_counter_add(&pc[0], 1);
> +		percpu_counter_add(&pc[0], -1);
> +		percpu_counter_destroy_many(pc, LIFECYCLE_NR);
> +		cond_resched();
> +	}

[ ... ]

> +static int bench_churn_fn(void *data)
> +{
> +	struct bench_thread *t =3D data;
> +	unsigned int pin_period =3D t->sh->pin_period;
> +	struct percpu_counter_tree tmp[LIFECYCLE_NR], *c;
> +	struct percpu_counter tmp_pc[LIFECYCLE_NR], *pc;
> +	u64 t0;
> +	int i;
> +
> +	if (bench_wait_go(t->sh))
> +		return 0;
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; t->sh->impl =3D=3D IMPL_PERCPU_COUNTER && i < CHURN_ITER;=
 i++) {
> +		bool pin =3D pin_period && !(i % pin_period);
> +
> +		pc =3D pin ? &t->pinned_pc[t->nr_pinned * LIFECYCLE_NR] : tmp_pc;
> +		if (percpu_counter_init_many(pc, 0, GFP_KERNEL, LIFECYCLE_NR))
> +			break;

[Severity: Medium]
Will passing stack-allocated struct percpu_counter arrays (pc in
bench_lifecycle_fn() and tmp_pc in bench_churn_fn()) to
percpu_counter_init_many() trigger a debugobjects WARN_ON(1) when
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is enabled?

The call chain is:

  percpu_counter_init_many()
    __percpu_counter_init_many()
      debug_percpu_counter_activate()
        debug_object_init()
          __debug_object_init(..., onstack =3D 0)
            lookup_object_or_alloc()
              debug_object_is_on_stack()

Because debug_object_init() is called with onstack =3D 0 while pc and tmp_pc
reside on the kthread stack, debug_object_is_on_stack() will warn that a
non-onstack object is on the stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102190708.1287=
100-1-mathieu.desnoyers@efficios.com?part=3D10
