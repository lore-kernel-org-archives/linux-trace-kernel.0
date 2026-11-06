Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997462;
	b=qkmR7kBYO6kYhf7Nl55MmLcLmuzYfoZh5CPnGl+oiIQfKJlWR7nCO5DaYbCjVCDG+kyn
	 LO0yuBZfpj8GKlKhsVOmU5lBA/dz4Nr3Tsluu+ZFGAVcIzHUmvjBIoUcOd/wns2x6PvQV
	 CXBaSurC+QQvs98O/WtkFLQ0PVp6abBxC052kcKYVKK0g4mev5dKPqi2J0REvL4GlqErP
	 Epx+OB9llnkUCxp5906MzPp9xjfmrG5f2P5ne0c6yXw5ZDgnsjNMUmPe2P7mUUMKrp+zM
	 0fGaii4dWrIQIXM0cPynhP2UDvneGw2dsz2EwE1fu8MUejWfys766EG+JjwHXBLWrrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hL/BUrSoards4qYdGTIOreFUsYkypEZCF+8Ircdtmg8=;
	b=eEVyHx6vz3/PWljw5ohM326m7/qICOcVApf8dRMfH9qxHpUbMJGoeTr5QRDZNQYA9Pal
	 Z8yLeP4WaKIfxQJg7ynRNJC1EI857NHETjMtr2oICEtIQBBOfw9zfQG/r9Ip1fFLpnaAQ
	 QfJUx9lkYUI6C5qOFWPIDYpKqOGEo2EGBUvTc5Uq+OqgXbRUuIEPlazCa05nqEkqyrhYY
	 Jjw0SQof6I5i2enkLKF6HNWItqbDYUzR65wxuzCxEf6flwfk9D/tqm3cYy7F7JKs8t50o
	 5A30ZU5l/KC3wL9ALi8kYjgcg42Lhva7NdlIOEfMQ23dvKfrg0v7g6cNkCZCo4CjG4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo2URpio;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A0606A32C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo2URpio
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F47B1F008A1;
	Fri,  6 Nov 2026 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997461;
	bh=hL/BUrSoards4qYdGTIOreFUsYkypEZCF+8Ircdtmg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lo2URpiocl70MKyDLTSFrmpg8KcAY76MMuNWwwcQvWOehhH5uQV0FyV4Y/FdN8Emb
	 GAGTGMfe2w8upSY/JpFZ4wySfsDQBxcf25rVOUS5emSHbM2rS9M+eBku27OXffpEHx
	 8HsJhOlyfokrRXi+4W9nvRRofp5kVg86OUyjYJHJj6urXwmnbHWZ0SLv0c4OGtwpQa
	 Qje4TovyevPF63aAaIxTfYlyv7eSuaJczPGIpTrQ1oHf4R9r3I9l1uHpxiJ4Dt7r9c
	 xBICCYM3hejhgZPSXfZCG+uIDWFpSOMMsr4BIV6BPIyysCsq//Gs9QPLwLwq8tJHNx
	 CjD6omd884hlg==
Message-ID: <sashiko-outbox-202248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v24 10/10] lib: add a benchmark of hierarchical
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
 Devarajan" <aboorvad@linux.ibm.com>, "David Carlier" <devnexen@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Kees Cook" <kees@kernel.org>, linux-trace-kernel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Oleg Nesterov" <oleg@redhat.com>
In-Reply-To: <20261105203639.1459524-11-mathieu.desnoyers@efficios.com>
References: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
 <20261105203639.1459524-11-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:37:38 +0000
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
- [Low] lib: missing kernel-parameters.txt entry for
  percpu_counter_tree_bench.batch
--

commit 88946339b389754c894fb27102ddde74cdda534f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

lib: add a benchmark of hierarchical per-cpu counters

This commit adds a KUnit benchmark comparing hierarchical per-CPU counters
against struct percpu_counter across update, lifecycle, and churn workloads.
It also introduces the CONFIG_PERCPU_COUNTER_TREE_BENCH option and a batch
module parameter to configure the counter batch size.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 3921177a0d243..6ab9644a4cb83 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -53,6 +53,21 @@ config PERCPU_COUNTER_TREE_KUNIT_TEST
> =20
>  	  When in doubt, say N.
> =20
> +config PERCPU_COUNTER_TREE_BENCH
> +	tristate "Benchmark of hierarchical per-cpu counters"
> +	depends on KUNIT && SMP
> +	help
> +	  This builds a KUnit benchmark comparing the hierarchical per-cpu
> +	  counters with struct percpu_counter: update cost with all online
> +	  CPUs updating shared and private counters, and init/destroy cost.
> +	  It runs for a few minutes on large machines.
> +
> +	  The batch size and the tree shape can be changed with the
> +	  percpu_counter_tree_bench.batch=3D and percpu_counter_tree.arity=3D
> +	  parameters, see lib/tests/percpu_counter_tree_bench.c.

[ ... ]

> diff --git a/lib/tests/percpu_counter_tree_bench.c b/lib/tests/percpu_cou=
nter_tree_bench.c
> new file mode 100644
> index 0000000000000..e041ba8ba8c74
> --- /dev/null
> +++ b/lib/tests/percpu_counter_tree_bench.c
> @@ -0,0 +1,610 @@

[ ... ]

> +/* Like the RSS counters by default. */
> +static unsigned int batch =3D 32;
> +module_param(batch, uint, 0444);
> +MODULE_PARM_DESC(batch, "Batch size of the hierarchical counters (power =
of 2, 2 to 128)");

[Severity: Low]
As reported by Sashiko on RFC v23 [1], lib/tests/percpu_counter_tree_bench.c
defines the batch module parameter via module_param(batch, uint, 0444) under
CONFIG_PERCPU_COUNTER_TREE_BENCH, and both the commit description and the
PERCPU_COUNTER_TREE_BENCH help text in lib/Kconfig advertise setting
percpu_counter_tree_bench.batch=3D on the kernel command line at boot along=
side
percpu_counter_tree.arity=3D.

Should percpu_counter_tree_bench.batch=3D also be documented in
Documentation/admin-guide/kernel-parameters.txt?

[1] https://lore.kernel.org/r/20261102190708.1287100-11-mathieu.desnoyers@e=
fficios.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105203639.1459=
524-1-mathieu.desnoyers@efficios.com?part=3D10
