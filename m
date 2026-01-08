Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2F34847E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861582; cv=none; b=XDPq103dnzEHDLc9fjecUduCceSa6n78+lLBi4QtfKQqYZvHDwUf0H95TixQQGhwDYAAqujHhuaDcThLHyPGqRSr4I1hkZlodYBvU3VWWBQD5tQmFhmF7sIpOSBaoy3DZ+dpzaHWLrw/1kAWEMzB56O5q4NuVliEbwWq6mbS4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861582; c=relaxed/simple;
	bh=KBSq5ozp9nWK7xE1oaTKEnG55tvkaczknOCnKuHL4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSkPnLHD6N2Ae0wKijMutyLYhp2MS1uIOd90BhsI1oowuoKH3mUGZBdyJeu+ZV4DcUtogqfX53WnwQwsYIX4Fkjd5UHCiYU1r5ZHvwyhtmf74+P9Npl+nR597gQFgx6udjTAE4CdMF6YgcEdq/jjYyf8jOvHs9jiVTqs5Dv0P1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QLyOhSyT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QLyOhSyT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb8aa0c3eso210170f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 00:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767861575; x=1768466375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vUisi3Mqmn3VVAgeiq/GIYmN1ZatSlGnG9ei2N00E=;
        b=QLyOhSyT24mR2/QzuAdbUodu/les2P483pjlQ5n5yVmXv5SsjX+vubuafITUKtCmj3
         tqkhi8BlZRtxhpRjbDfbciJaUtheKJyK/0OjFOhh1RvDz2o58nq8O1uFhizXeB2YgtSl
         byWkBkMtbPN6/i9SgzO177RAw63cXm4xijv6N70USAcDMk6vnvbbT5IU6ezjf+ND2j13
         WCA29Gv/j0/Efgez5FqbIfZiEAlTY4WXvb4d/frUAd75qiV/o06wtIEbyZmHl4OUPnmf
         XFbZBmkbCk3PTmY8E0vDie9vvD3NLaQxP+BScnru/Y9JzMENmxAPzmfTvT9TTbMLvyfn
         OswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861575; x=1768466375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/vUisi3Mqmn3VVAgeiq/GIYmN1ZatSlGnG9ei2N00E=;
        b=G+A56L8rreSxS00Mv2z97npGx2tY6flyYn7GpJhiw9butBQfvpcOgHy1m6mGr+ncSq
         XrlPzH9Rt4ympI/aKKOEQ6GgWbAlZIeIITboRwBvCfBTMQK0PaFkVugr2M3OEhOb25DG
         AjeZNfN6882oW8RZOMi3RDYQSNjC8J1HTdgcp5AGDtjhC8NxoygqySNXbSB0lkttjW8V
         QQ+8NtlRPH6fqNI1WUM/UXWjgRf5TgQTzrNLx0WTVhH7OatfY/LI7HI48icv83cu420L
         TEE8gMNx4wm2+QZT2urzv2FWhWTAqMhYIdlpy47jP+jGUj6l02MWRowzSeRCl6TFgbnV
         KgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXF+aJ5tg2XDYgzIYh/dg8K1TRoyUYNwhjXztG4fdDjFdMcy4MrbafRzuzOUPkbIpgLkPXuejREjkQ+afyVZFQTTTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyoXD2po1WKC/kDqXX8efaZyavK/h4R0aQdZ7BHVNDEcbRlJ0
	CI/lcd7tSjFtOFsYvLTaWfspKu5E/jq0GqsuqDkDxBzc2R8Tc5WGnqqtkhQePwNk6OI=
X-Gm-Gg: AY/fxX50uXpsDFDj9BDeJpBYbPgUQYMLnX4KKhlSFxLYGeGNNarZd95p2FAf57r2oeq
	ojM+rbf9BaBeWrKaLRgwgNGXkKaTqodZn2NX3VVStjPvuG9N30sQqKbGe8mI6ZFccUnyTzV7HO1
	FbT3dstHtQ1IwSano2rdd6eUDx+bqcy1ieIPUKB38ktp2iKzcIaewCW2FJTYcqViiyFDvsvcgaW
	524gXAkW8wtN/LcnArMlJHB3fbSJ5Se+ZPODiSstWSRxwNJomPmYe+LKLbBrDN3GnStO8DCFKML
	I/2IOb/dQHJK0X6txL911itLxQkxNLBVQozNgeB3BzSHo73wJfVwSYX/j/P0ov6GG6guaAdO+VE
	D7joTt9dVUqWXAoNLqrEwMLzFAAYBbCt6aG5LcuUVEHuHc5YVSnURHifmGzgZ1JRo1LEUNc08Qs
	MJddu8Y+fp2jOauvJtzzAhCrqhOELfqLroUfl0+2UhZmgAK9v/2j5ZsLdPtCrgFVzxi54VAIigb
	sMk
X-Google-Smtp-Source: AGHT+IE+AxG15zz8e6XqsM+Ihev+zYB7TD2+tvKX+z3mSuMcV9zIClsWCLuPxib3hoIzZay0GziECg==
X-Received: by 2002:a05:6000:2c0c:b0:431:66a:cbcb with SMTP id ffacd0b85a97d-432c37c1eddmr3835457f8f.7.1767861574850;
        Thu, 08 Jan 2026 00:39:34 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm15596057f8f.38.2026.01.08.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:39:34 -0800 (PST)
Date: Thu, 8 Jan 2026 09:39:32 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260108093932.252f6bc7@mordecai>
In-Reply-To: <20260107111935.3befc296@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:19:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 7 Jan 2026 11:17:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Or we simply change it to:
> > 
> > static inline void  
> 
> Actually, the above should be noinline, as it's in a slower path, and
> should not be adding logic into the cache of the fast path.

However, to be honest, I'm surprized this is considered slow path. My
use case is to record a few selected trace events with "trace-cmd
record", which spends most time polling trace_pipe_raw. Consequently,
there is almost always a pending waiter that requires a wakeup.

In short, irq_work_queue() is the hot path for me.

OTOH I don't mind making it noinline, because on recent Intel and AMD
systems, a function call (noinline) is often cheaper than an increase
in L1 cache footprint (caused by inlining). But I'm confused. I have
always thought most people use tracing same way as I do.

> > rb_irq_work_queue(struct rb_irq_work *irq_work)
> > {
> > 	int cpu;
> > 
> > 	/* irq_work_queue_on() is not allowed in NMI context */
> > 	if (in_nmi()) {
> > 		irq_work_queue(&irq_work->work, cpu);
> > 		return;
> > 	}

Thanks for the idea. There are some downsides. IIUC there is no
fundamental reason IPIs to other CPUs cannot be sent from NMI context.
It's just a limitation of the current Linux kernel code. As such, it
may be lifted in the future, and at that point nobody will remember to
remove this condition.

My current plan is it to keep the patch on hold and have a look why IPI
backends are not NMI-safe. In fact, I'm not even 100% sure the comment
is correct. The issue may have fixed itself e.g. by removing the last
affected architecture. ;-)

Petr T
