Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975944;
	b=20etPCS8sm+9+KT6M8Yi7KxfGSGGBxvC2JeoudsDMKHHLB5U9a9iOzh2GbfO7tc67GDr
	 zpeoxyBmed9m0uHXzZoLmK5qeZ5OjggCgNShvo6p5CyS4rS6yyYjTlCHLO+FYvoZrDBp7
	 iMYVMGl3N6sSAQhigoIQRXO/VNaLyB9xSlKwXYkUAKiXRSx+Nitpe5kZSOwgGY6UBsTXk
	 sDdG8EqBh10TtG5xGLwtmBeCNsBpGjDa3YIUI/DdkfvKdxRFU109BYKdwqVVyd/+TsDH5
	 9SFAfk6W7VJ6Zeb0wIJnFv/C7rk81vhPSHcNo17j1z3MT8jwQF4UHigyXPSjAEBtu9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bFCeBK4qdKlogWEuAteyJZ0UmU2nFLi1IfEEWVOmtMM=;
	b=0zPKfrxhiv3mvNmm8DAsNEv8nbUfzLEKtUDyXdVP3WEGYvteyLMnhlqxIyzSgtkUwpxh
	 kxj4q51CBMA4+zxZYbJeEzhGiSP6FDz+d9VBy6ZbMQN2gutCem+efoa7GUUWnAvzb+gJQ
	 X30oLUZqhq4jK55I1aiDpmYjid8/RAoCM4v6VdYL9dC9es6CJJi/DGili/2JxkGayeF2K
	 gFlyffmsWp2NbbUuZ1rfQGtm+eyTMw0WTtr17M0qkDC8JZuAQSskXTdWmWsg3t6dqh3+9
	 mhHGHNIZcFMSmURJdx+HOgJ1016mlKNQ4+tmfNAiEnyeiG3WshWWW2CW2mo5ihbjYmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXW2wkOp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799F606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXW2wkOp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15511F0089F;
	Fri,  6 Nov 2026 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975944;
	bh=bFCeBK4qdKlogWEuAteyJZ0UmU2nFLi1IfEEWVOmtMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XXW2wkOpM6Mn99mrzUzzfODAgMuxLMcz0jalrV8BorfIV4+EQn/8jIAOVywmcXxmi
	 xdDiKZqqqhyWYH4hdsURDsa09DUPX7Kf5Gb3uX1M+2MP14r3PmUvuCZDU08qYir3nn
	 30bPHDW7A3Wbbe9h0jxJ+yfyomwgkBFGUArb5d25zzb+Zy8627Q+FFzmMfV/vAOkgZ
	 QujiDCG0lhX/RDpYM8Mj48auMRuVsP3h1caI5R2bvugbMQEb1Gz/ItYY7JblbWf/OF
	 0ug4OGCznrla9AIbGOmBbkhJdP2EfEWlYnygSp+f9DhMRtKkzOgIpfElRIjtA5z3v4
	 VUm1rIWskEnQQ==
Message-ID: <sashiko-outbox-201597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] blktrace: require CAP_SYS_ADMIN for the BLKTRACE ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106142852.3233950-1-cui.tao@linux.dev>
References: <20261106142852.3233950-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:39:03 +0000
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
- [Medium] blktrace: missing CAP_SYS_ADMIN check in sg_ioctl_common()
--

commit 8392196724a6f06dfb860d63cf54fba3357cc04e
Author: Tao Cui <cuitao@kylinos.cn>

blktrace: require CAP_SYS_ADMIN for the BLKTRACE ioctls

This commit adds a CAP_SYS_ADMIN capability check to blk_trace_ioctl() to
restrict block tracing ioctls to privileged users.

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99e..c1bf8ca350fee 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -927,6 +927,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
ed cmd, char __user *arg)
>  	int ret, start =3D 0;
>  	char b[BDEVNAME_SIZE];
> =20
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
>  	switch (cmd) {
>  	case BLKTRACESETUP2:
>  		snprintf(b, sizeof(b), "%pg", bdev);

[Severity: Medium]
Does checking CAP_SYS_ADMIN only in blk_trace_ioctl() leave the sg
passthrough path in sg_ioctl_common() ungated?

drivers/scsi/sg.c:sg_ioctl_common() {
    ...
	case BLKTRACESETUP:
		return blk_trace_setup(sdp->device->request_queue, sdp->name,
				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
				       NULL, p);
	case BLKTRACESTART:
		return blk_trace_startstop(sdp->device->request_queue, 1);
	case BLKTRACESTOP:
		return blk_trace_startstop(sdp->device->request_queue, 0);
	case BLKTRACETEARDOWN:
		return blk_trace_remove(sdp->device->request_queue);
    ...
}

Because sg_ioctl_common() calls blk_trace_setup(), blk_trace_startstop()
and blk_trace_remove() directly rather than going through
blk_trace_ioctl(), an unprivileged process with access to an /dev/sg* node
can still allocate persistent relay buffers and control tracing state on
the underlying request_queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142852.3233=
950-1-cui.tao@linux.dev?part=3D1
