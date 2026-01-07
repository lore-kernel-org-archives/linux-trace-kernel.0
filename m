Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19ED313268
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779506; cv=none; b=ta8WVqXe/fi7SAcXe3hMFkH/f8jiKKaVPhX03Ei3TjKRcaUiXwp5A+5qt4okE180Mz+hEKiLwIQH/cdEo9j66QzcwR7wV6vnrF605DwfMbPwXDq+MNCBGLDNvL7Q06uYTjdoTGUWMibXmBpJco83aQhx/PG6ogacY6jVR6c0bgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779506; c=relaxed/simple;
	bh=iiT2R8UnHUrK/rPGvAFhFVgfetfWj89nepLFbQiox64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc7TdyWkxCZz8QZ/Xpt6togO2ljst2n19B/xNIsS/jv98mTnXLhvFb+xfC3gaE4YCTvajksOU7ST059FwlRT8buL+h3EQ88trO2DLJ+CLx8x+BsA4OFyScssGI8gVTLb+RA20bf5eQAKXQj8Jbqd1k9t9mLY5N6Yxv9sPyPn420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e7V+MxZA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e7V+MxZA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d211aee52so2290975e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767779502; x=1768384302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkfocqoVaxgUjAmHmf02FgYq+uCwVg0Btx7TYoadT20=;
        b=e7V+MxZAX26mEbmvSSNJ3K6XCeKoHG3MzvXSddS6rwIRDWGPOUCaECYT3wUGcm9NkC
         frQtPnDcrWPCp8QG2kGuOMmaJ95vZUb/ytvpXWgO3H/fLACEhEWHZz2hi3vCZDTY8UFJ
         awKqfEHNOprlS9xqDl7fUXPbhUDIebty7YD2hqNcJ90ddEgYML8Sg0DDpIT8zYLQaxFo
         bO2fQiuT03Kwhx+Ha6RAPfQZCeBdWpuJypmVtX9cFE/S//K+ofgIcjcpqBoaN8QbYHK6
         cRzAN9f0pbXib1Im1q/8AU9n1EtNEAkDSlVJNg8W9H0ZOHm8sBzSriBYTYD7e1oyffVk
         ISqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779502; x=1768384302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NkfocqoVaxgUjAmHmf02FgYq+uCwVg0Btx7TYoadT20=;
        b=b0AZ5fzDB7ASEAN4zgnyeWERpM1k8LcpLRixMdt9h1R3+JiBKSvqsvlztdn0U6YT3e
         y2VSFSwbSrJ9dI0UuP/gaSBCV1uafDaHssbR05PRihtvZrEsSlufEnGugb528Mm4UOCv
         WXr7Zu+4ZwzvwYeMwidGAV12OpRNs5gFonLhbNgZsJDoad6c5JayxYpnfv+Oo621mH73
         ZHXCL+/jWzjAyNOiFxpQnWk4BOTWKgSJNHfEfTfJuUIAHKmLqr6eUOSR/MB4+w+ikZ2Z
         f3J8wiFYAeU1xlCGdIdavraTkDMwIMR39ZsRRkAdF8TATnGRGKL1LWWq6uTmEPLglvtO
         Ok4g==
X-Forwarded-Encrypted: i=1; AJvYcCVFpc+fXMHtGFA/gpW64mp7wOuQrB3Wgq8s9dDUfb7XX7XW31fZSnD6sTWhxoArl8KhFPYdSeImwVJgJ30aXDBZSP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1K+T7pzvrtfalDGLbwc9gL06aNRruZw2ZNCuT+UZ5rZLW2jRC
	ov24ioHODQCPapeqJEftAL7yRAX+oZdsZkvoeNxYsbqmvbC5kasPbGC8caniLy/h2Ys=
X-Gm-Gg: AY/fxX5tXp6oFHHuCpKbhG+LktDoSFiynEKV2VAyY/gB9leUKbNK7qYskh3s1DrybQl
	TCWLxNBj7Fx46QDpFJIMtAfN1lgXZbnpJPwwKog3u0gj3VqMpLbF1oCnUq4nM3v+vY7m4unMnpC
	E6oQ8Jh3eb6IZIVRk62mTmY+PZm4JeSIv0rjQb6obc22xzX7GRnAcmYRelYZDUy4+Ie+zeMF/9d
	ar6JCP0/29JgwqmBySOAsxjd50GgcDdmuUbbGnUFi0jcBTWS+6S3x8Vs9Ej4GF7fpYzhon1DULy
	rPB5KmjHX9D/318K//HewaEeGa/bkGxm6lA+EdG36MCg6PJAq2boxcUpneQlHUiE3IdzoXhQXhO
	iXXTkmidHYYSJ45UotuB+ZDxN+2P4Gwgpm26E0o2RQTLsnJirRYi5CB7q5TS34dj7WdBTzwqjLc
	gn9DL4GIyehFbVfZPHVR2J9GY+TdGYPSPFWvZL6OA9LthIP7mIugrpK+WcDkh1QhKkQeXdo9hPr
	Mkq
