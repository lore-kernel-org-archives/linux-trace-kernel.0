Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198120F094;
	Thu, 13 Feb 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442424; cv=none; b=CsXNxwBe+S34sWxA6NMxcZxb9ZnCjv5ezTxh4nOlMglBa+ApAzMCmzwBccxuToT1o0NIDxQiqOILDZ/spfxgyE2x5AtcB/Bjg7kVFXYEXqu6gN9xxZ3b99u/pzLJirC3ARuVWrqjl6tK7g9jDB7lIJDHrU/Pngm7v/d1ulMeEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442424; c=relaxed/simple;
	bh=zthLkW6L0uWJ/4S9z2zh6oK0taZB+pzLG3PlNzcge4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEoQ8kLURl50NnRey0OMfTUMy3ABaDIV7V3QNqcJG9mju0+WNxqQfAk6gss9jTEMQ4b9UYP8joYVq35Q/Y+cQ4scPms/syJ9q29cMANjJu7z3+OhCeZMBf2XAJFcQJD32v6CAu5F5hYP3yPLH2f2zQXdeQ7AczVRO0ge860izY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRvkARii; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRvkARii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6dTQIfLwdvkAA+A8qSdLL/z7J1WLIvKB35lv6zSTFQE=; b=ZRvkARiiWOJ5aONr76bNdDm6a7
	wpMxrvaNBeO/b01fp2Va3C8sWNbjDahyOJiBwjQrFM+sfFi1crmMJvK9n8kSoG1xOkabjIRoinbCC
	qikgYOd48OHhadbc63R5kbZUjTFAZLboTQRmTJzrlO8FuQi+rrFGmfHh32mdWDYSH2v/vsanq2DUj
	uu8WhKHtej3yhDK6zd+6AWYcSCf8sqyanXQFkeJiMacwKa+8UJ8UKAevyragos/cEgYL6f/Ib9rSi
	X2sFqskTzb5HZ6X8rcpiqt1BaLu+raUR4QC3L6Yoyo64n+eKk+i81b+A6OacUD3kKygHUf4AOH57D
	BSH/SuDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiWQV-00000007yfG-2Jcy;
	Thu, 13 Feb 2025 10:26:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7210C3001AC; Thu, 13 Feb 2025 11:26:34 +0100 (CET)
Date: Thu, 13 Feb 2025 11:26:34 +0100
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
Message-ID: <20250213102634.GA30841@noisy.programming.kicks-ass.net>
References: <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net>
 <20250211105002.31b5a517@gandalf.local.home>
 <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
 <20250213100836.GC28068@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213100836.GC28068@noisy.programming.kicks-ass.net>

On Thu, Feb 13, 2025 at 11:08:36AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2025 at 08:52:27AM -0800, Sami Tolvanen wrote:
> > On Tue, Feb 11, 2025 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Tue, 11 Feb 2025 11:09:14 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > I was aiming my patch for x86/core, but if there's a reason to expedite
> > > > them, I can stick it in x86/urgent I suppose.
> > > >
> > > > Just need a reason -- what's this compile error nonsense about, my
> > > > kernels build just fine?
> > >
> > > Masami,
> > >
> > > Do you have a config that fails to build without this fix? If so, can you
> > > please reply with it, and then this can go in as a quick fix.
> > 
> > x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
> > are broken without this fix. Here's how to reproduce:
> > 
> > $ make defconfig
> > $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
> > -e GENDWARFKSYMS -e FUNCTION_TRACER
> > $ make olddefconfig && make -j
> > ...
> > In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
> >                  from <stdin>:3:
> > ./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
> > ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
> > function ‘get_kernel_nofault’ [-Wimplicit-function-declaration]
> >    46 |                 if (get_kernel_nofault(instr, (u32
> > *)(fentry_ip - ENDBR_INSN_SIZE)))
> > ...
> 
> It breaks much sooner, complaining about not having dwarf.h.. let me go
> figure out what package provides that :/

Bah, ofcourse there's libdwarf-dev and libdw-dev, both providing
dwarf.h. Obviously I installed libdwarf-dev and instead I need libdw-dev
*hate*

Anyway, yes, compile now fails as advertised.

And patch fixes it -- now I need to figure out what to do about urgent,
because applying it on top of Linus' tree will create conflicts with
patches already in tip/x86/mm *sigh*.


