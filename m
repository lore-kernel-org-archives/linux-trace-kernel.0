Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F835581D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949088; cv=none; b=GjlXHouvkXSgw9+DpYpgt1M+SlFcpvkuR1duYsOVwgR/g3CzTPA8/fO7ALGFier4PHi2Iw59c4yifXs9kOMg+Ll6Chq6cLEAI2HeUJrwvut+a/BhMqTfaG3VAYeKcfhkxqQOi6uWPo9fZqHkM02jGdtULl9gInO07UGLzuGcJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949088; c=relaxed/simple;
	bh=Ye1BtRyDyCZ7fcEJvKPT/mRELE9PMSLftW7wgjHmKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3xNeBymJDwNakrEzO8x2cuhHCXTM/CWBEGDjVRs50so97aylR0awu739+Q1OAeHXDBPQlEyiwmhea8u/sVsTijoxsfYMsgt5IBAgIaZuFg9QU5jCVAK19AQDShzoCJjikBOOeGz/ZAb4gm1fVm11vjuT5QhGZIDEFXzZoyW1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HA8vW+/c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HA8vW+/c"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47928022b93so7594015e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767949079; x=1768553879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXYuN6xeN+Ya8/ES460opJxIhbpHbZkVlPrAHWs4g/A=;
        b=HA8vW+/c+9xhlkRxOpcBMOymcZE0fy9GZpYKAsmNQ1fdBq+jaUHMVDrt1sWT6RVTU4
         fBo5pLG/kPkHWmulxqrliZq+aEeDOTStzkuSliJ6pLJsnixeIEz+mVnpmWCw/bmmcKZg
         GslcFgC/2ZOl26ynYF+Wa+Ca7oj6bt2WeAkn6YGH5Nsv25MhEQR9N1bjyg6CVCcXuCS6
         Fk5u0B5IqOwU3bAqBFTESmWD9XCA/jIEjV7Tu34KFpotrAZ2YHE50X8iFiMHvaPKBJ5z
         vfen0PC3zq4XEBlEXu3h2dB4caiK56OU+wmwG9L938aChwaUeIixtKgMhL6m3ILgYafr
         p13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949079; x=1768553879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXYuN6xeN+Ya8/ES460opJxIhbpHbZkVlPrAHWs4g/A=;
        b=OOvt8eSYp2DLKY4jIvs9qLVK+rAg1e4ih6FvDx6c9RodAQXpzMOonaYTuaqGRJxuhU
         jbzYMWph/65XPcN3KoV6dyzkoeGPZp68HDTfyIkpvwgghgm7YHEhD3tTL+eowdcaVcEl
         /Zo2OO5CpIVDFx8HIViQyeOI7cmhk4Ma07nzB7qnjCG+eqddqS6wLLHFsj1jakTFTtWC
         v6SM1JBTblHy7ROnp/C1VG0b5/N2yTbDE3zi0+AZHxNol1KrOSCONDFdU3+R+8WS/LY/
         Vs6vu5JgwDaVQBr3nL3MUBCqHOX5JnvuJt1gZ3G3U1y6X+L0F2IKJ1iTchvgFP7DjARC
         tmJA==
X-Forwarded-Encrypted: i=1; AJvYcCWEU5YvcKCpj6ncMTa61VcsXJA4I9iKzi027kEmxwUhFr/NriVjxNG6B7FX0fGfRt22aJlDB7FDa60UgWmfuIgM5+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSajZ6R0hR7ygKlEXxdvX1xzlci5UGTvM/89s+3tl7eBDSNYJ
	09DrBEICerji2p2rwh4VYyDbf6b/bzAdJoX7WHJGQOcDIzNpXKTAsMbOts8rNo4iBzg=
