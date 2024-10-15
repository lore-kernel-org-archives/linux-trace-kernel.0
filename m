Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA91FC7ED;
	Tue, 15 Oct 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000854; cv=none; b=kdMch6MUX4SC+SVMZoFxbAiNpJW7zd8cEhAp4QX2TGeG+4CWWFO2fNtfToJMAkohzowg4kLDyfffb6p3UG36dEn4+/XnaAnt1LY55gG+iEYD4k40NCo94pPH1fYMtnoievSf79qWSOSFzafDgqFEb5EUFqFkWkiLxxVUC2jz9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000854; c=relaxed/simple;
	bh=VBUKXGXAfb3iJDIYwPpB6hIzs1UeTcK6+tEEqYQ8IlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTD67bKS8gcsADtV8RM3IRHX/v8qw9Hw9nTMmYHl4Fm4cqcpf9zz2lVd71wprJOtpN2aQgii9sdt8FQ/tXiXqM6deTsu3inRzgHzw3E+GP+cgBX5McXQ5eu/D5PoPaNQGX/hQEpjBYh4QX2PKu1BR2HFZ6dMZvb57IHwYhJR/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1324C4CEC6;
	Tue, 15 Oct 2024 14:00:52 +0000 (UTC)
Date: Tue, 15 Oct 2024 10:01:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Nick Desaulniers <ndesaulniers@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: Have compiler remove __fentry locations from overwritten weak
 functions
Message-ID: <20241015100111.37adfb28@gandalf.local.home>
In-Reply-To: <20241015080149.GP16066@noisy.programming.kicks-ass.net>
References: <20241014210841.5a4764de@gandalf.local.home>
	<20241015080149.GP16066@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 10:01:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 14, 2024 at 09:08:41PM -0400, Steven Rostedt wrote:
> > There's a long standing issue with having fentry in weak functions that
> > were overwritten. This was first caught when a "notrace" function was
> > showing up in the /sys/kernel/tracing/available_filter_functions list.
> > 
> >    https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> > 
> > What was happening is that ftrace uses kallsyms (what is basically listed
> > by nm)   
> 
> Ah, if only. NM lists the symbol table, and that has strictly more
> information than kallsyms, notably it includes symbol length. Using
> symbol length it is trivial to distinguish the case you're tripping
> over.
> 
> > to map the location of __fentry to the previous symbol ahead of it.
> > Then it says that function is the name of the function for that __fentry.
> > But when you have weak functions, you can have this:
> > 
> > 
> >   int notrace do_not_watch_me(void)
> >   {
> > 	return whatever;
> >   }
> > 
> >   void __weak define_me_in_arch(void)
> >   {
> > 	return;
> >   }
> > 
> > The define_me_in_arch() gets a __fentry, but because it is overwritten, it
> > becomes attached to the end of do_not_watch_me(). When ftrace asks kallsyms
> > for the symbol name of that __fentry location, it returns
> > do_not_watch_me(), and ftrace will simply list that.  
> 
> Which is a kallsym bug that does not exists in the ELF space.
> 
> There is a patch set that tries to fix this here:
> 
>   https://lore.kernel.org/all/20240723063258.2240610-1-zhengyejian@huaweicloud.com/T/#u
> 
> Instead of adding size to kallsyms it adds extra symbols to denote the
> holes, which ends up being similar.

Yeah, I was looking at this patch when I thought the compiler could do it
for us. Especially since it now creates the __mcount_locs too.

> 
> > But I was thinking, since gcc (and perhaps clang?) now has:
> > 
> >   -mrecord-mcount
> > 
> > that creates the __mcount_loc section that ftrace uses to find where the
> > __fentry's are. Perhaps the compiler can simply remove any of those
> > __fentry's that happen to exist in a weak function that was overridden.
> > 
> > Would this be something that the compiler could do?  
> 
> Linker, this is link time. The linker would not only have to drop the
> (weak) symbol from the symbol table (which is all it really does), but
> it would now have to go and muck about with other sections.

Shucks, I was hoping that the linker would have enough info to know what
was inside the locations of those symbols. Oh well.

> 
> It would have to go re-write the __mcount_loc section and drop entrie(s)
> that were inside the dropped symbol. But then, what about other extra
> sections? For instance, we can have (and still patch) alternatives in
> the 'dead' weak text.
> 
> Where does this stop?
> 
> LTO can do the right thing and completely eliminate the weak function,
> but anything short of that is a really big ask. Esp. since this is a
> problem of our own making -- kallsyms is a flawed representation of the
> symbol table.

Yeah, if it's too much of an ask, then forget it. But I decided to ask to
find out how much of an ask it is ;-)

-- Steve
