Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57741B8CC
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210620; cv=none; b=L7QHcIpCOeHPiuJHi0tBiEmWnQ1BBWTU1RkBlCfJ23OsZvZyoSJ55ox2MzNTb1YJUGdeWaXAM2J8QuWKfEcaMeuMDTiYKnMDWCm62Sbsl2ScNB6r3IeC1cP/Eu3uHx34LBpPowe1YJgH9ijASv/6SvWUhuc+ajJsB1rLV/yRudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210620; c=relaxed/simple;
	bh=r3aPCG2mJ+ZG6kpfs9gxLXg0qgOKS1hQYKibOdGxIxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NN2M7flBQyksQB8PJd2KV7+TK7E45vhrrwT5+wS0vyz3Wqt0nJGTBdK29LAJPQuX0OPpAGBVllxhcK91/gjn0jKtq4X3gBW6br88aUmkwLErbbyEGh5auoQ+xJ7XB3ATTF4vifdGUXlX3yYvWkXZLFGprDU10iqqDMPqHQkt8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKV0dydj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKV0dydj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC5B1F00893;
	Sat, 12 Sep 2026 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789210619;
	bh=Wusvk7uKcix9DzU1QQXidl2/6WbU1uII456Xl7QKZe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKV0dydj3c5mrfsW5f6sjNAQqPSi0MAgW+fAVb13wM6YzGkIgpNIfYi0MwenKDUaC
	 TDi+eFW03dojDawucrf5uq8701fyyKnk48hJrbZtouI2TWqETd3Xq+9SqWTTQaHBMq
	 TYPD/wSKHXlVYqataK2wiO3xtcyZLz934XFzgfoKFXt5o6iLAPzWV0R7mjiLcY7MBm
	 DM9YHFLGQZ3UlpONKJM8YrNTErc2Nhu4qwUBCLHbhrasj4nq3SjQ08O7UkPuq6KEhS
	 yoNgdpMESCHe1dAFpHF0UMrO5mYF/gXjM0iue6wehJZ7wePhJd408WS0BHAlaTKhrm
	 Pd7dRRPGUjwoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Check resize_disabled before publishing
 the new subbuf order
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260912103938.1127021-1-devnexen@gmail.com>
References: <20260912103938.1127021-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:56:59 +0000
Message-Id: <20260912105659.6FC5B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing cpus_read_lock() allows concurrent CPU hotplug events to c=
rash ring_buffer_subbuf_order_set() via uninitialized list dereference or N=
ULL pointer dereference.
--

commit d554518f86e022de0069fc76033b9d71e9046148
Author: David Carlier <devnexen@gmail.com>

ring-buffer: Check resize_disabled before publishing the new subbuf order

This commit checks if resizing is disabled on any CPU before applying
the new sub-buffer order. This aims to prevent a race condition with
mmap fast paths mapping already-mapped CPUs with the new order.

Cc: stable@vger.kernel.org

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba2..d7e5e4620d096 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7474,6 +7474,14 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
> =20
>  	old_capacity =3D rb_subbuf_capacity(buffer);
> =20
> +	/* The mmap fast path reads subbuf_order without buffer->mutex. */
> +	for_each_buffer_cpu(buffer, cpu) {
> +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +			continue;
> +		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
> +			return -EBUSY;
> +	}
> +

[Severity: High]
Can this new loop race with concurrent CPU hotplug events and trigger a NULL
pointer dereference?

Unlike ring_buffer_resize(), ring_buffer_subbuf_order_set() doesn't appear
to take cpus_read_lock(). Meanwhile, trace_rb_cpu_prepare() can update
buffer->cpumask without holding buffer->mutex.

On weakly ordered architectures, could the lack of an smp_rmb() here cause
the reader to observe a newly added CPU in buffer->cpumask but load a NULL
buffer->buffers[cpu]?

Additionally, without cpus_read_lock(), if a CPU is added to the cpumask
between the allocation loop and the final page update loop later in this
function, new_pages will be an empty list head:

ring_buffer_subbuf_order_set() {
    ...
    /* One page was allocated for the reader page */
    cpu_buffer->reader_page =3D list_entry(cpu_buffer->new_pages.next,
                                         struct buffer_page, list);
    list_del_init(&cpu_buffer->reader_page->list);
    ...
}

Could this calculate a fake pointer overlapping the cpu_buffer struct and
corrupt memory when modified?

>  	atomic_inc(&buffer->record_disabled);
> =20
>  	/* Make sure all commits have finished */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912103938.1127=
021-1-devnexen@gmail.com?part=3D1
