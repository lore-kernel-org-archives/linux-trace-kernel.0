Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E247F47
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940829; cv=none; b=iydEAftRUlruo5Dc3yYKVi0CCwEYwdX+0AQjRSHWbb1cB2QjtQX/hYit/hs4ATrQPyUSw5pXIJZB5FLUTZIPAHlXPYYRdC1lD7iMBM9+1Lto/71frLSTjZwE6nVxSa1UnCjkU0kItKExvxnX9pG1eSMx1yhJg4Duys+05T8HZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940829; c=relaxed/simple;
	bh=81VC+3P/9ZBqPVP9KVAptwC7drQ509/J1S7L1Foa8iE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJneCdQqVfQfPJ1WIK8s8dCyyK+2s4B6Qs7JDaEIGcD2NDwbKzuTBrAFFc9CsAyudk5kPAKD424BK70i+wiJdRpYJKAbVVeBYL2I3L4P0VqBb4+IUFoFFXai5DAscXdaQP8j0uGeK/wUM+/YsqVcfTIugnyz+ndcgF8kD9VcpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30891C433C7;
	Wed, 20 Mar 2024 13:20:29 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:22:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/probes: Support $argN in return probe
 (kprobe and fprobe)
Message-ID: <20240320092253.2423ec30@gandalf.local.home>
In-Reply-To: <20240320124423.54cdb56dc8a07378fd09de38@kernel.org>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
	<20240319101000.4dbe0cc5@gandalf.local.home>
	<20240320124423.54cdb56dc8a07378fd09de38@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 12:44:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > kernel/trace/trace_probe.c
> > >     846                 return;
> > >     847 
> > >     848         for (i = 0; i < earg->size; i++) {
> > >     849                 struct fetch_insn *code = &earg->code[i];
> > >     850 
> > >     851                 switch (code->op) {
> > >     852                 case FETCH_OP_ARG:
> > >     853                         val = regs_get_kernel_argument(regs, code->param);
> > >     854                         break;
> > >     855                 case FETCH_OP_ST_EDATA:  
> > > --> 856                         *(unsigned long *)((unsigned long)edata + code->offset) = val;    
> > > 
> > > Probably the earg->code[i] always has FETCH_OP_ARG before
> > > FETCH_OP_ST_EDATA but Smatch isn't smart enough to figure that out...  
> > 
> > Looks that way:
> > 
> > 		case FETCH_OP_END:
> > 			earg->code[i].op = FETCH_OP_ARG;
> > 			earg->code[i].param = argnum;
> > 			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
> > 			earg->code[i + 1].offset = offset;
> > 			return offset;
> > 
> > But probably should still initialize val to zero or have a WARN_ON() if
> > that doesn't happen.  
> 
> OK, let's val = 0 in the store_trace_entry_data(), but WARN_ON() in this loop
> is a bit strange. I think we should have a verifiler.

Initializing to zero is fine.

-- Steve