X-Gm-Gg: AY/fxX5rfeW+JcKEJ65VEFh4J0a4LPMEd6//edJ24yLgjMqvb2Tjav1SnFFCbVptXmt
	8UZC/RTyLlbRHfXWJUXiuUO1cWT/LsAV/h2h39RHDv2IXldZVmTkwF+r8wccXDtqYHN7NuKkEp+
	Jaiq76UP7jOlfHtwwcWreoaH342+bNjJd5376DadEhKu16yGFza0wNYE205tcal4icojn3PKJ1l
	2Fq7geDh52QUXIxq9ywz+thKKvJ2Tm4QhyxqLvzivMqiauHyHEjOnRcwFwt9941VPENfbD3Z+d1
	rOODyCQcGWU9/XJEsxO5QOGYH5F7x5bAMMaYTR4QDYW9ncBEY3YziYy0VgnQInRvPO9JN4b1KhG
	4K4FUIBv8s6jG3/jsAtY5EyNhX8EIlmqjdDB/6rEJz7KrdQlYz3JfK3d13gWzkGagJOinFeJLiH
	tFBE3lbEF33sLD5Jn5vOnXmQqExbuF0TQ5EkF4ZqJivjHsoVvqPCDxyNEvqmE/1kJWSsWUbB9oa
	5Wf
X-Google-Smtp-Source: AGHT+IFgxQgdBinp7wbCc/TkbY/jHrzbeepppdW/KOxOAc/R3j+vhEOCPBjEv3iR0E9dqk/KefCpyw==
X-Received: by 2002:a05:6000:26d3:b0:42b:55a1:214d with SMTP id ffacd0b85a97d-432c379ddebmr6492578f8f.1.1767949078874;
        Fri, 09 Jan 2026 00:57:58 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm1002142f8f.27.2026.01.09.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:57:58 -0800 (PST)
Date: Fri, 9 Jan 2026 09:57:56 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260109095756.13deb429@mordecai>
In-Reply-To: <20260108115800.7a7fc8a7@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
	<20260108115800.7a7fc8a7@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 11:58:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 8 Jan 2026 09:39:32 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > > > Or we simply change it to:
> > > > 
> > > > static inline void      
> > > 
> > > Actually, the above should be noinline, as it's in a slower path, and
> > > should not be adding logic into the cache of the fast path.    
> > 
> > However, to be honest, I'm surprized this is considered slow path. My
> > use case is to record a few selected trace events with "trace-cmd
> > record", which spends most time polling trace_pipe_raw. Consequently,
> > there is almost always a pending waiter that requires a wakeup.
> > 
> > In short, irq_work_queue() is the hot path for me.
> > 
> > OTOH I don't mind making it noinline, because on recent Intel and AMD
> > systems, a function call (noinline) is often cheaper than an increase
> > in L1 cache footprint (caused by inlining). But I'm confused. I have
> > always thought most people use tracing same way as I do.  
> 
> The call to rb_wakeups() is a fast path, but the wakeup itself is a slow
> path. This is the case even when you have user space in a loop that is just
> waiting on data.
> 
> User space tool:
> 
>   ring_buffer_wait() {
>     wake_event_interruptible(.., rb_wait_cond(..));
>   }
> 
> Writer:
> 
>   rb_wakeups() {
>     if (!full_hit())
>       return;
>   }
> 
> The full_hit() is the watermark check. If you look at the tracefs
> directory, you'll see a "buffer_percent" file, which is default set to 50.
> That means that full_hit() will not return true until the ring buffer is
> around 50 percent full. This function is called thousands of times before
> the first wakeup happens.
> 
> Let's look at even a waiter that isn't using the buffer percent. This means
> it will be woken up on any event in the buffer.
> 
>   rb_wakeups() {
> 	if (buffer->irq_work.waiters_pending) {
> 		buffer->irq_work.waiters_pending = false;
> 		/* irq_work_queue() supplies it's own memory barriers */
> 		irq_work_queue(&buffer->irq_work.work);
> 
> 
> So it clears the waiters_pending flag and wakes up the waiter. Now the
> waiter wakes up and starts reading the ring buffer. While the ring buffer
> has content, it will continue to read and doesn't block again until the
> ring buffer is empty. This means that thousands of events are being
> recorded with no waiters to wake up.
> 
> See why this is a slow path?

Thank you for the detailed explanation. So, yeah, most people use it
differently from me, generating trace events fast enough that the
reader does not consume the previous event before the next one arrives.

I have removed both "inline" and "noinline" in v2, leaving it at the
discretion of the compiler. If you believe it deserves a "noinline",
feel free to add it. FWIW on x86-64, I didn't observe any measurable
diference either in latency or instruction cache footprint.

Petr T
