Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56A20323;
	Tue, 17 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568100; cv=none; b=eDIDErotlXJ6GoomqMDUTB5pcFRYvzSS2qyKltaqdKtfonLtv0vEtjlb7ey3TqXZxNZodXNn8n1azvI6SZtgSGfGky0B1zR+8KwQYkyFbMjv+lVsD0M8eNINe6PtySiX6XqmOYDYGxI17dNDvbSX605rV8dNr/0dgdwJCxR+0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568100; c=relaxed/simple;
	bh=+YgselXGB2n7Utocil+BbkClg7VXcbVrdFZwYP7vL0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm+eBgxBXt6+eh2g797uIUup7OM4J0sYe6l7BKxmfpRkltv9aNNnjgTy8v/sNLFO4HKABKfx7iQ5bIKfPLr7t8YdOgcHzQBNuT46OXB8CKqdiwp4tGaEvtrdC3MH63D+KciDtlpiqpvxZWFfA5vKRmf0CkvVhVH2JQiBTKC5A7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNfuLgMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNfuLgMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB92C4CEC5;
	Tue, 17 Sep 2024 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726568099;
	bh=+YgselXGB2n7Utocil+BbkClg7VXcbVrdFZwYP7vL0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNfuLgMoDNgLE6AjUI9dUk5KyYXunWTX1B3p0KG9DF/YKjE3tFPCZpo+0AlF9G3AE
	 GCyOLgAR99oIqXi4yYGxp0n4F5sJFngmwgjQ89H/oD2/QUdc9o78MxJo2KmFYRNzLW
	 D6yNfA6gbDMHmcCQANNAwp+jbPirSKHbj2chKBGi8m2t8vaQWW99qb3H6CatIqtSJq
	 iAFrL78yjkAS+adew9XIkEOBvlkuKPu1AikIhRfX2HiKvy32nfv7pwXBNhQX+6+i4i
	 N7uUgxBuJHV7n6t9IVbduPNZT3nkbun74GBWQ77YbslwruQMhpOJAV9OTwhMZx4JIG
	 CM5vJzazbG4WQ==
Date: Tue, 17 Sep 2024 11:14:54 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 08/19] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20240917101454.GC27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615377576.133222.5911358383330497277.stgit@devnote2>
 <20240915052204.3dff1f75@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915052204.3dff1f75@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 15, 2024 at 05:22:04AM -0400, Steven Rostedt wrote:
> On Fri, 13 Sep 2024 00:09:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > This is for the eBPF which needs this to keep the same pt_regs interface
> > to access registers.
> > Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> > used by kprobe_multi eBPF event), this will be used.
> > 
> > If the architecture defines its own ftrace_regs, this copies partial
> > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> > ---
> >  Changes in v14:
> >   - Add riscv change.
> >  Changes in v8:
> >   - Add the reason why this required in changelog.
> >  Changes from previous series: NOTHING, just forward ported.
> > ---
> >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> >  arch/riscv/include/asm/ftrace.h |   12 ++++++++++++
> >  include/linux/ftrace.h          |   17 +++++++++++++++++
> >  3 files changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index dffaab3dd1f1..5cd587afab6d 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -132,6 +132,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> >  	return fregs->fp;
> >  }
> >  
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > +	regs->sp = fregs->sp;
> > +	regs->pc = fregs->pc;
> > +	regs->regs[29] = fregs->fp;
> > +	regs->regs[30] = fregs->lr;
> > +	return regs;
> > +}

Ah, I guess this is where we pick up the lr that was set in patch 5.

Acked-by: Will Deacon <will@kernel.org>

Will
