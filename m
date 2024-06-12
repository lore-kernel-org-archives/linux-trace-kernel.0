Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707515C9;
	Wed, 12 Jun 2024 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156383; cv=none; b=bVn77rZhYTIEt6B8ehiEtKL0JgkXVKr/VCINOcfSCwD6oPyKBNtXryNsH5BB8ot+52W547+JjJHjYr3X0B7XPKdFW4cdtWFjkUujuxi2394RtdEJoNcC5PVb4B2V7pa8S32gM7slI9CaULmKPju93DQ+gmdMEneqeUi1hlwWR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156383; c=relaxed/simple;
	bh=KS36mYBgIWf5s1bwtKzvKfKlN+P6ZAnGVmdaZy12Wqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOYBcJ4eUanuYR4nKWlXAdUOM9d58GabohGSpXG61W4G+9MIvYMp9pcMv7+GS3JRf+3u1H3/xQcG7VlMT4rINIFgdjd1kNahxrnuQIl7Jm+US+PT9HfKCVgMO/8SDsT2rxNeITaKb4EQhH9swzJG1Y/cnS2K4Drc7rcPjqPrUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E77C2BD10;
	Wed, 12 Jun 2024 01:39:39 +0000 (UTC)
Date: Tue, 11 Jun 2024 21:39:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Ross
 Zwisler <zwisler@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 01/13] ring-buffer: Allow mapped field to be set
 without mapping
Message-ID: <20240611213937.408770fa@rorschach.local.home>
In-Reply-To: <1e74c6d8-ae74-49c2-bdc4-d9880110ab57@roeck-us.net>
References: <20240611192828.691638177@goodmis.org>
	<20240611192907.402447387@goodmis.org>
	<5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
	<20240611185319.58a52a1b@gandalf.local.home>
	<1e74c6d8-ae74-49c2-bdc4-d9880110ab57@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 16:53:43 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> >>> @@ -6403,7 +6407,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> >>>    	mutex_lock(&buffer->mutex);
> >>>    	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> >>>    
> >>> -	cpu_buffer->mapped = 0;
> >>> +	WARN_ON_ONCE(!cpu_buffer->mapped);
> >>> +	cpu_buffer->mapped--;  
> >>
> >> This will wrap to UINT_MAX if it was 0. Is that intentional ?  
> > 
> > If mapped is non zero, it limits what it can do. If it enters here as zero,
> > we are really in a unknown state, so yeah, wrapping will just keep it
> > limited. Which is a good thing.
> > 
> > Do you want me to add a comment there?
> >   
> 
> Maybe. I just wondered if something like
> 	if (!WARN_ON_ONCE(!cpu_buffer->mapped))
> 		cpu_buffer->mapped--;
> 
> would be better than wrapping because 'mapped' is used as flag elsewhere,
> but then I can see that it is also manipulated in __rb_inc_dec_mapped(),
> and that it is checked against UINT_MAX there (and not decremented if it is 0).

Yeah, the __rb_inc_dec_mapped() is used as it is called when external
sources map the ring buffer. 

This is incremented and decremented internally. That is, we increment
it the first time the ring buffer is mapped, and decrement it again the
last time it is mapped.

I could add the above logic as well. I hit a bug in my more vigorous
testing so I need to make another revision anyway.

> 
> Maybe explain why sometimes __rb_inc_dec_mapped() is called to
> increment or decrement ->mapped, and sometimes it id done directly ?
> I can see that the function also acquires the buffer mutex, which
> isn't needed at the places where mapped is incremented/decremented
> directly, but common code would still be nice, and it is odd to see
> over/underflows handled sometimes but not always.

Sure. I'll add comments explaining more.

Thanks,

-- Steve
