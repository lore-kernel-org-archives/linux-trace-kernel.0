Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDD3CFF42;
	Wed,  1 Apr 2026 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036439; cv=none; b=MtEbBh3UOzcuDHcntuJ6If4VGbjJlWAGX2bQvHBiqFD4qsSvkOrwpl0/wRyIfV4bPIWw62bvAdR1OU8HZARFihykGDFh+4/NYVzfnHaZ9FT1mAwf0VJgbZqjO6xjuwEq88fcnlc4Ge/eigdg7EW/9D+V/BoMF6AjRaxoM0SvZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036439; c=relaxed/simple;
	bh=BtRu89iXUmh6y+V0gXx+ybKGUzoMiJjxKREIJodj/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE9WLPaXki4liv6FkV6WdgUXxZlzq/Mw07hrpDGPLRkZKd63HTSyjSRHteBhjYxYSHxdNDKJMwxVDqnkLkOnmusvazIfh7BJUzczpoRuCb3esrTndUSxLcBb3oxAPMEQ4jgn8umqKYfQZy6Y0h/KmdcqDjn7yQs5paIM2ZGXRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=J/ikEI8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpIXyyV+; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="J/ikEI8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpIXyyV+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 6EB30130098C;
	Wed,  1 Apr 2026 05:40:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 05:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775036432; x=
	1775043632; bh=Y9NnXQxPztrbYHBA9jaAeD7O8AqeRBhf086IpNU0WKc=; b=J
	/ikEI8hqJofj2hE83LA2940Aj6cjunXx8YwWOWT4cEaFvM+MGmMSpCW9Mkse63uv
	6p1RZqI4BbJRtcf72XrWBA5YwQArC2StO8zF0ZHyvrAJ0HSaC2cnt2ioLnDbNRQp
	Fqqfz8pEu1BDAHsLyjoc2ArrCgduAs5WS8JjHzLm5V3f/ARScroxfypPTX8sls07
	SG4uJPAXSsmc2xeEbuuPh32S4cYTnLzQ3bmWw1SlmLJw/lHbOz1q+MeeDznhqIGs
	pi9+A63zJrCFzHimDTWYNRmR0C0HH9MoAAMrJJnPEX4wJXiSA2aEa9qhdZFqqvmX
	10u1KXUtTuWYe3uxUFBiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775036432; x=1775043632; bh=Y9NnXQxPztrbYHBA9jaAeD7O8AqeRBhf086
	IpNU0WKc=; b=fpIXyyV+Ycgc4aEc7y+Nao2+qT/H/0bktagYsuRHsx6SxfcpH1l
	ABEUOq3L1IcpVibVpAxdCLibiA881AH7p+h6isUbAv/N5NIl7hrUGkw6KrWCCGpJ
	Z2IuZ99N8IzMJzW5FkJbBWCDzIyNijyEttw2QJTRGqiNqgGFQ91Qo15UrS6FFOFS
	Q7DjDSeS4sRxk4cweGrWtQQ2DhC9pMpHQPKb6zn+z+2eUtHK5DOKQ41niQMGcQfv
	wMPpnBXUrD0xRnFz5ujvOFSff2JEIMpsOtxafHVUtb0CptN962A3zV+o3JS6WgK5
	LDNrqC06+t6rD05d+19Fm8ML4H6AarTtY9Q==
X-ME-Sender: <xms:D-jMaX7jUOo7NIRCzSzBHJBsFeEG4twJgTbGY1_jPDIr1gsNHq352w>
    <xme:D-jMaegXxYLrLhTm0626QbmVZEMPx2f9tCD6__jWAqR71MwWiOc9CEmTwtdWHwh0z
    ukb2Iq7nkhWZTnhIQ6VkTrAa0Fj57ZXrSoCc-w4v40H-1i_gD18-tI>
X-ME-Received: <xmr:D-jMaSiDB2LLvYXM1iRi6ijk1p5jBlGu8ywa2L2UtCxFpQzgpp2CJlBOSNHWmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeuieet
    jeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepshhkhhgrnheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgrtggvqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshesmhgrlh
    grthdrsghiiidprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:D-jMaelu-tv0s68PjzqFcUeqwHEQHQmhdTRN7qKWJu6tKbpTzUYZ2g>
    <xmx:D-jMaaErDcQUPPrOMXLwA1f2IXsuYipYowL_XjJ8-ugVBGqG0iiWYg>
    <xmx:D-jMaQMtiycRs6mK4arsJT_T-yqXwn5rVqwwiwSAxjxGYQ_uXLKXew>
    <xmx:D-jMaRvtolEKypjK-OlD1HgcOEj1SfwcDvwBMVCJAB2hoIh7Ysy0TA>
    <xmx:EOjMaQguslXKmO5e92MMvrYe5cxtsNTbubvQTfL-74Rk9rz8Av5id3SE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 05:40:29 -0400 (EDT)
