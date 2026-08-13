Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6A420463
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629213; cv=none; b=JehlnVPppXDbCr2sAfFv/fnvuWuyC+IVZk52LKkddUGWNnXq1GPHwu+ZJHZYVbRht6cWNwF5whtDBvgoZmnR6118pO8z1PnBlLKuo+BFSt47UIAGkU8CTZz+YScpbORC81nWy+nQ3Qufuuy0/XxK05VlQ9qlp7HrLuauzAnlGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629213; c=relaxed/simple;
	bh=7BrhDmOI4pj017dhMKlyiB+Z2YE1kULce2LuxqkdHH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=frGP8bYnVY1e8QxCvjw0fo4gYxOAAAHtvRrCFUrulcWdle2r9FKi4FeNDObI0lg9VS8CKUCOYVXg/nKZVLfHGFJ9oMrLzLPq1JwOOKwGlpWSfBxGFhI/l3CzgrFB1NDqEgv3uap/lMW68eG88KTapNRcgpI2nQCR7mh7FIahmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHvmFRpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHvmFRpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAAF1F000E9;
	Thu, 13 Aug 2026 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629212;
	bh=FnrFmcEA9VE5I2G9ErmihBYb6etvnhxz/9G/T+9Tir0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHvmFRpNc/ZKfbHQTGNKJ7i3AnWKJ2wsrvXK2P+t7W8+0zcu6lKm2hv1a1MdcKsC3
	 KxCTusnjjc3z+yxKSIHKqhsibEDCNEBv1YAAH6QqicD+HhH+PCgoKGdscqsc1+bqAF
	 ZBIFm2JyLpcisaJFrK3OAxwSpWgriAqZD+ggKTF0G/Qj7HXg/MCsiRaemkBeNW08xV
	 tN2iou2Q0foS9Ks5klRhje1S8qfx/oPjTlCPUV4kkasDYHiL4eVGRzpG05cGo9tyHn
	 LTLI62KOE1QxpkzPt3WSvDmZfXqv2m4k7lKnnSWbqzKtnmCD9lYOyVQBerHblLecyg
	 r679mUhNLWJ1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-7-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:53:31 +0000
Message-Id: <20260813135331.CDAAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data Race / Double Free in tracing_buffers_read with concurren=
t readers
--

--- Patch [6]: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace=
_pipe_raw readers ---
commit a4a4fc189c85fb142cc626dac47e73d02ae21aef
Author: Vincent Donnefort <vdonnefort@google.com>

tracing: Fix subbuf resize races with trace_pipe_raw readers

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values. Modify
ring_buffer_alloc_read_page() to let it handle the resizing of
a previous buffer_data_read_page if necessary and add a new
ring_buffer_read_page_size() which enable ring-buffer users to not use
the racy ring_buffer_subbuf_size_get().

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a00ab8a9cbd0c..83292d90599ec 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> +struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_b=
uffer *buffer, int cpu,
> +							  struct buffer_data_read_page *prev)
>  {
[ ... ]
> +	if (prev && prev->order =3D=3D order) {
> +		return prev;
> +	} else if (prev) {
> +		/* We can reuse prev, but we discard the payload */
> +		free_pages((unsigned long)prev->data, prev->order);
> +		prev->data =3D NULL;
> +		bpage =3D prev;
> +	} else {
[ ... ]
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715c..f9399f391ac6c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, cha=
r __user *ubuf,
[ ... ]
> +again:
> +	prev_spare =3D info->spare;
[ ... ]
> -	/* Do we have previous read data to read? */
> -	if (info->read < page_size)
> -		goto read;
> +	/* Make sure the read page order is aligned with the current buffer sub=
buf order */
> +	info->spare =3D ring_buffer_alloc_read_page(iter->array_buffer->buffer,=
 iter->cpu_file,
> +						  prev_spare);

[Severity: Critical]
This isn't a bug introduced by this patch, but it looks like a pre-existing
issue with concurrent readers remains. If two threads share a trace_pipe_raw
file descriptor (e.g. via fork or pthreads) and call read() concurrently
while the subbuffer order is being changed, can they trigger a double-free?

Since vfs_read() does not hold f_pos_lock for this file (because
FMODE_ATOMIC_POS is cleared by nonseekable_open()), tracing_buffers_read()
can execute concurrently. If both threads read the same info->spare pointer
into prev_spare:

Thread 1:
    prev_spare =3D info->spare;

Thread 2:
    prev_spare =3D info->spare;

When both threads call into ring_buffer_alloc_read_page() with the same
prev pointer, and the subbuffer order has changed, wouldn't both threads
concurrently enter the 'else if (prev)' block and call free_pages() on the
same address without synchronization?

ring_buffer_alloc_read_page() {
    ...
    } else if (prev) {
        free_pages((unsigned long)prev->data, prev->order);
        prev->data =3D NULL;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D6
