Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82E26299;
	Wed,  1 Apr 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005361; cv=none; b=DpHwfheo0pNPWdEUUcsOvNg2/dDyz0iEMg/7FQFgcbRFJVDRbOS9hxnq3KctIkriUjaiy2UEmtr/x85n+TvYmFX6W9gi2A1weFF7cvxFoybs84YcRR9lbo2AifAqroYoiC95gv/1AhylJkFsfUIvF3sMxc1o1+bVc1wg9QFsthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005361; c=relaxed/simple;
	bh=o0GkM9NSMbU9xamJgvLyN+reID5/kjRHKwPejuHsW6Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rpG8eo9AjVHjyVLuxRdsptMCfOpsxAR5xK3y4X2RqPJ74Bx40prbeQEsetPJQoHzeu9BBM0rWusRwPkQm6e2pJ1wWh4l5UdkXgwe0NPwy7csgHb2/flqGjKhtTrDokYX5rSb9KRJN03NDVHsePz2+knTyaG19lB/4T0gCoqXy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOLR6z9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOLR6z9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71666C19423;
	Wed,  1 Apr 2026 01:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005360;
	bh=o0GkM9NSMbU9xamJgvLyN+reID5/kjRHKwPejuHsW6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOLR6z9Ied1+mHgKZNfTJLey4bUBAl2ViZVrLwrOUI+4hnMclcsRPvN2fl/lqwjc7
	 ASGJFQ/bFplwJZZ+3H5tRH6IBtsr4u3/mLC2yCg8HgB7X2H1pZax9caYjuQRtlXo65
	 ssKtnmHVJUPUCQOIz0tsyRjWS/K86tw53tyjz0UBXW6WGQ5kqpEOitPCZkfRhzph25
	 +nbp/KcgNiRANM2pmKVtuIuC5/JE1AmRpk7pgGzX26BkzUmJOUOimqiMqqLfy7RMnT
	 /46kkdcMNDkp7Etcolf0JH7KNvkxAiGSvrCvg/EfG6wgjd9MnHzfly7ecagOu/BMfR
	 nHFOHgcr7XaaQ==
Date: Wed, 1 Apr 2026 10:02:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260401100237.ff9a37505d041a00e4d8658a@kernel.org>
In-Reply-To: <acueCFv4neO7zQGI@thinkstation>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<acueCFv4neO7zQGI@thinkstation>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 11:18:33 +0100
Kiryl Shutsemau <kirill@shutemov.name> wrote:

> On Wed, Mar 25, 2026 at 11:22:04PM +0900, Masami Hiramatsu wrote:
> > > diff --git a/init/main.c b/init/main.c
> > > index 453ac9dff2da0..14a04c283fa48 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -416,9 +416,64 @@ static int __init warn_bootconfig(char *str)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * do_early_param() is defined later in this file but called from
> > > + * bootconfig_apply_early_params() below, so we need a forward declaration.
> > > + */
> > > +static int __init do_early_param(char *param, char *val,
> > > +				 const char *unused, void *arg);
> > > +
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
> > To fix this, we need to change setup_arch() for each architecture so
> > that it calls this bootconfig_apply_early_params().
> 
> Hi Masami,
> 
> I have a question about bootconfig design. Is it necessary to parse the
> bootconfig at boot time?
> 
> We could avoid a lot of complexity if we flattened the bootconfig into a
> simple key-value list before embedding it in the kernel image or
> attaching it to the initrd. That would eliminate the need for memory
> allocations and allow the config to be used earlier during boot.

Hi Kiryl,

Thanks for a good question.

If it is embedded in the kernel, yes, we can compile it. But if it is
attached to initrd, the kernel needs to verify it. So anyway we have to
parse the key-value. Of course we can make it a binary data structure,
but it still needs verification. Moreover, memory allocation is not
required by design (the first design uses a statically allocated data).

Even if it is normalized as key-value, we can not trust the contents
without outer verification system, like verified boot. Therefore, our
basic strategy is to parse the text.

However, if the content can be verified externally, for example, if a
verified boot program verifies the compiled boot configuration, then
it would be possible to use that directly.

Thank you,

> 
> What am I missing?
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
