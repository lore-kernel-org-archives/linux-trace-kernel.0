Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447C3E0C5F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975694; cv=none; b=drxLO26uG3F3kbmKFQ9fuQe28Oyf85luahXmcLQkE+E0B8bWK4NnaXX3GSYZPm1xE0wsHRo+u3qh8DbUeX4Eif91BbRZbjsN1GrKh2VGOntWl1LOxluY9z0uLduZadGm2U8my0lZ8WUGdtnLLN9kdZrs2NUBap/+8AANs/HOUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975694; c=relaxed/simple;
	bh=g1kOb/oq6gEO+ehWaFtoz4ghq5sLcCT/UulTal4Rx6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eoNBpOHR5Lfv3yvk7NMnlstTdhX2rod2Y6kydOn9Zf8L0BlNpPmGXnw75C+d5aGmP5HRyyoOtKo6glze2Nloon06i3h8E7ZQbBcOy+zStEWy79cbEk0QqFV2JUnS11r7Fn53s5zxnlW1KL8FGvQZSuquSODW+1QiTWpP67n5GOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCorDDhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCorDDhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D41F00A3A;
	Mon, 17 Aug 2026 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975692;
	bh=poysPEPYvmSFCX86OhcLKRHykgwM092a+B0i9terJMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCorDDhJjregOzDlpjZW/UGitY7pNzu3JEEYZKyyTmzB8k3YLE6TtXH2ly7ZQ8wdz
	 MK7qWT+lqfn/0muT8e42XfmMTKQtUryIQfHiNv76zYtD+EsPO0k7sAfMmrPlWbipik
	 S7519SqfJVQRR7jNrQ7cqPJvtsH47qrHIrXNtHkvTTNy7AahySUE5CKxtfwiBTXd7p
	 yz5q7LUAj4/88+wPdU7U0csMftDPI8dO82BHLCL94zOBQFictThbT5JCSYtJYvIFL+
	 SPKXhZJfmPxMHS8+nnkQniUkE4soi8c37bTta41J2UAkRwYxpvQeeXIGGViaH0ghfo
	 bOvPgqsiiezfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817134750.3909384-2-vdonnefort@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:08:11 +0000
Message-Id: <20260817140812.2C7D41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Infinite busy-wait loop in tracing reads (tracing_buffers_read and=
 tracing_buffers_splice_read) causing lockups during concurrent ring buffer=
 resizes.

Pre-existing issues:
- [Critical] Concurrent io_uring reads trigger a double free on info->spare=
->data due to missing VFS locks.
- [High] Use-After-Free vulnerability in VFS pipe buffer destruction path d=
ue to lifecycle mismatch with the trace array.
--

--- Patch [1]: [PATCH v7 1/3] tracing: Fix subbuf resize races with trace_p=
ipe_raw readers ---
commit 3b5685c224f6977e19f6580474cf69ff34b547a9
Author: Vincent Donnefort <vdonnefort@google.com>