X-Google-Smtp-Source: AGHT+IFbMuCYRQqFyYc3iW2AQwZ3ygkAVP5hORsbEHKVe3DoFNpU5VkF5QR76ZXtOw48GVJBALlpkg==
X-Received: by 2002:a05:600c:3556:b0:477:9fd6:7a53 with SMTP id 5b1f17b1804b1-47d84b04e1amr11902665e9.2.1767779501536;
        Wed, 07 Jan 2026 01:51:41 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm88569435e9.13.2026.01.07.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:51:41 -0800 (PST)
Date: Wed, 7 Jan 2026 10:51:37 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107105137.4cf9a67e@mordecai>
In-Reply-To: <20260107085009.58fcffd4@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 08:50:09 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> On Tue, 6 Jan 2026 17:04:05 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue,  6 Jan 2026 10:10:39 +0100
> > Petr Tesarik <ptesarik@suse.com> wrote:
> >   
> > > Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
> > > run on any CPU, let's pick a housekeeping CPU to do the job.
> > > 
> > > This change reduces additional noise when tracing isolated CPUs. For
> > > example, the following ipi_send_cpu stack trace was captured with
> > > nohz_full=2 on the isolated CPU:
> > > 
> > >           <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
> > >           <idle>-0       [002] d.h4.  1255.379329: <stack trace>    
> > >  => trace_event_raw_event_ipi_send_cpu
> > >  => __irq_work_queue_local
> > >  => irq_work_queue
> > >  => ring_buffer_unlock_commit
> > >  => trace_buffer_unlock_commit_regs
> > >  => trace_event_buffer_commit
> > >  => trace_event_raw_event_x86_irq_vector
> > >  => __sysvec_apic_timer_interrupt
> > >  => sysvec_apic_timer_interrupt
> > >  => asm_sysvec_apic_timer_interrupt
> > >  => pv_native_safe_halt
> > >  => default_idle
> > >  => default_idle_call
> > >  => do_idle
> > >  => cpu_startup_entry
> > >  => start_secondary
> > >  => common_startup_64      
> > 
> > I take it that even with this patch you would still get the above events.
> > The only difference would be the "cpu=" in the event info will not be the
> > same as the CPU it executed on, right?  
> 
> Yes, this is trace of a similar event after applying the patch:
> 
>           <idle>-0       [002] d.h4.   313.334367: ipi_send_cpu: cpu=1 callsite=irq_work_queue_on+0x55/0x90 callback=generic_smp_call_function_single_interrupt+0x0/0x20
>           <idle>-0       [002] d.h4.   313.334390: <stack trace>
>  => trace_event_raw_event_ipi_send_cpu
>  => __smp_call_single_queue
>  => irq_work_queue_on
>  => ring_buffer_unlock_commit
>  => trace_buffer_unlock_commit_regs
>  => trace_event_buffer_commit
>  => trace_event_raw_event_x86_irq_vector
>  => __sysvec_apic_timer_interrupt
>  => sysvec_apic_timer_interrupt
>  => asm_sysvec_apic_timer_interrupt
>  => pv_native_safe_halt
>  => default_idle
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => common_startup_64  
> 
> The callback function in the trace event is different. That's because
> send_call_function_single_ipi() always uses this value. Maybe it can be
> improved, and I can look into it, but that's clearly a very separate
> issue.

Erm. It's actually good I had a look. :-(

A helpful comment in irq_work_queue_on() explains that "arch remote IPI
send/receive backend aren't NMI safe". That's something I wasn't aware
of, and I'm afraid it's the end of story. The comment is followed by a
WARN_ON_ONCE(in_nmi()), and I can easily trigger it with "perf top"
while nmi:nmi_handler is traced.

Please, remove the patch again. I'm sorry.

Petr T
