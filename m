Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF63153BD9;
	Mon, 30 Sep 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722937; cv=none; b=pGJ0BmAevi2NNHGPRcqiuRzHD3BKPFJKtpCJTFX+HDN4OiiNs8I11EvyP5K25HZ2zMWXkv63vxnr9LAI6xLU51AzsAXndPZ+29lE0Dc0NPeG8e2+lD1el7S+D8NYKzRL1SRX6I9i/xPgdrQG4Z8wQkTO2YhcUJD4uIFDCCQBABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722937; c=relaxed/simple;
	bh=wMbFHdXqBIdG+oRxD5J6NHowpF0hcDclJPDEViwBQ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRKbd2pN23jji7pVXlG+SFEakaIVOxK+j0p+ro8BYyGhiw08ErBSPEjcICiq9xy/DYY7E6nieLYedMGprKSQU/2qGbq6WJg/s28c2BWR4pGtvKcOedp1v+D4rG9OTsYyWf5//XIn8u8eXnr76rrnZFxeEhrHL8LtnZA1V5ednzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75599C4CEC7;
	Mon, 30 Sep 2024 19:02:15 +0000 (UTC)
Date: Mon, 30 Sep 2024 15:03:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 05/19] function_graph: Pass ftrace_regs to retfunc
Message-ID: <20240930150302.6c5c9f0a@gandalf.local.home>
In-Reply-To: <20240917100848.GB27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615374207.133222.13117574733580053025.stgit@devnote2>
	<20240915044920.29a86d25@rorschach.local.home>
	<20240917100848.GB27384@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 11:08:48 +0100
Will Deacon <will@kernel.org> wrote:

> > > @@ -787,6 +789,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > >  	}
> > >  
> > >  	trace.rettime = trace_clock_local();
> > > +	if (fregs)
> > > +		ftrace_regs_set_instruction_pointer(fregs, ret);  
> 
> Where does the instruction pointer get used after this? The arm64
> 'return_to_handler' function doesn't look at it when we return.

It's for the hooks to the return instruction. kretprobes will start using
function graph tracer to hook to a return of a function (via fprobes), and
the callbacks will need access to the return pointer. The callbacks get
passed the ftrace_regs, and this is how they can see what the function is
returning to. For example, BPF programs will need this.

So it's not needed for the infrastructure, only the callbacks that hook to
it.

-- Steve
