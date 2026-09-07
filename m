Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFC42123F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769351; cv=none; b=Xe7Nnz6khsqX7R/jEhHHi+3fwyQa+mlndX/qzluQ8uevarhUia3Pjcetanj44RDX7f8UldJAFAl3nJDfLDMOe+HwZtccJD82ME9ScyQuXpIXj3W44U4bEa7fjXlXG/DVKkbOwwHmt6spKy7t+Ao59zHq0HMhVxmwqPBnjux4oa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769351; c=relaxed/simple;
	bh=lvOBvxD8FN9k+NXVD6ziS8x82OpMmRptRlYQc6kiA1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nxIyCt+FTNc5W8mz6j+cipat2n1I0494jr7s4HzPTKLGsRVBZ3CM0gFHaVUSuBYcwy/uS4dDtv0pGMAKucJHKwVDpXqLfBikSsQmFZSm+wrna787y2UQ4Vb79giE+Q60qJh5/9BjgLphsCrT6kWtgRNpp1VYJZLHLGaAq82DXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErKagU1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErKagU1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16E61F00A3A;
	Mon,  7 Sep 2026 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769350;
	bh=DI6sdGfidyszF2+rWN1hEl97Rlp6KuA5Kx/oDwytNKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ErKagU1FTjZx7WoS6+MBVnmN3W+blEAmRsk2XY08YXzUQVNqyQguDQcoTWiOMYFxS
	 nSzO/ZASSFs/guZ1T2H06YWuDh63XUPfYfTCwTRQCBYTLZyCirftDI7dJfoXSw0YxE
	 GQ7e1gQajD0FE7gk+PoquOF0K9yeWVYEcdKNeqSzZRo6xo5IsxogiDFqalPgWTZ/9c
	 pBehxiaVCQZ98Uzcti11SE+GWj9ntCnDuytyDGfwHaYsODO/xuQIffSgV1QegZU+7X
	 i6e1FUhpcH5GTQkufHbYFuGncL0xb8VJb3O6nbxGTmk/Y6G1Fkx5qrgyHNFgG/YAgF
	 OD2bM/2xei7XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 08:22:29 +0000
Message-Id: <20260907082229.D16E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based cleanup labels with scope-based guard() declarati=
ons in the same function.
--

commit e4ac0b901a628fa09984a6972d98830031479b53
Author: Ye Liu <liuye@kylinos.cn>

kernel: convert process/thread iterators to for_each_*_rculock

This commit replaces manual rcu_read_lock() and rcu_read_unlock() pairs
combined with process/thread iterators across the kernel with the
for_each_*_rculock() macros. These macros use scoped_guard(rcu) to
handle the RCU lock duration.

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
Does jumping to a manual cleanup label from within the scoped_guard(rcu)
loop introduced by for_each_process_thread_rculock() violate the cleanup
subsystem guidelines?

According to include/linux/cleanup.h, goto and cleanup helpers should
never be mixed in the same function to avoid confusing ownership semantics.
Since alloc_retstack_tasklist() still uses a goto-based cleanup for
ret_stack_list, should the allocation here be converted to use scope-based
cleanup to avoid mixing these paradigms?

>  		}
> =20
>  		if (t->ret_stack =3D=3D NULL) {
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907081334.1152=
889-1-ye.liu@linux.dev?part=3D5
