Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813E155A2F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269886; cv=none; b=hzEiygH3Pmj8sOQ7dsVrxKSyLTzSBEOtKAxsFLKM0zdNwQdkQkzXo7lXrikf9hOyTH2UJrlemd9HfEroVNFa2VoA+qRPATrghz+s5yQKy+Tje0ZDpQfOOT4ksgVtgKsUu6eDIJQD8xU7zeAbauYmy/sWN7xg3CjWWIHA2wEhWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269886; c=relaxed/simple;
	bh=G0cqPEahkysujxB/PBn4LPwSyVzrV66i/fETGksNg1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzGH5YOpD39WlN1MTn35pdFd3XuW7DYX8CMdOP+xVjZ2/f1SEm57Qbse1HLG4Pfkq3cgxgExcqtEbiRt7jPdqjSXBmvD49wyRkme1SNVFCzL44pv4DKzwbIecM+iNA2y4EAvN9EV257UF9hVpmC6dPdL//pDMOYeY7ymaZctWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24608C4CEC3;
	Fri, 18 Oct 2024 16:44:46 +0000 (UTC)
Date: Fri, 18 Oct 2024 12:45:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Adding ftrace support for coldfire ?
Message-ID: <20241018124511.70d29198@gandalf.local.home>
In-Reply-To: <12dbe761-d2e7-4289-88b1-4b7d548b4e8c@yoseli.org>
References: <12dbe761-d2e7-4289-88b1-4b7d548b4e8c@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:37:39 +0200
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Hi there !
> 
> I always have been a fan of ftrace, in particular when it comes to 
> latency issues debugging.
> 
> I would love to use it on my coldfire custom board (M54418 based).
> I can see that it needs TRACE_IRQFLAGS_SUPPORT and STACKTRACE_SUPPORT, 
> both are missing.
> 
> Is it not doable ? If it is, what is required ? Implementing the 
> save_stack_trace() ? I suppose it is not enough :-) ?
> 
> Thanks in advance, as it would be a great helper !
> 

The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
trace_hardirqs_off() when interrupts are disabled and trace_hardirqs_on()
when they are enabled. Now this is mostly done for you when you use the
function local_irq_save() and local_irq_restore() and friends from C code.

But each architecture needs to add those calls in the assembly for when
that happens, or even in C code where interrupts are being enabled or
disabled by other functions than generic code.

Now, x86 has been updated to basically enable interrupts almost immediately
when coming back into the kernel from a system call. Also the irq_enter()
and irq_exit() routines handle this for you too. Today x86 doesn't even call
trace_hardirqs_on/off() anywhere, but still supports TRACE_IRQFLAGS. It may
be possible that your architecture already supports TRACE_IRQFLAGS.

Basically, it is a requirement to use lockdep properly. If you enable
TRACE_IRQFLAGS_SUPPORT and enable lockdep, it will give you nasty warnings
if the architecture isn't keeping the irqflags in sync with the tracer. 

As for STACKTRACE_SUPPORT, you just need to implement save_stack_trace() or
arch_stack_walk() (which would be needed for live kernel patching). See the
code in kernel/stacktrace.c.

-- Steve

