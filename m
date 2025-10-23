Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416F26D4E5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252134; cv=none; b=q0OA49MEz4WR1o+EQU/ANGRwaRv/9fLF3Jd2qnhAC7nepxRED+ITXV6+7Z3TIjJpvPPDJB6fkc6GhJr+BAchj/jIhefbBUvvA2BL05TWcwx5rmbrJN51o5Dkq1bejRrczzzNBewO1lyL+G3GOd3uhrR7pqWPPZHOg+gmt2bb0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252134; c=relaxed/simple;
	bh=Ko8enK1JFjO4wksPDhx1vkb6ZOvA41mPBysZQUIMwjA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6KWKTiVKuSfQxiKdOVF3EoMtNABqGIzcH8EatPp5JccssIgpx/wllz1XY1fbZrX6Hl+CeCEM6KL9OA2PLkNWp78gELkSmHi3m5Cd4fiIrZ+tHsKL9aL10mdSPfm1EqgOnEFqivh+PXaXHtYIdzYBnzqRTaZVslvV+CNKcVRDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bODeXg8c; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bODeXg8c"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427015003eeso1233546f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252131; x=1761856931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66M7HGTPtc8u9frhoZGdDnXO4Jxrrpgkx85w11tGgd0=;
        b=bODeXg8cRBHwkmpEEi1RfGb4AsEb1lzQqCQdJGQzXs9oVrImKPf5xNN022v1kLJxFd
         cery3yPSgXZ6FQowyjnun7JT6HFHLHz4C8Mgv4Yi02MMRm3qJNghBugN7nm2BMD63iHs
         SCaJLpEhOYxJ06jhxNocvMxVAno7pz15OEq3ZtQ+T80Sq9m2UOyZ+Nm9cBu9msRuE6x+
         YXr1PaAkf3PGO10XEjHPhwYGA6cn9JMvSq+4vYL3C6Dy5JJ62oOkxQmqs60qcP5SXx0c
         FVUgPwtdLXcpKl9Vu7cQy1KoVgNOOqVfKxI418o8dInr248JVwrOazeGvgMkNmIbBeK8
         fkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252131; x=1761856931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66M7HGTPtc8u9frhoZGdDnXO4Jxrrpgkx85w11tGgd0=;
        b=QoxRn7dxyqxNuMGl/0OafSf/G4KufnEqKGkZWDXso+zG0i4VM0qqpcIXct61SdjzLT
         BJUjax4UjyJISKFEFpsL0BPgA8S+4yCjHYy4fyrtJNOCg8bCavdhKN9qrxsiN3Wk+n5I
         C4J6+gIFV6R7m9+CTJA/ReqR+HNNnEUpL0XemE1yiD+DxNDbb16KjgenmOuF05CeDUWr
         ycvvKSu3tzjVpstHzxwhmxKmMauoJDI1HRb/XMP6F2y76SWydBCN0Cf/FOtZsj4UJiez
         jXcb6vN8WAcCAn/0XandLaqBi5XcIjWRxEAchAeRMlPRVpX8vs2uyi/gURbUB2/tzpvL
         kDlg==
X-Forwarded-Encrypted: i=1; AJvYcCUtfYnVrFFmoA+fXCwyiXtWIRdcsW0eVqAi01XuN826npzK7p2xZAWj6kHrSJHMmSpn58ScTJFnzNeuKeVPawTSAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpVfiflffqiZbqZxIzW7KAdxSlIznGvKoQKAlFvT/TeFlrN3g
	+n00RDhmnG7dtkwqCzLaMouTxfWw5q6AGxJ31GTfsza92Zs+KOkx8v7m
