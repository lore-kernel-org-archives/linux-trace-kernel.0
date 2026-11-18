Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962406;
	b=FNUu1T3GggO9yYYqXWNkuKMHvO8Aw+jx8N2nJvaJ878jgqfO1vwgceCTLhGgtstlgkT3
	 C8gcTN3SHIm0/gA3b4gsxyUWp5suXDgNM6iA/IevqP0p4ACjr1p22+3LhXas+SY35EEcE
	 MYleX3FvsD1qngpsmupTuFAEBO+x9TMcflSPHTgh/8UPRL85Uuz8HAgpWn3GBxoeJ7lkw
	 ZScY8LNvZS9VQ+kRFE+RsU3TBzTBYDtKdGj/jxkoTFWhuH+6PCDPURKJPhBjas9ubJYE6
	 Vgo7Y4esxjXqMHT/I72U72439p8Jfy56XVrzMF+DAyiYCfbOPNGKUB8cgd4n/p+P65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RBhP2efSbh5Qx8vYvyeSrs3pfaq2wVW5VxT9IjZRr/s=;
	b=3JAgOb0NvVe6tddGrrzXGPk2G++rnzstiJICGwHgFu3o2wIjKk0m3k7gZfB0RfvIP2e/
	 PfmG8wme2sQy7juIOKaKIkW8G7lmbKxVn/nrsL/w9gAMMXL4mHKmsR9+1dUVLjLXQxXzb
	 emhYzmhiyltdMkMOxEOrsMLxpVmgXwf/HFY/ukI+sB5g1KvoU4xmkTsjfmfv+Fh0MTulV
	 WoX6Pgup8N9yN7vY7s6Z8u44I+U10n/CnjdL2M3F22KZ5xKwvzz82VdQC6whXquvahjv4
	 MboprHQCz2xNx3aS/LGvkvss9RUDgg6e0mXtGuavH0PqzVRv+7DRJmCJVAwVDLv9rjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8uivWgp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C29606A88A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8uivWgp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D11F000C5;
	Wed, 18 Nov 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794962405;
	bh=RBhP2efSbh5Qx8vYvyeSrs3pfaq2wVW5VxT9IjZRr/s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g8uivWgpD+pjX5nHzwLebzvDQz2NSuZtjBg+yGgU7LA+AFGXCp958n+2Z1ytgan7I
	 tTACPYzRRfNcovjPYYF9D9oKdH9s/pQxv7rCg3lsejEia3lR11pTzT6ouwm24IRtx0
	 s7bSqI20L36FLcYy7/+EmotaPzQoKxhLUwPP8PCU2jMCCtEz5eutNCqA2nYS88pfgK
	 tyzcW8qpb+jn66rbitqyB0IF+QQlB4rXQ5IrdsltAaZo2WaeENWv1FB8OzFTgNRryn
	 7WcVDcoy5/LbGZgeHnZ42jyH6NbKnppVVdO4T0CGAu4RmQYxvoQcV3LjLC2+QxZ0r7
	 H86ASj0w8xVCg==
Message-ID: <sashiko-outbox-219864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fgraph: Read the task->ret_stack with a
 smp_load_acquire()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261117193007.6ee9f605@gandalf.local.home>
References: <20261117193007.6ee9f605@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 00:40:05 +0000
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
- [Medium] fgraph: missing smp_store_release() conversion for
  task->ret_stack writers
--

commit b7c8f41f039b807327203effc627ecc71bfa14c8
Author: Steven Rostedt <rostedt@goodmis.org>

fgraph: Read the task->ret_stack with a smp_load_acquire()

This commit replaces the plain read of current->ret_stack and subsequent
smp_rmb() in ftrace_push_return_trace() with smp_load_acquire().

Link: https://lore.kernel.org/all/20261021174406.2891598-2-vineet.gupta@lin=
ux.dev/

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513be..eaa8d6aadb0e8 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned=
 long func,
>  	if (unlikely(ftrace_graph_is_dead()))
>  		return -EBUSY;
> =20
> -	if (!current->ret_stack)
> +	/*
> +	 * We must make sure the ret_stack is tested before we read
> +	 * anything else (See alloc_retstack_tasklist()).
> +	 */
> +	if (!smp_load_acquire(&current->ret_stack))
>  		return -EBUSY;
> =20
>  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> @@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned=
 long func,
>  	/* Set val to "reserved" with the delta to the new fgraph frame */
>  	val =3D (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFS=
ET;
> =20
> -	/*
> -	 * We must make sure the ret_stack is tested before we read
> -	 * anything else.
> -	 */
> -	smp_rmb();
> -

[Severity: Medium]
Should alloc_retstack_tasklist() and graph_init_task() also be updated to
use smp_store_release() when assigning t->ret_stack?

The commit message notes that setting task->ret_stack was switched from
smp_wmb() to smp_store_release(), and the new comment points to
alloc_retstack_tasklist().  However, both alloc_retstack_tasklist() and
graph_init_task() still use smp_wmb() followed by a plain store to
t->ret_stack:

kernel/trace/fgraph.c:alloc_retstack_tasklist() {
	...
			/* Make sure the tasks see the 0 first: */
			smp_wmb();
			t->ret_stack =3D ret_stack_list[start++];
	...
}

kernel/trace/fgraph.c:graph_init_task() {
	...
	/* make curr_ret_stack visible before we add the ret_stack */
	smp_wmb();
	t->ret_stack =3D ret_stack;
	...
}

Without converting those writers to smp_store_release(&t->ret_stack, ...),
the store side remains an unmarked plain assignment when racing with
smp_load_acquire(&current->ret_stack).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117193007.6ee9=
f605@gandalf.local.home?part=3D1
