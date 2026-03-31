Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A603A1E70;
	Tue, 31 Mar 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952322; cv=none; b=pmvvxq1b7CCBgSjk8t0wERotLLqUinU9JLJcIvtPFvy6wF1vlFp7EqmEI85QvJNCrq/xe0SghLzq6HPXF51BbrWh8+NH3Oa6NVmToixj15yJgaavPG2IFesiKUcp2dJZDBDZjv9rM1q/y2sBG3QV0cxp+Nbh5BE4xXiqclotMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952322; c=relaxed/simple;
	bh=8B0kepbrDceqBn3pM6V9/uzXicoAOydFwLF4mMVCfVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0zON0urC9+0kuaCX1lkw0wK3fqeIAX9J8svP1YGLbCliSSsk0mjKb3EXjltUdH88WJK3keYq7B2PxDpxZ6TWzDRs1mOXFHl5edRbCxK3akdTibXfYGyhvseuKXPcyQ9v8yK/7Obyl0rVPf5JYvzceOUvphrcJt2Aii1aulLBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SMCJRXeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cr3MvK7e; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SMCJRXeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cr3MvK7e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id E274013808CA;
	Tue, 31 Mar 2026 06:18:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774952319; x=
	1774959519; bh=JYEKmtOaDpdPC566rZh2DS5tTiOcJLEMTCfDpu/CL+E=; b=S
	MCJRXeHtxJX9EvscAbG36zg7WENRsFVT4J9XTEcBYOMzSG8B/hyu5LXAqF0VdiDs
	y3vCX2gmlP+jjaZMVFT2j5/ynAzoHF9K3FGuSUTLPxxnxeHa3StbqYi7j4HCQ9E7
	BEz8BqubcmmxEhoD/szvKrhbRuaj1qkHIz90zZYF7MFpUp5hUMwHi+WhdbZvR/a/
	vJYclLOngebfSKpkOOplREzPy6lp7iKmK1N9mRhlrGs3Nnrq4dUAlP+J99TnrhVO
	ORAYsO7NlmbKb7m7byKgps7aXT+LdBLGGAb0jrM+AzHXDy73aZVJakVc20+No4Fi
	4kohQsBUI3wcTKhQahuwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774952319; x=1774959519; bh=JYEKmtOaDpdPC566rZh2DS5tTiOcJLEMTCf
	Dpu/CL+E=; b=Cr3MvK7eMbLTJxNdyEJqPAbUX0BdAP0hPk41BKZ/eT8pCkERv6s
	GUNaPsYc2hg2wGHvAqH7DdYLHsM/yM7FlCoylQSRa5uVHg8y1JzXrzFH1XV7IQE/
	uujiAFngAn9amu5Uv6Q7oJNlHvv55YI7x7t8L+JaCbII6dpbOHQ7VAv9Ks2KNldX
	ydzpzvh+f4IE5oJN+jh5/a96F6iVgNO5IuBV8M3v7Al10OI4itdlHRnop7sNgl04
	tB3n+pn9uaQsgccWu8IdqP41QOWcvuwSM5zarvpbEQ+ehAhcZjVWKmbBXA0barEL
	P6DgANrfPAgIxNWk/RaYlzKT3DJihBqBcPw==
X-ME-Sender: <xms:f5_LacJJS7ntkFE8w-ano1TP7WYUxBajLmi9Fp_I1Hjl4r-6j5jxag>
    <xme:f5_Lady689nA3rGcw_z0e3vlfdV76Zfa4tXocaRuOiDA2vERtKLN1xsKkuG0APbez
    KV_6wpGbbMFRLbke9hu3jBSDwemleWE9mfVM2gLkaaZnW5usCYM-VU>
X-ME-Received: <xmr:f5_LaQwdOjjZeZUAHxvHpyc2MEMVhbln_GXNPzCX5aBPGThO1hR6DyI5syu7sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghp
    thhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepshhkhhgrnheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgrtg
    gvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshesmh
    grlhgrthdrsghiiidprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f5_Laf3M-BtrEUBgMs6oA1f9EG2ZZRNAqIEI8ykmN4BkSLvA7NBMjg>
    <xmx:f5_LaSUyUZ4VoaLQAIWOdhBDX5ZmZ2CSZIoXJBG3bTZ_uuSinw_lWw>
    <xmx:f5_LaTeLDK41gge-02CtGPTydXj3uHhljZS4CfLRp0kDAc12pw-oSw>
    <xmx:f5_LaT_BSsEFj0lhKG_2bapu9RXRGQ8rmBICuI2cNiOLhYzYJu-h1Q>
    <xmx:f5_LaZz8vbrpeQlZpxsLhmrxjC9MSspk7AFg0MD3SlZ8m4GXRxmH8uVC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 06:18:38 -0400 (EDT)
Date: Tue, 31 Mar 2026 11:18:33 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acueCFv4neO7zQGI@thinkstation>
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

On Wed, Mar 25, 2026 at 11:22:04PM +0900, Masami Hiramatsu wrote:
> > diff --git a/init/main.c b/init/main.c
> > index 453ac9dff2da0..14a04c283fa48 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -416,9 +416,64 @@ static int __init warn_bootconfig(char *str)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * do_early_param() is defined later in this file but called from
> > + * bootconfig_apply_early_params() below, so we need a forward declaration.
> > + */
> > +static int __init do_early_param(char *param, char *val,
> > +				 const char *unused, void *arg);
> > +
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
> To fix this, we need to change setup_arch() for each architecture so
> that it calls this bootconfig_apply_early_params().

Hi Masami,

I have a question about bootconfig design. Is it necessary to parse the
bootconfig at boot time?

We could avoid a lot of complexity if we flattened the bootconfig into a
simple key-value list before embedding it in the kernel image or
attaching it to the initrd. That would eliminate the need for memory
allocations and allow the config to be used earlier during boot.

What am I missing?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
