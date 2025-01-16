Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA12C1A2;
	Thu, 16 Jan 2025 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993619; cv=none; b=DH1T+xRmewczSXICLV/KqB17n7lOjIqPZGjCFMPIk4G+6d8Uxhgn7bafXYDAS5XQ5VZ+ajFOnkqdPfWuLoyL7YLRPNYu2UCsz9tsv5aLIwV+V8BXtSXiRQ4R3qSMlGtQuNTxToqWms/c27NDm6VOl9M57RXgyA/hUreyr3JUKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993619; c=relaxed/simple;
	bh=LKmrl01+qZK5fI/2tUIXWHIMi8/zcRkfex+mFZvCBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0DEh5ItPK1QzkKYcC9Q7gSt33TLIeCTWMxTyovgi33yvTX35SW2t7PMMpVdMqvXdRLvSdhLAx1VnD6np/okbGmluCsn/Y8Jx2FHJEVzd7UIR11TpDBYPpZc72HLEErSgDEsacXjPO3rfoh93/JFHsAN6sY5tecbOM8HIZu+8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A903AC4CED1;
	Thu, 16 Jan 2025 02:13:37 +0000 (UTC)
Date: Wed, 15 Jan 2025 21:13:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-ID: <20250115211341.7a576804@gandalf.local.home>
In-Reply-To: <20250114212902.2bb6381e@gandalf.local.home>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
	<173643302228.1514810.2053430844068447947.stgit@devnote2>
	<20250114212902.2bb6381e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


ping!

-- Steve


On Tue, 14 Jan 2025 21:29:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  9 Jan 2025 23:30:22 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Adopt __free() and guard() for trace_fprobe.c to remove gotos.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v6:
> >   - Rename trace_fprobe_create* functions.
> >   - Rename __free label for trace_fprobe.
> >   - Simplify the last part of trace_fprobe_create_internal().
> > ---  
> 
> This conflicts with the changes in my tree. The ones that I pulled in from
> you that makes fprobes use function graph.
> 
> Care to rebase this patch on top of my ftrace/for-next branch?
> 
> Then we don't need to worry about the conflicts.
> 
> -- Steve

