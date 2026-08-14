Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A53DAABE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723292; cv=none; b=b2wRCYQr/Sp/2ehOEscmv/ysRilTpjq3VvyjYgUc5P4dU1e+4S/whs/zISnJ1+KqbjFdXVdGPWZnFf6iXalHMKu8vqktRlE/xn3Xon7M8ZGGiAkp8E0AaFu1xaisfXi6mxCQoIRsx0ESY17z5vRuB1q31zLHJ/1t6dW7dxQfjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723292; c=relaxed/simple;
	bh=5aA8mJzxa6ez8HsFIaWA44CsEyxQue0+uzE1UXeI2x4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0mOnt3tPfX6hgoKocrADS8cIR831sWe+zkk7qgt+e41VqhNBQ6+xRzxsbzKMN6IM/aQuXmb9Y2hGqKBG+M8fRlAJ06gfLW2W6jk0avhgF67wPJ/TyAgW+eGcQlcdBSOnrS3UCnEvvkZC0saVlkSd8SoTzkcgMMrooi037f/NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8mUWYJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8mUWYJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F21F000E9;
	Fri, 14 Aug 2026 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786723291;
	bh=b+dwS0TvGee93VVUgRu5DB6kEO1flfek17s3phqT7xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8mUWYJ2ST+BmP60WjczfuuO0mFIsWfNd4KmNi9IEcDhSpylbcDWQgBa1eIPPwUEt
	 kUe21EC5VOyuLHycQ6SRYx9q/pt4oaHWrosG2rh0y+rFCXfh53TzOOfrhGQBW9fZL7
	 X/+xqJ6EH9G2KRptm9Za+Mw900i+2cr7IT8z0mMou/p70fa7liXsHcSI78KvSNWd6/
	 Z6p22XdZv8EACxcmvVeJBbEIZ9Xa9fWqCsee2gYbnuHEA7f+O+ehwBI9/3vZ/sI5Al
	 qR2LaBzL0SFjUhu89DuzB43EtAk3afldOMZtvezE0xs9UnRnuoWs6CtC8efe0Yi4HW
	 giZ2UFkaq91Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260814154823.755406-2-vdonnefort@google.com>
References: <20260814154823.755406-1-vdonnefort@google.com>
 <20260814154823.755406-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:01:30 +0000
Message-Id: <20260814160130.E69F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The local variable `spare_size` is left uninitialized via `goto re=
ad;` in `tracing_buffers_read()`, resulting in a kernel memory leak to user=
space.
--

--- Patch [1]: [PATCH v6 1/2] tracing: Fix subbuf resize races with trace_p=
ipe_raw readers ---
commit bdc760fe7b1aa6eb8c8a8b8c38e9fd02d25051b6
Author: Vincent Donnefort <vdonnefort@google.com>

tracing: Fix subbuf resize races with trace_pipe_raw readers

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values. This commit
modifies ring_buffer_alloc_read_page() to handle resizing and introduces
ring_buffer_read_page_size().

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715c..355278083b3fb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -7091,36 +7091,21 @@ ssize_t tracing_buffers_read(struct file *filp, c=
har __user *ubuf,
>  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
>  		return -EBUSY;
> =20
> -	page_size =3D ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> -
> -	/* Make sure the spare matches the current sub buffer size */
> -	if (info->spare) {
> -		if (page_size !=3D info->spare_size) {
> -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> -						   info->spare_cpu, info->spare);
> -			info->spare =3D NULL;
> -		}
> -	}
> +again:
> +	/* Do we have previous read data to read? */
> +	if (info->spare && (info->read < ring_buffer_read_page_size(info->spare=
)))
> +		goto read;
> =20
> -	if (!info->spare) {
> -		info->spare =3D ring_buffer_alloc_read_page(iter->array_buffer->buffer,
> -							  iter->cpu_file);
> -		if (IS_ERR(info->spare)) {
> -			ret =3D PTR_ERR(info->spare);
> -			info->spare =3D NULL;
> -		} else {
> -			info->spare_cpu =3D iter->cpu_file;
> -			info->spare_size =3D page_size;
> -		}
> -	}
> -	if (!info->spare)
> +	/* Make sure the read page order is aligned with the current buffer sub=
buf order */
> +	ret =3D ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->c=
pu_file,
> +					  &info->spare);
> +	if (ret < 0)
>  		return ret;
> =20
> -	/* Do we have previous read data to read? */
> -	if (info->read < page_size)
> -		goto read;
> +	spare_size =3D ring_buffer_read_page_size(info->spare);
> +	info->read =3D spare_size;
> +	info->spare_cpu =3D iter->cpu_file;
> =20
> - again:
>  	trace_access_lock(iter->cpu_file);
>  	ret =3D ring_buffer_read_page(iter->array_buffer->buffer,
>  				    info->spare,
[ ... ]
> @@ -7146,8 +7133,9 @@ ssize_t tracing_buffers_read(struct file *filp, cha=
r __user *ubuf,
>  	}
> =20
>  	info->read =3D 0;
> +
>   read:
> -	size =3D page_size - info->read;
> +	size =3D spare_size - info->read;

[Severity: High]
Can this regression leak uninitialized stack memory to userspace?

If a userspace process does a partial read (consuming fewer bytes than a fu=
ll
subbuffer page), the next read syscall will take the goto read; branch at t=
he
top of tracing_buffers_read().

When that branch is taken, spare_size is completely uninitialized stack mem=
ory.

Could size end up being a large garbage value (or underflow if spare_size <
info->read), causing copy_to_user() below to read beyond the bounds of
info->spare and leak arbitrary kernel memory?

>  	if (size > count)
>  		size =3D count;
>  	trace_data =3D ring_buffer_read_page_data(info->spare);
>  	ret =3D copy_to_user(ubuf, trace_data + info->read, size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814154823.7554=
06-1-vdonnefort@google.com?part=3D1
