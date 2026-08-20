Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC047D92E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245142; cv=none; b=L8nf5JxR/TUXtAoyFhFp1HEZ0BrEo4EkyExp/SBlVYzP/JO56AgYT7X2wGScPmH90rxKvTu1JNEQt3lqRU4mg4ocON5/pG9Zz8h4027pNeG3W8Rvp/rRpT53yGSdFM9WCJUXBQBGjMf0xYjpa3ZtLldyfkzLp3iTZfZu/1O64us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245142; c=relaxed/simple;
	bh=EFVk/X6uNvGCheBayfwqXLCbBrHcieexknLGpE8nkVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQ9xocMRX4pyAhPUYn8P9AuCelYZ47I+t/F5UZwvjruRU65ouEgBa9C30GwY4Xwh6snDPiqeTQP5vC6cN9RJ6kSvmKFF+GjtIR3/pOn2EyPtTa/Ah5xacphPR0VINZvZiBwHlCwKEfYPFEN7Vjw/FRy7CxgVKYMo+s7831EPpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTNivpRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTNivpRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB4F1F000E9;
	Thu, 20 Aug 2026 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245141;
	bh=OcGKm3XIclKWrhYDJcbdQlXcWhrOOhJ54vk1/4XViFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTNivpRGCc3tmhjV1Fp60mt5Z0UgmSLC1tYcaL8Uqu4tYqAuX0s0XqgHO/H9sSMUt
	 d4EczWPmmUgJDPW9Umhd2IKap+d8DS55K21Oyp4D4eFDjbZudg0J7pTbPqfndm+Uwj
	 HLQZZwb75sxxLLCWCCDFmZic0Etkb2v8hERFvaWDKTxoTh6Az8e7lpQ9GuUHz/u1wg
	 EFXe8dmcSXV76xNluHBmcyhSL/aaePy8gQEns1ux+ok88SKNCX0DaZWZDQGrgJ2ymF
	 WzhJeMvvdqfzALwpRU0a0iE1bYL+9X3kLM/H5b+N/+QLd9eu6TtFbjOglBdal1dOUV
	 WOmXqyeSOwvkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] rv: Add generic uprobe infrastructure for RV
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <16b5866f7425a94d42ae370e8e6974911ced9513.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <16b5866f7425a94d42ae370e8e6974911ced9513.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:59:00 +0000
Message-Id: <20260820165900.CFB4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] API state tracking design in `rv_uprobe` leaves stale pointers o=
n error and breaks state validation for batch cleanup, trapping callers int=
o a double-free or memory leak.
- [Medium] The commit message explicitly states a factually incorrect resou=
rce lifecycle that contradicts the code and creates an RCU use-after-free h=
azard if implemented as described.
--

--- Patch [2]: [PATCH v6 2/9] rv: Add generic uprobe infrastructure for RV =
monitors ---
commit be3e5812586424192ba2d5028d63b1a9b959099b
Author: Wen Yang <wen.yang@linux.dev>

rv: Add generic uprobe infrastructure for RV monitors
   =20
Monitors that instrument user-space function boundaries need to resolve
paths, register uprobes, and deregister them safely.  Provide a thin
wrapper so monitors share a single implementation of this boilerplate.

> struct rv_uprobe embeds struct uprobe_consumer directly, avoiding a
> separate heap allocation per probe.  The struct holds a struct path for
> the probed binary so that the inode and its mount remain referenced for
> the full uprobe lifetime; uprobe_register() does not take its own
> reference to the inode.  The path is released in
> rv_uprobe_unregister_nosync() after the consumer has been removed.

[Severity: Medium]
This isn't a bug in the code, but this statement contradicts the actual
implementation. Looking at the code, rv_uprobe_unregister_nosync() explicit=
ly
leaves the path held to prevent RCU use-after-free hazards, relying on the
caller to release it after rv_uprobe_sync(). Could this description be
updated to match the code?

> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> new file mode 100644
> index 0000000000000..b412a8e28a6ec
> --- /dev/null
> +++ b/kernel/trace/rv/rv_uprobe.c
> @@ -0,0 +1,91 @@
[ ... ]
> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_upr=
obe *p)
> +{
> +	struct inode *inode;
> +	int ret;
> +
> +	ret =3D kern_path(binpath, LOOKUP_FOLLOW, &p->path);
> +	if (ret)
> +		return ret;
> +
> +	if (!d_is_reg(p->path.dentry)) {
> +		path_put(&p->path);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Do these error paths leave a stale pointer in the caller's struct?

When path_put() is called, p->path.dentry is not cleared. If a caller is
using an array of struct rv_uprobe and tries to batch clean up failed
registrations, could they accidentally use this stale pointer and cause a
double-free?

> +
> +	inode =3D d_real_inode(p->path.dentry);
> +
> +	/* uprobe_register() takes no inode reference; the path is held in p->p=
ath */
> +	p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
> +	if (IS_ERR(p->uprobe)) {
> +		ret =3D PTR_ERR(p->uprobe);
> +		p->uprobe =3D NULL;
> +		path_put(&p->path);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +void rv_uprobe_unregister(struct rv_uprobe *p)
> +{
> +	if (!p || !p->uprobe)
> +		return;

[Severity: Medium]
Does this early return cause a memory leak if the caller previously used
rv_uprobe_unregister_nosync()?

Since rv_uprobe_unregister_nosync() clears p->uprobe to NULL, a caller
attempting to use rv_uprobe_unregister() on it later will hit this early
return. This skips path_put(&p->path), permanently leaking the path
reference.

> +
> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
> +	p->uprobe =3D NULL;
> +	rv_uprobe_sync();
> +	path_put(&p->path);
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
> +
> +/**
> + * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
> + */
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> +{
> +	if (!p || !p->uprobe)
> +		return;
> +
> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
> +	p->uprobe =3D NULL;

[Severity: Medium]
If p->uprobe is cleared here, how does the caller know which paths need to =
be
released later?

The documentation suggests batching deregistrations. However, if p->uprobe =
is
set to NULL here, any subsequent iteration over an array to conditionally c=
all
path_put() has no reliable state indicator left to determine if the path was
actually held, potentially leading to incorrect cleanup.

> +	/* path held; caller must call rv_uprobe_sync() then path_put(&p->path)=
 */
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D2
