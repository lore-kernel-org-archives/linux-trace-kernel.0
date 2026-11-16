Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869882;
	b=lKdU/wFlMYFu2/VFToJWmBxdLwG4uyLVbBwQdAfDz3Oam6zabqOgOpfVuIu95Tgi1NdT
	 a7ByozXaDyRk81y0hJcITGslgGzZc0tLS7KQe29lTrzkF7BVXOJ9BHI36XaS9IEEBEyid
	 eRq02rYh3tchF1pchCLcLaYuCC+2/F3urjEhfGqxpFi8OmzhvMIbeEIsH2RGPolIvz2eZ
	 0nEXKvTa1GFFyIJlStMoeDmBRHOn/HUezJncDYKXh6GLsI63cbAD7fRFOiOmt9JJd1ICa
	 pn6PKqbCL21OWVjsyQKnSXo9PCo+USdsLd9ZNwXsTVADh7pAH6rMnAXakk+V7t72osw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qi3VxZRMByLQRHApLWxrb5WefbpJAiZWBbnfTFEqRko=;
	b=z0wIj4zp1tL6KFGuOSsFW6OmYARiTQE3rBUnpye4NzQ6Ze1ANr3JAo4qVtpimXG/vEiR
	 XG413CwYawT5cN9Wbq6/rT12WbXKsO802Y3zd3EwNcTQvd8dAPzbIlK2EnlNFPBS18mOj
	 5hxeOXml4soJDa68m8RFKRwkZmu8pEDvgdZbXo7XfLAQzboSkDjwBu3lLH9eR33tnL3IH
	 2uLvHmgIHMxAMF2SHf7lU0+k8MNtWdqjb5j7CV0g9rd1zW5kR00vg/8goP4Y4k/EBaQnU
	 eotTFqB0/qrDHXxob8ZrKmCmIZLjB78UE2lAz65jKQAY3TxKVIfZUiJVT6k27uzDEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dp20ZWxy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5F606A323
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dp20ZWxy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319821F000C4;
	Mon, 16 Nov 2026 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794869882;
	bh=Qi3VxZRMByLQRHApLWxrb5WefbpJAiZWBbnfTFEqRko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dp20ZWxyY3emZ1F8smMPsED08y6V2ElPl/zQcTdjYUeJdndZiolGkt4Z5DHwqQweY
	 atXzszhgRZ++Z5zjgz5t6EemKMhm+4ftKlFL9kwl0H5dW449pUn1LWbiuMLS0q40fu
	 EdgfYsoDlAiB82aD7UMecaYkOGoljgs2/UK/yDcjq9YCIo8JlTjjEk6lok1NvNE+er
	 BX6ma69hurK1a+ou4x3s23rrCu9QF/pE2o2d4zv+XgeRJoXePs/nkHqQsPusRkP9nW
	 rWMoTAOut0TS/aP/ZxCweNSihAQk0xMmmRPv0fmnqy9ezdKypSKsF9cmzSPDlcxQLA
	 I1MpRJVRGpbxA==
Message-ID: <sashiko-outbox-217828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Norris" <briannorris@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:58:01 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] tracing: FTRACE_STARTUP_TEST misuses select GENERIC_TRACER
- [Low] tracing: inaccurate Fixes trailer commit in commit message
--

commit 4d561c782a03c23e0e690cb6af78d98e81aa94d6
Author: Brian Norris <briannorris@chromium.org>

> tracing: 'select' GENERIC_TRACER, not 'depends'
>
> GENERIC_TRACER is not a user-selectable symbol, so it's impossible to
> enable FTRACE_STARTUP_TEST unless one also enables some other symbol
> that 'selects' GENERIC_TRACER for us.
>
> This very file also suggests:
>
>   All tracer options should select GENERIC_TRACER
>
> So, use 'select', not 'depends on'.
>
> Fixes: 60a11774b38f ("ftrace: add self-tests")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

[Severity: Low]
Commit 60a11774b38f ("ftrace: add self-tests") added FTRACE_STARTUP_TEST
with "depends on TRACING" before GENERIC_TRACER existed.  Should the Fixes
tag instead reference 5e0a09391087 ("tracing: fix config options to not
show when automatically selected"), which introduced GENERIC_TRACER and
changed FTRACE_STARTUP_TEST to depend on it?

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c41397eccee50..347658dabbe33 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -1135,7 +1135,7 @@ config FTRACE_SELFTEST
> =20
>  config FTRACE_STARTUP_TEST
>  	bool "Perform a startup test on ftrace"
> -	depends on GENERIC_TRACER
> +	select GENERIC_TRACER
>  	select FTRACE_SELFTEST
>  	help
>  	  This option performs a series of startup tests on ftrace. On bootup

[Severity: Low]
Should FTRACE_STARTUP_TEST depend on TRACING (or select TRACING) instead
of selecting GENERIC_TRACER?

GENERIC_TRACER is meant only for full tracer options so that
ENABLE_DEFAULT_TRACERS is hidden when a full tracer is enabled:

kernel/trace/Kconfig:
    # All tracer options should select GENERIC_TRACER. For those options th=
at are
    # enabled by all tracers (context switch and event tracer) they select =
TRACING.
    ...
    config ENABLE_DEFAULT_TRACERS
    	bool "Trace process context switches and events"
    	depends on !GENERIC_TRACER
    	select TRACING

Because FTRACE_STARTUP_TEST is a test option rather than a tracer, having
it select GENERIC_TRACER disables and hides ENABLE_DEFAULT_TRACERS when no
full tracer is configured, and implicitly pulls in TRACING even when all
tracers are disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116144652.1.Ie=
cb63200dd245f62032a3b1f60ae78cc48868094@changeid?part=3D1
