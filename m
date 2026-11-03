Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667929;
	b=SLGfVufQ0eTZ3dLuAkEkLg1QVbnMWEkgh6+HnIrMR+0B66oNBJD+C0LGYrmT9D57REmW
	 20ySmo/VMOvkKb8ra9r+6cgAz2vP1q3PxlkcTUwOwnYBh3WNbg849o8LnhErrea5H3w22
	 7CJeFmVWTen1XJhaANhjqL+rtF/CfXZFPkAFa/BkUoe3v5djOXv5gDahAJe9UrIXAhhSJ
	 4hCFknGcIZ44r0DmbMOIewBit82hC3NRjlEJ4VpRpZ9uTkaVaop3HGECyLq6NrkhGqFkM
	 /19zCQ5BcMS4Rlchl/JOZPUJGfALDwH/sbh4xf5N4XFnzr7dd9FX/qRuUYNOKF6SODA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bCWu8JKFKstFM9YXABEB/RkX8/lttGPFfbhaE+T7M5k=;
	b=bwoTha7NYqo1XEJ20N0HDRiE7Vsnjl//xJwHBn8SokF1/csGyk+VGo3+ADVFJDll94B9
	 hc4bpc/GO6Y3IUFw0Uog/ygGIu/5wrLKCn+JuLbpVhU3d7ZGtYrLU1PdHfBU/FEpt/a9c
	 Wamx/zON+u87cjYgFF8MIfMckaOK3nGNM7zdR2AfUjJBzE+giUbv300LuE9/l2vVBauUl
	 1nFopyktZQuXKKPtBidq6hc/rsUGPphCytOn4rRoSq8eVkGgC92nSwnBE980i8Z4Sx/Px
	 FRMyVMl/xwjVzq5/h2pKZFCPLG8VPvLo1XzRH7CLYk0Sbl/2FZyxiwggZMOgvgosxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2m2bijZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBF606A324
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2m2bijZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1327E1F000C1;
	Tue,  3 Nov 2026 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667928;
	bh=bCWu8JKFKstFM9YXABEB/RkX8/lttGPFfbhaE+T7M5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V2m2bijZr81K5TsrLniIVKTChkFlqFR186k8X/9qm3PkqEjEY7O3+j8pCTK1qVNTE
	 Ny1cwi/DDHoGNvmY2u1M2YylxCH8us8o3YfNuto/t5ehg3Lp6RVH9UA7CXJQzE+N5L
	 vHrZg6+S/Kpa5ViO5OwMCc52+JaqySjakrs8ts23plGuphisW/nmN789tLbPph5tVB
	 K/yHnHmoUkar7bQcgs0AxC7WdPGlqKQWLa4nCY3qA91cv3dynqO5tkYlWQdKH0dkcp
	 WDR1PjqNXvVkX2ZxuqBqJ5jQxSpRgDXULPi6mQUl0w05s6cCqkbxC9xMD9DtTRyAnz
	 vfKFMGd9aZi/A==
Message-ID: <sashiko-outbox-194417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: Keep copying markers when one instance is
 stopped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaewon Jung" <jaewon8868@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261103005219.3236380-1-jaewon8868@gmail.com>
References: <20261103005219.3236380-1-jaewon8868@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:05:27 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing: successful marker write overwritten by tail error in ma=
rker_copies
--

commit 2345280f3b3625fa6e36116fc50947e792b25719
Author: Jaewon Jung <jaewon8868@gmail.com>

tracing: Keep copying markers when one instance is stopped

This commit removes the early break on write errors in tracing_mark_write()
and tracing_mark_raw_write() when iterating over marker_copies so that
stopped instances do not prevent remaining instances from receiving markers.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 08614af8fad1c..0b66c55d378b1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6330,8 +6330,6 @@ tracing_mark_write(struct file *filp, const char __=
user *ubuf,
>  		guard(rcu)();
>  		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
>  			written =3D write_marker_to_buffer(tr, buf, cnt, ip);
> -			if (written < 0)
> -				break;
>  		}
>  	} else {
>  		written =3D write_marker_to_buffer(tr, buf, cnt, ip);
> @@ -6409,8 +6407,6 @@ tracing_mark_raw_write(struct file *filp, const cha=
r __user *ubuf,
>  		guard(rcu)();
>  		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
>  			written =3D write_raw_marker_to_buffer(tr, buf, cnt);
> -			if (written < 0)
> -				break;

[Severity: Medium]
As reported by Steven Rostedt on v1 [1], should errors from stopped
instances in marker_copies be prevented from overwriting a successful write
return value?

When instances enable copy_trace_marker, update_marker_trace() adds each
instance to the head of marker_copies:

kernel/trace/trace.c:update_marker_trace() {
	if (enabled) {
		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
			return false;

		list_add_rcu(&tr->marker_list, &marker_copies);
		tr->trace_flags |=3D TRACE_ITER(COPY_MARKER);
		return true;
	}

This leaves earlier-enabled instances and global_trace at the tail of
marker_copies.

Because tracing_mark_write() and tracing_mark_raw_write() unconditionally
assign written on every iteration of marker_copies, if an earlier instance
in the list is active and receives the marker (setting written =3D cnt), but
the last instance in marker_copies has tracing disabled,
write_marker_to_buffer() or write_raw_marker_to_buffer() will return -EBADF
on that tail instance. Won't that overwrite written and cause the syscall
to return -EBADF to userspace even though the marker was successfully
written to the active instance(s)?

[1] https://lore.kernel.org/r/20261102091751.2ee7c4d3@gandalf.local.home

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005219.3236=
380-1-jaewon8868@gmail.com?part=3D1
