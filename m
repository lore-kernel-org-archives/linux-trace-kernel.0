Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0D3EC54B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882766; cv=none; b=BMtIaD1zIx9Sxm+7SwQvqPxP3OIh1srHl6b9EO89jk+oYtFrueurzSOTM68MImmyisn3v8lzjQ6OJxFIcq/Hc7lhA+EtO9VXjdsgM6z9oWpavpYrJoW7Euv3ex/3jCLoGfiqkx0eqXImL3TaM7QVr2UUTPbi2jdzTtmztC35LXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882766; c=relaxed/simple;
	bh=dHjIgFqdeoPzZ5z+03xbnogVyQwTr9wuLKUwgnPwV5g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4RtWaheYG87A6j5xGbU5XaMZ0tcmGekj9HF0/yxzFa9o/eCnQmiVOMA5TJytFnYUFvjEvAehjy4bv4sEq0KfDr2SrLj2+yZTHMN08OfKyjgV+Y2/GzcjfVwj3Wf+JfcrJvAZyPAJcYnaxDAvOE80/mtCYVUyIEvH+5/RV1qcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ESvgyB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ESvgyB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so30585785e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882763; x=1768487563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKsZk5STRUk0X4Pv4cc5SZyi6XswPBivoY5uNi8SKAU=;
        b=e3ESvgyBt9gQC42atr/ki2jdc8asvgjXgWS7NTslxdIZMC+NBmxPxSwI3k0RKU5SO9
         /UyneP+AJEY7kAZPrr8Cin3d6ob9M20cbqWCCf1NvimjKDyUV/KuPVJ+89IxyKLVFjED
         ejkMuPr1PprNWktCdPuA35EKU7tRdtm2G+oXEko3C+ynagQTCJ7kkBkt0yPQHNxhl55l
         t5zikgTxhmK1Ey+/km+FWTHUMPKAB6G3emEa/YSlV1Mc8c1+h4DJ0w/w1Mqj7Jr/OoRJ
         gZOciTuVfrCV2gZkV6RK3bYcVRvYsxfoGwLTDqy6YGD288vtNUi6uH7pRR/DyEWBZSp8
         B0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882763; x=1768487563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKsZk5STRUk0X4Pv4cc5SZyi6XswPBivoY5uNi8SKAU=;
        b=M2Z2kjFVwWKX6CJSRETi+/Kl9KHoR74Q3sEyIA+rzkoUJUGdFNPVcg7Tqm6tq1aPf9
         5z2yz6jplXqpVZ8zXXNHjbgDOnMBKc4ZVWsG3DUkfyR7w12fdlq9oBDmd4qNTdf9W6r+
         fTkoPFxWo5/IcCbnO2YKDNMD2iJI2avlPbxznmhIcLzRbOfgMrgNFmc0tyUF6PKC+to6
         /eswBYPDexHesIDML+9mRAz8qUpVQA4Ol3YlXXE75L4kgdKj9yCivcPf2Bl+NllQ01Wv
         NSPlpj+/DLoiT9liU/xyS65PISNOen9yhnrHnQ5fMNlGNOqMUsCMjSEw0vtZum7qf8CA
         Xo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCUzj4PQZ81UTnkyIS/PoS6WRKd1POk8nF7m7mvwgPNs5pe/VoisNFcHditEZix7lfUdEzFnpFECdTuGBO374PQTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZglGuvixdIhzKxnTEMxRiDoR5fPCbRPFJWqKLNdPRfGxBWEEb
	y/lad/+vBGudbTWdKPSdJrX6kAlGrAAi2+TJFIInmPv7gT59Ta7P7sKx
X-Gm-Gg: AY/fxX4I/d/gHxYrpp+bFVrsUF/3sKDB4Uln6n15B53QWPute4fxRkOEZaAfEtZJEdp
	CQvCDzW1K8st7fkvc49T+QpQ0O3WoUHHLUhzTXJroxmTvusetHYz3FY95n3VZzWSXasqdXT+Io8
	4LXDPA83d9e5bAJF3I5rAXMZD2Xmc7D5Vh9pv8RFWhcuyNYc8dcA9QE5pcJ9C7yPlskz/g2miQz
	kci69puzSHPTBv7CG7hxR2fuhSqaGbCmZ3TXMbS4+qjn8DpKg31ntH/IY3CvrI+HzvwJamnAwjE
	ghTzdinFW6KG80IEcOHi9uIIr/7dvS3j8Ovpxo9A5SCCHuCKp3adjbPs1XShBLud1FYJLA+xwj0
	U521FCi3Yf2vYj44LCdS1BIGcZQqGxlcpPLXIIvrjGiDJCHOcbZYwY3ADv+egbQ1MdwxTk+Hhcg
	A=
X-Google-Smtp-Source: AGHT+IGnDsY3fisUw/PeO5pgI1mNCLBNotubRxiPg3jCybSey6S3sceqOXla0zwMBu7+42vl1Y5nvA==
X-Received: by 2002:a05:600c:4ed1:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-47d84b54031mr77169965e9.33.1767882763275;
        Thu, 08 Jan 2026 06:32:43 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm159970735e9.7.2026.01.08.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:32:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Jan 2026 15:32:40 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV_ACGtNHRfheAme@krava>
References: <20260107093256.54616-1-jolsa@kernel.org>
 <20260107110352.3fd7ddda@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107110352.3fd7ddda@gandalf.local.home>

On Wed, Jan 07, 2026 at 11:03:52AM -0500, Steven Rostedt wrote:
> On Wed,  7 Jan 2026 10:32:55 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 1621c84f44b3..177c7bbf3b84 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  	return regs;
> >  }
> >  
> 
> See my reply in the other email thread:
> 
>   https://lore.kernel.org/all/20260107105316.2b70a308@gandalf.local.home/

ah ok, thanks

jirka

> 
> -- Steve
> 
> 
> > +/*
> > + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> > + * @fregs: The ftrace_regs to update from @regs
> > + * @regs: The partial regs from ftrace_partial_regs() that was updated
> > + *
> > + * Some architectures have the partial regs living in the ftrace_regs
> > + * structure, whereas other architectures need to make a different copy
> > + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> > + * if the code using @regs updates a field (like the instruction pointer or
> > + * stack pointer) it may need to propagate that change to the original @fregs
> > + * it retrieved the partial @regs from. Use this function to guarantee that
> > + * update happens.
> > + */
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > +
> > +	if (afregs->pc != regs->pc) {
> > +		afregs->pc = regs->pc;
> > +		afregs->regs[0] = regs->regs[0];
> > +	}
> > +}
