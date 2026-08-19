Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768C44065B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164022; cv=none; b=m8kdUMRP2YoX/TOz2CNYZzPsiF50HDfyr1iHEgZd5kMaJRGTpoeZrd9ei9L4lh9S2EPls9N3Hb+Q6Gwl22MAdgsKngXkWBAFkf0h2xeZ8bHJu8Kne5OkSMXT3GPI+qlx58AGgmzZrg+Yw8r6GXdIAPXSlXoKq+2VDL1WHrzyW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164022; c=relaxed/simple;
	bh=p+Qj+ryh/7lpusBTmdTtOULYTID5jMud53GGNTf6vLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQgLYVsFq99ZDd1leBfRZ9ES9U2JfRY6Foy2cYBiuZuh3BIpY/LoPWk6PIAp4NKG3WBSB/801cicoCrmpzwEwsDJhgpil/fTQfUDmUYuNr6OoFxjt0HUryY/DeWBI3vP9y8fKVhCVS/TgMv2xuiRqHsN0vycYeBFNaVuLFfooW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Lr3Fg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Lr3Fg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F81F000E9;
	Wed, 19 Aug 2026 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164021;
	bh=ErlVtYtpDchU43wkMAhhZino4+mAWFSA3xMKYKJnswo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+Lr3Fg/y1wNPiXR3iGq6PnRd9ln4S8u8NVeatJcprcMjc/elVFP72Wlm4WaYEEHB
	 7dLjI6TITE2GDwak+ivTPw3tIDXkrdPJjdbSJGb91B2G6APq43bEo+w9IFkFfoSjOc
	 IcNA3+qkJrb+ycw1AggKPUJQq7clHIcd9h3j0/MXy3eeN8LCJl/csFXY4+KqlPlv/H
	 JZgRXJSe64psFGF/HEqRCgYQkJAlr5AHVrp346pf5B6jrcmzxUCnA9s9nNgBWz1dVK
	 KU5mk6XtkQxTO7pGs/HoywDqJSUpjR6+bktsvIXiKJGsVYoP05fuz5IXE6CR4/vV6M
	 gkT9DIL/SsNAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] rv: Add generic uprobe infrastructure for RV
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <683751e6d588baf407a96a0a7a2e9ec12c5d865b.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <683751e6d588baf407a96a0a7a2e9ec12c5d865b.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:27:00 +0000
Message-Id: <20260819182701.039F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `rv_uprobe_unregister_nosync` API destroys state needed for sa=
fe batch cleanup, leading to resource leaks or double-frees.
- [High] The `DECLARE_RV_UPROBE` macro fails to zero-initialize the structu=
re, risking execution of uninitialized function pointers.
- [Medium] The commit message explicitly contradicts the code regarding pat=
h release in `rv_uprobe_unregister_nosync`.
--

--- Patch [2]: [PATCH v5 2/9] rv: Add generic uprobe infrastructure for RV =
monitors ---
commit 51a0e9ee4d8b7c0315a129cc3c664429f117eeb4
Author: Wen Yang <wen.yang@linux.dev>

rv: Add generic uprobe infrastructure for RV monitors

Monitors that instrument user-space function boundaries need to resolve
paths, register uprobes, and deregister them safely. Provide a thin
wrapper so monitors share a single implementation of this boilerplate.

>     The path is released in
>     rv_uprobe_unregister_nosync() after the consumer has been removed.

[Severity: Medium]
The commit message states that the path is released in
rv_uprobe_unregister_nosync() after the consumer has been removed.
Is this description accurate?

Looking at the code for rv_uprobe_unregister_nosync(), it explicitly
defers releasing the path to the caller. Could the commit message be
updated to match the actual implementation?

> diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> index 0000000000000..d0a9079ac5be4
> --- /dev/null
> +++ b/include/rv/rv_uprobe.h

[ ... ]

> +/* Embed a named rv_uprobe inside a caller struct */
> +#define DECLARE_RV_UPROBE(name)		struct rv_uprobe name

[Severity: High]
Does this macro zero-initialize the structure?=20

Since it simply expands to a struct declaration, local variables using
this macro might contain stack garbage. If a caller only sets p->uc.handler,
could this leave other uprobe_consumer fields like filter or ret_handler
uninitialized, causing the uprobe subsystem to execute random memory when
triggered?

> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> index 0000000000000..b412a8e28a6ec
> --- /dev/null
> +++ b/kernel/trace/rv/rv_uprobe.c

[ ... ]

> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_upr=
obe *p)
> +{
> +	struct inode *inode;
> +	int ret;

[ ... ]

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

[Severity: High]
When uprobe_register() fails, path_put() is called, but p->path is not
cleared. If a caller blindly loops over an array of probes to clean up
paths later, could this leave dangling pointers that result in a
double-free?

[ ... ]

> +void rv_uprobe_unregister(struct rv_uprobe *p)
> +{
> +	if (!p || !p->uprobe)
> +		return;
> +
> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
> +	p->uprobe =3D NULL;
> +	rv_uprobe_sync();
> +	path_put(&p->path);
> +}

[ ... ]

> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> +{
> +	if (!p || !p->uprobe)
> +		return;
> +
> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
> +	p->uprobe =3D NULL;
> +	/* path held; caller must call rv_uprobe_sync() then path_put(&p->path)=
 */
> +}

[Severity: High]
By setting p->uprobe to NULL here, does rv_uprobe_unregister_nosync()
destroy the state needed to safely perform the path cleanup?

If a caller attempts to use rv_uprobe_unregister() to clean up paths
after a batch of nosync operations, it will return early because
p->uprobe is NULL, silently leaking the VFS path reference:

rv_uprobe_unregister() {
	if (!p || !p->uprobe)
		return;
    ...
}

Alternatively, without external shadow state, how can a caller
distinguish between a successfully unregistered probe that needs a
path_put() and a probe that failed registration initially?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D2
