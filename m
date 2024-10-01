Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C017B421;
	Tue,  1 Oct 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825506; cv=none; b=UEMcR+A4in3sQq/scTpErNJmyVHHs/HXcjSYMsTq/dgPWNo1pKt9agpuF5LAYVjSIubiQB5B+Rmg9qJYn0DTCzC9ND69fj71XyQFk1ka6ikxMXEEnzbDkmjEQazWeklcrXyRCgGcvjV78J26o/7lMANy9x6yrDSfxYVrTh8iz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825506; c=relaxed/simple;
	bh=LppxYpij5Sae1esxSH6qjYR07pEjT02QXGzBH7V4zN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuoalcJaFx9+9khaBrrd7rQ/8iNritkE9yc7TA1jd/9+HGW4U2TenOQXU1XF7LqXqfZPO5YczjeOsVYNFFeBTQVw8pVgkZeDrpxcdnMON+UsxaoKiPSjfdD68nnyAVQGbultSwU8Qqn18B+rPRDGgNKNVnKWHZ+mnuOX2HQ8PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59747C4CEC6;
	Tue,  1 Oct 2024 23:31:44 +0000 (UTC)
Date: Tue, 1 Oct 2024 19:32:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Florent
 Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241001193234.2acb6147@gandalf.local.home>
In-Reply-To: <20241002081037.e9b825f7456ce4815eccad1b@kernel.org>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051144.445681c2@rorschach.local.home>
	<20240917095538.GA27384@willie-the-truck>
	<20240930145548.08c8f666@gandalf.local.home>
	<20241002081037.e9b825f7456ce4815eccad1b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 08:10:37 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > I may add some compiler hacks to enforce this. Something like:
> > 
> > struct ftrace_regs {
> > 	void *nothing_to_see_here;
> > };  
> 
> Yeah, OK. But sizeof(fregs) may be changed. (Shouldn't we do too?)

Honestly, I don't think anything should be doing a sizeof(struct ftrace_regs)

Heck, perhaps we should make it totally zero!

  struct ftrace_regs {
	long nothing_here[];
  };

If someone needs to allocate, then we could provide a:

	ftrace_regs_size()

helper function.

> 
> > 
> > And then change the arch code to be something like:
> > 
> > // in arch/arm64/include/asm/ftrace.h:
> > 
> > struct arch_ftrace_regs {
> >         /* x0 - x8 */
> >         unsigned long regs[9];
> > 
> > #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >         unsigned long direct_tramp;
> > #else
> >         unsigned long __unused;
> > #endif
> > 
> >         unsigned long fp;
> >         unsigned long lr;
> > 
> >         unsigned long sp;
> >         unsigned long pc;
> > };  
> 
> And if it is pt_regs compatible, 
> 
> #define arch_ftrace_regs pt_regs
> 
> ?
> 

Only if it is fully pt_regs compatible.

-- Steve
