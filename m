Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B991CEAD7;
	Tue,  1 Oct 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825182; cv=none; b=TN2GpN714ir89rLLSVGbH0Gg+Y5GAK2Zj/qWhQVCk9QlAJg0d1VCARx+q9LTvqQT4Z9TmgjjZmizKIFpQ3Fo/c9WN1XMTAgEUBp1mSaMjTl5i/mYmLiIhZaPbs/nf1YY5FivZ2PgCjNVgDxhHq1r8EcjrXzLkHwMXtRe1zMNCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825182; c=relaxed/simple;
	bh=YG/qa9jzP2BgsMhKT8ybaJ73W1pJe3SjqzugQP9q1BI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ffDcrIDq+6mCuXLcqKYQW26i8HgQQM37gIEp4AhvjG5/oYMSwsospqpi7UIC3XBJxmyMCR+/dcMnm1tL6uXicuWl3OJcLYMRBRR/V0m/lAcn8Z+wNhlKc8XEZeq9CpNv0u7BxUsDW0nla7RJsq9TSnKJeDrbo0CJDB4+YtTob/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm5cBieP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm5cBieP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B996CC4CEC6;
	Tue,  1 Oct 2024 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727825181;
	bh=YG/qa9jzP2BgsMhKT8ybaJ73W1pJe3SjqzugQP9q1BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rm5cBiePWcg8iYf7bE4lqRquENW9eLl4sXQipIJaPPycW/zicBqKK7djvdjFZ+aMu
	 rERUvcSwfksEaGznesvvVNl3/ibF3sL4kOM4rfIQlqNzbb9+3kdM7rvM8C3TX/9fHO
	 dm2NDzgidKvXlv31t6Z75N8C3b6d1UcZRCBbmsBSkW0vv8pGc1hFvLa6MOWNd+pC0e
	 Myi9eWsSRJmD+ckUv3whYzTIebDotlmH2U3EmANzmDabAY4Iasn5UVmqKrChOhvw7Q
	 VhR2rv+fxvV43NTkEfL1npva7Oxi3zXyCp320N9KkQKZmpzmJaAJK4GrHSNadShPVH
	 Jj18bJHjk2uxg==
Date: Wed, 2 Oct 2024 08:26:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 08/19] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-Id: <20241002082616.e02d3f92968291fad7533b70@kernel.org>
In-Reply-To: <20240917101454.GC27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615377576.133222.5911358383330497277.stgit@devnote2>
	<20240915052204.3dff1f75@rorschach.local.home>
	<20240917101454.GC27384@willie-the-truck>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 11:14:54 +0100
Will Deacon <will@kernel.org> wrote:

> On Sun, Sep 15, 2024 at 05:22:04AM -0400, Steven Rostedt wrote:
> > On Fri, 13 Sep 2024 00:09:35 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > > This is for the eBPF which needs this to keep the same pt_regs interface
> > > to access registers.
> > > Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> > > used by kprobe_multi eBPF event), this will be used.
> > > 
> > > If the architecture defines its own ftrace_regs, this copies partial
> > > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Acked-by: Florent Revest <revest@chromium.org>
> > > ---
> > >  Changes in v14:
> > >   - Add riscv change.
> > >  Changes in v8:
> > >   - Add the reason why this required in changelog.
> > >  Changes from previous series: NOTHING, just forward ported.
> > > ---
> > >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> > >  arch/riscv/include/asm/ftrace.h |   12 ++++++++++++
> > >  include/linux/ftrace.h          |   17 +++++++++++++++++
> > >  3 files changed, 40 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > index dffaab3dd1f1..5cd587afab6d 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -132,6 +132,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> > >  	return fregs->fp;
> > >  }
> > >  
> > > +static __always_inline struct pt_regs *
> > > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > > +{
> > > +	memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > > +	regs->sp = fregs->sp;
> > > +	regs->pc = fregs->pc;
> > > +	regs->regs[29] = fregs->fp;
> > > +	regs->regs[30] = fregs->lr;
> > > +	return regs;
> > > +}
> 
> Ah, I guess this is where we pick up the lr that was set in patch 5.

Yeah, this one also copies the fregs->pc to regs->pc, mainly for bpf.

> 
> Acked-by: Will Deacon <will@kernel.org>

Thank you!

> 
> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
