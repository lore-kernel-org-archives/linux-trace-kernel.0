Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805584;
	b=vc5t/PT+hwAY6pnVTf5PmNgftfBtDgZ/MsDoUeLlAGH/NvOVRqdY2mC5rpcj5/KrDRJ9
	 RqRfgWsF1XwkTIOq7swiYBWINMDlRkEYn0RNws7tMJrdDdWny4lpV/g7aGMtyzJgNIDfP
	 g4dLW1ZttVTHssX0oQcVAjsbRnq5rmESYkNjFOYJoZJ+EcKi4z6W+BGGkQDPPeU0Na5KY
	 6u1szL8ZGrSSgTtTjiSYsbruJwr8iFzqSrY5agkfrK+81WzDuQoVMmpAPhWM1+TGSHUKW
	 mi1B6vObj0IhsctGHLf7JT9LdCOHRpIP840MUUdIV8IuOJX7LSQCNKCz6UxM9H68sVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhAcjXRMKtP1KxHh3lPR8Zd73nii2eMsTAHpHB52Mlk=;
	b=EA6Y9JhNC1lUDuuSSE6edn8ZkMy0cEjnHbhWqQGr2UEo408oStNpkQomcTi11Ys69Fic
	 YUhdIAd1yeg2Eg6YjMTcURyzY4vUWKpBxVvZOTgd75tcyMGaiF4FYJp18mVHIZoj8sb5k
	 20FMXq8dgEBVb5XjD1XnhcWfTCMUaCx+tyfRSAx2++swil+pSjSiPO62e2VTwTL13Zr5S
	 g4nJtlmku5sYOuvKmlBB/LbOwbg7bmx94q4beRMYzXR+zbYtSgTrMHOklnavaolZsJn39
	 69jQ5UWKkMXMV7ttdlTI3hRm2ArQnpTcH5VYnvhjyGYS67hi7E5BBEuzynzP1rGRqQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyeXGcSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8C606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyeXGcSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54301F00893;
	Fri, 27 Nov 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805583;
	bh=jhAcjXRMKtP1KxHh3lPR8Zd73nii2eMsTAHpHB52Mlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyeXGcSlnyzgiPTXb/EVj0pNL7nS7ouCUiWrO/ZJeK3+x66Z6GPY+tuAhpyPkZvlx
	 a9LZ5h6zKv+IUr0YU11OBWTL8tBVCSdFwu0YGQ+A/I5mxC0Gz2KW1ohle0kgqrydV+
	 boIiLsQ6U4mwcoWRtPxpXv6ejzYvOvDok/+iaaCQs1NAYpEfzNxDDw6mBlarWNfCG1
	 qJLZ2SbrNO8zalxO3QEGBzYyPvftVOBQlSvCRn4empmk21YNNYaiOXzmH+xaOEnphw
	 ieXyD7XxRMT0KWDYC45Ku90OBHYAoaeVIl4IkrlSbhO5LkBANnq97hc0592TeEFFXt
	 K+wAWEI4eAGIg==
Message-ID: <sashiko-outbox-238117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rethook: link the node before replacing the return
 address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Feng" <evanfengff@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261127184037.71903-1-evanfengff@gmail.com>
References: <20261127184037.71903-1-evanfengff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:53:03 +0000
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
- [Medium] rethook: missing compiler barriers in rethook_hook() and
  arch_rethook_prepare()
--

commit 8555f1c8da702428f75ba61ef07accb91b4115a4
Author: Yifan Feng <evanfengff@gmail.com>

rethook: link the node before replacing the return address

This commit links the rethook_node into current->rethooks with sentinel
values before calling arch_rethook_prepare(), so that an interrupt or NMI
stack unwinder never observes the trampoline return address without a
corresponding node on the list.

> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 87a27f3aa4a61..c0d89720e1a8b 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -196,8 +196,16 @@ NOKPROBE_SYMBOL(rethook_try_get);
>   */
>  void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool =
mcount)
>  {
> -	arch_rethook_prepare(node, regs, mcount);
> +	/*
> +	 * Link the node before the return address is replaced, so that a
> +	 * stack unwinder never finds the trampoline address without its node.
> +	 * Until arch_rethook_prepare() fills the node in, make it one that
> +	 * rethook_find_ret_addr() skips.
> +	 */
> +	node->ret_addr =3D (unsigned long)arch_rethook_trampoline;
> +	node->frame =3D 0;
>  	__llist_add(&node->llist, &current->rethooks);
> +	arch_rethook_prepare(node, regs, mcount);
>  }
>  NOKPROBE_SYMBOL(rethook_hook);

[Severity: Medium]
Do these stores and the updates in arch_rethook_prepare() need compiler
barriers to protect same-CPU interrupt and NMI unwinders?

__llist_add() expands to plain stores:

include/linux/llist.h:__llist_add_batch() {
	new_last->next =3D head->first;
	head->first =3D new_first;
}

Because node comes from an objpool and rethook_recycle() does not clear
its fields, reordering current->rethooks.first ahead of the stores to
node->ret_addr, node->frame, or node->llist.next exposes stale values to
rethook_find_ret_addr().  With LTO, arch_rethook_prepare() can also be
inlined into rethook_hook(), allowing the compiler to eliminate the
sentinel stores to node->ret_addr and node->frame as dead stores before
they are overwritten.

In addition, because node is now already visible on current->rethooks
when arch_rethook_prepare() runs, arch_rethook_prepare() itself needs a
barrier() before replacing the return address with
arch_rethook_trampoline so that the real node->ret_addr and node->frame
are committed first:

arch/x86/kernel/rethook.c:arch_rethook_prepare() {
	...
	rh->ret_addr =3D stack[0];
	rh->frame =3D regs->sp;

	/* Replace the return addr with trampoline addr */
	stack[0] =3D (unsigned long) arch_rethook_trampoline;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127184037.7190=
3-1-evanfengff@gmail.com?part=3D1
