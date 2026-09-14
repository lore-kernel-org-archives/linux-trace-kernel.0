Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C24446E9;
	Mon, 14 Sep 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396689; cv=none; b=pPKjMg4mroaAczq5szCyWSx8QAm+S7ijUQQuQEWKHMoE/bCJ6erWOGOJi/Qhd3dHdt/hKMTRZy5IWYT4LkcEtOnNJFAyWMxOiuWUe/Mdb99oOp2dPGQBrog6WTCriEvDfimCt0LlzSOsMqawHlpzhnFT2q205s4MK3BEhJPHqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396689; c=relaxed/simple;
	bh=knM2VXjnoxa+7DS0IiR/0ojZCj0RHWOUD6Qs61G2nnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OP88c9xZsC8zgKK08+5XPq5pEq8QAtFZmQHQQrekXr+Xu2dAZ7VhXmcyjkRT+yo/RdTyhK7A+chQUBZNHWZPFDzknOSXw5tVjPA1uv5vYfXKYXOMbjtOLndRnqvdnl494uP56iOXKEc/C5lRpXWopIZQaxbNxKt2WgVCLQoXphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnUwfJJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnUwfJJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5895E1F00893;
	Mon, 14 Sep 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396687;
	bh=7Q4Ps+7FFRegAtf8nnDfJRqlHg7/ysSdP5doj/M1M+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnUwfJJ7F7Vz3yn+eFZKVhMqZy6WBLD9grFMwf8KeWS7ZFacUl6iIWMVSJIeJdVSp
	 nHM39Te6AWkXytPb5d/Xt9ot4kffFMcJw2Q/r8EAJFVKyuT+IA7tUPREeawzcP+nnl
	 EhjWuuyZnRLc24uZpjBdzOk8W3c4sWtFQpvokwVik0ty/i/Co6g8DJ6gw6Z5oFVcpb
	 mmbj6YqlDRy+eTNvLNhucdIAram45xSuVX+jClKx2atQGNZ2/gmC3NVV/Q/w9FWU/F
	 GQ9Olsk134R5ANAzydh2nxLuqNQJoyc/93yLOlkvHTHUfityVNOCyHTbi6IB55bf9h
	 gA9kdicPLY3Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] module: pull out add_taint_module() to be public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260914-bind_taint-v4-1-eadf8a090903@linuxfoundation.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <20260914-bind_taint-v4-1-eadf8a090903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:38:06 +0000
Message-Id: <20260914143807.5895E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing EXPORT_SYMBOL for add_taint_module() causes link failures f=
or loadable modules.
--

commit af64416dcd45d326037820ed7ffd035efeed6ec0
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

module: pull out add_taint_module() to be public

This commit extracts add_taint_module() and makes it a globally accessible=
=20
function so that other kernel code can call it to taint specific modules.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..444d990c99832 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct modu=
le *mod)
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
> -	set_bit(flag, &mod->taints);
> +	if (mod)
> +		set_bit(flag, &mod->taints);
>  }

[Severity: Low]
Since the commit message mentions that other kernel code might want to call
add_taint_module(), does this function need an EXPORT_SYMBOL() declaration?

Without an export, if a loadable module attempts to use this function as a
module-aware counterpart to add_taint(), it will cause a build error
due to an undefined reference during the modpost stage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-bind_taint=
-v4-0-eadf8a090903@linuxfoundation.org?part=3D1
