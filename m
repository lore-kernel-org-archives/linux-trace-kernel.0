Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F91A2651;
	Wed,  9 Oct 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490767; cv=none; b=ZRhmyKa9LRJYDct7Y61QsdlKJyUtrEmKZtH1MfKtxcKCWb3WjXfKje3egE4CoGQ0L4tRTeEZFQd6xZxkl28UmwdbatGprzXbHkligz06OKmXrNUFwagExaAE/Hop5r3UJjryJjDrzpvGCXMF65RV2P19riTXmJcVzVVjKdzQqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490767; c=relaxed/simple;
	bh=sRCmrVo89+N/qcFG/7dN09ZirhQhhA+h4Jgfkh88iN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lynmydiF+MUn8O8MyBxUOoKTy4ROQECDgwSIgsDEJhLJ22y7yIIdF6E410wGi4Tm6AIzfuFh7DVLCqbW1nsVPUWI4Q55kY3ncsiU08Vxh2J1iI2/NQXdnmJSWBROZu+CcgKPlk/uiFF/6NtT1E7HZnnUyeTDhIq1Q3qjpk63+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB8C4CEC3;
	Wed,  9 Oct 2024 16:19:26 +0000 (UTC)
Date: Wed, 9 Oct 2024 12:19:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
Message-ID: <20241009121931.6156accd@gandalf.local.home>
In-Reply-To: <CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
References: <20241009153901.3878233-2-ardb+git@google.com>
	<20241009120257.7b2de987@gandalf.local.home>
	<CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 18:13:54 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> > > @@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> > >       movq R14(%rsp), %r14
> > >       movq R13(%rsp), %r13
> > >       movq R12(%rsp), %r12
> > > -     movq R10(%rsp), %r10  
> >
> > This part of the patch I think is perfectly fine. We haven't been restoring
> > R11 for 12 years I'm sure nobody will notice if we don't restore R10.
> >  
> 
> Not sure I follow this reasoning tbh. R10/R11 are guaranteed to be
> dead, so I don't see any point in preserving them. But if you do
> capture them, shouldn't you at least ensure that the captured values
> match the values that the callee will observe? (even though they are
> dead and we know it will never look at them)

Say we have code of:

	pushq	r10
	pushq	r11
	call	foo
	popq	r11
	popq	r10

Where we add a kprobe to the start of foo, the callback should be able to
see what r10 and r11 were. But the restore part is for the function foo to
see. It shouldn't care about r10 or r11 and if a kprobe updates them, it
should not have any effect.

What does restoring r10 and r11 give us?

-- Steve
