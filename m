Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E61F7080;
	Wed,  9 Oct 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490447; cv=none; b=TxSV6Eow0gameTkdimrRPHIR9O37Kh2RK07fUYpiolHawxbufa835R8pcmc0oNdqXjcsEw9mUDSqnaR/OmMFNldxlF4sLGE58phIq9Mu4ycDNWBsU864UH3Z73nnojG2viCnLxWt3EXxBHZc4/ZL7zU18fQDPGk60f5ndI3GlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490447; c=relaxed/simple;
	bh=PL5o97ExCqcN7XNy41khy8PdoDWkAGT0RRDbUP7371M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbTf7V9+31/KgA/hJbESotZEJTa6FL+Z0b79fs3LGRRTHFbL2RyBljlmq0DvBIYY7j8t6fEwBt649zYYLjGIGLKeATxl4/Gz4VAQCDhg0rCsjgljHQQlb4rbG+lJzXFiBoaIbBxg3AJ+UaehBgbhnHjb9tRzDAVJ3pom28JsHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHtGCIig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHtGCIig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2577DC4CEC3;
	Wed,  9 Oct 2024 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490447;
	bh=PL5o97ExCqcN7XNy41khy8PdoDWkAGT0RRDbUP7371M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QHtGCIiguNmatToABbPuH4jKXlaEyxZG9UyiS0M5iTIS3ZimJh1xWiJBweviD72l8
	 vJbla+5P4Cs9Cnr23/WHzX+UJ+POHEBZqF/FfbVrOlYrtHOxiA9aJQB46oYSAPoAHm
	 wCM1T0LEzX3NzhanOZN2uik+ydyScfcc2Ptv78ksbM7YdHYBfcYGCLQCwKcpev5KFJ
	 RgNfCuNX5rA/aemwlFNiwpW9y3+iEML7FmeEJ0otti6S0hClbb7aBHIRyrRkWmN59j
	 bSjw+S3FHqXZZuvMhwzMeoZrB1AbsvHLK1W+eH5Yhx8QeU344yEG/tkErPiauYF0ZY
	 VYVzLVpL7RiDA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53997328633so9571877e87.3;
        Wed, 09 Oct 2024 09:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnYaQizO6oGyCsgNvq4kw2rvO5rHfEdCmCNnGknUrf43kox3oHyUrXB/WPPxtHn3o2eFomVGervv8nB8k=@vger.kernel.org, AJvYcCXZJ/567DQhWKCivYufpK7NA6u8Ah3dx0KGi+twAJEhG6DDDack2CDqjW3BQOMPWSa+CcBoC1miUWJ7deRvOYa3CuLW@vger.kernel.org
X-Gm-Message-State: AOJu0YwR98Tp1rjwjXxxCXo4Rt62Bz7AABFVx+nhOANXsYWsXMHKQoFu
	94pZA7lGrPvIdsP1o4O2GFyBs84LS/+xQbNWh7qPFX9IHVrZ8meUDPu/goqCo3l+9b0EtURF/1E
	Ft4OMBHUz4gzk+IDm8t+bnZOf6Qk=
X-Google-Smtp-Source: AGHT+IEawgTB50U3SwPa0RrbmgOj/cQdmn1k1Cl34NjzxbXnBCNbZULDaI6yEgFa0VeVThE8j88hxC07CtBQdYdTApI=
X-Received: by 2002:a05:6512:280a:b0:539:9fbb:4331 with SMTP id
 2adb3069b0e04-539c4967f41mr2929555e87.54.1728490445557; Wed, 09 Oct 2024
 09:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009153901.3878233-2-ardb+git@google.com> <20241009120257.7b2de987@gandalf.local.home>
In-Reply-To: <20241009120257.7b2de987@gandalf.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 18:13:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
Message-ID: <CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 18:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed,  9 Oct 2024 17:39:01 +0200
> Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 214f30e9f0c0..9e13f9b203d1 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -216,8 +216,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
> >       movq %r14, R14(%rsp)
> >       movq %r13, R13(%rsp)
> >       movq %r12, R12(%rsp)
> > -     movq %r11, R11(%rsp)
> > -     movq %r10, R10(%rsp)
> >       movq %rbx, RBX(%rsp)
>
> This may need to still be saved. Even though they are pretty much useless,
> it can be used by kprobes, and perhaps they want to see what's in R10 or
> R11 from the caller. I'm not sure we want to remove this. Especially since
> we are even saving "flags"!
>

Are you saying kprobes will call this hook from arbitrary other
locations (where R10/R11 might be live), rather than only from the
fentry hook?

> That is, this part is visible by the callbacks, and the ftrace_get_regs()
> is to return a fully populated pt_regs if FTRACE_OPS_FL_SAVE_REGS is set.
>

Fair enough.

> >       /* Copy saved flags */
> >       movq MCOUNT_REG_SIZE(%rsp), %rcx
> > @@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> >       movq R14(%rsp), %r14
> >       movq R13(%rsp), %r13
> >       movq R12(%rsp), %r12
> > -     movq R10(%rsp), %r10
>
> This part of the patch I think is perfectly fine. We haven't been restoring
> R11 for 12 years I'm sure nobody will notice if we don't restore R10.
>

Not sure I follow this reasoning tbh. R10/R11 are guaranteed to be
dead, so I don't see any point in preserving them. But if you do
capture them, shouldn't you at least ensure that the captured values
match the values that the callee will observe? (even though they are
dead and we know it will never look at them)
