Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940932BE7AC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869184; cv=none; b=R6AbtKxFsGcpGc1FpvEtRUtdEqc8X5Zbj7n4lnCbDP0Gf1M+XglqhABTVeRFBICKpI4hGUklD88H1H9gSqYP0OJCiueeEBe3F5WN1aHw6NfiETEwo8YPRkd8camj1AuusepwpLt7lYWozZtiOlLPbVNQmnerS0L3RI2rkpE4b+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869184; c=relaxed/simple;
	bh=8DMIYjsADq5oGXB/idiFns1XxpaSaoX5Tvu7oL8sKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDZXjv1F+DXS6Cn6x4MhoJFEve6/2Ll4zIIVNN5uKUCztoXbqwvRIgoUch1ReFVEHzrUnxvWTSabcsuKtoN7OE9I5MFilOBGhhDUnmL+sbrYAY/Qyg5TI5SVyTPIRm+jxDHw3SMa9D5/w1ATE/RarOfbOtxH/lwy+ts52l0H0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MndPWu5T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MndPWu5T"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47797676c62so4116485e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767869178; x=1768473978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib649LYcFubip2cWtXdZTA/LYveMY5mkmekbtPClLBw=;
        b=MndPWu5Tg8v1AnQuFke03obzDHj1T/fA8Ms9Kp/bSOpbQLzPlHB43X36ctRqHuvFvJ
         W6VVri/d6obEuLhkIitK4OiPLilRsXfc2jKYWX1mQDYOi9d09qwivtLvQcuwqLykF560
         zywjAQjqZrAb0bJJ2PYCZIPzoznxIivXR/QFMDQ7R94UqL05+CGDwv5ZC0w+76DR1AL7
         aTp5UY52aRQIe+42yaZbYZeVBS/2nAmCHNZ3ZecoEMM13QM1kvpuWvbfW1B8ra0G+ejU
         2dJECQXBhG5VIjd1k2Bcu3bRVgZnoe+vx0Gr5UyRFPlL/xEhnuQ3B/n+4nKxl67pOMiZ
         d4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767869178; x=1768473978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ib649LYcFubip2cWtXdZTA/LYveMY5mkmekbtPClLBw=;
        b=nAxQgH+1FOXspkDyKKsoHuFZcwdsonIyCAs/RvFezO+8AEg5DRF+ia2Dk+jkDD4FW6
         P5ul3tgjE4MSAn0x3MWX4Ap1VNeBk6vPTbTuRhPr0NGxRC90Dzrmg3LHzMJGJPSltDqo
         9XjcnJOrBuUSJgWmlb6qAan7tu3+9sDNPW+WVfzSamPfmiz1xiNddTnQ3TMkEEsy16qW
         nsLSsc/On+f/OqRNfVVcEdgDLJjdhuG81QqhYlX2HN/ysp7Ee4lKKaJ9f7zU0r9NoM3j
         IxuJDvFtEDMkgWXMcjNUj/mjDkkP7CLUjUONQO+V7P4djzEoOn9Tx0A5flwsyyDCTaQ/
         fUsw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Z/pBcm+9En3vbaEgonouan0sjvuXTfSaNXVMog+9h3A4BeH5J2A/r5fhk8thD2jol8lmWW4mPZVFUwfdSPicTSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfy0TwvjjX9n0wL3fG8LXODeKxQLouxjrfwnubYig3OELgzG+u
	rp8tOc1Cg1gUvqB8MpeOipncDMU5V9VtqdyugiM0G1YZC3fB+IRZWYDiwzvSA3aaPEg=
