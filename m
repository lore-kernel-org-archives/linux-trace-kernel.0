Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018023BFE3E;
	Wed, 26 Aug 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740163; cv=none; b=iJA1xV990W48ctJQTqp+L6/2nzhWHNmAN5YED7jPI8tLwgNiqVdcWhn38WX/yirtLpUddKjLyVLf9o/sUsihXMbC6YPgicoJRJH5pwMliIDul+yVBsf5KRQhhyOjF43xCv18+8jDFxlvznnazZgOSTvkk6t/s09kjTZXaxBLV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740163; c=relaxed/simple;
	bh=iyOvRVrS5YdiNs7XBokG9Q+cJkxz6p1ke36zQYsLjfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUzDJW7MBG2HzQhgOFcea8rF1sxzFgRTaE9Fbhy5FDI9qXhMoq8xamHHB2hM+EpmwnsAZZzh9I4Smz5UsKvtSAsJrSyWuYLTg7L72h1O3opmP2yVZ7PiHqdaoI1u2mGuyo0f19mFKaFqnztIUL/j8O6CTbN2E/LWoR2Oo3ZUNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX2NWAZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX2NWAZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B81B1F000E9;
	Wed, 26 Aug 2026 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740161;
	bh=G0qVtZMDjGku1hsP47yYYXeyerJPGamppuqMKu/3dRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eX2NWAZFkDXZkaOpCp6iRemgL2r9N4m7uSEK/c0j4iKWWRnBWo0zgcuSFzEQGuIKT
	 eJ8pJq6Cf1xpuCsjNjZ3sXdRwFDhIADsAKFsM35h0kHzSGPcAqWJ5ZkgBnbqTi3oJa
	 13dZEihgwtjF1E2txsR5yq08P0JfX6FhBSo7+QzqsJrlln9JqzhNO05tyPX0/4w9aS
	 Jk9kvKH68aDlHlJCeVEUa4Sw8AV5rjvoAMPj1PnmefgbK/Fk/eBJ+JukP3CPRNklK4
	 prNZVLNhQyhBD7im/cyN4U5D8fR9PuM7xCv2jsT/qRUngGuqPJpOI18WdGg6CNsJLm
	 NBz9dq8GCtj4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:29:20 +0000
Message-Id: <20260826102921.5B81B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Potential NULL pointer dereference in `add_taint_module` if called=
 by built-in code passing `THIS_MODULE`.
- [Low] Syntax error in the `!CONFIG_MODULES` stub for `add_taint_module` c=
auses an unconditional build failure due to an undeclared identifier.
--

commit 371e790be5ebdf80163e6326d6a8f79c05f469bb
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

module: pull out add_taint_module() to be public

This commit makes add_taint_module() public so other kernel code can call i=
t.
It also provides a fallback stub that simply calls add_taint() when modules
are not enabled.

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea5..25221539e6459 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
[ ... ]
> @@ -877,6 +880,11 @@ static inline bool module_is_coming(struct module *m=
od)
>  static inline void module_for_each_mod(int(*func)(struct module *mod, vo=
id *data), void *data)
>  {
>  }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag, e=
num lockdep_ok)
> +{
> +	add_taint(flag, lockdep_ok);
> +}

[Severity: Low]
Is this a build regression when CONFIG_MODULES is disabled?

The third parameter in this stub specifies the type enum lockdep_ok but omi=
ts
a variable name. The function body then passes lockdep_ok to add_taint(),
which resolves to the enum tag rather than a local variable, causing the
compiler to halt with an undeclared identifier error.

>  #endif /* CONFIG_MODULES */
> =20
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..99cedb9618988 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -191,8 +191,17 @@ static inline int strong_try_module_get(struct modul=
e *mod)
>  		return -ENOENT;
>  }
> =20
> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +/**
> + * add_taint_module: add a taint flag if not already set for a specific =
module
> + * @mod: pointer to the module that caused the problem
> + * @flag: one of the TAINT_* constants.
> + * @lockdep_ok: whether lock debugging is still OK.
> + *
> + * If something bad has gone wrong, you'll want @lockdebug_ok =3D false,=
 but for
> + * some noteworthy-but-not-corrupting cases, it can be set to true.
> + */
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);
>  	set_bit(flag, &mod->taints);

[Severity: High]
Is this a regression that could unconditionally dereference a NULL pointer?

If built-in code calls this function (for example, passing THIS_MODULE which
evaluates to NULL for built-in modules), mod->taints will be accessed witho=
ut
a standard if (mod) safeguard.=20

This could lead to a fatal page fault if, for instance, a local root user
writes to a built-in driver's bind or unbind sysfs file which then calls
add_taint_module(drv->owner, ...).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-bind_taint=
-v1-0-52b05f4a965c@linuxfoundation.org?part=3D1
