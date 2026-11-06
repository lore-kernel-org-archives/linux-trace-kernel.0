Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989590;
	b=0z1hKk12qo8VyH4vGGLGWuU0zRubolzsgq0oQe7QB1BGsA5F9hJcFpnaLYaRoKJrYjcr
	 bomR1BIymrOKX0aBs7HyOlhK5LCuiJHsK5wIBUJrst6Ga/lu0j+CwfrQ+PiAGVU+GNqVy
	 lSi0AWIkEWbcMZBcfFj/WoVKxHmqfp1q2QFb5n1FIH2T5IUn0BB/tmmCvAfKOS+uLFu6k
	 6OZKbXKz8rmYZgmSzm4y1A77idetPxatof5ueRW6jeBebdqwLbnSZd4OG3/XrY9Ir2tA3
	 h6PDHXvexeFPgWN9sjEMtv33A20QBlb+gkQOXCxSZcedEOqIDaq0SnpUsVWH+jUqX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S+cRGxJUS6rBJ/+MgkkC63fs9wH+nic0cCeFUOm7ZhI=;
	b=psNfbg6DvwbPsKXmaVlTG5+FM39Q05mmvz5INF2Kv62UWHDBrTUBXAEVVFF/vOu2afxd
	 DE/F8jetYQUrrvtNVEhCVdbN2xr/RgPl7FgbLy6g97s5/cdd9OrYWHd35Ga1HhZDtbbSU
	 2vRNURIL8HHn2X2XF43IO8vKW1eiyZP3mYYslobAftSs3T/4jPEVo4Uq5+sfQb4i58to/
	 +ECkFg2c0f5sUIDs4r1w5K+nA/F0z/2Lcs86weJbXZupn9B7XNiqKO/c9WaQWwQsWvj1T
	 m+OYScda+ZHjq6tZq769WpxuApt/PaXJDugP3LOWjjKIMtZoMWn4yvX4wYFOys85ouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJi9muhK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4E606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJi9muhK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13961F0089F;
	Fri,  6 Nov 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989589;
	bh=S+cRGxJUS6rBJ/+MgkkC63fs9wH+nic0cCeFUOm7ZhI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OJi9muhK6W+qP5zNhnmVOvOFVsY10QQF/5d9iikNAVhEgq8dY+tknhHg8sngmbJts
	 tz1QV6ZOpH/T2HC9iCM6E0hM4MdQsTlqCQJjz886E3E9B11RyA9FpwDyPRIkAvZRe+
	 CaciWWYPjyRePgJx8/E9+rLSAa5HHNygCi12zyNyXoxsJsjOth9Mp0Xva0oBBEoGbl
	 Z52gj6wbBggJ0Clt28w283Uwaeu1z3mHRCzklj6Uq+tppqybu++Boni69S9kbP+gxr
	 i/WYMu8aNbKykodVGse5fm5TRLiol5yzXHrj7mPakkSgJPqgBXCkK8xqQrw7aXxPBS
	 FY9EivASixtYw==
Message-ID: <sashiko-outbox-202026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/21] tracing/remotes: Add dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106180657.2460376-9-vdonnefort@google.com>
References: <20261106180657.2460376-1-vdonnefort@google.com>
 <20261106180657.2460376-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:26:29 +0000
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
- [Low] tracing: trace_remote_do_dmesg() stalls iterator when
  !CONFIG_PRINTK
--

commit 8ec4000ae15e5140e201a48a2cd1db29b0828760
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dmesg tracefs file

This commit adds a dmesg tracefs file to trace remotes that redirects
remote trace events to dmesg when enabled.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 08a89b7315c3c..3dbb4912dbd6d 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

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
Does this stall the iterator when CONFIG_PRINTK is disabled?

With !CONFIG_PRINTK, the _printk() stub returns 0, so the loop breaks
before trace_remote_iter_move() consumes the peeked event.  Enabling the
dmesg file then keeps poll_work running and pins the remote trace buffer
open while repeatedly peeking the same first event without making progress.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106180657.2460=
376-1-vdonnefort@google.com?part=3D8
