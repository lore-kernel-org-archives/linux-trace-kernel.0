Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644D3CF210;
	Sat, 22 Aug 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407553; cv=none; b=EOYQUvQbTyRkO2T6OvzoHb8SU/3K0Cb1MpkC/nMh69R/4m6PB3RYH0wE2IrcOGOjrK3ECeyENkYzmoYMgzBYaUlbSA/3g0L9bT8TXRH4UBGijLwD0pIilg2UwXxbi5Ij3L+VpREpQIILNTjo54YFR2JCbmaWDM4+2G6zkTkICdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407553; c=relaxed/simple;
	bh=JsIIoZYgt5eEYttPnTfkR9/jPMjWMtOlzsYro7LmaDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VekR4ucG7YsaNHkKf76a44dqfNzN+VmbBLbQZXmwTMdcyW4yrPMxvvvr/9c6yogZj11iO2TGcM124+mzwKOGF8lgTDFnhwD9V3LkpSaJ7p057UbXuY08zzoXQLQ7HQsgEIC4GsS+TZvv5mkr0GUF/ndJR7l9+gTlNBApJSIhp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6cJlFr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6cJlFr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B10C1F000E9;
	Sat, 22 Aug 2026 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787407551;
	bh=DUbk8OTyDmHLqxvSP0sp35oTtnh3tMFBfCYiLNLnd1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6cJlFr6Zx/2Dojq7tUUudDVb9AF5r6oReMZeRH+V9N+NtSNtDhzwhdJilqKf4Bts
	 abzb7F5o0zTaYUURCefIwDcSuEwmaXarosLlB6qmm4CC/UH4Ao2mTQjkXli3plr/OE
	 ixlgJEepWxa4K/WaiFLkU2kgbydCkGG22X7t9LOUd4DFRWKfrdMsgHnWnBdeI+MqUq
	 NnAJRwMZqrAholXUDyLaKEK9MCm023718ERWiYoLkp64GI7YMDzvROxT0kbbvYLw33
	 bRrT2KSDL2kFZnnAvsJtkCJkvtcgIHSQaOzuAhb11psSeahmTaARAMK7qR46l1+2fl
	 aS98rvBAR4XEQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/9] module: Place MOD_TEXT before MOD_INIT_TEXT in
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260822135323.795946-14-ardb+git@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-14-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:05:50 +0000
Message-Id: <20260822140551.1B10C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The reordering of `enum mod_mem_type` breaks the `lx-lsmod` GDB =
script command, causing it to report a core module size of 0 for all loaded=
 modules.
--

--- Patch [3]: [RFC PATCH 3/9] module: Place MOD_TEXT before MOD_INIT_TEXT =
in enumeration ---
commit 5a5649e85e950b908f9830e5862b49ac415dfa18
Author: Ard Biesheuvel <ardb@kernel.org>

module: Place MOD_TEXT before MOD_INIT_TEXT in enumeration

This commit reorders enum mod_mem_type so that MOD_TEXT appears right
before MOD_INIT_TEXT. This ensures MOD_INIT_TEXT is allocated immediately
after MOD_TEXT, reducing fragmentation when truncating allocations in
subsequent patches.

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe8..0336a46733dd9 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -316,10 +316,10 @@ struct mod_tree_node {
>  };
> =20
>  enum mod_mem_type {
> -	MOD_TEXT =3D 0,
> -	MOD_DATA,
> +	MOD_DATA =3D 0,
>  	MOD_RODATA,
>  	MOD_RO_AFTER_INIT,
> +	MOD_TEXT,

[Severity: Medium]
Does this reordering break the lx-lsmod GDB script command?

In scripts/gdb/linux/modules.py:LxLsmod.invoke(), the total size of a=20
module's core sections is computed by iterating over the memory regions:

for i in range(constants.LX_MOD_TEXT, constants.LX_MOD_RO_AFTER_INIT + 1):
    total_size +=3D module['mem'][i]['size']

Because MOD_TEXT now evaluates to 3 and MOD_RO_AFTER_INIT evaluates to 2
with this change, the Python iteration evaluates to range(3, 3). This
generates an empty sequence and the total_size remains 0 for all loaded
modules.

>  	MOD_INIT_TEXT,
>  	MOD_INIT_DATA,
>  	MOD_INIT_RODATA,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822135323.7959=
46-11-ardb+git@google.com?part=3D3