X-Gm-Gg: ASbGnctgqL+GIjUDzhjGgvDvJgqZImyw5PcPFDfFANgFvUWkxdyTTxEgp8q6i0KoTCL
	R8FpMoB3nfzBaq5SkRpIhUTrMPyoQ0YZBhUkDTqTq0RfQy3FGu6qodx4gt2CIXZ3LK9nwc7yFmg
	MizGJkTJMiWCLC5Q6mbRjMdTbYPc6blImlWZuBpszzg+Gva7vYhLRKdvuNF6xCpJF+BNqJEASsO
	Sv0WSLPDWkTkbFzBJlQh7CRZIhpJ7cmJ1T9BcA+n4JaQdrzz6jEHvRBo7lfpy4vlDlyZ4mBW04c
	zQIRIQz65d8vB7DIpFqs6YvP1UFxThyTqTRwr7XGajtcMNiqLE7TEKkexOQUNiJ6mZBRf6DznZ4
	LUuQpPdTOEc3ZOSizr51BM1WyqzFQ3retBwrXx/TnP7SBfGUt4rmwBViwFLlsVQoSX9DbpfFp8n
	I=
X-Google-Smtp-Source: AGHT+IH6iZz8EFIzMppyjzOaLTK75/NP0cBLfDd4PIrxDLXcjekN47dybvrXy+nypfWmsQABw7E9fg==
X-Received: by 2002:a05:6000:2586:b0:426:d81f:483c with SMTP id ffacd0b85a97d-42704daed1amr18761932f8f.33.1761252130798;
        Thu, 23 Oct 2025 13:42:10 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f5696sm5985507f8f.14.2025.10.23.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:42:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Oct 2025 22:42:08 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Feng Yang <yangfeng59949@163.com>,
	andrii@kernel.org, bpf@vger.kernel.org, jpoimboe@kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aPqTIDSHOSTiwYA6@krava>
References: <20251015121138.4190d046@gandalf.local.home>
 <20251022090429.136755-1-yangfeng59949@163.com>
 <aPjO0yLCxPbUJP9r@krava>
 <20251022102819.7675ee7a@gandalf.local.home>
 <aPlBcKq7S-bD3B56@krava>
 <20251022171711.5c18f043@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022171711.5c18f043@gandalf.local.home>

On Wed, Oct 22, 2025 at 05:17:11PM -0400, Steven Rostedt wrote:
> On Wed, 22 Oct 2025 22:41:20 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > >   
> > > >  	ANNOTATE_NOENDBR
> > > > +	push $return_to_handler
> > > > +	UNWIND_HINT_FUNC  
> > > 
> > > OK, so what happened here is that you put in the return_to_handle into the
> > > stack and told ORC that this is a normal function, and that when it
> > > triggers to do a lookup from the handler itself.  
> > 
> > together with the "push $return_to_handler" it suppose to instruct ftrace_graph_ret_addr
> > to go get the 'real' return address from shadow stack
> > 
> > > 
> > > I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?  
> > 
> > if I remove the initial UNWIND_HINT_UNDEFINED I get objtool warning
> > about unreachable instruction
> 
> Right. I was thinking we add UNWIND_HINT_RETHOOK and an
> UNWIND_HINT_TYPE_RETHOOK that lets objtool know that this function is a
> "return_to_hook" function and the unwinder can do something special with it.
> 
> > 
> > >   
> > > >  
> > > >  	/* Save ftrace_regs for function exit context  */
> > > >  	subq $(FRAME_SIZE), %rsp
> > > > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> > > >  	movq %rax, RAX(%rsp)
> > > >  	movq %rdx, RDX(%rsp)
> > > >  	movq %rbp, RBP(%rsp)
> > > > +	movq %rsp, RSP(%rsp)
> > > > +	movq $0, EFLAGS(%rsp)
> > > > +	movq $__KERNEL_CS, CS(%rsp)  
> > > 
> > > Is this simulating some kind of interrupt?  
> > 
> > there are several checks in pt_regs on these fields 
> > 
> > - in get_perf_callchain we check user_mode(regs) so CS has to be set
> > - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set
> 
> So this is a different issue. I rather have this added in
> kprobe_multi_link_prog_run as its the only user of it. Or have the

there's also fprobe tracer that probably needs it as well

> ftrace_regs conversion update it. This isn't something that should be done
> at every call and slow everyone else down.

I think it's ok, but not sure where to get rsp value at that point,
perhaps we could just use the pt_regs address

jirka

> 
> > 
> > >   
> > > >  	movq %rsp, %rdi
> > > >  
> > > >  	call ftrace_return_to_handler  

SNIP
