Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A353217648
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309225; cv=none; b=YtKB3/ZpIlGbMTj3sQ9bkajMYum43zwONfv31HsrfpDpuI9uJEUa7ymbrNDAnleYsnGbaf4WsdDeU8xlSWgwKsFNZXRZI4e2/hNQOEeSY9Q65Wmj5vwpZVhf8yA7K9G20ZxrzbndgBHoh7HqHb+onNvFCZJNGre4g1LE5myuWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309225; c=relaxed/simple;
	bh=JxBHwRe/fh2NAfVvTk3Ub4Fw0DNu7krOJJhckfK7wfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4t6yf/94MahhxSZjP9XHylYGe+yGsC8ktvJp9qAjw4RROy9F6QqXkjGTPF4qxIz9HBkJVTruXKA+yaphlZffMPlL31o0NapbPYqSKfBHkDIFWFrRk9e5G9GWXyAcMfetx/es76fPy3cy8TorHJwHQbmVybTtmU8qMTEkf+pe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R25XmOeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R25XmOeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117481F000E9;
	Wed,  2 Sep 2026 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309224;
	bh=iVgk8JGNqMHA1WxAmlX+0hcSgpJs5dmW3dclw0vzLkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R25XmOeqshC74s5uXm2aoAKuq8ory7KMSwyvDogI3NgAmlRzs26xZRRlk4PUEsPOT
	 2QjHTwFnwgWcQDwmBziwivx0ungtcTz2FKSEvecEmiUb7XXifwvhv9BSTGSxb/FJf2
	 vdSLFCpH0CM2jQpetdV5gPWZ2tbE5lNErGTN00Y+MrEGRyJuj5AcGAmA14Pi5jpBBb
	 DSWyFBN1ZD7oDxXya1OnVBYLew7rd7L8okK3nBTkV9yAbg6XFGv2WUMKXnGdu+QjDN
	 i/zN2ABabx3ZVJcqHuA+GkQVW1a1sviKCovNLvf5tUbz9KIvcENiJhHj4GvHaB0QOc
	 fF0zCY8p8TN/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ftrace: Synchronize the initialization of ftrace_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901202020.09a1119a@robin>
References: <20260901202020.09a1119a@robin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 00:33:43 +0000
Message-Id: <20260902003344.117481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced `ops_mutex` logic implements a Double-Checked=
 Locking pattern for `ftrace_ops` initialization but misses required memory=
 barriers, allowing concurrent threads to observe a partially initialized s=
tructure on weakly-ordered architectures.
--

commit 0d99940712b506309368df1237eae674da6b9bc1
Author: Steven Rostedt <rostedt@goodmis.org>

ftrace: Synchronize the initialization of ftrace_ops

This commit introduces a mutex to synchronize the initialization of ftrace_=
ops
across multiple tasks. It implements a fast-path optimization by checking t=
he
FTRACE_OPS_FL_INITIALIZED flag before acquiring the lock.

Link: https://lore.kernel.org/all/20260829025528.49A831F000E9@smtp.kernel.o=
rg/

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9d80c7bd9f16..0dcc1ec1a366f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
[ ... ]
> @@ -160,6 +162,10 @@ static inline void ftrace_ops_init(struct ftrace_ops=
 *ops)
>  {
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
> +		guard(mutex)(&ops_mutex);
> +		/* Could have been initialized before lock taken */
> +		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> +			return;
>  		mutex_init(&ops->local_hash.regex_lock);
>  		INIT_LIST_HEAD(&ops->subop_list);
>  		ops->func_hash =3D &ops->local_hash;

[Severity: High]
Does this double-checked locking pattern introduce a memory ordering
regression on weakly-ordered architectures?

The initial lock-free fast-path check !(ops->flags & FTRACE_OPS_FL_INITIALI=
ZED)
uses a plain load, while the subsequent completion signal
ops->flags |=3D FTRACE_OPS_FL_INITIALIZED (which occurs just after the quot=
ed
lines) uses a plain store.

Without an acquire memory barrier on the load side and a release memory
barrier on the store side, is it possible for memory accesses to be
reordered by the CPU?

If Thread A completes the initialization and writes the flag, could
Thread B bypass the mutex by observing the initialized flag as true, but
still read a stale uninitialized or NULL value for ops->func_hash?

If Thread B then immediately dereferences ops->func_hash, for instance
in ftrace_startup_subops():

kernel/trace/ftrace.c:ftrace_startup_subops() {
    ...
	if (!ops->func_hash->filter_hash)
    ...
}

Would this result in an invalid memory access and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901202020.09a1=
119a@robin?part=3D1
