Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C153E5579;
	Wed,  3 Jun 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503621; cv=none; b=RRrcjaGC7SnzaU99OqAWrltef1l8yzsNtZyNYrIiCQeX+8CWT86Fg/x6Ejy4YF8kE0uJb+BPa9CvaZZl1n0Sl8rqAbg8H0wA02ABWlPq31vD3g5yhe0s5Yx7wGx6n//a58jnFPCg62sZb9qcxqDqQgSrVpDJdUAyxxpwO+JQgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503621; c=relaxed/simple;
	bh=TEIT/jrJjzlQDT3gEM6JOXcNzKreGn/PZIOhZgZIOUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX/QNLT68VBSp0KAih/V/kN5Ig5pkuwl0XInzYZJXXlXuqbWP5+NiNTFj6MDtSVxMIo2AKpS8zgXPMqDpo1gs7rDmyvWe6R/0BeMSqDEK98M9WBnIzBg9sIs8ogAyLGomhMYY2/x7hXLiMKwA0wp3AJapDkGBCRs5kFPJLfBsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GisXoFoe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GisXoFoe"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD55540E00B8;
	Wed,  3 Jun 2026 16:20:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fgZAnMZvIDEE; Wed,  3 Jun 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1780503605; bh=KQF5anc3clInAXcjBfKS1egNzzHrFhfRAKh+Hd0L9uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GisXoFoetprH2QNiza4ohZ5H5fYeZ9K6vD6/cFL6IzfaZaNrK/Vo43IkUWAhbwf6+
	 77oeu3mqF8w6d7Z535vvPvr8t2ixE3MrIbXilf5CnkP4RXvGqk2ZUr9Z8QU96HTyf/
	 Dmq1iHKmmA1OskVhADdGIj6/PDxBxqjZRssbaRcdMQ9GA6NJZLUAFAXQA9UeKNcg6w
	 MKlAiVQ3i57S/StJRLYwloNvirlJIO3/Ng5Yh+phGb3RWCXYWHQl7mykvge+FJKS2Y
	 CYM1GiCzPgf4Hq7E3OsgqjOcq+KtU6GKyT7TNGkFVIO02o2aj0efXaltN8eAflP/rG
	 YeCO76N1GeyAkpZN3OfexfyRL0fGhxjQmEVtCoa5i14tGYB5iMYfsLtwvmRtqGYIV1
	 GjtDbP50cI0UfAtcRiIzu4r8ffvk2OdRibREg1edMqEWA6dGZc0A0qi3u9SmtEzSeu
	 uJb2qzuKbbh32Xct76RUGJtBm5Tkbg8l8r3GSsl9tGIfJoi/o+621202vZJTAIGw9w
	 ZRvHZBL1gCDdtGkIfImM/27lLzWJ0+hEScKxivs8px7laLlIwy2jNEpdOX0OZrj4UA
	 TgLftwLm80mKZFU8RhUtJRnW4KnZtqayhk/JttXGfPnRJBOhWeDIUD63tiWYDyF9Z1
	 f2FdWuAToTow5Q5k9cOKUoyc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7F4E40E0031;
	Wed,  3 Jun 2026 16:19:50 +0000 (UTC)
Date: Wed, 3 Jun 2026 09:19:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>,
	"Lai, Yi1" <yi1.lai@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Message-ID: <20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
 <b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
 <20260603121707.7eccb9fb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603121707.7eccb9fb@gandalf.local.home>

On Wed, Jun 03, 2026 at 12:17:07PM -0400, Steven Rostedt wrote:
> On Wed, 3 Jun 2026 15:44:54 +0200
> "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > Likely the latter. BPF [1] documents:
> > 
> > Q: Are tracepoints part of the stable ABI?
> > A: NO. Tracepoints are tied to internal implementation details hence they are
> > subject to change and can break with newer kernels. BPF programs need to change
> > accordingly when this happens.
> > 
> > The Kernel ABI document explicitly doesn't list them AFAIKS.
> > 
> > There were previous discussions on the stability of tracepints [2], I don't know
> > what changed in the meantime. CCing Steve
> > 
> > [1] https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html
> > [2] https://lwn.net/Articles/747256/
> > [3] https://www.kernel.org/doc/html/latest/admin-guide/abi.html
> 
> Tracepoints are not stable or BPF programs only. But other applications
> they are[1].
> 
> Adding Linus as he's the Supreme Judge on the matter.

I *think* tools or libtraceevent can't really anticipate the TP namespace
change so we might have to revert, I'm afraid...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
