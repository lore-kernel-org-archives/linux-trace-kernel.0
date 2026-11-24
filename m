Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535074;
	b=fvwo34AT3g9aw6fCMiqiRUMPpFK3+OceGgqGoWfONhPrNOk6z7YD0YJWfc2oVITR64r/
	 wy3MHG+dVffySAT+7Y5czdruxuL5XQZbyByAIB3GHYCf444XJvOtG325PgcZegcbD6ZF7
	 hwXzANkm91ImbwFQumg3HegbxFm959zvj/IhnWw1bjrSyNLgA/GVd56HaUB8A1mESIRQ9
	 96kmMAPH3VcHlqxyHOfLrFxDIHYF+SfGrq2MnmehjTQvqXc5ochqtvtvXXOzlxSCbNV5c
	 NLWt2qWut96AlU5gWjY3IaABVnUXlNNeqUqwGaJq05/emMfatBN9ZwMjP/nkqrKpV2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hny2RJi6pz/X2FicFZcj8ZAr2KvxNK7LZ+IDLj3FHUk=;
	b=D98Onuu9Qr+QVuiQmJS0KYJmyUNrLaK1X5J72Gb5ztYRL9PzilacP4YLh0T2lU4Gld/f
	 HnMpzfjU9kwFhLK6LkKcrcb7GTKXxeQrD3vYRH+WbbbFpXxFV36N3D9xKNvxlZOQd3/0A
	 NzHZJ+PoH8XGTokiIy/zzL+PMdbfpO95xmWR7xuDSFKH1pl85iaYHkhNsyzAfFSfeO0O8
	 0cpr8I+SDgC8P/4X8y2BUFyHEjsBlJSnaj4rMR/92Sho4UohXvjLpbK7y5Qjff5332Jfz
	 28Qov53t50r8u/79OE+ULF+h//xJc5WVUxGvj61SfJUDEGZfbQamZ6nIwQebwbzfixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBv9mc5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFE606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBv9mc5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E40F1F000C4;
	Tue, 24 Nov 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535074;
	bh=hny2RJi6pz/X2FicFZcj8ZAr2KvxNK7LZ+IDLj3FHUk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KBv9mc5XgGyjhaSIOhDZzXzXJmpwo3XUby9HFC4a2hizRgZoo2xibji8OJ2+JmxDl
	 gJ7mG8gY+nUQaSKqGUh+1jaXBU2wK+xlf4pOzGag7PxBlViAGy4vy24DRddtCJSGmQ
	 aO5A0v2GMMa6wnhr/pEnNvVC89f3asw1IXcXa8lw/KcdEldPygWuznLD+F0lwdIYDM
	 /Cn/IYAYjyzPW0Cj/L2wrXAmCO5TN/4J7SLPxbvksHs82R8TYM8tizU5JkOC8Gx6sx
	 dMIlV89z0jCS5EYtqOCLkDj1DXVTDafjZdHmwXDV913A45Bj3VhMD1BJAFsrM08tZx
	 G2e/MeuCzV2CA==
Message-ID: <sashiko-outbox-231467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/21] tracing/remotes: Add dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261124152845.2233401-9-vdonnefort@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
 <20261124152845.2233401-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:44:34 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tracing: trace_remote_iter_free() clears dmesg before
  flushing poll_work
- [Low] tracing: trace_remote_do_dmesg() stalls iterator when
  !CONFIG_PRINTK
--

commit 1f0a563309e4b76090103510dd16d6576ccfc2b9
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dmesg tracefs file

This commit adds a dmesg tracefs file to trace remotes that redirects
remote trace events to dmesg via a consuming iterator polled by
remote->poll_work.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 91c6ab9d5672d..f23d3386da29a 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -487,6 +502,11 @@ static void trace_remote_iter_free(struct trace_remo=
te_iterator *iter)
>  	lockdep_assert_held(&remote->lock);
> =20
>  	switch (iter->type) {
> +	case TRI_DMESG:
> +		WARN_ON_ONCE(remote->dmesg !=3D iter);
> +		smp_store_release(&remote->dmesg, NULL);
> +		flush_delayed_work(&remote->poll_work);
> +		fallthrough;
>  	case TRI_CONSUMING:
>  		trace_remote_dec_poll(remote);
>  		break;

[Severity: Medium]
Should flush_delayed_work(&remote->poll_work) run before clearing
remote->dmesg (or should trace_remote_do_dmesg() be called after
stopping poll_work)?

Because remote->dmesg is set to NULL first, the flushed
trace_remote_do_poll() run calls ring_buffer_poll_remote() to pull
pending remote events into remote->trace_buffer, bails out of
trace_remote_do_dmesg() without printing or consuming them, and
re-schedules remote->poll_work right before trace_remote_dec_poll()
cancels it.  In addition to dropping those final events from dmesg,
leaving them unconsumed in remote->trace_buffer causes
!ring_buffer_empty(remote->trace_buffer) in trace_remote_try_unload() to
prevent the remote trace buffer from unloading when trace_remote_put()
is called at the end of trace_remote_iter_free().

[ ... ]

> @@ -883,6 +909,87 @@ static const struct file_operations trace_fops =3D {
>  	.release	=3D trace_release,
>  };
> =20
> +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> +{
> +	struct trace_remote_iterator *iter =3D smp_load_acquire(&remote->dmesg);
> +	unsigned int max_events =3D 1000;
> +
> +	if (!iter)
> +		return false;
> +
> +	trace_remote_iter_read_start(iter);
> +
> +	while (trace_remote_iter_read_event(iter)) {
> +		trace_seq_init(&iter->seq);
> +
> +		trace_remote_iter_print_event(iter);
> +		trace_seq_putc(&iter->seq, 0);
> +		if (!pr_info("%s", seq_buf_str(&iter->seq.seq)))
> +			break;
> +
> +		trace_remote_iter_move(iter);

[Severity: Low]
When CONFIG_PRINTK is disabled, _printk() is a stub that returns 0, so
does this loop break before trace_remote_iter_move(iter) on every poll
cycle and leave the dmesg iterator stuck on the first event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124152845.2233=
401-1-vdonnefort@google.com?part=3D8
