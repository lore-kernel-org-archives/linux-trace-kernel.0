Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D03D6498
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254445; cv=none; b=b75US9k7m5VxIwpb3C9G4PFvVMyINsNPYfmpBhXQ2Dp06UDudvVj8nGdp7Ej7s1KuVMyvowWtAsH+9XTrY8f3bTpfEJVHH6GqnMRGXYANgoEnLG8wtMjw/aO1mL/tlgNnRWYHf58lZjDhlpYt0KJ6nUdrv1rf4Ol3XWWWJz+G+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254445; c=relaxed/simple;
	bh=60BGbmO6JnqJy1zcM4WcjNIxuBp/1/MBR0f5PNBn/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+BtVppWQGFGHNPf7rKZVoPBaE66Wa6/J916UcjfvduJcxgM3MuCKpfEgiiVg+5U+HVorey72NcsfXsp2K7oHF68Qj82uOwnvZRCetCmSlQX94OjPkHHebUjNxVyqggLl0f9qsN49A8SBuERoSZo4rdpjvXJiVevjKJ7/4s7fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CW5BW7SE; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CW5BW7SE"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so1344387f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790254442; x=1790859242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q/0D8UdTsfWb5fXahtezHfnKDdqvE6b7jnEG+b5uols=;
        b=CW5BW7SEha63xhFMF/23UnWdMxbXG1upb11XZo2BYWdIZdLRsa2LeTpz3QKqSM9lj+
         2/K130KuzLPU+3V5asA87o4kd4PPvI/btqr+cW3lVqcYPkZkaBVC2N8J4mtB7xVjzbhy
         ooZbPSB8tdZhGqEukPvGIWFu0LOGetJXyWlUzYM6NjkkhpcCUzQxbaieg+HOrjkv1n6Y
         US9NRpCdRT6XwwBo9yLMZoDFljctgP9uSaUBDlPwr4ujLOHywFnHPLlOfObTvW7ti4sq
         HbhNix071Ifq6qGbzhS3idFLlAZgzsgeu3jpp/7i1MWqATdcLlfA1xFgdIv6guXMvjGH
         a9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254442; x=1790859242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q/0D8UdTsfWb5fXahtezHfnKDdqvE6b7jnEG+b5uols=;
        b=qnhFqY4uiCEscfbg24KLiNDMzt5LgaPua6AlKiLkLLH8KDVeyDzNQZp281brlRFeXw
         22DknZn+qm0luTAkeJ7kYfSV1ivJJq0JmBv7S0sVGTB13DHdqllEUQzFn7ndCzdxkYm8
         HNU3fyNH/9M+1eqbeLrprM7sKfcbIK47kiY1zaXghhrR1XALb/wOKWIfbui8sTiG++2h
         bibcrGK2CxvcGb0FNLpg7scHZkKMpeQ8YZm3iOHtYgXXnbHt0YitncyoQNDz0m8iEzhM
         cBBnf4IIaTN8Yt15kV8F4KGqwCiy4KmvxNb+dLo/lHpZ4uG//VwdjMGq9yWGIMP01Uje
         FUUA==
X-Gm-Message-State: AFuF++nFoPvTw2VwnP1q15BFveFzKzsRTeiWm4h30sH2sQ4ZOKAEYb5/
	f3J6lfvlNHR/qaAN8v1hURoN8Y8Jj2AvPeu5GtO1m4IuB3a5SPViu20/7RT3BasZtg==
X-Gm-Gg: AYBFou0bf17oF7kkkDaCYfC05X1nLKg80pAyFwrvjg5z0SXSbRB24P9nh1+6z1yal/w
	ifdoAvlZzb9bhQ+xYNOGxU7YGnB08jlW+4AbpeDWKObB8AgRp4KTvukdjq5U0Kkpvn/1CL39VyW
	UpmXpvvpHy8Ndy5F3HCMkpwv2Pr+nP2ba9oznFf3ufPdhkmgssjAPGTMmswEn9plD7NrobknlBV
	2FQCLhkr2RtJK1IB2ZiUEn8APfS6T3oFsFJUzO8GpEfDdrbQB0cOv6JTv6bv9HtrZ/2wCfVkv0q
	zBTwvCZiihO1gDKiEiZEcRFpiufL8lN72P6WG7ZynGosVDuRbi0EjDug2Nk/gZAB0W4PdWJadhC
	PzhZ/hR3RSxaiFjhPcoIVx3A/68k6jpStvu9yw2sDBC9vNmRuvhPr5d0RRJ/TIv9e9p0lMJQamC
	+1fNzKEYBgziS600jNyGIFJ8BOEav8GKB7+SqF89+fltkC59cLXHcTlon3rwPFqL/1sRSiEN2WE
	DbexaNc+FjOG02f1qXVwJTxDIyPcFUiIIZoNOp97aM=
X-Received: by 2002:a05:600c:3107:b0:49f:cbad:eef7 with SMTP id 5b1f17b1804b1-49fe66fd4ddmr41363975e9.33.1790254441788;
        Thu, 24 Sep 2026 05:54:01 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd77bsm79019935e9.8.2026.09.24.05.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:54:01 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:53:57 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/18] ring-buffer: Use panic-friendly locking in
 ring_buffer_iter interface
Message-ID: <arUdZfrYMlRVjYAD@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-11-vdonnefort@google.com>
 <20260817140454.231C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817140454.231C71F00A3A@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:04:53PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete panic-friendly locking leaves the system vulnerable to deadlocks during non-NMI panics.
> --
> 
> --- Patch [10]: [PATCH v6 10/18] ring-buffer: Use panic-friendly locking in ring_buffer_iter interface ---
> commit ecd8a71adf986114125493b0d7821b40d48b7d2e
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Use panic-friendly locking in ring_buffer_iter interface
> 
> This commit replaces raw_spin_lock_irqsave with rb_reader_lock in the
> ring_buffer_iter functions. This prepares the iterator interface for dumping
> the buffer on panic without deadlocking on the reader_lock.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index a7d9936b4c835..a6f2293f409b8 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> [ ... ]
> > @@ -6302,11 +6308,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
> >  	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
> >  	struct ring_buffer_event *event;
> >  	unsigned long flags;
> > +	bool dolock;
> >  
> >   again:
> > -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +	local_irq_save(flags);
> > +	dolock = rb_reader_lock(cpu_buffer);
> 
> [Severity: High]
> This is a pre-existing issue, but does rb_reader_lock() actually prevent
> deadlocks during non-NMI panics?
> 
> Looking at rb_reader_lock(), it only falls back to raw_spin_trylock() when
> in_nmi() is true:
> 
> static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
> {
> 	if (likely(!in_nmi())) {
> 		raw_spin_lock(&cpu_buffer->reader_lock);
> 		return true;
> 	}
> ...
> 
> If a standard oops or sysrq-c triggers a panic in a normal process or softirq
> context where in_nmi() is false, won't this unconditionally call
> raw_spin_lock()?
> 
> If smp_send_stop() halted another CPU that was currently holding the
> reader_lock, or if the panicking CPU interrupted a context holding the lock,
> this would spin forever and prevent kdump or panic_timeout from working.
> 
> Should rb_reader_lock() also check oops_in_progress to fully realize the
> panic-friendly locking behavior intended by this patch?

I do not see how this can happen. All rb_reader_lock users are also disabling
with either local_irq_save() or raw_spin_lock_irqsave().

This is also what ftrace_dump_one relies on.


> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=10
> 

-- 
Vincent
