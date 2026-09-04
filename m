Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8D3B7B7B;
	Fri,  4 Sep 2026 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499284; cv=none; b=jMvfXHxjQLSKFelNlZdmh+qeDYyZ0wRZ56WESEgxjzbS3tdH0Lx2Mw1qaRKfNa6S+3F0ZkdivPcYTWvtz+yA4FDDavgsq37DLS05TrJLGhzTkbhg72nHgnzv1TPwW3Qae0kDoHtwWwe4zxNE85kTTkEIk6JhGSOUmLu15e4LIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499284; c=relaxed/simple;
	bh=X5ozIG10Ce9hsx/METcFRP5F7yooikx661AOjjl4qbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPhmrUVvsSArQD5TFZyVDPrX+F9ySAKIOlxiVY8ayeEXjhYQmPA9iqdIl5IujR03D2rPPxMi3XIDkGcb7uvVxVM0oNwulQ/UGxpUIITHQQTC2jlKIHIo66U4TxtUPZsX87OHQBIHPh3kNbemF5c/Lt/jQ2g6nvOfxCZRgczaYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2gaM5DG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2gaM5DG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E601F00AC4;
	Fri,  4 Sep 2026 05:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499283;
	bh=D9crCEWL5vnXxb2g5bv61naRSiuM325jlq1qnWvLlBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2gaM5DGvDl0GWPW8xEOqeIMfxBc5KH8Ij2fgXvSBRCFcGut/9ALQSn+7PBRfsj+/
	 Eb3eFQ9TgqyjkhOtHqbBYsASu5qxdQqjE4k9tmAnBveHy18FwO4MJj9o1cwgUhdQXG
	 RrfVCLQLOFmrJQfAx7p4StPNBMp5cPvqQ+58RmZhaAZtAWtmqxYh+Nk0Ble3ogL5oE
	 adDT+YMqb905bIdAHXaC6XyDqRawmRLL0rc6VqkiMt+fFLMBuq/w0mUDCvQZ9Sv762
	 sz5/FTjidMWeOlevCv0YTAROrYMg4ceK5VI1H7EmXzkpK44kvaXsVuSpAw5RpNE4G8
	 mzd4xxIHr7uJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] module: pull out add_taint_module() to be public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:21:22 +0000
Message-Id: <20260904052123.27E601F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added docstring for `add_taint_module` provides danger=
ously misleading advice regarding the `lockdep_ok` parameter, treating an e=
num as a boolean and effectively reversing its logical meaning.
--

commit 2864484c56cc4bda3a7f73ba92dcb0a54f6a1232
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: module: pull out add_taint_module() to be public

This commit makes add_taint_module() public so other kernel code can call
it, providing a fallback to add_taint() when modules are not enabled.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..444d990c99832 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
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

[Severity: Medium]
Does this documentation invert the logical meaning of the lockdep_ok enum?

Since lockdep_ok is an enum where LOCKDEP_STILL_OK is 0 and
LOCKDEP_NOW_UNRELIABLE is 1, a developer following this advice and passing
false (0) when a serious error occurs will inadvertently leave lock
debugging enabled. Passing true (1) for minor issues will unintentionally
disable lock debugging.

Would it be clearer to document the explicit enum values rather than
suggesting boolean true and false?

Also, there is a small typo in the parameter name here: @lockdebug_ok
is used instead of @lockdep_ok.

> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);
> -	set_bit(flag, &mod->taints);
> +	if (mod)
> +		set_bit(flag, &mod->taints);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-bind_taint=
-v3-0-30025465f38a@linuxfoundation.org?part=3D1