Date: Wed, 1 Apr 2026 10:40:22 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <aczm1TfPmstqvUtU@thinkstation>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acueCFv4neO7zQGI@thinkstation>
 <20260401100237.ff9a37505d041a00e4d8658a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401100237.ff9a37505d041a00e4d8658a@kernel.org>

On Wed, Apr 01, 2026 at 10:02:37AM +0900, Masami Hiramatsu wrote:
> On Tue, 31 Mar 2026 11:18:33 +0100
> Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > On Wed, Mar 25, 2026 at 11:22:04PM +0900, Masami Hiramatsu wrote:
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 453ac9dff2da0..14a04c283fa48 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -416,9 +416,64 @@ static int __init warn_bootconfig(char *str)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * do_early_param() is defined later in this file but called from
> > > > + * bootconfig_apply_early_params() below, so we need a forward declaration.
> > > > + */
> > > > +static int __init do_early_param(char *param, char *val,
> > > > +				 const char *unused, void *arg);
> > > > +
> > > > +/*
> > > > + * bootconfig_apply_early_params - dispatch kernel.* keys from the embedded
> > > > + * bootconfig as early_param() calls.
> > > > + *
> > > > + * early_param() handlers must run before most of the kernel initialises
> > > > + * (e.g. before the GIC driver reads irqchip.gicv3_pseudo_nmi).  A bootconfig
> > > > + * attached to the initrd arrives too late for this because the initrd is not
> > > > + * mapped yet when early params are processed.  The embedded bootconfig lives
> > > > + * in the kernel image itself (.init.data), so it is always reachable.
> > > > + *
> > > > + * This function is called from setup_boot_config() which runs in
> > > > + * start_kernel() before parse_early_param(), making the timing correct.
> > > > + */
> > > > +static void __init bootconfig_apply_early_params(void)
> > > 
> > > [sashiko comment]
> > > | Does this run early enough for architectural parameters?
> > > | While setup_boot_config() runs before parse_early_param() in start_kernel(),
> > > | it runs after setup_arch(). setup_boot_config() relies on xbc_init() which
> > > | uses the memblock allocator, requiring setup_arch() to have already
> > > | initialized it.
> > > | However, the kernel expects many early parameters (like mem=, earlycon,
> > > | noapic, and iommu) to be parsed during setup_arch() via the architecture's
> > > | call to parse_early_param(). Since setup_arch() completes before
> > > | setup_boot_config() runs, will these architectural early parameters be
> > > | silently ignored because the decisions they influence were already
> > > | finalized?
> > > 
> > > This is the major reason that I did not support early parameter
> > > in bootconfig. Some archs initialize kernel_cmdline in setup_arch()
> > > and setup early parameters in it.
> > > To fix this, we need to change setup_arch() for each architecture so
> > > that it calls this bootconfig_apply_early_params().
> > 
> > Hi Masami,
> > 
> > I have a question about bootconfig design. Is it necessary to parse the
> > bootconfig at boot time?
> > 
> > We could avoid a lot of complexity if we flattened the bootconfig into a
> > simple key-value list before embedding it in the kernel image or
> > attaching it to the initrd. That would eliminate the need for memory
> > allocations and allow the config to be used earlier during boot.
> 
> Hi Kiryl,
> 
> Thanks for a good question.
> 
> If it is embedded in the kernel, yes, we can compile it. But if it is
> attached to initrd, the kernel needs to verify it. So anyway we have to
> parse the key-value. Of course we can make it a binary data structure,
> but it still needs verification. Moreover, memory allocation is not
> required by design (the first design uses a statically allocated data).
> 
> Even if it is normalized as key-value, we can not trust the contents
> without outer verification system, like verified boot. Therefore, our
> basic strategy is to parse the text.

Hm. I am not sure what issues verification aims to solve. Could you
elaborate.

With normalized key-value structure, we should be able to extract the
needed value in the same way as with normal kernel command line, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
