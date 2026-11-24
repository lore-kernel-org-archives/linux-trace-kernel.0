Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534551;
	b=q0LPieSMZpNdJGIYs0HqUsj6xbAhrtqHRWqCBl+6+zdvtkPMUAT80UinnJ69v1XNb1oJ
	 WFB/GJ89vvgIVF2tSPF692dYpky1FbeAs+TsC+43e4FjQL/qWY2cPGCb87f0WiRi7i3g9
	 wpWnY/OLlN8LhytUQD2DN1fsQKV5PaXT8v0jxJolSj88qK5M0SJH4tTHT3Ln4ZhbdS+bB
	 SWOC9p/CJqd595IsTGv/ZUazCKiWMPL823uHehqu1/SKfM6iU2LxmRQg+4In0N8Q0j85J
	 c1aNVTvptWiQhFpwH5k6M0c6rL9XSJFxmRRbhuh13rdS0cwqJ12GhavLfVT5aRVvQhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8q8dDXkOXfNsJc7aX666+sxpU9p9+8dtxYUjwD4CB7o=;
	b=E4w6dT6jWAbmxnClUfhuCqYqwj7P9bhrIQkWFybhZRtoJiTaD6rdT06YZPdxJmO/G6ZO
	 j+TaPYZp6HAsHUZIM7MBVX796SMjiaES01ShKvAfEuOYvIzjwbY+FsTpfH5hdTNIMpfaa
	 qnJUyUVUX3YZWhNFs57SN1HKWTmOsG4qFSBGtelba7eH1t6v1yDtip1iprC8Ci/xX83oL
	 Pze/G5FMpPA21eVNUm6/U4Nc6fWd6Hrn+ccmhKBC7n/CrFRES0g7eL1aULILtuDTFi00V
	 sIrN4/gQVGg6nad0GE0enolseJ40qNIIDFkZL/Rj6EXsv4KxgYSjdzLsS8QTKAo4vGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IztKwSKF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AC606A326
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IztKwSKF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13D1F000CA;
	Tue, 24 Nov 2026 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534550;
	bh=8q8dDXkOXfNsJc7aX666+sxpU9p9+8dtxYUjwD4CB7o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IztKwSKFZiYHCqejO8puIsP4fuc6ilR4/dyWQA/NPPRIBJotITjJW10+35nd1zLf+
	 MMXFCxGMbZOfJpsxhUPd1P/Z72BeJokvc6lZI10JhrNcXwJj3+EI0dvU/qtXgefd4s
	 nMyPc1Vr3OSnGhZo+4p5EhGHdot+bEZ8KPUn+n5z1/pog8X8mbg89FKlg2yYf47VBn
	 uU3t7m9TXplnQTDPe7OGjUtyOheoN6AXMtFKXkYnLrMBVR6f2rarNIxz3NnXuA27Bc
	 TdvDJ4FRCdGqb1wv6filWtdDXDZNth9kkDoHO34z6NFatKhgUmrb15k469udj8uWJS
	 X6n9WjU+0EK+Q==
Message-ID: <sashiko-outbox-231423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/21] tracing/remotes: Annotate remote shared fields
 with READ_ONCE/WRITE_ONCE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261124152845.2233401-6-vdonnefort@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
 <20261124152845.2233401-6-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:35:49 +0000
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
- [Low] tracing/remotes: unannotated trace_buffer race in
  buffer_size_kb_show()
--

commit 7e6f51d9ef6864f10f965d8d3d3e6a0f3fcd19ec
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Annotate remote shared fields with READ_ONCE/WRITE_ONCE

This commit annotates lockless reads of remote->tracing_on, evt->enabled,
and remote->trace_buffer_size and their corresponding locked writes with
READ_ONCE() and WRITE_ONCE() to avoid KCSAN data-race warnings.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 6e514e78392f4..7faa589ddf429 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -290,7 +291,7 @@ static int buffer_size_kb_show(struct seq_file *s, vo=
id *unused)
>  {
>  	struct trace_remote *remote =3D s->private;
> =20
> -	seq_printf(s, "%lu (%s)\n", remote->trace_buffer_size >> 10,
> +	seq_printf(s, "%lu (%s)\n", READ_ONCE(remote->trace_buffer_size) >> 10,
>  		   trace_remote_loaded(remote) ? "loaded" : "unloaded");
> =20
>  	return 0;

[Severity: Low]
Does trace_remote_loaded() also need READ_ONCE() on remote->trace_buffer
(with corresponding WRITE_ONCE() annotations in trace_remote_load() and
trace_remote_try_unload())?  buffer_size_kb_show() calls
trace_remote_loaded() without holding remote->lock, so reading
buffer_size_kb while the remote trace buffer is concurrently loaded or
unloaded can still trigger a KCSAN data-race report on
remote->trace_buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124152845.2233=
401-1-vdonnefort@google.com?part=3D5
