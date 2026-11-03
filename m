Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732873;
	b=wSnUTE3tEQHmeKAydCDCD5iU2tswerW+qN/W8eLjdTEOuKwspnAuZlZvpDc2/x2Szpwi
	 6UhhbtsBwBQ5T16s+Ni++FKLFmUjfBKiUc+aWY+w95A/2RwWdGZ9uP7lNGOQsGJPYgiM4
	 TsDuHbj3Dq5fSX2s0Ch9XRmYzCUMn2knJCp4I2YszqWGb72waV0/kJ6W1xB3QljfLacCe
	 W9CQvn3UMDQVTFi5ylg5gXTcXmadmZunCwdNxynZ5PtnG/FE8Echgo61RZ6zanaVcVlzO
	 zgUFmmF2CnwaBgx/GcoeND8xdJHcPXvt1Xd/jr0fAaRZFKN541Sdko5VjiJg19PEX2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hj5sGf4zuQDzxKH9qB3EIUe2aXuw6LNNWfdi8I5hW/k=;
	b=040awTw9CARqaCzIZLS0PHECSSJbo/VJSVQwQtzN2MAK2+JtHLb5C2NI338gLprmYSV3
	 3jj21MekhzEk43aMY+TK920XKdnlrQdp7xQYKWQaC2Fz/P8WWBNwDDjTP7gHnqybxS0M6
	 e/B0dBCmptRkdkEmN0p9Kpu3kzNKWLkKtgIrud7v6PTmtEe48yYEZm11NGEvgVdmp7xtZ
	 Ysy7ZvTARG9kAn2RnIjSG5RJ563B7BbULTVuco36PIqJsKUuso0ZV/LmWrLCO4CncnZS0
	 CTgQF8xOjtlOF+y5G+cYbRS3boScoUWf83YIxMte706Y/xgQsVwFuSLUcOE+fzU1Wzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngGMpUJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B28606A328
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngGMpUJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8221F000C1;
	Tue,  3 Nov 2026 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732872;
	bh=Hj5sGf4zuQDzxKH9qB3EIUe2aXuw6LNNWfdi8I5hW/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngGMpUJa26AXpOYCLOj8Ws2TWAtRrkSUJNmAMWoILDJ/YqTAp7sZpQTVsoS1jSuN6
	 2GzbPOEBiHxEnnKlesKpTlg3zLI6egZjPUSvDK/qL0DYBNlDHXBIBUyjl739WFA52M
	 QGMIbVxGdSoz2RqEr5vKBT2KQXwgctslR2Rh9hgjjdxrXGLdtwLdF2RZSa0jcf9cKh
	 g6GSjyKpKgu6gK7xAHo5EsfUzkMAZDls82BoEd8VdXwvDS5HtF81yMIaNcdWeMWjUk
	 9DwCMnxXu3qOQr5th0d6Gz1UfZf1igpLEPpLT9F9iuKweOptfFcAJbx1zFBR/zL8j7
	 cRLu58yPfANVg==
Message-ID: <sashiko-outbox-195884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v23 02/10] lib: test hierarchical per-cpu counters
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
In-Reply-To: <20261102190708.1287100-3-mathieu.desnoyers@efficios.com>
References: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
 <20261102190708.1287100-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:07:49 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] lib/tests: unlocked cpu_online_mask read passed to work_on_cpu()
- [Medium] lib/tests: missing release/acquire ordering on sh.started in con=
tention test
- [Low] lib/tests: unlocked num_online_cpus() check in do_hpcc_test_saturat=
ed_compare()
--

commit 48b3ce088047ee1ccff5c20155903c1a143e78df
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

lib: test hierarchical per-cpu counters

Introduce KUnit tests for hierarchical per-CPU counters covering
single-threaded updates, concurrent multi-threaded updates, contended
carries, and saturated counter comparisons.

Link: https://lkml.kernel.org/r/20260227153730.1556542-3-mathieu.desnoyers@=
efficios.com

> diff --git a/lib/tests/percpu_counter_tree_kunit.c b/lib/tests/percpu_cou=
nter_tree_kunit.c
> new file mode 100644
> index 0000000000000..58b2e488e3c6b
> --- /dev/null
> +++ b/lib/tests/percpu_counter_tree_kunit.c

[ ... ]

