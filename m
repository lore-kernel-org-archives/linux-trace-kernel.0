Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080B211474;
	Thu, 13 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441332; cv=none; b=fyWWZ6nf9Lm6pCXqmzmdbm97ZRBSuwA2x2Tj+g3vksjF5DFwMItTzy5vT5PNk64V2QJTiUTZ4pRnsmFerj64ZxIuogTd+vzIYN9ej0nHSQ9vP3Gys8iXAV/fUFmEsnUzNsR4kK4/QKFjSUGsUVDTaFXeN1SHWQl/W7Ai1ZE7kaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441332; c=relaxed/simple;
	bh=gFpRK/JkdgX13UygTMKOHD6tsNu85A/NEUS8hn+Wmow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJcdUrh49Stw0bJIX5kZuPPuIp/lnaZXDvhLPOEVlD9C73sqvFh9Cf8bmENM7Q4d2Wk6HdQvTNuit5PfXEpOVYHizz8WuZ7Izd3JBwS9QSqZN3Eb2rKxbEbR2DmcWr0jXlMA3AFQwHq1CHimJYYvYrhyZvKHFYZKK9LbLsgxslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BhWsbXVR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BhWsbXVR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lkR5HccpBuZLkizNzU99y3bBaTyy+HSQ8rJU1fNxcTU=; b=BhWsbXVRFgyMTetQDG8EwW6EN/
	NVwzdLblMFdudFFCF8L95wG55iZWI5gDUI7pJsXiZP1fVJTRudSfzel1yVH48lzQAEcvVwZ+9QWgO
	QXhnJYFhWLNSc7JSnf6A1LBGkMmnj9+u8NP/I0bKx1R72s/3OGNDLct5tlV2Hu9RylYs6hybDSY/Z
	DMjDXJLDnkGapDMMD0cvgMm6ayah2V0REsepDWT9/OzDkEkS3irK8IIRxeQ5VR0VZgwim4lb4KqhZ
	Ox9063pwKwgt/3oCcZJCzr147MR8SrgCfEHaXUT9EHqxbEm29hNaNseaCDgfw5OE1NQtZGkMN8Yn+
	pt1HL9IQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiW97-00000000xLl-1nvj;
	Thu, 13 Feb 2025 10:08:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9DF49300155; Thu, 13 Feb 2025 11:08:36 +0100 (CET)
Date: Thu, 13 Feb 2025 11:08:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Gabriel de Perthuis <g2p.code@gmail.com>,
	Haiyue Wang <haiyuewa@163.com>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250213100836.GC28068@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net>
 <20250211105002.31b5a517@gandalf.local.home>
 <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 08:52:27AM -0800, Sami Tolvanen wrote:
> On Tue, Feb 11, 2025 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 11 Feb 2025 11:09:14 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > I was aiming my patch for x86/core, but if there's a reason to expedite
> > > them, I can stick it in x86/urgent I suppose.
> > >
> > > Just need a reason -- what's this compile error nonsense about, my
> > > kernels build just fine?
> >
> > Masami,
> >
> > Do you have a config that fails to build without this fix? If so, can you
> > please reply with it, and then this can go in as a quick fix.
> 
> x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
> are broken without this fix. Here's how to reproduce:
> 
> $ make defconfig
> $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
> -e GENDWARFKSYMS -e FUNCTION_TRACER
> $ make olddefconfig && make -j
> ...
> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>                  from <stdin>:3:
> ./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
> function ‘get_kernel_nofault’ [-Wimplicit-function-declaration]
>    46 |                 if (get_kernel_nofault(instr, (u32
> *)(fentry_ip - ENDBR_INSN_SIZE)))
> ...

It breaks much sooner, complaining about not having dwarf.h.. let me go
figure out what package provides that :/

Anyway, thanks, I'll go see if my patch helps here.
