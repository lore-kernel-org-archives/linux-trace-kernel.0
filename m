Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55823F439;
	Thu, 13 Feb 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453748; cv=none; b=kBY8stcJOOHpP+bc0Bcd0WKKwth4puuy4CxbLh1/+yMNlY1V9gGGySvuWik6Raj8VRPBDUfTOxQ+vmD1xDhcaU5/ApxfliYKxIPNcevDIIHVFdVZGhegyjOAW7giWLJTzbV310EwZbytx6OzXvlCOr8Ko7gxkyIjhpJkBAqbLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453748; c=relaxed/simple;
	bh=LAJ2zcQtXURfChEloX6J+PyoNgE5CNbfUKecNJ4qpMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=krAy0G75028t+vAKpAqmD+NVy3W76nsmBhnPTM1cpfblhEacrmvPVxC9+kQK/aUCE62WKEIZyABgWCtJDVDsL5oImjFUUC0B7EQflHadTB9nH+yIg/TXXGZZ8rLAcnRL7i59yiyvMWbS064pQsjkrOaMt8cY165io+xbnFpjQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arw9M1in; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arw9M1in"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F15C4CED1;
	Thu, 13 Feb 2025 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453747;
	bh=LAJ2zcQtXURfChEloX6J+PyoNgE5CNbfUKecNJ4qpMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arw9M1inPJ3KBtNIz/FdWR/6iSGrlOOOicAFLkNuJMdh3JxN6wiSlv3HP1roeq7jo
	 exmPjmlT7Xm/kp+INfcLmqal7CQ5r46w+bXWXdoaRKw2Cq66+wQLmfG8A+QeUGqpfI
	 4hrgyXoy64bm4SW2uKsK3mt5FEAjtOfeslUmlpvsp13vwIojLujCwTtEOBytzvl2yq
	 /Giv/NdvQscOclSh9QYAoSN52fPB5PBsCsf3oRmQUQI/r4a9v/4quhJzdJn6ig4G7g
	 eh20wMBpR+8SN2EssbmHnT5CrIauBRHDVLTX2AI4y0QCol304uwZM7TG42sPQY06sA
	 4WRawVqKCxo2w==
Date: Thu, 13 Feb 2025 22:35:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Gabriel de Perthuis <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-Id: <20250213223542.44542e542434158056d3b7ed@kernel.org>
In-Reply-To: <20250213102634.GA30841@noisy.programming.kicks-ass.net>
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
	<20250213102634.GA30841@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 11:26:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Feb 13, 2025 at 11:08:36AM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 12, 2025 at 08:52:27AM -0800, Sami Tolvanen wrote:
> > > On Tue, Feb 11, 2025 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Tue, 11 Feb 2025 11:09:14 +0100
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > > I was aiming my patch for x86/core, but if there's a reason to expedite
> > > > > them, I can stick it in x86/urgent I suppose.
> > > > >
> > > > > Just need a reason -- what's this compile error nonsense about, my
> > > > > kernels build just fine?
> > > >
> > > > Masami,
> > > >
> > > > Do you have a config that fails to build without this fix? If so, can you
> > > > please reply with it, and then this can go in as a quick fix.
> > > 
> > > x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
> > > are broken without this fix. Here's how to reproduce:
> > > 
> > > $ make defconfig
> > > $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
> > > -e GENDWARFKSYMS -e FUNCTION_TRACER
> > > $ make olddefconfig && make -j
> > > ...
> > > In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
> > >                  from <stdin>:3:
> > > ./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
> > > ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
> > > function ‘get_kernel_nofault’ [-Wimplicit-function-declaration]
> > >    46 |                 if (get_kernel_nofault(instr, (u32
> > > *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > ...
> > 
> > It breaks much sooner, complaining about not having dwarf.h.. let me go
> > figure out what package provides that :/
> 
> Bah, ofcourse there's libdwarf-dev and libdw-dev, both providing
> dwarf.h. Obviously I installed libdwarf-dev and instead I need libdw-dev
> *hate*

Agreed. :(

> 
> Anyway, yes, compile now fails as advertised.
> 
> And patch fixes it -- now I need to figure out what to do about urgent,
> because applying it on top of Linus' tree will create conflicts with
> patches already in tip/x86/mm *sigh*.

Hmm, if so, can you pick my patch [1], which does not introduce any
additional header including issue?

[1] https://lore.kernel.org/all/173881156244.211648.1242168038709680511.stgit@devnote2/


Thank you,

> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
