Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14617470425
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549634; cv=none; b=GWh5pXbAnHuLzJwk5qyrm5juXNetR2dIXglEuqhdbzaWf1rSWcSX3F4Mce9L+IuLHxdhuP1SEbF9r5owJVvQltQJjrYSwh/M1PraffAaq8s+ZJuJranJ0tdBAokd+WzziQtbDIBr26T6LyRsdJdXlzls/cudBlXXoLF3fdGY04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549634; c=relaxed/simple;
	bh=rGT/DyZAMAMWaF2YRXBSeKdOgYP6XoopFtYJGn6xkR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xols1g4vd/M3aXJTYX4WvT0/isbZdq9gXFFFmPQkrKW1TpbItLhpbnnTDKPLvdLcZ1uter/JhX+8YBJVusQm4BC4glW8QJNG4k69j5Wflxlqzvj/m567Mv3d1z2tLk65Js4nUUgq2LPH7z5Su6m+oNuY8mYUiYxtfWyLbKPW6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrZ+8s89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrZ+8s89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1751F000E9;
	Wed, 12 Aug 2026 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549632;
	bh=+mgXJXSIKOo4IYYKFF4g+yeoj1kKqRKxBTBf37PfGJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IrZ+8s89UPjUTZhgz5sWxkHGW2JNnt2L4XumSEm8UVgvkAQyLDvKnl+mnQ8tWAqTz
	 SpGoUg2fT7W+wzcDfjbGu+2qK3YSAegDqsI3PCaxibTbRV+xjZ3nRvklQ/jXozlVLg
	 esQl/UFOBrEvlvazuDk8eSgKdtbQQQG4QkjDjhE/0tOibgJwAndD0aLmFJFybAuf40
	 7GtOpl7xc2Geo9I5A1SEhmu7g1Wvz1cAPf7tckMapRw6AbUqk3BS+cJTVvwlJcr3ih
	 5VWTPQoQZkjDgD+YiMEATLXDBtCbgKS87+G6cB5D3GFmFr/s2akdvk2h1faRQyfGE1
	 0/soNpBEFJ/qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] ring-buffer: Make nr_pages unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-10-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-10-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:47:11 +0000
Message-Id: <20260812154712.1B1751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Integer truncation of `nr_pages_to_update` allows a massive bu=
ffer resize to bypass memory allocation checks, directly triggering an out-=
of-bounds page removal loop causing a critical kernel Use-After-Free (UAF).
- [High] Multiplication overflow in `subbuf_size * nr_pages` evaluates as a=
n `unsigned int` when allocating huge persistent ring buffers, destroying t=
race data isolation.
--

--- Patch [9]: [PATCH v4 9/9] ring-buffer: Make nr_pages unsigned int ---
commit cb1365ebdbbed7daa3a685ae1d6be7a4167052dd
Author: Vincent Donnefort <vdonnefort@google.com>
Date:   Wed Aug 12 15:33:10 2026 +0000

    ring-buffer: Make nr_pages unsigned int
   =20
    nr_pages is an int or unsigned int almost everywhere already. Also, all
    the meta-data ring_buffer_desc, ring_buffer_cpu_meta and
    trace_buffer_meta allowing to share information about the ring buffer
    are already capping this value to 32-bits.
   =20
    Make ring_buffer_per_cpu::nr_pages unsigned and align all the users to
    it. As a side effect, this makes ring_buffer_per_cpu slightly smaller.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 990a904cefe85..2fccb950e593c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -561,7 +561,7 @@ struct ring_buffer_per_cpu {
>  	struct ring_buffer_remote	*remote;
> =20
>  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
> -	long				nr_pages_to_update;
> +	int				nr_pages_to_update;
>  	struct list_head		new_pages; /* new pages to add */
>  	struct work_struct		update_pages_work;
>  	struct completion		update_done;

[Severity: Critical]
Could this type change lead to an out-of-bounds page removal regression?

In ring_buffer_resize(), size is an unsigned long and can be quite large,
resulting in an unsigned int nr_pages near the maximum 32-bit value. When
calculating nr_pages_to_update:

ring_buffer_resize() {
    ...
    cpu_buffer->nr_pages_to_update =3D nr_pages - cpu_buffer->nr_pages;
    if (cpu_buffer->nr_pages_to_update <=3D 0)
        continue;
    ...
}

If nr_pages is very large (e.g. 4294967286), subtracting the current nr_pag=
es
(e.g. 10) results in an unsigned value that wraps into a small negative num=
ber
when stored in the 32-bit int nr_pages_to_update (e.g. -20).

This would bypass the allocation checks and trigger rb_remove_pages() to
remove more pages than exist in the buffer, causing it to loop past the end
of the list and free pages that are still in use.

[ ... ]
> @@ -2773,7 +2773,7 @@ static struct trace_buffer *alloc_buffer(unsigned l=
ong size, unsigned flags,
>  					 struct ring_buffer_remote *remote)
>  {
>  	struct trace_buffer *buffer __free(kfree) =3D NULL;
> -	long nr_pages;
> +	unsigned int nr_pages;
>  	int subbuf_size;
>  	int bsize;
>  	int cpu;

[Severity: High]
Will this type change cause a multiplication overflow when allocating large
persistent ring buffers?

Later in alloc_buffer(), the pointer is advanced for the next CPU's buffer:

alloc_buffer() {
    ...
    ptr +=3D subbuf_size * nr_pages;
    ...
}

Because subbuf_size is an int and nr_pages is now an unsigned int, the
multiplication is evaluated as a 32-bit unsigned integer.=20

If the buffer is larger than 4GB per CPU, this will overflow before being
added to ptr, placing the next CPU's buffer inside the previous CPU's buffe=
r.

Previously, when nr_pages was a long, this math was safely performed as 64-=
bit
on 64-bit systems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D9
