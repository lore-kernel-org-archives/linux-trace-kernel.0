Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932363BADA3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114215; cv=none; b=RvZ6nOvnJ1kKKST6cc0XGhdbD6xpI7LXPaZpqUn0vSvl3qPcCfKRD0P2GaeZzk9fV/PalUhc0rse5V+S2rQlDQLPUvn0oxuIiNJ5xsumC5yshHaHiK55SoOE63QGttYr39iVa+poHBJo59FWMjm8xtGyYzyxw+RWvujuJRulKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114215; c=relaxed/simple;
	bh=mM2QZVHbp8IyxQDpesukfPNhyceuBWYUt/GOCcYZ9/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=myw0k8p4DrckwkgtCHwqOKM/5TE9ieE1cLwW75n++2bqDMaHDRSOj34IrtyJ0SvQ/cC72Tbwuurs58dQ3NbTfYwU8UsD4Im32hsbc3upmNUOmu7tfC82XCQJBAWiBakfvnBDkTbdjuSPXkK4TUOrY3UQOGKFRK5R7iOzEdJp89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a54Va2dB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a54Va2dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ACF1F000FF;
	Fri, 11 Sep 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114214;
	bh=Khg4LPN851uJ0ACwwqkxuvZhcl2AIL7+/gvnAKdXw5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a54Va2dBSnt0W4krhuopfM/u41AlcwQ49DXCQ9UVAFFDVkIBCjHXjM29tG/G66XnO
	 fDzWAsJOlOMT7dkDO0WxuZhJkdsmU2KTmu3NzG6x2aJI/lp8e2dqTh6HszWLiYNZeq
	 XAKMIbor3g1qBcV5eYJNsPBGfF5yXfybB0qUlWbrSHGP+oKRCL3zo2sn7cjxd4G3Fa
	 WDJi3anSG5cgSKzx4Fx6kFDeu5JmbpjqdZD//lHr+Bv5jr0Mc3xQekChHRlF5LUPPU
	 ViVWaPB81g+JKhfhquyKc+2/OA44omUiQbPBZ+ILeC1K+lKlLc48PyHQ4odDDBl1ew
	 ezsB2EqBoKMAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/15] tracing/fgraph: convert process/thread
 iterator to for_each_process_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911075800.491472-12-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-12-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:10:13 +0000
Message-Id: <20260911081013.E1ACF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based error handling and scope-based guard() cleanup in=
 the same function.
--

commit 70fc208f5f44114137a3c935785ed1ab665ae0e0
Author: Ye Liu <liuye@kylinos.cn>

tracing/fgraph: convert process/thread iterator to for_each_process_thread_=
rculock

This commit replaces the manual rcu_read_lock() and rcu_read_unlock() pair
combined with the for_each_process_thread() loop in fgraph.c with the
for_each_process_thread_rculock() macro, which scopes the RCU read lock to
the loop body via scoped_guard(rcu).

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b9..f797ce1192233 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
[ ... ]
> @@ -1057,11 +1057,10 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>  		}
>  	}
> =20
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (start =3D=3D end) {
>  			ret =3D -EAGAIN;
> -			goto unlock;
> +			goto free;

[Severity: Low]
Does this mix scope-based cleanup with manual goto-based error handling?

By replacing the manual RCU lock with for_each_process_thread_rculock()
(which uses scoped_guard(rcu)), the function now relies on scope-based
cleanup for the RCU lock, but still jumps to a manual "goto free" label
for the memory cleanup below.

The cleanup guidelines state that for a given routine, we should convert all
resources that need a "goto" cleanup to scope-based cleanup, or convert none
of them, avoiding mixed usage in the same function.

>  		}
> =20
>  		if (t->ret_stack =3D=3D NULL) {
[ ... ]
> @@ -1074,9 +1073,6 @@ static int alloc_retstack_tasklist(unsigned long **=
ret_stack_list)
>  			t->ret_stack =3D ret_stack_list[start++];
>  		}
>  	}
> -
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i =3D start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911075800.4914=
72-1-ye.liu@linux.dev?part=3D11
