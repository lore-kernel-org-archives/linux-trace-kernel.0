Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732875;
	b=dp5pvGTKwVdrUSEuy+HnSZJuBe23dSCQEbOOnPHEDQH4cyLLqZEGFWbwPrAPVuSNwwJR
	 3WnkFFOrNo/Jmoozm720wEHhmikh+HeEjudSmrlrkOvJMStqerbZCijCD9ytN3wvsuDrL
	 4bUUwjW3twggxNWDrVW52H8au1QbnOBzHdniPn1XVTg6vqX6+SnW92jIiuo21PkLixnRX
	 PLCmSpEsF5vFoMaflQn7o97y41fXRVkWSYfpRq4IH3NROYJDjHzb0TgcgfihGmAiYeWwn
	 8aKogn0z0OIQXGOsRHMZSDrAYUIHLS3cew019s/vE/I0QgvjsTIy5LyQ/8TnMwq1Esg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A8HtBIj+8UA4ApalLzQOjrxxVwWtafDT0U5NHOYSGZ4=;
	b=Uzors7dZBivvmWzM2+bkbrhr5ZJrntsWseQ6ad7bPnzK2irt4llOoWGGCEdnel3285SB
	 rmkP8yYdPthn78act7kVV5N3MQse856MrPsVi6VspF2uvxyLPLCPsBrX2ZwMAnp0r124Y
	 9F8Sppoeyw5inkliOg+b4zgCelNSmbWTzUkh2Rjc/HIVGLakYIfhjm/NfGX1k7M4CdJri
	 5u6I4eirYSSNKzoDQc7pgYtXMsWrhgY/HSnY26hqzZAMo3I9F+lK+2K6RW+Vrqw3FN9lM
	 P8Aji+qQe39EizzH8cyE8p8p9JYWfAaD/5QroOvcQWOj9fn/5DIVLbfzxFdBKaAxXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLyf66Bg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9F606D804
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLyf66Bg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EAE1F00919;
	Tue,  3 Nov 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732875;
	bh=A8HtBIj+8UA4ApalLzQOjrxxVwWtafDT0U5NHOYSGZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLyf66Bg4MDZlU9tb2muOvLe5UkZij27IYV6xhAPA0ep2kCD2FPvQ/7/ePAfdBylG
	 gk0qlnzuFxiifl0+RdCwSxOOZVY6Ik8HGKZBGfOcYGFndCCQEfidiFHNnCTeC1HEPd
	 OyOulLS47jp/EerKnj0NNDMDA5uaZy2EylXgTL8il6jZaQIZmKzcHy//zwjY16Vmbv
	 NK6X2/iUw7iRe0oCjfua1n3e6nDdo1aTh0e0jcLDrkWz5Ap0cPV5Dp/2UjnzI4DkwH
	 0+9g8dVeSto7rqo/jHYi/KFb/ovXApI4W90MmzUiXPb34UG83ok/y0AzkTltUhATJt
	 scvzgGSXdo+GQ==
Message-ID: <sashiko-outbox-195886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v23 04/10] tools/testing/hpcc: add userspace test of
 hierarchical per-CPU counters
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
In-Reply-To: <20261102190708.1287100-5-mathieu.desnoyers@efficios.com>
References: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
 <20261102190708.1287100-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:07:52 +0000
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
- [Medium] tools/testing/hpcc: counter leak in test_saturated() and test_ra=
ndom_walk()
--

commit 503d613a781c32158eec55568b3137245d93fe15
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

tools/testing/hpcc: add userspace test of hierarchical per-CPU counters

This commit adds a single-threaded userspace test harness under
tools/testing/hpcc that builds lib/percpu_counter_tree.c with a simulated
topology to verify counter saturation, random walks, accuracy range
contracts, and comparison functions across all supported CPU counts and
batch sizes.

> diff --git a/tools/testing/hpcc/main.c b/tools/testing/hpcc/main.c
> new file mode 100644
> index 0000000000000..b707754aab0a7
> --- /dev/null
> +++ b/tools/testing/hpcc/main.c
> @@ -0,0 +1,413 @@

[ ... ]

> +static void test_saturated(unsigned long batch_size, long inc)
> +{
> +	struct test_counter c, probe, exact;
> +	unsigned long accuracy;
> +	long approx, delta;
> +
> +	if (test_counter_init(&c, batch_size) || test_counter_init(&probe, batc=
h_size) ||
> +	    test_counter_init(&exact, batch_size)) {
> +		CHECK(0);
> +		return;
> +	}

[ ... ]

> +static void test_random_walk(unsigned long batch_size, unsigned long nr_=
steps)
> +{
> +	struct test_counter c[2];
> +	unsigned long step;
> +
> +	if (test_counter_init(&c[0], batch_size) || test_counter_init(&c[1], ba=
tch_size)) {
> +		CHECK(0);
> +		return;
> +	}

[Severity: Medium]
Can these error paths in test_saturated() and test_random_walk() leak the
already-initialized counters when a subsequent test_counter_init() call
fails?

Each test_counter_init() call allocates per-CPU level0 storage and tree
items via percpu_counter_tree_init(). In test_saturated(), if
test_counter_init(&c, batch_size) succeeds and test_counter_init(&probe,
batch_size) or test_counter_init(&exact, batch_size) fails, the function
records CHECK(0) and returns to run_case() without calling
test_counter_destroy() on c (or probe). Similarly, in test_random_walk(),
if test_counter_init(&c[0], batch_size) succeeds and
test_counter_init(&c[1], batch_size) fails, c[0] is not destroyed before
returning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102190708.1287=
100-1-mathieu.desnoyers@efficios.com?part=3D4
