Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C392882A7
	for <linux-trace-kernel@vger.kernel.org>; Sun,  4 Jan 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527783; cv=none; b=eECPRhsGhwKwhlRI5xJ1ialr0aEUvAVfSi09X099CJCPDKwNl5Hy/MprDWXpYxsj3bl/xG8hU48OobbHolxr1ULHPJyfjTKHh5edQbtKxsI+g3vEb4uWI/bCQLRqkqmKKr6du525FxEzDJGqW6/8fACWov7GbspENY634qeji1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527783; c=relaxed/simple;
	bh=GAoHNm2kxQ3VVMYBhOd0J23ZuTQPhy4Pg9gBc2k7exk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIN0goNzZRqcJHmYjcnzq6duy9P8jrAWrPllmlu3xYt5nii1mKIRmeZhYur2x97491/lGqCD5nzLYrpjKXpU+BeMkyUqkOZnqF2UHNCszhyeUiYPdnoQs8Faa7RTqJJJgJWretbjGVBR9lDKf1LBa5JDdM4lOPXpvXIfqiyD9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvmWHaNV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvmWHaNV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47796a837c7so85050815e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 04 Jan 2026 03:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767527779; x=1768132579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHWuScMnE43MBF17SntuhCPn9/ypQW7BMwUOJWNkTIA=;
        b=hvmWHaNVEpnLx5kUvhRSHFpEoR9HQcpWjX/LoBkx5uBs4lAHExfoY97zVOiqunoUka
         ZC5B30hZsZ9T6BWuhyppNvQt5TQxtDIEMnf4pFS5cmEZWLih3KyY2b8tQ1xmj9aVyoIN
         x486/7nrbgwLywAD6HB/DQg0ZL7FPFXeMA7NwciFHloYMLGKA1ERPFU2m7lNkQmA7alJ
         To//iag9Jqr+Kr1v7vTzEoQzmTH/9yx4IjvbhlgZFSfgtPrGSN7vO9S3H0sR7ew6QpXF
         Ig35DxxoZDki118NbtdgqYMLmIOLhYND5qons/ldOm0KsLaHmzrSVAZPl/3HXWGKdQao
         OeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767527779; x=1768132579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHWuScMnE43MBF17SntuhCPn9/ypQW7BMwUOJWNkTIA=;
        b=weI7/2ZbErcWO+otTtRk1lRA7NWFABdrNNrzkp4DsoMNBEEobKmbxTeUMDWmLILs+C
         FYYuey860ROJn6VbZ1Hg27O1W+V2mw07AEQUTsG829M9EdEy0SiUtgMuBy076qCu1gLe
         402KUcoQIW+Zsvw0EGFGRyVFwSXp5r+lHSUotyce/8UVNhtyRGYB17i0ZXB5mYUBRIsK
         OMCPZg81uOzKWbNcjX6WaXbQjs5M4xREy9PyslWEkngUua6m8hmC0skOQWeK8tusSuBJ
         Sy5ERXm/sl3I6t00Fs+TXChtOoHbL/VLQji6aW5xYkvNKg4MR7EgzH87t312noOIWtkZ
         NcBg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ocS2BGAqr9lVQllwctGKecnj9aLUEon0prOjQ5QFb5c/KcoH0+TEBT0iEzkiAaUNNPcqI2wUwdVLwzg25MOx8+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsn4CQpAOIv1opmgC/JTySCfYeinYfNcqa5pDSd1ht2dN8oVI
	5QMUcRvTa9biil8wi3QLbDEsENsw6U6eC96La+z6/H02U9/gEHgqsxWl
X-Gm-Gg: AY/fxX6UfKo7WKV9hkRXV7Sj8dbTRG2ZBi/ad9g09uCk2cR4Iz/SLtzJYy5Z+Qp39p2
	bq0YWrbeC3g2ZkNVluSYU6OOi27NoCNKM3CCRDh9fMCMY11yTYc5AAKsMvvVmzmyCtCFOnwI5Ci
	YezYVZk4buGdb/bc7E0aLGeF7Fkrkby8LfHk/0aR5X/qvf3aW56znetMh/1k/ZVp8y4X5bFTufG
	LB7baZOXcwcdz2QJBxET6W64geRHyZ+pTq9AiHhqRBCeQrJHH7BT2ehhkhn1TO7AHi6rfo11jqb
	lEs1Px1BXlsiwJ/Z95gd3qdo1JXF8hFTVKrGojw3604WxXAh4yI5kvc4TfhpGpOsiCw+LG62m1F
	wQoOtwPKM2YmY8Xfnyt0GkAnWtpWe5jSLidYFD9cjHM3kT3QkOHl8SGGAhimi
X-Google-Smtp-Source: AGHT+IHIZnfdFKqNFB8eAXksIPvZyz9IWgsHY++6OlvULt6SnYStqYI9H7OUETi7olVZTWz0wUJceA==
X-Received: by 2002:a05:600c:a31c:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-47d264eb68dmr411443735e9.22.1767527779267;
        Sun, 04 Jan 2026 03:56:19 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba5001esm36036965e9.3.2026.01.04.03.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:56:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 4 Jan 2026 12:56:17 +0100
To: Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aVpVYUaBOWk22RtO@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
 <aVfbqYsWdGXu4lh8@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVfbqYsWdGXu4lh8@willie-the-truck>

On Fri, Jan 02, 2026 at 02:52:25PM +0000, Will Deacon wrote:
> On Wed, Nov 05, 2025 at 01:59:23PM +0100, Jiri Olsa wrote:
> > hi,
> > Mahe reported issue with bpf_override_return helper not working
> > when executed from kprobe.multi bpf program on arm.
> > 
> > The problem seems to be that on arm we use alternate storage for
> > pt_regs object that is passed to bpf_prog_run and if any register
> > is changed (which is the case of bpf_override_return) it's not
> > propagated back to actual pt_regs object.
> > 
> > The change below seems to fix the issue, but I have no idea if
> > that's proper fix for arm, thoughts?
> > 
> > I'm attaching selftest to actually test bpf_override_return helper
> > functionality, because currently we only test that we are able to
> > attach a program with it, but not the override itself.
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> >  arch/arm64/include/asm/ftrace.h | 11 +++++++++++
> >  include/linux/ftrace.h          |  3 +++
> >  kernel/trace/bpf_trace.c        |  1 +
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index ba7cf7fec5e9..ad6cf587885c 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  	return regs;
> >  }
> >  
> > +static __always_inline void
> > +ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > +
> > +	if (afregs->pc != regs->pc) {
> > +		afregs->pc = regs->pc;
> > +		afregs->regs[0] = regs->regs[0];
> > +	}
> > +}
> 
> This looks a bit grotty to me and presumably other architectures would
> need similar treatement. Wouldn't it be cleaner to reuse the existing
> API instead? For example, by calling ftrace_regs_set_instruction_pointer()
> and ftrace_regs_set_return_value() to update the relevant registers from
> the core code?

I knew I forgot some change.. thanks for replying

ftrace_partial_regs is overloaded in arm64 and because of that we need
to propagate the change to pt_regs, so I think the ftrace_partial_regs_fix
code is arm64 specific, so can't see that in core code

also wrt ftrace_partial_regs_fix name, I was thinking it might be better
to have begin/end functions, like:

  ftrace_partial_regs_begin
  ftrace_partial_regs_end

thanks,
jirka


--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2560,10 +2560,11 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	}
 
 	rcu_read_lock();
-	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
+	regs = ftrace_partial_regs_begin(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_end(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
