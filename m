Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A522EB5B8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369131; cv=none; b=iH8tuMLMlIvMYu9+u2FQ6Ct4jrlsDxrCTjjpF2PUbXVHxj7CVn+94loGwhY1mlsHOiKADQ10gkKyA1FKtR0POcWxvdnVmrrLelkIIIVEyCbpPPIc+Zg3zRLnZXSpxKUqtm8p5L4dUVALSewisSJUFB9cyqV8fg9rv+NJsbKhK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369131; c=relaxed/simple;
	bh=73et1he1Ni5RWLoLIORHvnjazinxFZVeyqeO82Dy28k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok2Ei3hUFaZpg3UgOuQkEJe7puaT1U4if8W0I/haHuwJZmSgWQSjUVIrEqDtrqmzeEZYNdruUKl4yHTbnyPZZv0KQ3k3ERqs7/UmvkGslTvqtAjTbyJBFdlt8D5jt19P2E31oqhxu64F/LVJZPhQ0jc1qGvDXgpmcFwXiSwJXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klhFX/zv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klhFX/zv"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c20ce3c118aso1976466b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786369128; x=1786973928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C03w05phe+r5fWT7l+Wdmc8yWe7jkEKyfez6GNDcYcw=;
        b=klhFX/zvNZ8iNsp+Mieb8Sn4Qh8jg42un7bbuS/yAYtpSjQ0Hl6zyQ7tyeildSJXxs
         bUOmJnXZEfUPlMwfN73IkQrw3kipXwWk3EntvxXxvWqEgHtZoSBlYaMj81qYnps4giuP
         +hyN1iWqo8vyIvyTIp180epSGog4QNaaAp2/XcUCEYiQ0jae+MWcUEVuehEcZ4tfaRMJ
         L/iFJzlRkVEpNIs3AakR2D27eMPK9thX9v4Xb8+7eQ1eAaBcEwYue8oC3Zhjn7vxBwg3
         1VmPtCfJwCwEMW9uLOLkSQVZOc8yCjJkHTFKq3PBo+ycMB4u5LTK1S1N01rwv+sOir31
         1azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369128; x=1786973928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C03w05phe+r5fWT7l+Wdmc8yWe7jkEKyfez6GNDcYcw=;
        b=filU3OqLvAWMQRyweO3tbvITMJE+sPCyDuSY4sdKYcUJyjc8RcgRVmVwPC9S9J/7AJ
         qyoHcvIjLlGi+nf8Z8+bKBHJNigm4S1y6PszWj91DrF34cayOb4HN69dInJZMBCoB0rf
         fem6YoSpZ3zcKAjs06HIYWqu3QtnT4q9GjvW4+ZktnhJkpMEDFQTFwKHNjKkgFMxHiXE
         T4Rlfu9Ho6+dDOVdpuOCqwjuDsoBxQ/naHER6IAVVwd9I91+O9R3Yqmpg7zwBs6L8T0t
         KaLFj5IIFgZEy6gSXATIHYFk7uDGIybaI2m39R0SUYTwuV/XkBHDlBt60GMx/SigBbvx
         jDYA==
X-Forwarded-Encrypted: i=1; AHgh+RoUOOnzMPF/TL7nV6uKDrx4CFE3USyHg4TJMLkxtPdppEG9EPYzFWHcJce8aqRfu+Fw/x08uCABX37t+R9bj1/8EOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3iBDMNn70pBY3ShrNVw9C9Dr86k0g6z2j1gw4LtGvt18178j
	Rcphbql0cb6tOxmz7PUn9dmfb1pPfU6Vmd4Ec2TUCT4mSUZg4KQF1FesIiHR/53P4w==
