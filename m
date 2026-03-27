Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D228D8D1;
	Fri, 27 Mar 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606024; cv=none; b=pm4vvB0GaZnwTWkPMOHmt8EtdLjjCGdMoqev4fs43c/cW0CdXYDOoJzpaXaqqgY4ftRngAgG75bY0kEE0BPp9fEXKNNxTYf5e+9QQBsAuXkIGfAomjlLJ+nEPf4BfyVCoc0K8qSx+Ir2tIanFOkMmP1fYtEnSjwL258tXbvJJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606024; c=relaxed/simple;
	bh=9hoqf8836qUkHCGwSuoanrTdy8WBwzbnZSoL6IVkKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5iER1eOCU7zDnWPQJh1TeSYaX5eXDgZMl8nzgHv39sUJM03RzXMnaN4rIdCTvhgGe3JRtP+5cbPwghlaiDSeJPi3oFOXZyCXhwPqfZy7YdYLVF21gji8kd+VjPT5K5DvotULy+xBtJ8iiqjQ29CZ4RGOmpLDbavMg860HKXegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=V3evrK8Q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V3evrK8Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T5M5vU1ThQjnLaTGimKygXppER6xPWGVctbXzovZmnQ=; b=V3evrK8QsRWoHKUc2Vpt0X+j0c
	jUlztjZb8QlzR1CZ2xnkyBML9NrZHevWxmsPPbZ9AvVDNqe4EshgwF+PIwr3S7oixI/06tMBkIe1z
	iSF0xz56SUBvp1aRXovTIyNnTlNy00xNRJ3OlYJ06DdtHGpxVtDY3eI0EiU0XNt1G2qTnp3Fus+OH
	fOOBbIiwbSXwmQi4ccekOLHzRq5xnS0k4Lo5oLcse42qe+GaoIlZuX5u0PEb13fBq4ca49kLyUZ2n
	dqC3Z5P8+z8r53LEqj9I7DcLp5cxTt6tRFkZZ2LaDoqqk6oTddvvPzYOSd+bJgEpzhiCUCzA5RqsG
	XEu3t7vg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w645X-00AY6o-CS; Fri, 27 Mar 2026 10:06:47 +0000
Date: Fri, 27 Mar 2026 03:06:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acZPZ4XKy4QynznK@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
X-Debian-User: leitao

Hi Masami,

On Wed, Mar 25, 2026 at 11:22:04PM +0900, Masami Hiramatsu wrote:
> On Wed, 25 Mar 2026 03:05:38 -0700
> Breno Leitao <leitao@debian.org> wrote:

> > +/*
> > + * bootconfig_apply_early_params - dispatch kernel.* keys from the embedded
> > + * bootconfig as early_param() calls.
> > + *
> > + * early_param() handlers must run before most of the kernel initialises
> > + * (e.g. before the GIC driver reads irqchip.gicv3_pseudo_nmi).  A bootconfig
> > + * attached to the initrd arrives too late for this because the initrd is not
> > + * mapped yet when early params are processed.  The embedded bootconfig lives
> > + * in the kernel image itself (.init.data), so it is always reachable.
> > + *
> > + * This function is called from setup_boot_config() which runs in
> > + * start_kernel() before parse_early_param(), making the timing correct.
> > + */
> > +static void __init bootconfig_apply_early_params(void)
>
> [sashiko comment]
> | Does this run early enough for architectural parameters?
> | While setup_boot_config() runs before parse_early_param() in start_kernel(),
> | it runs after setup_arch(). setup_boot_config() relies on xbc_init() which
> | uses the memblock allocator, requiring setup_arch() to have already
> | initialized it.
> | However, the kernel expects many early parameters (like mem=, earlycon,
> | noapic, and iommu) to be parsed during setup_arch() via the architecture's
> | call to parse_early_param(). Since setup_arch() completes before
> | setup_boot_config() runs, will these architectural early parameters be
> | silently ignored because the decisions they influence were already
> | finalized?
>
> This is the major reason that I did not support early parameter
> in bootconfig. Some archs initialize kernel_cmdline in setup_arch()
> and setup early parameters in it.

Would it be feasible to document which parameters are architecture-specific
and must be processed during setup_arch()?

We could potentially introduce a third parameter category alongside the
existing early_param() and __setup():

	* early_param()
	* __setup()
	* early_arch_param() (New)

This would allow bootconfig to support __setup() and early_param() while
explicitly excluding early_arch_param() from bootconfig processing.

This would move break down the early parameters in those that can be
easily handled.

> To fix this, we need to change setup_arch() for each architecture so
> that it calls this bootconfig_apply_early_params().

Could we instead integrate this into parse_early_param() itself? That
approach would avoid the need to modify each architecture individually.

Thanks for looking at it,
--breno
