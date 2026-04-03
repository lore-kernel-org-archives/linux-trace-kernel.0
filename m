Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BB242D9B;
	Fri,  3 Apr 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184347; cv=none; b=rDOtWamIcK0d5EA95rbSmt59lOQVZ3VyKofjbiydayeKVMBDc2384povdZyiGRl/Dyd5WX5Ep5ay6DvvePuJLVUhmWSW+NXvvv+yCwtK4OqsdhqnqjbjXy8p5f4UMahbAJIjGF/X0wQp/UAghCdSoN9P5B/3LRUWb4EzeQHG6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184347; c=relaxed/simple;
	bh=AqNclWxDeWKUa9kjhoO2smv2Kp/Xym33+MiMt57QX/Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FYETv6p/0l0pT5/iLNoqIUTt5hga8F7BMKOqJX33IrwcQe7S4HghWiBk8HbPIzmFKQoKG4oBQN4e90/sCT79H4Soz4QsvEW0tq9fPBh/SD6zJ+xPxw2+JL3MjaX3cGm2wqEAZ2B1qiEiO4/mZK8JyctpFrf+AKH1C9ZVznhP7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVsoqGEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVsoqGEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCEEC116C6;
	Fri,  3 Apr 2026 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775184347;
	bh=AqNclWxDeWKUa9kjhoO2smv2Kp/Xym33+MiMt57QX/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVsoqGELyHqjNHT8uciXUu/9igJhMlWi5Ot2DgTKyRJXGqCQOa1Xq9wbE5ldXkftQ
	 zM9fl8lob2EbsRil6xLqtjkSVeSVhjZRbV5AA+fYLGt5ziDtCQQiHhyJsxV2XNlTin
	 0PxIrCcV1fJ/EWJummsPst0eqr1VyL1g57x5cBoSKnl9VDhNA+QKIUOh8zB0M4R5/2
	 kqde4i0Fz8eBCETBTLUHHzD2HxSuIQ6dMabi5EUmNr/sL1H13t4psgoSYIZZfwRkqJ
	 bVJWIi7sh9wcfwkBXl3qIN3m/k6nAXIWN571VtKs0U8eQ+umWrT2/I6PhluxMh/ss1
	 L4v+SoEbzSXug==
Date: Fri, 3 Apr 2026 11:45:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com, Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260403114519.14e326a4bba019373bf3ff09@kernel.org>
In-Reply-To: <ac0wz_eW5Zgi4t45@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<acZPZ4XKy4QynznK@gmail.com>
	<20260327223744.f246150adc1671f7605a4f0a@kernel.org>
	<acpzhCBEPh-tKVqg@gmail.com>
	<acqJk-zbyjIiy6hJ@gmail.com>
	<20260331125827.157a833882830007ea9b0b31@kernel.org>
	<acvjcCqIAeHyIiQN@gmail.com>
	<20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
	<ac0wz_eW5Zgi4t45@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 08:01:48 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Wed, Apr 01, 2026 at 10:48:53PM +0900, Masami Hiramatsu wrote:
> 
> > > The challenge extends beyond that. There are numerous early_parameter()
> > > definitions scattered throughout the kernel that may or may not be
> > > utilized by setup_arch().
> > >
> > > For example, consider `early_param("mitigations", ..)` in
> > > ./kernel/cpu.c. This modifies the cpu_mitigations global variable, which
> > > is referenced in various locations across different architectures.
> > >
> > > It's worth noting that we have over 300 early_parameter() instances in
> > > the kernel.
> > >
> > > Given this, analyzing all these early parameters and examining each one
> > > individually represents a substantial amount of work.
> >
> > Yes, that may require a substantial amount of work. But to improve
> > the kernel framework around the parameter handling, eventually we
> > need to examine each early parameter.
> 
> I'm still uncertain about this approach. The goal is to identify and
> categorize the early parameters that are parsed prior to bootconfig
> initialization.

Yes, if we support early parameters in bootconfig, we need to clarify
which parameters are inherently unsupportable, and document it.
Currently it is easy to say that it does not support the parameter
defined with "early_param()". Similary, maybe we should introduce
"arch_param()" or something like it (or support all of them).

> 
> Moreover, this work could become obsolete if bootconfig's initialization
> point shifts earlier or later in the boot sequence, necessitating
> another comprehensive analysis.

If we can init it before calling setup_arch(), yes, we don't need to
check it. So that is another option. Do you think it is feasible to
support all of them? (Of course, theologically we can do, but the
question is the use case and requirements.)

> Conversely, if we successfully move bootconfig initialization earlier
> by breaking the dependency of memblock (assuming this is feasible), the
> vast majority of early parameters would execute after bootconfig is
> configured, eliminating the need for this extensive categorization work.

OK, I agreed.

> 
> Please, feel free to tell what approach might be better for the project.
> 
> > > Are there alternative approaches? At this point, I'm leaning toward
> > > breaking bootconfig's dependency on memblock, allowing us to invoke it
> > > before setup_arch(). Is this the only practical solution available?!
> >
> > Basically, the memblock dependency comes from allocating copy of data.
> > Only for the embedded bootconfig, we can just pass copy memory block
> > to the xbc_init(). Something like;
> >
> > xbc_init() {
> >  xbc_data = memblock_alloc();
> >  memcpy(xbc_data, data);
> >  __xbc_init(xbc_data);
> > }
> >
> > embedded_xbc_init() {
> >   __xbc_init(embedded_bootconfig_data);
> > }
> >
> > Afterwards, we can pass mixture of embedded bootcofnigt and initrd
> > bootconfig data to parser again.
> >
> > (But in this case, we must be careful not to override the early
> >  parameters that we have already applied.)
> 
> Do you have any additional recommendations if I proceed with this
> approach?

OK,

First of all, even if we enable early parameter support in bootconfig,
this is only possible if bootconfig is embedded. In that case, we can
pass memory that has been pre-allocated at compile time to bootconfig
as a working area. However, this will consume a lot of memory, so it
needs to be selectable in Kconfig.

If you're going to embed this, as Kiryl pointed out[1], it might be better
to pass pre-normalized (or compiled) data and avoid using a parser.
Compilation itself is relatively easy if you utilize the tools/bootconfig.
(However, in this case, there doesn't seem to be much point in using
 bootconfig in the first place because we also can use embed kernel
 cmdline.)

[1] https://lore.kernel.org/all/acueCFv4neO7zQGI@thinkstation/

Can you clarify the main reason of requesting this feature and
examples?

Thank you,

> 
> Thank you for your detailed responses and insights.
> --breno


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
