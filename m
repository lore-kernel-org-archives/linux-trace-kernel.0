Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A827280A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772219; cv=none; b=Ig+oT1/Pv5b1couCyCBu99Fuh0R0XcgTE88QG0IFjpIWdo27wYTFugx4Cy8dBHuziIbk34fvNvjjdZx2Om1Epg107jnU0s1Hh/IC5zvJc6bC/TdPv+Qcq8rZJuDYjtAdKbvxH0HaVALMFF9bChQv72gC3jwnvPmOzzvkNnsRWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772219; c=relaxed/simple;
	bh=7tiwIhJYnE3dx5jyQCWjPRVoHabKi0Yd5MocQaeuTG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw31qxzm8WCRHaQJSVE+MXbLXBzCrIS8p3khtT7VxdxXVNBHWpPmXOxDJsIN6RzeWkeq/dwckYG847ADvVvsmdjWX7MbFsx3gPJA5So+EJlkZxX83Z/cw8fvrouegHi8suWAi7aKKLZvh/nbMGyqarU3Xy4nFs+R5vDHODWMew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M9XIRsP9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M9XIRsP9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477985aea2bso2327115e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767772213; x=1768377013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTwsEdCvk1LcWq9yzHvV8qXzDbqu/xI5jjC5aep5ibc=;
        b=M9XIRsP9CxqYQjbzMmkD1ybnVN659/ZkpGzTGwtHJbRlEeLiP6wOz72fc21VpJJeOo
         J+GdvrN8+TqFcIrka+w1tHoHuCUZ9I51N4wgJ0HZxJcqOC2U/Iu6oEZVmq52y2P5Y0r3
         +gz/4s3mQI+7XDU1u1AhAzJQ87mrA+hsEAB/lySIWKYfoGGjT7RVoC+g4l6zcGtk2ya9
         EajK630nCIDhfhFaOLe7pxNb3DM7OvLrx7+7ghr12g0gaUBXrQOZOgtZHT3NTpyrngr1
         ooukkOoH/DcQE2Xi5iwEf7nbzbCq8PRycx0ctGbOX7+Df1m08E6cU5YNP5LWUH6Sb79M
         PZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767772213; x=1768377013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTwsEdCvk1LcWq9yzHvV8qXzDbqu/xI5jjC5aep5ibc=;
        b=XKgvcldfgwI79fzFSrT1S1FjkHNriSg5G7KpO7+lrlIdBlLfCi7pKD0Pmh4DoPO8Iq
         30d4s8KWTVHnvl/RVP9hSySqu0MflWapz0Pxc6dZZaTIAeDz5ffPZJV2nTL/pE/fx9a4
         4zzfHt+G3GuoyYV+Z6chwMNsmyUt7M7z5PwZHYPbOhUrSL/BcePJloX3kUJTi47HlN+0
         OOFjCzu0INgP75yUKPnThBLDr8pY9n3syDAH7dofbZ3P59L4p2eQznKl+dW1BmzaSTDx
         q28i8q5uPSpSWzbQVxGgWFMJTmwOqdwSulI6YeA9+EouG8SqtR74xZ61BeL6yZsi/5BV
         oQXw==
X-Forwarded-Encrypted: i=1; AJvYcCXGdO99acn9VmH6bG1VIndNv8m7KFatlY6z4p3Of/m5/uZgxmTcaQd2f7W9PKAbxxjMYyfF4xqHrN/3fmYA592zjxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfbxiqVVhkmQEt4s334lA1XrgSFB91BVbPS2eL5djDwVYYvKb
	FQI6B6LLbt71+UPygb0w1PP/bcr5/P3bhH6+ga2AgVfuSB+86HqELtSisPBjnGcenHY=
