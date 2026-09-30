Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4826374A17
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738346; cv=none; b=Cdf9m7Zhu/xTHHYK7Y3BWGHyoO4oDyu+UcS8CucRmZuM5MrnRy+bJTLYY2ES/4caO3YQRvi7MPrRoF8/4Ll7U7UU+d/JdSNZPzEhxyG2v6cBSiEJWL6zALsCTVUvbfBE/9zofNKNZ9sFOdh7O/5GiWOcrv+h9HjfWwlV4J3R9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738346; c=relaxed/simple;
	bh=Hzz840MBWLAOhyLB0MlDTbRjWbyjxvpPG5mj84RVku0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMv3sg8gV70xFOj1mZe+IDeYHIBck5LF9B7ZWBZAIEYxL9glRLW4zlRXhibQgdJL7TsEj+acz5syUENDhqWExW137WLRKkJ+wS1zyhnGqWxmUwuJGk48H82VpIYH7+7Kg03q3QrQGstYfm+T2pQV7FB5sl3WfXX8pHzXBcoIBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWSTyxnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWSTyxnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B226E1F000FF;
	Wed, 30 Sep 2026 03:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738342;
	bh=AneH/X39YZ3FZmXVDbqCx3aLibNtf4EyWbnyAhU1ixQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWSTyxnHik9ZuMb6FS/OZcBzDfG5cZTOIDWapE/t9sasOdDGqMNtvaZ/lRdl/kLmq
	 SZHmNpBoSY7NRFvFpNb4vh8eDzyY7xNl+W8BmZZqvRgyYr9l4IVeuNBgyCKI6CtLLn
	 fyJ4cdvYQcAS+/5bqu+wIC/ku2XAJfQpueIc8DU5xn6r6oDLzLy1bz3Jr/6Zes07ej
	 joOua+GCTew9tWB2GRqL/QsPIQ5bbdD/9R9yc5X8mjfrukwMTLLJRXzkjZE5zUczqe
	 dzOi6ZayqpaXvQJGPTZcsX2t0Gh6JL57jpaeG+KdiJVbWzWvw8q9KHl9RkruIEOpmr
	 zbHiic112QKYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Make branch profiler counters atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: nanshuaibo <nanshuaibo811@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930030728.1144418-1-nanshuaibo811@163.com>
References: <20260930030728.1144418-1-nanshuaibo811@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:19:01 +0000
Message-Id: <20260930031902.B226E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tracing: severe performance regression from locked atomic instru=
ctions on branches
- [Low] tracing: build failure on non-atomic archs due to compiler built-in=
 atomics
--

commit 9ef68553e3432c59dcd576b4a0f6c62d77db0cf7
Author: nanshuaibo <nanshuaibo811@163.com>

tracing: Make branch profiler counters atomic

The branch profiler updates its static counters from arbitrary contexts.
Concurrent updates can race and lose counts, resulting in KCSAN data race
reports. This patch uses relaxed compiler atomic operations for the counters
and atomic loads for reading the tracefs output.

> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
[ ... ]
> @@ -14,6 +14,16 @@
>   */
>  void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  			  int expect, int is_constant);
> +
> +/*
> + * Branch profiler data is defined in compiler_types.h, before the atomi=
c API
> + * is available. These counters are independent statistics and do not or=
der
> + * accesses to other data.
> + */
> +#define ftrace_branch_counter_inc(counter) \
> +	__atomic_fetch_add(&(counter), 1, __ATOMIC_RELAXED)

[Severity: Low]
Does directly invoking the GCC built-in here cause linking failures on
certain architectures? On architectures without native lock-free atomic
hardware instructions for unsigned long (like SPARC32), GCC lowers this
built-in to a library call such as __atomic_fetch_add_4. Since the kernel
does not link against libatomic, will this unconditionally fail to build
at link time on those architectures when branch profiling is enabled?

[Severity: Medium]
Could turning this into an atomic instruction cause a severe performance
regression? When CONFIG_PROFILE_ALL_BRANCHES or
CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, using __atomic_fetch_add
compels the compiler to emit locked instructions (e.g., LOCK XADD on x86)
for every evaluated branch condition kernel-wide. Can this result in CPU
pipeline stalls and cache-line bouncing?

> +#define ftrace_branch_counter_read(counter) \
> +	__atomic_load_n(&(counter), __ATOMIC_RELAXED)
>  #if defined(CONFIG_TRACE_BRANCH_PROFILING) \
>      && !defined(DISABLE_BRANCH_PROFILING) && !defined(__CHECKER__)
>  #define likely_notrace(x)	__builtin_expect(!!(x), 1)
[ ... ]
> diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
> --- a/kernel/trace/trace_branch.c
> +++ b/kernel/trace/trace_branch.c
[ ... ]
> @@ -239,13 +238,15 @@ static int annotated_branch_stat_headers(struct seq=
_file *m)
> =20
>  static inline long get_incorrect_percent(const struct ftrace_branch_data=
 *p)
>  {
> +	unsigned long correct =3D ftrace_branch_counter_read(p->correct);
> +	unsigned long incorrect =3D ftrace_branch_counter_read(p->incorrect);
>  	long percent;
> =20
> -	if (p->correct) {
> -		percent =3D p->incorrect * 100;
> -		percent /=3D p->correct + p->incorrect;
> +	if (correct) {
> +		percent =3D incorrect * 100;
> +		percent /=3D correct + incorrect;
>  	} else
> -		percent =3D p->incorrect ? 100 : -1;
> +		percent =3D incorrect ? 100 : -1;
> =20
>  	return percent;
>  }
[ ... ]
> @@ -329,6 +334,10 @@ static int annotated_branch_stat_cmp(const void *p1,=
 const void *p2)
>  {
>  	const struct ftrace_branch_data *a =3D p1;
>  	const struct ftrace_branch_data *b =3D p2;
> +	unsigned long a_incorrect =3D ftrace_branch_counter_read(a->incorrect);
> +	unsigned long b_incorrect =3D ftrace_branch_counter_read(b->incorrect);
> +	unsigned long a_correct =3D ftrace_branch_counter_read(a->correct);
> +	unsigned long b_correct =3D ftrace_branch_counter_read(b->correct);
> =20
>  	long percent_a, percent_b;
> =20
> @@ -340,9 +349,9 @@ static int annotated_branch_stat_cmp(const void *p1, =
const void *p2)
>  	if (percent_a > percent_b)
>  		return 1;

[Severity: Low]
This is a pre-existing issue, but does this pattern create a race condition
when computing these percentages?

annotated_branch_stat_cmp() takes an initial snapshot of the lockless
counters into local variables, but then calls get_incorrect_percent() which
takes a second snapshot of the exact same counters. If the live counters
change between these snapshots while user-space actively reads the debugfs
trace stat file, the computed percentage may not match the fallback raw cou=
nts
used for tie-breaking.

Could this yield internally inconsistent sorting keys and violate the strict
weak ordering required by the rbtree implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930030728.1144=
418-1-nanshuaibo811@163.com?part=3D1
