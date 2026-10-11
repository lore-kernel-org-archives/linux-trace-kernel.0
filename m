Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2692DCBEC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748152; cv=none; b=f5R9nTyrwq3GWlCetxurgXa9Nm2pnAklkk2zUSESNW0pxdj8lVXtRNt3Wy/vpoIl7tskWqgQXlj9oNfMTre49kidhWfedbX9nMHgxXst1hbPcPT9lNRbIi1tMtImDMqfpqG/Z9RjWCKLH5GRXVfHsCGkY8on2QDAwzF5LeXzsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748152; c=relaxed/simple;
	bh=iHgEkFRs9geEIuYm+oRsuiM0g6zQ4Bm5Qq0rT7tV1qQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bpXah8CVph4CoNi98LCNWlKDqFZca9zHze4CoAerAQo+pP0UHdXoE6g9XM7a6yx1Nouwc/2N0Lt5KVqoDwsjW794hDicn5QYj3rpaG49dWGjHY2XAsERu3OVRT8yFAlQ6QOHfIMw3Hlp/YWhI9abrbdK938BpWgc5hEP7r35/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJt1ZAHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJt1ZAHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902B51F0089B;
	Sun, 11 Oct 2026 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748150;
	bh=tjYP8e/ZqM8enfgkRHsu9dzgYHyqDvlhQCsjVpHLYNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJt1ZAHKrxkKT6+BeKBdcBQAke8nGZj98nAG5fPe5e51fIrMKwREAB6ObCniH8RXG
	 o3RabTxlvl7Xa5Mlm8L64r5gROxiKZkdx9ZMUwDX/rtkF6iqVMdJLvNe4GNsbOTOJB
	 trkonxmdzL/XNGTV+8iHQdn/BTJKR++8KbPobG444xU2xSw8bidj2XBVSoPtl2t5lg
	 6zkmOicfip16yY+2eq3LTvqn0K7p8D1mkLApTRO+BzEtnJ3cp7ulJB9TqbFvOoolBR
	 RJSZfS2ars5hxCVRWyyvXCDFwlH4qWVZlPMTvLDRs6I/peuYFFTiAAJZFW3Ib0P3OY
	 U0OkwCC05Gt4A==
Message-ID: <sashiko-outbox-167418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] rv: Add generic uprobe infrastructure for RV
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <1f311bb81a9270391bb9d3aa03b8b881de928c1a.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <1f311bb81a9270391bb9d3aa03b8b881de928c1a.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:49:10 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] uprobes: missing vfsmount reference leads to VFS BUG on unmount
- [Medium] uprobes: double registration leaks inode reference and corrupts =
consumer list
- [Low] uprobes: missing <linux/export.h> inclusion
--

commit 27eb3c739b9acf445ce512a1c9be0a7dca8bace0
Author: Wen Yang <wen.yang@linux.dev>

rv: Add generic uprobe infrastructure for RV monitors

Monitors that instrument user-space function boundaries need to register
uprobes and deregister them safely. Provide a thin wrapper so monitors
share a single implementation of this boilerplate.

> diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> new file mode 100644
> index 0000000000000..b93c2a81bc228
> --- /dev/null
> +++ b/include/rv/rv_uprobe.h
[ ... ]
> +/*
> + * Free the containing struct only after rv_uprobe_unregister_nosync() +
> + * rv_uprobe_unregister_sync() + iput(p->inode).
> + *
> + * The inode reference does not pin the dentry, so callers that re-resol=
ve the
> + * probed path must hold a struct path: 9p cache=3Dnone remints an inode=
 per
> + * lookup.
> + */
> +struct rv_uprobe {
> +	struct uprobe_consumer	uc;
> +	struct uprobe		*uprobe;
> +	struct inode		*inode;
> +};

[Severity: High]
Does this struct need to hold a reference to the vfsmount as well?

The core uprobes API documents that the caller of uprobe_register() is
required to keep the inode and the containing mount referenced.=20

If the infrastructure only pins the inode via igrab(), and the caller does
not independently hold a mount reference, user-space could unmount the
filesystem while the monitor is active.

During unmount, the elevated inode i_count from igrab prevents eviction,
which causes the VFS superblock shutdown sequence in generic_shutdown_super=
()
to trigger a bug for busy inodes after unmount.

[ ... ]
> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> new file mode 100644
> index 0000000000000..1c7f8466aeedd
> --- /dev/null
> +++ b/kernel/trace/rv/rv_uprobe.c
[ ... ]
> +/*
> + * uprobe_register() takes no inode reference of its own, so grab one he=
re and
> + * drop it only after rv_uprobe_unregister_sync().
> + */
> +int rv_uprobe_register(struct inode *inode, loff_t offset, struct rv_upr=
obe *p)
> +{
> +	int ret;
> +
> +	p->inode =3D igrab(inode);

[Severity: Medium]
What happens if rv_uprobe_register() is called on an already registered
struct rv_uprobe?

Since p->inode is unconditionally overwritten with igrab(inode), the previo=
us
inode reference seems to be leaked without calling iput().

Additionally, passing an actively linked uprobe_consumer to uprobe_register=
()
again could corrupt the uprobe subsystem's internal consumer lists.

Would it be safer to check if p->inode is already set before proceeding?

> +	if (!p->inode)
> +		return -ESTALE;
> +
> +	p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
> +	if (IS_ERR(p->uprobe)) {
> +		ret =3D PTR_ERR(p->uprobe);
> +		p->uprobe =3D NULL;
> +		iput(p->inode);
> +		p->inode =3D NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_register);

[Severity: Low]
Could this EXPORT_SYMBOL_GPL usage cause build failures on some architectur=
es?

The source file uses EXPORT_SYMBOL_GPL but does not explicitly include
<linux/export.h>. Relying on implicit transitive inclusion of this header
can lead to build breakages on alternative configurations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D9