X-Gm-Gg: AR+sD12ruiQGZoXmhkBzZyjFmdaSf9WbNXMq6vxijHSTeVefXzG5NnrKsGtDTRwxx08
	oydOB5HNdPEP3Apx3muNf9mtynQyJHXOfgH+cMjXX0VdpBsv7HpA+BXA3akHOJtR+0IrvqdIhMt
	RDq1uoluybmNy56yoTA0TlD58tS5CYfJjbYaWSj6BAezj4EKsPOxDHsEzuLXz5oYv/DMjjCJZ7X
	UbCcilvR6rEBF5wPkuUsCvQVK56C/FNBpKl6adR7MmzfyENLJaQSyzxKeejFr5bwPMnICJEReXP
	RAgUL0aHwNZYBZKPfBS1bgD7ny2z20+yGv0oX5TghbdNg+mBx+uC+GCeFZmP9grjn7x/yXYtmT8
	dV44xSIaIP0boRa+iZ0/9z25aH1wlKrAMepkwGIy4P4ovIagYZpb3DCT2SPQ0d/LdtI+QHsbc5D
	sg3jp8lpl+ZX5WUpu89JEZpWaXBSktcJRmti9/U0hQyREkFP93daphsGpj2ptxIC5pRuFGxd20T
	T1NselRpyFG5CZ2S62pZe4VpSkeTawdMwwQsO5xAcs=
X-Received: by 2002:a17:906:fe02:b0:c16:785:cfb6 with SMTP id a640c23a62f3a-c208d2df2bfmr835635366b.3.1786369127239;
        Mon, 10 Aug 2026 06:38:47 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90eb4sm385690066b.35.2026.08.10.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:38:45 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:38:41 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/6] ring-buffer: Fix subbuf resize concurrency
Message-ID: <annUYSQxg3Yo1nar@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-5-vdonnefort@google.com>
 <20260808145854.4ff68a39@robin>
 <anmDrhrSLQI3jAMI@google.com>
 <20260810092606.1742d25a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810092606.1742d25a@gandalf.local.home>

On Mon, Aug 10, 2026 at 09:26:06AM -0400, Steven Rostedt wrote:
> On Mon, 10 Aug 2026 08:54:22 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > This is probably the issue.
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index c2cbdb3ef727..a64cdc925078 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3534,7 +3534,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
> >  {
> >         unsigned long addr = (unsigned long)event;
> >  
> > -       addr &= rb_subbuf_size(cpu_buffer->buffer) - 1;
> > +       addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
> >  
> >         return addr - BUF_PAGE_HDR_SIZE;
> >  }
> > @@ -4123,7 +4123,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
> >         new_index = rb_event_index(cpu_buffer, event);
> >         old_index = new_index + rb_event_ts_length(event);
> >         addr = (unsigned long)event;
> > -       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
> > +       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
> >  
> >         bpage = READ_ONCE(cpu_buffer->tail_page);
> >  
> > @@ -5033,7 +5033,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
> >         struct buffer_page *bpage = cpu_buffer->commit_page;
> >         struct buffer_page *start;
> >  
> > -       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
> > +       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
> 
> What about just making those functions return unsigned long instead of
> having to add typecasts all over. It shouldn't hurt the places it's made an
> int? Although I'm not sure if bots will complain. :-/

I thought about that, but it is used to assign to 32-bits variables, such as
ring_buffer_cpu_meta::subbuf_size or in ring_buffer_subbuf_size_get().

so it felt the (unsigned long) cast wasn't that bad in the end.

Alternatively, I could make all the "size" (_size, _capacity _max_data_size)
related accessors "unsigned long" and do the same for the buffer_data_page and
buffer_page accessors?

And just WARN() if we set one of the meta data fields with more than U32_MAX?

> 
> >  
> >         /* Do the likely case first */
> >         if (likely(bpage->page == (void *)addr)) {
> > 
> > 
> > I will resend a V3 dropping the 3 first patches you have applied already.
> 
> Yeah, they are already in Linus's tree.
> 
> -- Steve

I have sent the v3:

https://lore.kernel.org/all/20260810125633.3344684-1-vdonnefort@google.com/

-- 
Vincent