tracing: Fix subbuf resize races with trace_pipe_raw readers

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values.
Modify ring_buffer_alloc_read_page() to handle resizing and add
ring_buffer_read_page_size() to avoid racy subbuf size gets.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5fc009edc1ec9..ec13779922ffb 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -6990,56 +6990,78 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
> +int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
> +				struct buffer_data_read_page **rpage)
>  {
[ ... ]
> +	if (*rpage) {
> +		if ((*rpage)->order =3D=3D order)
> +			return 0;
> =20
> -	bpage->order =3D buffer->subbuf_order;
> +		/* We can reuse rpage, but we discard the payload */
> +		free_pages((unsigned long)(*rpage)->data, (*rpage)->order);
> +		(*rpage)->data =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but concurrent io_uring reads can call vfs_re=
ad()
without holding f_pos_lock, leading to concurrent execution of
tracing_buffers_read().

Neither tracing_buffers_read() nor this function protects the shared
info->spare pointer with a lock.

If these threads race during a subbuffer resize, can both observe the order
mismatch simultaneously and execute free_pages() on the same data address,
causing a double free?

> +	} else {
> +		*rpage =3D kzalloc_obj(**rpage);
> +		if (!*rpage)
> +			return -ENOMEM;
> +	}
> +
> +	(*rpage)->order =3D order;
>  	cpu_buffer =3D buffer->buffers[cpu];
[ ... ]
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715c..737922b236d46 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -7128,7 +7116,9 @@ ssize_t tracing_buffers_read(struct file *filp, cha=
r __user *ubuf,
>  				    iter->cpu_file, 0);
>  	trace_access_unlock(iter->cpu_file);
> =20
> -	if (ret < 0) {
> +	if (ret =3D=3D -EAGAIN) {
> +		goto again;
> +	} else if (ret < 0) {

[Severity: High]
If ring_buffer_read_page() returns -EAGAIN because the subbuffer order was
updated but cpu_buffer->reader_page->order hasn't been updated yet, this
branches back to the again label.

Since the loop does not yield the CPU or call cond_resched(), could this ca=
use
a hard lockup if the reader and the resize thread are on the same CPU?

>  		if (trace_empty(iter) && !iter->closed) {
>  			if (update_last_data_if_empty(iter->tr))
>  				return 0;
[ ... ]
> @@ -7268,23 +7259,12 @@ ssize_t tracing_buffers_splice_read(struct file *=
file, loff_t *ppos,
>  	};
>  	struct buffer_ref *ref;
>  	bool woken =3D false;
> -	int page_size;
>  	int entries, i;
>  	ssize_t ret =3D 0;
[ ... ]
>  	for (i =3D 0; i < spd.nr_pages_max && len && entries; i++) {
> +		unsigned int page_size;
>  		struct page *page;
>  		int r;
> =20
> @@ -7304,25 +7285,38 @@ ssize_t tracing_buffers_splice_read(struct file *=
file, loff_t *ppos,
> =20
>  		refcount_set(&ref->refcount, 1);
>  		ref->buffer =3D iter->array_buffer->buffer;

[Severity: High]
This is a pre-existing issue, but splice_to_pipe() links kernel pages to a
pipe buffer and stashes ref->buffer as private data.

The VFS operation never acquires a reference on the trace_array. If the user
closes the trace file and deletes the trace instance, the trace_buffer is
freed.

When the pipe buffer is subsequently read or destroyed, won't
buffer_ref_release() dereference the dangling ref->buffer pointer when call=
ing
ring_buffer_free_read_page(), causing a use-after-free?

> -		ref->page =3D ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
> -		if (IS_ERR(ref->page)) {
> -			ret =3D PTR_ERR(ref->page);
> -			ref->page =3D NULL;
> +
> +new_read_page:
> +		ret =3D ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref-=
>rpage);
> +		if (ret) {
>  			kfree(ref);
>  			break;
>  		}
>  		ref->cpu =3D iter->cpu_file;
> =20
> -		r =3D ring_buffer_read_page(ref->buffer, ref->page,
> -					  len, iter->cpu_file, 1);
> +		page_size =3D ring_buffer_read_page_size(ref->rpage);
> +
> +		r =3D -EINVAL;
> +		if (IS_ALIGNED(*ppos, page_size) && len >=3D page_size) {
> +			r =3D ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_f=
ile, 1);
> +			if (r =3D=3D -EAGAIN)
> +				goto new_read_page;

[Severity: High]
Similar to the read path above, this catches -EAGAIN and loops back to
new_read_page.

Because goto new_read_page executes continuously without releasing
trace_access_lock() or yielding the CPU, can this permanently deadlock the
system during a resize by preventing the resize thread from acquiring the
necessary locks?

> +		} else if (!i) {
> +			/*
> +			 * If the first iteration fails this is an invalid userspace input.
> +			 * Otherwise, this is because the subbuf order has been modified. Do =
not
> +			 * report an error and finish the read.
> +			 */
> +			ret =3D -EINVAL;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817134750.3909=
384-1-vdonnefort@google.com?part=3D1
