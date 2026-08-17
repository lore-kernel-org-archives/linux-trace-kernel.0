Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADA231830
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976858; cv=none; b=pnCywPA0SH9Kc9UdcPk4JgDxov7x+BiV7eLkjmsbW0RHu8+gDw9cdu8d8RXCPPKgFok3cy8YGXVnOt9MmQyEl+m/ufL9OqKgt7p1miG9KgGWkkAjmpltDeo7T0WbEjI1D+dN6oH0dsDCKqDCU5Lz228yVkxoK0poj93uQ9mqEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976858; c=relaxed/simple;
	bh=GJE6JLxJFbGoWZhApASVv4ZpVpHzZGijHiEdgP9qHNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pLliEb4+z3rUbXFwf5ZHTaqy50AOSNKSrmCt/mRLWywdrpB+9EaBDu0heSSSwdig4A0kVIbDQUHbmXLmychzPoaJ72OCUKkqC7fCy85HZRXRbh6ZT6EKdf4fHwk+Rpil7Md3cn63lI9EDfLsWB1PrmZb7hot2keKFMrCMYE7iSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obraQpGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obraQpGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E5D1F00A3E;
	Mon, 17 Aug 2026 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976856;
	bh=5eOAv9uQvup07MIcY/hVumHv2pfED5e9Fnz9R0VhAUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=obraQpGWkSTqcb8OWI8Rn59c2scNa1eyf/wp9jlh8H8eBJBYjdtJ0xVl0O1dCcVES
	 4lDuk+9xry+ujb2Rmj26k7IWCOy8SMHsK9NaZuZyn3eKpDBmT2cKFCwIIKZeiip3rW
	 uiULsNk+sjwi2Z6H+MRuTDuap0s6KKM0YunOPKclUYZ6oE37JGj3yjKopJRvyWYzC5
	 OT4vkEhnyDZsR4yD2D1opyFlF4yOGw2jfj1atuFK6fpT3PpwQS1u7dVzo28ehr9mSD
	 NLShQSKXd4x4UqjXzJk25JmFpgCvmwsyRGKYHYCoAP4yPc827VOw8MBvh4CZZnXx7i
	 Vqxfa1khF0eng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Fix use-after-free in trace_pipe read on
 sub-buffer order change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817140655.5694-1-kartikey406@gmail.com>
References: <20260817140655.5694-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:27:36 +0000
Message-Id: <20260817142736.89E5D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents a use-after-free for `trace_pipe` readers but l=
eaves standard `trace` (seq_file) readers and `tracing_splice_read_pipe()` =
vulnerable to the exact same use-after-free.
- [High] Snapshot buffer allocation and freeing call `ring_buffer_subbuf_or=
der_set()` without holding `trace_access_lock`, leaving snapshot readers vu=
lnerable to the exact same Use-After-Free race.
- [High] Ring buffer resizing (`buffer_size_kb`) frees active pages without=
 taking `trace_access_lock`, leading to a use-after-free for `seq_file` ite=
rators.
--

--- Patch [1]: [PATCH] tracing: Fix use-after-free in trace_pipe read on su=
b-buffer order change ---
commit 36ad4aeed5301b8016b09a675a4d6aac8686489f
Author: Deepanshu Kartikey <kartikey406@gmail.com>

tracing: Fix use-after-free in trace_pipe read on sub-buffer order change

Writing to buffer_subbuf_size_kb calls ring_buffer_subbuf_order_set(),
which frees every sub-buffer of the ring buffer, including the reader
page, and replaces them with newly allocated ones. This patch adds
trace_access_lock protection to prevent a use-after-free when readers
hold pointers into those pages.

Closes: https://syzkaller.appspot.com/bug?extid=3D685955db58555575fdd2

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 19b0d7a53c589..34328916245df 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -8216,6 +8216,8 @@ buffer_subbuf_size_write(struct file *filp, const c=
har __user *ubuf,
>  	/* Do not allow tracing while changing the order of the ring buffer */
>  	tracing_stop_tr(tr);
> =20
> +	trace_access_lock(RING_BUFFER_ALL_CPUS);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the same use-after-free
still exist for seq_file readers and tracing_splice_read_pipe()?

While trace_pipe readers are now protected here, s_start() and
tracing_splice_read_pipe() appear to peek the first event before taking
the access lock:

kernel/trace/trace.c:tracing_splice_read_pipe() {
    if (!iter->ent && !trace_find_next_entry_inc(iter)) {
        ret =3D -EFAULT;
        goto out_err;
    }

    trace_event_read_lock();
    trace_access_lock(iter->cpu_file);
    ...
}

If a concurrent write to buffer_subbuf_size_kb runs during this unprotected
window, could iter->ent be left pointing to freed memory?

[Severity: High]
This is a pre-existing issue, but do snapshot buffers need similar
protection?

It looks like free_snapshot() and tracing_alloc_snapshot_instance() call
ring_buffer_subbuf_order_set() without holding trace_access_lock:

kernel/trace/trace_snapshot.c:free_snapshot() {
    ...
    ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, 0);
    ring_buffer_resize(tr->snapshot_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
    ...
}

Since the snapshot seq_file reader drops trace_types_lock before iterating,
could a concurrent read of the snapshot file and a write to the snapshot
file trigger the same use-after-free by freeing the pages while readers
are active?

[Severity: High]
This is also a pre-existing issue, but does ring buffer resizing
leave seq_file iterators vulnerable to a similar race?

When writing to buffer_size_kb, __tracing_resize_ring_buffer() is called
without taking trace_access_lock:

kernel/trace/trace.c:__tracing_resize_ring_buffer() {
    tracing_stop_tr(tr);
    ret =3D ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
    ...
}

Since ring_buffer_resize() frees active pages directly, could this cause a
use-after-free if a seq_file reader is concurrently holding an event pointer
that points into one of the freed pages?

>  	old_order =3D ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
>  	if (old_order =3D=3D order)
>  		goto out;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817140655.5694=
-1-kartikey406@gmail.com?part=3D1