> +static void do_hpcc_test_single_thread(struct kunit *test, int _cpu0, in=
t _cpu1,
> +				       enum up_test_inc_type type)
> +{
> +	unsigned long batch_size_order =3D 5;
> +	int cpu0 =3D _cpu0;
> +	int cpu1 =3D _cpu1;
> +	unsigned long deadline =3D jiffies + SINGLE_THREAD_MAX_SECONDS * HZ;
> +	int ret, i;
> +
> +	ret =3D init_counters(1UL << batch_size_order);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	if (ret)
> +		return;
> +	cpus_read_lock();
> +	for (i =3D 0; i < 10000 && time_before(jiffies, deadline); i++) {
> +		struct single_thread_update u0 =3D { .counter_index =3D 0 };
> +		struct single_thread_update u1 =3D { .counter_index =3D 1 };
> +		long increment;
> +
> +		switch (type) {
> +		case INC_ONE:
> +			increment =3D 1;
> +			break;
> +		case INC_MINUS_ONE:
> +			increment =3D -1;
> +			break;
> +		case INC_RANDOM:
> +			increment =3D (long)get_random_long() % 50000;
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			increment =3D 0;
> +		}
> +		if (_cpu0 < 0)
> +			cpu0 =3D cpumask_any_distribute(cpu_online_mask);
> +		if (_cpu1 < 0)
> +			cpu1 =3D cpumask_any_distribute(cpu_online_mask);
> +		u0.increment =3D increment;
> +		u1.increment =3D increment;
> +		work_on_cpu(cpu0, single_thread_update_fn, &u0);
> +		work_on_cpu(cpu1, single_thread_update_fn, &u1);
> +		check_counters(test);
> +	}
> +	cpus_read_unlock();
> +	fini_counters();
> +}
> +
> +static void hpcc_test_single_thread_first(struct kunit *test)
> +{
> +	int cpu =3D cpumask_first(cpu_online_mask);
> +
> +	do_hpcc_test_single_thread(test, cpu, cpu, INC_ONE);
> +	do_hpcc_test_single_thread(test, cpu, cpu, INC_MINUS_ONE);
> +	do_hpcc_test_single_thread(test, cpu, cpu, INC_RANDOM);
> +}
> +
> +static void hpcc_test_single_thread_first_random(struct kunit *test)
> +{
> +	int cpu =3D cpumask_first(cpu_online_mask);
> +
> +	do_hpcc_test_single_thread(test, cpu, -1, INC_ONE);
> +	do_hpcc_test_single_thread(test, cpu, -1, INC_MINUS_ONE);
> +	do_hpcc_test_single_thread(test, cpu, -1, INC_RANDOM);
> +}

[Severity: Medium]
Can cpu go offline before or between the calls to
do_hpcc_test_single_thread()?

Both hpcc_test_single_thread_first() and
hpcc_test_single_thread_first_random() sample cpumask_first(cpu_online_mask)
without holding cpus_read_lock(), and then pass that cpu across three
separate calls to do_hpcc_test_single_thread(), each of which acquires and
releases cpus_read_lock() on its own.

Because _cpu0 >=3D 0 (and _cpu1 >=3D 0 in hpcc_test_single_thread_first()),
do_hpcc_test_single_thread() never re-reads or validates cpu0 or cpu1 under
cpus_read_lock() before passing them to work_on_cpu(), which requires the
caller to ensure the target CPU cannot go offline.

If CPU hot-unplug runs concurrently under CONFIG_HOTPLUG_CPU=3Dy, could
work_on_cpu() be called on an offline CPU?

[ ... ]