X-Gm-Gg: AY/fxX7nd4F69MEMf4if0ueu22BRlZ8DTamALRm9hMLiNxBSWaIoeeRvUhG34lafqju
	1TiOtycTCKTVeqaR/7Ng31KKW1yaFiu4U6R0Eui15PtjihumH4jMXDg98Hq3gZ27AfbhCV8l95y
	Tsvsc7BUa6dwWoUqT1oq8HYp9H3ZbGMN4TxT8xgjvrCTSy9wGAYdrI3UToKomG+fPii8n9YxuZB
	z6WuR40SR+1IBdmw0QX0z1pk3VfE1e6JJ9ULRBF1zci8XF+1MgsTJqnn6BWMHoMJjKyOWFYfzX3
	AuTq5vemeqY1I/IVZuV32sZe9U4QtSjtufgrlE78Vk2ISkNXeKnBmlcQtKG5rRj1WP7KEdm0bcV
	S+I2Dc2AUzKnEHjV1VjJtGMR33lVjcPh+hErSvfxvsJ4MZ2pldmwogJQpm5AbyZTomgns0TbTtt
	/QMmM4tODrI2SJPSJqaGcsSDMmuUlg5pAUBBi522FDii5SMoWxHv6o2P7MJEY+GPNeCvcxA+GuE
	EYo
X-Google-Smtp-Source: AGHT+IFJqp1SOAxk3q3pW4y2QgpTbPyTlEjg0+NaiBYrsrzs+VyELuO27rZMwFwlcACfdvU9pFjKyQ==
X-Received: by 2002:a05:600c:34c5:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-47d84b30104mr42672595e9.4.1767869178019;
        Thu, 08 Jan 2026 02:46:18 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86637b90sm38000875e9.2.2026.01.08.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:46:17 -0800 (PST)
Date: Thu, 8 Jan 2026 11:46:15 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260108114615.02cd0c7c@mordecai>
In-Reply-To: <20260108093932.252f6bc7@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 09:39:32 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> On Wed, 7 Jan 2026 11:19:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 7 Jan 2026 11:17:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > Or we simply change it to:
> > > 
> > > static inline void    
> > 
> > Actually, the above should be noinline, as it's in a slower path, and
> > should not be adding logic into the cache of the fast path.  
> 
> However, to be honest, I'm surprized this is considered slow path. My
> use case is to record a few selected trace events with "trace-cmd
> record", which spends most time polling trace_pipe_raw. Consequently,
> there is almost always a pending waiter that requires a wakeup.
> 
> In short, irq_work_queue() is the hot path for me.
> 
> OTOH I don't mind making it noinline, because on recent Intel and AMD
> systems, a function call (noinline) is often cheaper than an increase
> in L1 cache footprint (caused by inlining). But I'm confused. I have
> always thought most people use tracing same way as I do.
> 
> > > rb_irq_work_queue(struct rb_irq_work *irq_work)
> > > {
> > > 	int cpu;
> > > 
> > > 	/* irq_work_queue_on() is not allowed in NMI context */
> > > 	if (in_nmi()) {
> > > 		irq_work_queue(&irq_work->work, cpu);
> > > 		return;
> > > 	}  
> 
> Thanks for the idea. There are some downsides. IIUC there is no
> fundamental reason IPIs to other CPUs cannot be sent from NMI context.
> It's just a limitation of the current Linux kernel code. As such, it
> may be lifted in the future, and at that point nobody will remember to
> remove this condition.
> 
> My current plan is it to keep the patch on hold and have a look why IPI
> backends are not NMI-safe. In fact, I'm not even 100% sure the comment
> is correct. The issue may have fixed itself e.g. by removing the last
> affected architecture. ;-)

This turned to be an interesting digression. Since we still support
old xAPIC (not x2APIC) systems, there is a reason in hardware. The xAPIC
ICR is programmed by writing to two 32-bit registers. If an NMI occurs
between those two writes, we'd have to restore the upper 32 bits of
ICR. Alternatively, we could queue the request if ICR write is in
progress and flush the queue after finishing the write to the ICR (out
of NMI context). The code could even be arch-independent...

However, it's not worth the effort just for this one corner case.
Besides, it seems that other people have always been aware that
irq_work_queue_on() is NMI-unsafe, so in case the future brings a
better reason to make it NMI-safe, there's a fair chance that all
the extra code in rb_irq_work_queue() gets reviewed.

Petr T