X-Gm-Gg: AY/fxX7yZrHQ5olEV/mWG+Jkx5x3JRgyZxaOARK6mWJEBACbt2prVVojp8hej1AqYr5
	3sS/dZiXZP9TQUj0+KLhn0/mDch+7/HviTowuaPnhF9fCjzhSvoQ/xVSHAEMjNKt+8XxTYD4bm8
	TzFfD+m2jwPztEHRoDlYt5Eu4Wsr0f3DYmHGSIhbTxsy/Nu1ki7eJevEQquvtdJClaq7IcTKdBg
	IIy0BNY194Nn+c7g6Nl0vRqm5q0fTfSRNF1ve7G/HiqKDhWyt67XWM6GSnBKzjOvhMxNQl2KDYc
	kqq6wEkoxUZkDeFIkRYhGnKY5TS4lAtm5ZDW2cL7a/dMivhUQlujl0fhqlCt9hO7G+bRpuCT2mN
	/rgOKrNbElYze+V8dbE64Evb6iONcArhc+a/ZrOYDz72PjlmooHR1kzyICSJnCGkUWQGhxsnfho
	YDKHve1JA47q6/Pm/VsiAPjF84FtaBnRNaOS46GIVKxGNl3q028qHMgA1fr/kWdcWC0uO5u255p
	rYj
X-Google-Smtp-Source: AGHT+IEeSL9a0sO/p+itJvQV8zFNgZvIXQnOGqZK2SqTOEnng5pUuSMZXMvpl/vjk4ZvT6vQlklhNA==
X-Received: by 2002:a05:600c:310b:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-47d84b37d1bmr7849795e9.5.1767772212776;
        Tue, 06 Jan 2026 23:50:12 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm85554685e9.7.2026.01.06.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:50:12 -0800 (PST)
Date: Wed, 7 Jan 2026 08:50:09 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107085009.58fcffd4@mordecai>
In-Reply-To: <20260106170405.425f469e@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 17:04:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  6 Jan 2026 10:10:39 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
> > run on any CPU, let's pick a housekeeping CPU to do the job.
> > 
> > This change reduces additional noise when tracing isolated CPUs. For
> > example, the following ipi_send_cpu stack trace was captured with
> > nohz_full=2 on the isolated CPU:
> > 
> >           <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
> >           <idle>-0       [002] d.h4.  1255.379329: <stack trace>  
> >  => trace_event_raw_event_ipi_send_cpu
> >  => __irq_work_queue_local
> >  => irq_work_queue
> >  => ring_buffer_unlock_commit
> >  => trace_buffer_unlock_commit_regs
> >  => trace_event_buffer_commit
> >  => trace_event_raw_event_x86_irq_vector
> >  => __sysvec_apic_timer_interrupt
> >  => sysvec_apic_timer_interrupt
> >  => asm_sysvec_apic_timer_interrupt
> >  => pv_native_safe_halt
> >  => default_idle
> >  => default_idle_call
> >  => do_idle
> >  => cpu_startup_entry
> >  => start_secondary
> >  => common_startup_64    
> 
> I take it that even with this patch you would still get the above events.
> The only difference would be the "cpu=" in the event info will not be the
> same as the CPU it executed on, right?

Yes, this is trace of a similar event after applying the patch:

          <idle>-0       [002] d.h4.   313.334367: ipi_send_cpu: cpu=1 callsite=irq_work_queue_on+0x55/0x90 callback=generic_smp_call_function_single_interrupt+0x0/0x20
          <idle>-0       [002] d.h4.   313.334390: <stack trace>
 => trace_event_raw_event_ipi_send_cpu
 => __smp_call_single_queue
 => irq_work_queue_on
 => ring_buffer_unlock_commit
 => trace_buffer_unlock_commit_regs
 => trace_event_buffer_commit
 => trace_event_raw_event_x86_irq_vector
 => __sysvec_apic_timer_interrupt
 => sysvec_apic_timer_interrupt
 => asm_sysvec_apic_timer_interrupt
 => pv_native_safe_halt
 => default_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

The callback function in the trace event is different. That's because
send_call_function_single_ipi() always uses this value. Maybe it can be
improved, and I can look into it, but that's clearly a very separate
issue.

> > The IRQ work interrupt alone adds considerable noise, but the impact can
> > get even worse with PREEMPT_RT, because the IRQ work interrupt is then
> > handled by a separate kernel thread. This requires a task switch and makes
> > tracing useless for analyzing latency on an isolated CPU.
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>  
> 
> LGTM,
> 
> I'll queue it up for the next merge window.

Thank you!

Petr T