> +static int contention_worker_fn(void *data)
> +{
> +	struct contention_data *cd =3D data;
> +	struct contention_shared *sh =3D cd->sh;
> +	int round;
> +
> +	wait_event(contention_wq, READ_ONCE(sh->started));
> +	for (round =3D 1; round <=3D CONTENTION_NR_ROUNDS; round++) {
> +		if (cd->coordinator) {
> +			atomic_set_release(&sh->round, round);
> +			contention_add(cd);
> +			while (atomic_read_acquire(&sh->nr_done) < round * (sh->nr_workers - =
1))
> +				cond_resched();
> +#ifdef CONFIG_SMP
> +			if (percpu_counter_tree_check_residuals(&counter[0]))
> +				sh->nr_errors++;
> +#endif
> +		} else {
> +			while (atomic_read_acquire(&sh->round) < round)
> +				cond_resched();
> +			contention_add(cd);
> +			/* Order the additions before the coordinator check. */
> +			atomic_inc_return_release(&sh->nr_done);
> +		}
> +	}
> +	complete_work();
> +	return 0;
> +}
> +
> +static void do_hpcc_test_contended_carries(struct kunit *test, unsigned =
long batch_size)
> +{

[ ... ]

> +	for_each_cpu(cpu, cpus) {
> +		cd[cpu].sh =3D &sh;
> +		cd[cpu].coordinator =3D first;
> +		cd[cpu].seed =3D get_random_u32() | 1;
> +		task[cpu] =3D kthread_create_on_cpu(contention_worker_fn, &cd[cpu], cp=
u,
> +						  "kunit_hpcc_contention/%u");
> +		KUNIT_EXPECT_FALSE(test, IS_ERR(task[cpu]));
> +		if (IS_ERR(task[cpu]))
> +			break;
> +		atomic_inc(&kernel_threads_to_run);
> +		get_task_struct(task[cpu]);
> +		wake_up_process(task[cpu]);
> +		sh.nr_workers++;
> +		first =3D false;
> +	}
> +	/* Start the workers once their number is known. */
> +	WRITE_ONCE(sh.started, true);
> +	wake_up_all(&contention_wq);

[Severity: Medium]
On weakly-ordered architectures, can the coordinator thread in
contention_worker_fn() observe sh->started =3D=3D true before seeing all
increments to sh.nr_workers?

In do_hpcc_test_contended_carries(), each worker kthread (starting with the
coordinator on the first iteration) is woken via wake_up_process(task[cpu])
inside the loop while sh.nr_workers++ is still being incremented on
subsequent iterations, and completion is published with
WRITE_ONCE(sh.started, true).

In contention_worker_fn(), if the already-running coordinator hits the
wait_event(contention_wq, READ_ONCE(sh->started)) fastpath before
wake_up_all() is called, it does not go through the waitqueue spinlock and
there is no release/acquire pairing ordering the updates to sh.nr_workers
before the coordinator reads sh->nr_workers in:

	while (atomic_read_acquire(&sh->nr_done) < round * (sh->nr_workers - 1))

Could this cause the coordinator to wait for fewer workers than were created
and call percpu_counter_tree_check_residuals(&counter[0]) while other worke=
rs
are still updating counter[0]? Should sh.started use smp_store_release() and
smp_load_acquire()?

[ ... ]

> +static void do_hpcc_test_saturated_compare(struct kunit *test, unsigned =
long batch_size,
> +					   long inc)
> +{

[ ... ]

> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		work_on_cpu(cpu, saturate_worker_fn, &sd);
> +		KUNIT_EXPECT_FALSE(test, sd.overrun);
> +		if (sd.overrun)
> +			break;
> +	}
> +	cpus_read_unlock();
> +
> +	precise =3D percpu_counter_tree_precise_sum(c);
> +	approx =3D percpu_counter_tree_approximate_sum(c);
> +	kunit_info(test, "batch_size=3D%lu inc=3D%ld precise=3D%ld approx=3D%ld=
 accuracy=3D%lu\n",
> +		   batch_size, inc, precise, approx, accuracy);
> +
> +	check_residuals(test, c);
> +	check_residuals(test, &probe);
> +
> +	/* Accuracy contract. */
> +	KUNIT_EXPECT_GE(test, approx, precise - (long)accuracy);
> +	KUNIT_EXPECT_LE(test, approx, precise + (long)accuracy);
> +	/* Saturating every possible CPU reaches the accuracy exactly. */
> +	if (num_online_cpus() =3D=3D nr_cpu_ids)
> +		KUNIT_EXPECT_EQ(test, (precise - approx) * inc, (long)accuracy);

[Severity: Low]
In do_hpcc_test_saturated_compare(), what happens if a CPU is offline during
the for_each_online_cpu() saturation loop and comes online after
cpus_read_unlock()?

Because num_online_cpus() =3D=3D nr_cpu_ids is checked after cpus_read_unlo=
ck()
is dropped, a CPU brought online in that window would make
num_online_cpus() =3D=3D nr_cpu_ids true even though saturate_worker_fn() d=
id not
run on it, causing the KUNIT_EXPECT_EQ(test, (precise - approx) * inc,
(long)accuracy) assertion to fail spuriously.

Should num_online_cpus() =3D=3D nr_cpu_ids be recorded while cpus_read_lock=
() is
still held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102190708.1287=
100-1-mathieu.desnoyers@efficios.com?part=3D2
