Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5318A6CF;
	Fri, 27 Mar 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618667; cv=none; b=eEbdqi+5zYhWxdvTyBssUhBgsrkiVn9VDTy2Gpe5tM8O3xMqXGiQaMjnY9+Jq93IU9WGDGZ8Zwx74eAHI9mVP8J9m4d5q4FJ1PzFpVaqfeLTpTTJmuVoLVjpStIsFtKftNFoxDXfqb6AnrwSPzbGi8ZCvdfA7ODBVGCT8erwswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618667; c=relaxed/simple;
	bh=ziX8Pb9NteDHOy8jc3iBI5jysPxWYnSF9JhpXzTXk9s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kv2KfsHDU5feWbTcwx2J0nHHi7NLm2tI6+wOFReMc+IryP43yOf1JdZrQ1vwH/Rqq/F2Xzv6DWpl3sBHqntoGQP8eFB3XrwOMiiMqIeVJqmQRaEWBYcRg7iWGl8kJMoxKpnpT7CVdxPCSrUvcE2oF/Qzj0y+nZ5QFhbWT2ILwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZuPSDVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZuPSDVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB684C19423;
	Fri, 27 Mar 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618667;
	bh=ziX8Pb9NteDHOy8jc3iBI5jysPxWYnSF9JhpXzTXk9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZuPSDVDcvjXC33ASnJUA9ENi3f7SytVBxxqsvU+kbIpc3XOdR0M73jAEog2t1MnG
	 D+t+PLsn2pLOawWZA1jxQShlxiZ9F+1zVyUBFqanAAR6l+wRaUfnwiaqL6ekcNXSPs
	 2CM5FM40x17staYnpnNNkFdQO+fEHPdAZ506Ek2xxt+7pcqbFCw509nhrJZeyptKw2
	 +xOABWwDKsIC6L+0Ew8AffwhRWNLHyeg7oO9RDW1jxOFGMSSdry+6vrjl2C0oSNgLx
	 9Gl1C6TSvVzL/77SQsobIj0TiW5acvlqkv+LYjR747Etm+uwiu9YWkd1Pc1SVSkJXE
	 2g5gKwIHiC55g==
Date: Fri, 27 Mar 2026 22:37:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
In-Reply-To: <acZPZ4XKy4QynznK@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<acZPZ4XKy4QynznK@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 03:06:41 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hi Masami,
> 
> On Wed, Mar 25, 2026 at 11:22:04PM +0900, Masami Hiramatsu wrote:
> > On Wed, 25 Mar 2026 03:05:38 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> 
> > > +/*
> > > + * bootconfig_apply_early_params - dispatch kernel.* keys from the embedded
> > > + * bootconfig as early_param() calls.
> > > + *
> > > + * early_param() handlers must run before most of the kernel initialises
> > > + * (e.g. before the GIC driver reads irqchip.gicv3_pseudo_nmi).  A bootconfig
> > > + * attached to the initrd arrives too late for this because the initrd is not
> > > + * mapped yet when early params are processed.  The embedded bootconfig lives
> > > + * in the kernel image itself (.init.data), so it is always reachable.
> > > + *
> > > + * This function is called from setup_boot_config() which runs in
> > > + * start_kernel() before parse_early_param(), making the timing correct.
> > > + */
> > > +static void __init bootconfig_apply_early_params(void)
> >
> > [sashiko comment]
> > | Does this run early enough for architectural parameters?
> > | While setup_boot_config() runs before parse_early_param() in start_kernel(),
> > | it runs after setup_arch(). setup_boot_config() relies on xbc_init() which
> > | uses the memblock allocator, requiring setup_arch() to have already
> > | initialized it.
> > | However, the kernel expects many early parameters (like mem=, earlycon,
> > | noapic, and iommu) to be parsed during setup_arch() via the architecture's
> > | call to parse_early_param(). Since setup_arch() completes before
> > | setup_boot_config() runs, will these architectural early parameters be
> > | silently ignored because the decisions they influence were already
> > | finalized?
> >
> > This is the major reason that I did not support early parameter
> > in bootconfig. Some archs initialize kernel_cmdline in setup_arch()
> > and setup early parameters in it.
> 
> Would it be feasible to document which parameters are architecture-specific
> and must be processed during setup_arch()?

Yeah, at least we can mark what is not available in bootconfig.
Or, maybe we can export this function to setup_arch() for each
architecture.

Anyway, some cmdline options are not possible to be passed via
bootconfig. IIRC, for example, the initrd image address is
passed via cmdline (via devicetree) on arm64 from bootloader.

> 
> We could potentially introduce a third parameter category alongside the
> existing early_param() and __setup():
> 
> 	* early_param()
> 	* __setup()
> 	* early_arch_param() (New)
> 
> This would allow bootconfig to support __setup() and early_param() while
> explicitly excluding early_arch_param() from bootconfig processing.

Yeah, that maybe possible.

> 
> This would move break down the early parameters in those that can be
> easily handled.
> 
> > To fix this, we need to change setup_arch() for each architecture so
> > that it calls this bootconfig_apply_early_params().
> 
> Could we instead integrate this into parse_early_param() itself? That
> approach would avoid the need to modify each architecture individually.

Ah, indeed. 

Thanks!

> 
> Thanks for looking at it,
> --breno


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
