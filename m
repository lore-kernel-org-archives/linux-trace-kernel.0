Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B993DDB07
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511244; cv=none; b=ZICwUaJ5+dpnWBKr90gqb8lZqJ/MfnqaMi38sG11oYrFlI3NsgUWgEOKeaHJXcaFYFC/YbFgP6Pc8fy4YdfgAbkxAtVtukyKPgiC6BBgHrbQPNT++VN+ZZeIylsNLW7qvsxZ8pnBSUbZ2uG74pSvFyP0jhInfsl04qbeBoyiXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511244; c=relaxed/simple;
	bh=XtkE74w4gFbN3VH2R7oqmGoLRVoe7Fbvy+5z0VC0PJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L+unZ81W3NliuY1inXmjZeVbiLLJTaaQargk7POd/Nk/tpTZ2RSXRls4e1ZZ4sOgp577sQogt3rY5SEnf6ZdFfj9j7iNCvLnuaNeRdpA9UA4ff5muUg5SEUeGPQyWvKjgMys/VqKo5CJhyI3ZsSDHSRUqaBgtagKuio7yySutxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLSPEcQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLSPEcQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E611F00A3D;
	Fri,  4 Sep 2026 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788511241;
	bh=YDuIGw5pe8VfS2GPhJSpzX1LSz2Sz2GXMhSMD95vUuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OLSPEcQMlF97D1Lsgy3IL2KM6tHv7m9ziTEARp17CSz01WruAl1RuqvfWPf386WlY
	 e/qFuHSN09ZInfFXOE36VPMHeA+mfZGgLaAu9iyDdCJyYdNRt2Dkc712mgE4jthADI
	 jiJuUb7xoV0mB8Y4VQ+1wev14a7X96//m44+yecEqB5Al9A/+ZFqhDRIWBEG8T3ubO
	 FLjN7WJfLSrcouIK3ygJHHIlc85EiQaAlztx8CyYHwfKiKn2Wz96PjOE+Re7izDugN
	 ZMl9aCQSa+to8xqB3XRxE6jnSLb8KwB7woU7AFYHTCKBhVpkRezUKNTQ1D0WlDUvKz
	 3RLjYzJ1myZCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] kernel: convert process/thread iterators to
 for_each_*_rcu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904083001.553587-6-ye.liu@linux.dev>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-6-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:40:41 +0000
Message-Id: <20260904084041.A0E611F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based error cleanup with guard() scopes in the same fun=
ction (`alloc_retstack_tasklist`).
--

commit f2b0046bb431ebefb3d059e22788f2810f0e6684
Author: Ye Liu <liuye@kylinos.cn>
kernel: convert process/thread iterators to for_each_*_rcu

This commit converts multiple manual rcu_read_lock() and iterator blocks
across the kernel to use the new for_each_*_rcu() macros.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b9..e522433ec8a5a 100644
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
> +	for_each_process_thread_rcu(g, t) {
>  		if (start =3D=3D end) {
>  			ret =3D -EAGAIN;
> -			goto unlock;
> +			goto free;

[Severity: Low]
Does this change violate the cleanup subsystem guidelines by mixing paradig=
ms?

The for_each_process_thread_rcu() macro expands to include a
scoped_guard(rcu). However, alloc_retstack_tasklist() still uses a goto free
statement to manually clean up the ret_stack_list array allocations upon er=
ror.

According to the kernel guidelines in include/linux/cleanup.h, the
expectation is that a given function either converts all resources requiring
a goto cleanup to scope-based cleanup, or converts none of them. Mixing
goto-based error handling with guard() or scoped_guard() scopes in the same
function should be avoided.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904083001.5535=
87-1-ye.liu@linux.dev?part=3D5
