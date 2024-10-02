Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6B1D0E18;
	Wed,  2 Oct 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879473; cv=none; b=iXAm0aIrv3Bp1YTWC5MIzXLyFQwRyHVaXFgqvgDtG0yI17fMtsdet+WRFqpKtetcggo45xjV/Ec4GZ8PBUfWr9gXDxy9MUlbNIlO0nuzCJ4+2z7UcNCkwdj/xV4YGXSTyKQHt7uYtqckyNogzZ4+ylcxnfntnEaQF4mKWZvjuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879473; c=relaxed/simple;
	bh=7QrNOvyhNom77KQGrs/t7eMr6qYJYQNHCPzn2XeEmZk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kCxRUoQiV1zqztNS9IBZcGjVGJnmlJmIiXTeH+yS13szFwDqQzYGZUi95eIzLKKUgM+43jzpBvJPjFHwdsdHWyzO8+4yO7iWZNBFs4LgPLGobtzD2cRZLV+AU9XcND2Slsgaf9wcDEtMo2WcDlLgwHAC8Tu9L/wx2YDS6I/kWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJKQKjtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJKQKjtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67049C4CEC5;
	Wed,  2 Oct 2024 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879473;
	bh=7QrNOvyhNom77KQGrs/t7eMr6qYJYQNHCPzn2XeEmZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJKQKjtwuljUQETX3A01ZIMibs/ViHavZ74RNwceIvmWzOaQ5RnRGKG22YgnKlBut
	 vfkpP2b4ZfHgZDr9i84lgp1trq+pD9VcWU9K8c9xat9EGT1pKlx2JHYN17t/UOiYOw
	 iRM2aHuwdZ0ejp+4auqwjM2QJIEtyUxSybw/9523lYeYAACGiy5beFokFcCYXBAw3O
	 sgbQ2QwIuR+W1/VO3diF34mCXir9CSb8JA5gNBZZmczNq3dYMPXic59LnyC7N/oyof
	 6Xx0Y5o1XX92jex1p1VnXPdcPsj7nYOGV6SU28hWvfk/it08ZluzzWtO6p1R7382I8
	 jSFURQZ7W0GNQ==
Date: Wed, 2 Oct 2024 23:31:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Florent
 Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241002233108.9e4c2aaa09b8532870016dc0@kernel.org>
In-Reply-To: <20241001193234.2acb6147@gandalf.local.home>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051144.445681c2@rorschach.local.home>
	<20240917095538.GA27384@willie-the-truck>
	<20240930145548.08c8f666@gandalf.local.home>
	<20241002081037.e9b825f7456ce4815eccad1b@kernel.org>
	<20241001193234.2acb6147@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 19:32:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2 Oct 2024 08:10:37 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > 
> > > I may add some compiler hacks to enforce this. Something like:
> > > 
> > > struct ftrace_regs {
> > > 	void *nothing_to_see_here;
> > > };  
> > 
> > Yeah, OK. But sizeof(fregs) may be changed. (Shouldn't we do too?)
> 
> Honestly, I don't think anything should be doing a sizeof(struct ftrace_regs)
> 
> Heck, perhaps we should make it totally zero!
> 
>   struct ftrace_regs {
> 	long nothing_here[];
>   };
> 
> If someone needs to allocate, then we could provide a:
> 
> 	ftrace_regs_size()
> 
> helper function.

Ah, Indeed.

> 
> > 
> > > 
> > > And then change the arch code to be something like:
> > > 
> > > // in arch/arm64/include/asm/ftrace.h:
> > > 
> > > struct arch_ftrace_regs {
> > >         /* x0 - x8 */
> > >         unsigned long regs[9];
> > > 
> > > #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >         unsigned long direct_tramp;
> > > #else
> > >         unsigned long __unused;
> > > #endif
> > > 
> > >         unsigned long fp;
> > >         unsigned long lr;
> > > 
> > >         unsigned long sp;
> > >         unsigned long pc;
> > > };  
> > 
> > And if it is pt_regs compatible, 
> > 
> > #define arch_ftrace_regs pt_regs
> > 
> > ?
> > 
> 
> Only if it is fully pt_regs compatible.

Yeah, OK, this is good idea.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
