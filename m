Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260202F069E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165686; cv=none; b=Ns6ois3rfBrhRe213PcPbpuOZz2zII4HsgT5lo7ieYp+RhlIUlgP4TjvcGcRHwMQciw3ZfwJHJHQO3thUBEsIsrpczXo8xUuhaxPKf/1TQExZfN0f6BjwjD1yKsOhsvfSX/imbDampRjmfQXn4Sh5WeO+PpWOgJZvn/S3s9G3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165686; c=relaxed/simple;
	bh=/cjzEoYOZUH5gf58st5NFBxDx/pO/aQKRFNN5GRl/nk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjgJjqptaZgsPPqu/79nvS5NftpwrewNbzJdqSp97bhqCXzrJjzeM6W6UBFtHHxouO9Ats7/5z89AhblckRUbMM9JA0nqZd0qT52oq1vyWH3ERZ/ZIwrvFBd622MN9PNzuIqsxit/msrwul6DCC4JCC7o1bdpEjLVDIDoBY9IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfKsQJTX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfKsQJTX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4283be7df63so23407f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165682; x=1761770482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unKE/F22XNSyuW9yU5JIIPfLSp87oQ293d4LB9OETlc=;
        b=dfKsQJTXV6q0cTduGrLtM9UYCSkixPf1QSGYbO/kqQNa0ITiP3fuQuTjrl1GR/OgKw
         UUD5+UjwAw7WN4L8S6rOWgFYL+2aHPtna2mMtFE7drAYVDF73Yd+A/WmDQSNGPbu9/lG
         cspwWB4yfmZPrzwxFuJnJP7RxkJ2pXIBGPvMd8kDJIRoECgosvz7D15wgCQkcN0mtT2E
         XK0D5Vq4hjUHq7cQGBA9aO2eKyCoF9d0C4zp232OecUo2qUZrorI9A75dDRMUbmTgH/5
         76b+QbsBsMQ3GZUeFRI2vZdBVA2Uu/tj1tAG86x5A5wqDAE6QWFZJV2JP9Sc8pyX6H7i
         txRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165682; x=1761770482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unKE/F22XNSyuW9yU5JIIPfLSp87oQ293d4LB9OETlc=;
        b=fuTs82/sNCQX6o7/29m7g3dzXp8RePUE+AeD7EkfOlCpxDZz5KLupRDZcKfD8IG4jR
         GRSrhpxLfAaoHjU4DaU918TGFeAbUYIyGga2xLqy5TAy8kIAXDZCA4RzX3Om90j9CDGI
         aVfrIBAHsZULnnEtupJ7gctwC7+nskJ/iu1g+B2PvtK1Qhi96r8VGOkml1FRqmIEI9Fn
         guZXcydlMYd6+EwPot1j703OSAPvxPw0MqcEWP3oZmCQKdF6SKNegqo2+jHQCiIbz+gH
         YwJF+ZoVYLpm7eQJ1dg4zY0mL+o+rGLElhYkzyMKxIzAMUWnArPK7XTKdEr0mj0VGdLt
         WyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV34GgI+mNZ+MBjDniT8KvGc96Md4Cy4WjiAZkdrzr3ILf+9OzQazBWW87wM6gqzOhis+GQPS3CGe2FWgzu1HbV9p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2orYusfQSAzkg9ZX60yiyX8HMMucz8cO09aN8N05TRFmnpAKe
	+V7v1LVWkCbFS6kD+fxj35lMy4markHau4gBUVD39f19jYAkl+zf3oXL
X-Gm-Gg: ASbGncv0rzL3vEgJkYj3wrv/p5QS0ffRG0ERBKJbrttJbld/pgNbd2lLia10xO2L2c3
	dFyVE0aNCPNDrSD7Rifp6KJpfPC59u1r+kqrtLlffcTmD1wB5W19QBdgsQvxZwWgm5FQZnRcpwb
	HPdoULr8hByZ/dcH2Jvc/nwiT/7L3jijUtuFr9wWQnnV2y6Ng0rXlssARuOwkSlvHDjQj4mf/pE
	sHzVNBuqoQCAYPXsIraqV8O9QAvCRRXkl4p4ZZTXF35rgU7cnz0O0z9i2xfw2wmbpoAiekQJwjD
	iOnaZWhc1pMKrJQQxG9oYVEoeuD1UvXfj+a+XmaXHNQwdr2qjkkH8ryabn/ZigXu+Rwuhlq6XoJ
	gaxeToxoETJKbL9PqtkTZWQ656rAb/5R4ytizw+fMG+b7T9En7/UwilCdUA60EsabNlTwSoUAPv
	s=
