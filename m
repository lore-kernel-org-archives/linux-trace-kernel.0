Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726151CEEA7;
	Tue,  1 Oct 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824242; cv=none; b=IiehTPVKL/6THXMW2/Bh75WPhVKstbfoDOJODvnysUco+pNY861Sxbdc2P3Nh40SK9pzOikxWI3A3qJns13uWENK4a5uSdi4xayYoLnGj4azmJSNsSCjhkBMGZwXDmDg8XcIxOewFH1YG7iaZDrAHW7dzMDVe/Rgv3YvPASkAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824242; c=relaxed/simple;
	bh=DcJk0ZurD4m477NZqGPsjHZFR3HoBgS1o2cMcYNYB2s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eWSW0FbdbOk5Q2n9WQEKZ+ORRXmqc1nA+IdILGEIfMRlHnaw7Wl/1Hzq8Yd1LKPGXiFoBosQC5q5HOd9Kb0BqLNXvdTxGIc9fL/uWdewQefBTXqy6b3h3jcKfTLQOKpDQXXPuRlgx9oB7A01ZsOl6dKm9Rq2Qt4Fh1LnY3ccM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/nIdavm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/nIdavm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A67C4CEC6;
	Tue,  1 Oct 2024 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727824242;
	bh=DcJk0ZurD4m477NZqGPsjHZFR3HoBgS1o2cMcYNYB2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/nIdavm1JqAX/giEtnJOkGz3xbjdMq6KQkVw4ljhSRaSLSeInkxiw57CPANodEdt
	 BDUmGhFZm3fprZ+HevIktBUAx5izVq2R/JTp8im484EKY4oXw8NTt5t6oKNbAQp1kC
	 e8yGKgKRY02ydyHb6dqxZyFPr4GJ8e9yA250mszB4bEa89E1LainJdofTupgX33ff2
	 LHU3kk6t+C1PUfcD4xRbxeFFbInkC08OQmL7FF6cple4SqU8vaHvD8uzGuqokjYtWd
	 GNQDdGXc7GtxZBSNqO/lNAEZp+2CDk/O28MXbb+Aezidxvikak450fAzj1jNkx2SkF
	 /ltNKeuVdCAyA==
Date: Wed, 2 Oct 2024 08:10:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241002081037.e9b825f7456ce4815eccad1b@kernel.org>
In-Reply-To: <20240930145548.08c8f666@gandalf.local.home>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051144.445681c2@rorschach.local.home>
	<20240917095538.GA27384@willie-the-truck>
	<20240930145548.08c8f666@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 14:55:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Sep 2024 10:55:39 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > The arm64 part looks good to me, although passing a partially-populated
> > struct out of asm feels like it's going to cause us hard-to-debug
> > problems down the line if any of those extra fields get used. How hard
> > would it be to poison the unpopulated members of 'ftrace_regs'?
> 
> The purpose of creating ftrace_regs was to allow a partially populated
> pt_regs to be sent around, as Thomas Gleixner and Peter Zijlstra were
> against using pt_regs that were not fully populated. Hence, I created
> "ftrace_regs" for this purpose.
> 
> ftrace_regs should never be accessed via its internal elements but only with
> its accessor functions, as depending on the arch or functionality used, the
> content of the structure should never be trusted. The accessor functions
> will do all the verification needed.
> 
> I may add some compiler hacks to enforce this. Something like:
> 
> struct ftrace_regs {
> 	void *nothing_to_see_here;
> };

Yeah, OK. But sizeof(fregs) may be changed. (Shouldn't we do too?)

> 
> And then change the arch code to be something like:
> 
> // in arch/arm64/include/asm/ftrace.h:
> 
> struct arch_ftrace_regs {
>         /* x0 - x8 */
>         unsigned long regs[9];
> 
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         unsigned long direct_tramp;
> #else
>         unsigned long __unused;
> #endif
> 
>         unsigned long fp;
>         unsigned long lr;
> 
>         unsigned long sp;
>         unsigned long pc;
> };

And if it is pt_regs compatible, 

#define arch_ftrace_regs pt_regs

?

> 
> #define get_arch_ftrace_regs(fregs) ((struct arch_ftrace_regs *)(fregs))
> 
> static __always_inline void
> ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>                                     unsigned long pc)
> {
> 	struct arch_ftrace_regs *afregs = get_ftrace_regs(fregs);
>         afregs->pc = pc;
> }
> 
> 
> -- Steve


Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