X-Google-Smtp-Source: AGHT+IGh0GLLdjFBGi5Y/tsXH9nF2sfGR5neIPd614tGmkEBYvy3EnkjHraKKTLmiYbIfHg64UFXJw==
X-Received: by 2002:a05:6000:400d:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-42704d98980mr14222089f8f.31.1761165682163;
        Wed, 22 Oct 2025 13:41:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm46152755e9.0.2025.10.22.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:41:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Oct 2025 22:41:20 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Feng Yang <yangfeng59949@163.com>,
	andrii@kernel.org, bpf@vger.kernel.org, jpoimboe@kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aPlBcKq7S-bD3B56@krava>
References: <20251015121138.4190d046@gandalf.local.home>
 <20251022090429.136755-1-yangfeng59949@163.com>
 <aPjO0yLCxPbUJP9r@krava>
 <20251022102819.7675ee7a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022102819.7675ee7a@gandalf.local.home>

On Wed, Oct 22, 2025 at 10:28:19AM -0400, Steven Rostedt wrote:
> On Wed, 22 Oct 2025 14:32:19 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > thanks for the report.. so above is from arm?
> > 
> > yes the x86_64 starts with:
> >   unwind_start(&state, current, NULL, (void *)regs->sp);
> > 
> > I seems to get reasonable stack traces on x86 with the change below,
> > which just initializes fields in regs that are used later on and sets
> > the stack so the ftrace_graph_ret_addr code is triggered during unwind
> > 
> > but I'm not familiar with this code, Masami, Josh, any idea?
> 
> Oh! This is an issue with a stack trace happening from a callback of the
> exit handler?

yes, it's triggered via:

  return_to_handler
    ftrace_return_to_handler
      fprobe_return
        kprobe_multi_link_exit_handler
	  kprobe_multi_link_prog_run
	    bpf_prog_run
	      bpf_prog..
	        bpf_get_stackid
		  get_perf_callchain
		    perf_callchain_kernel
		      unwind_start

> 
> OK, that makes much more sense. As I don't think the code handles that
> properly.
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 367da3638167..2d2bb8c37b56 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -353,6 +353,8 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
> >  SYM_CODE_START(return_to_handler)
> >  	UNWIND_HINT_UNDEFINED
> 
> I believe the above UNWIND_HINT_UNDEFINED means that if ORC were to hit
> this, it should just give up.
> 
> This is because tracing the exit of the function really doesn't fit in the
> normal execution paradigm.
> 
> The entry is easy. It's the same as if the callback was called by the
> function being traced. The exit is more difficult because the function
> being traced has already did its return. Now the callback is in this limbo
> area of being called between a return and the caller.

I followed rethook trampoline arch_rethook_trampoline code which does similar
stuff and gets similar treatment in unwind_recover_ret_addr like fgraph

> 
> >  	ANNOTATE_NOENDBR
> > +	push $return_to_handler
> > +	UNWIND_HINT_FUNC
> 
> OK, so what happened here is that you put in the return_to_handle into the
> stack and told ORC that this is a normal function, and that when it
> triggers to do a lookup from the handler itself.

together with the "push $return_to_handler" it suppose to instruct ftrace_graph_ret_addr
to go get the 'real' return address from shadow stack

> 
> I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?

if I remove the initial UNWIND_HINT_UNDEFINED I get objtool warning
about unreachable instruction

> 
> >  
> >  	/* Save ftrace_regs for function exit context  */
> >  	subq $(FRAME_SIZE), %rsp
> > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> >  	movq %rax, RAX(%rsp)
> >  	movq %rdx, RDX(%rsp)
> >  	movq %rbp, RBP(%rsp)
> > +	movq %rsp, RSP(%rsp)
> > +	movq $0, EFLAGS(%rsp)
> > +	movq $__KERNEL_CS, CS(%rsp)
> 
> Is this simulating some kind of interrupt?

there are several checks in pt_regs on these fields 

- in get_perf_callchain we check user_mode(regs) so CS has to be set
- in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set

> 
> >  	movq %rsp, %rdi
> >  
> >  	call ftrace_return_to_handler
> 
> Now it gets tricky in the ftrace_return_to_handler as the first thing it
> does is to pop the shadow stack, which makes the return_to_handler lookup
> different, as its no longer on the stack that the unwinder will use.

hum strange.. the resulting stack trace seems ok, I'll make it a
selftest I send it

ftrace_graph_ret_addr that checks on the 'real return address seems
to have 2 ways of getting to it:

        i = *idx ? : task->curr_ret_stack;

I dont know how that previous pop affects this, but I'm sure it's
more complicated than this ;-)

jirka


> 
> The return address will live in the "ret" variable of that function, which
> the unwinder will not have access to. Yeah, this will not be easy to solve.
> 
> -- Steve
> 
> 
> > @@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
> >  	movq RDX(%rsp), %rdx
> >  	movq RAX(%rsp), %rax
> >  
> > -	addq $(FRAME_SIZE), %rsp
> > +	addq $(FRAME_SIZE) + 8, %rsp
> > +
> >  	/*
> >  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
> >  	 * since IBT would demand that contain ENDBR, which simply isn't so for
> 
