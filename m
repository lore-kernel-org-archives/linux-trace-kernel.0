Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAB36A35A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659673; cv=none; b=VbV82eNjJWq0W/gBEeWf5QjXj++f7AwmE5fcmUMKu6+EmQH1spmgtEIBzKR/+muLAskl96EqLQs/MawHFBRzsckN4hbcKtDHoSNSDSJSDQQf0YNRwPOlaEIm7wRm83ZVJBZYBLEz1QNm0LZEJoWBNwLz5KOkTufDr9JxIpp8sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659673; c=relaxed/simple;
	bh=3VERMq+xiLZ9WUMPX8js5tvfdxGKD0cIlLNFz0YzHbA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUZh4VZ5tkq4fPUnH22dLS136bXknSm8ZrP21hgAfXcrG2+UuXzgz77/fewiPgutrHxaCLwzytMjGAPs60vsYfpHmHtLED5HrubvlVbL8aGRjiEdoOKcTDPOj4TqZuojHQ10sKgU9To9MH2NYrSamNHTE11au3pmS+EaH8M8K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzjAsLfW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzjAsLfW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so35535835e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779659671; x=1780264471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I10QhtVmzV81xL+5R9qfUHIcQyyiwHM6k2SsnmlTNcg=;
        b=YzjAsLfWg0M9XiBiF5By4f147gf8F8+WJsiU26iQwXuusQD4Ulz5z0hz1wq/Xxa8ir
         tfJHxOYS2+t/nJ8apfGnD3Y3hPdaZ9zAYMJ2QY5dH4mM5h5hVcfAr8sgil5nXHuN6hte
         Wreu/1cCaTkVEJrBcbey0IE4g78KdWJ3wC5Vy2lNAsiqZvEZYgqnGE9mNwHtWpGCTwKK
         8OHE/iyWN1M5zJroxbVVG8eeE9HHIRU0PaMpEtmsniDGI0a27Bf1ag6FYzl/1JZ22uzi
         kla0ngDclrbR+TdLHw2kfDy5DVjYvOX6WdcmjRkNhJcRFtDI4N6CQZZZpfQWuNtDhv0d
         47rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779659671; x=1780264471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I10QhtVmzV81xL+5R9qfUHIcQyyiwHM6k2SsnmlTNcg=;
        b=Mk46lcQUJnCyB8dvIE0z9EFIxW1ciN7L5h1YYfdIEnWsu1AncMXE3KaRX94Ksnk6sL
         WvVtagEnZV40yzhCILxwaZMD1y3mjKlopBgGkyNCwIU1Y1Jahp3KWSJyVaZkBjaZKo2t
         j1yLPciLHUuTX4ZneIMpXgvbLbrEQJYQCYqTjlOLd1UZrZCjETonHH6RiV6htCowfwq6
         qw+tJGhk3pI5sVaBYimQp6i1FM10X4MGNBkwPTdIH+6BZ5ylFZ/xRIacAC97AOJOho+P
         xPXDSmR94wFBW0uE/CG19AVCW3fs1UwkYOPVol52gDRNt1GljdyKnE044PHBaRNPCFwl
         hQfg==
X-Forwarded-Encrypted: i=1; AFNElJ8oc9afL/u8fYPffTofz8CmdzP62qvRBT/43ZiA1ronEt8DUTe8lrsuO4J2DO1sTuGKcN3PdDqpwqYmZS2ocktPe+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKqbGqRqVqygl7pTqh89fRCaDLIPLL3i/JMEqti+vHiW5BnPf
	e7HsBmCLK8Buc6Ufj6iq0vltE+7HbDaOsyinS9TCUcThFmAbCtdRX73FB8dUA034
X-Gm-Gg: Acq92OGw37jG9dWyHPPhpXMqLcqvVVbTVVghS/ZYVhY16iWrINHlnfw0eO7HzPx9+bn
	dkWV723fYGthkbfZ1WUuC5X1H42tgR+dBOwQYz3+y7U8MkI5xqgkYUljgXAgSq7UaOe6XZT6jrp
	82cuYCe7q4qbNQIeJYOWXl0lceETOsnGBx4OS7zJop2mZbi9Z8ZeyNuMjK3Dd2CIHqbyEuOBy2A
	/+nM6COeb8sh/JFLkEclJeuJQZCYN2oCTK8Mb7fuENvULhSqRnQ1A1Eqyeq5ZYr3mm5QrTDA2PU
	liNuXId4bjqhlyHb5u3ksAqySNZmo7rCNgA40kVldXuv6dD3v1A8tXECOpBBWHGv/VJJmsUJEES
	GZ9YifIMFyIcKJ05XY3IX60B/+xVMgTxE5Y4NbUoNO9XCiRGvNJjLZlep63rGgqG43cZ3YLw3bZ
	7IW3VED/97Hd4=
X-Received: by 2002:a05:600c:4fd0:b0:490:3dc7:9778 with SMTP id 5b1f17b1804b1-490426d3f0dmr191593075e9.23.1779659670466;
        Sun, 24 May 2026 14:54:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm345299875e9.1.2026.05.24.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:54:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 24 May 2026 23:54:28 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 03/12] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <ahNzlAfUnymDDGOR@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-4-jolsa@kernel.org>
 <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>

On Fri, May 22, 2026 at 11:50:54AM -0700, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 5:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > When we do fork or clone without CLONE_VM the new process won't
> > have uprobe trampoline vma objects and at the same time it will
> > have optimized code calling that trampoline and crash.
> >
> > Fixing this by allowing vma uprobe trampoline objects to be copied
> > on fork to the new process.
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 6824376e253d..11ec6b89b135 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(unsigned long vaddr)
> >                 return ERR_PTR(vaddr);
> >
> >         return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
> > -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> 
> so on fork we'll get sys_uprobe invocations which will go into uprobe
> trampoline and syscall will just keep returning -EPROTO, is that
> right?

so the child gets the inherited optimized call path.and now also the
trampoline, which executes the uprobe syscall and so if there's related
uprobe it will be processed

-EPROTO is returned for uprobe syscall executed out of uprobe trampoline


> 
> what would happen in the similar situation for process with int3
> uprobe being forked/cloned? Will it inherit int3 as well, and then
> will keep hitting interrupts that would just do nothing?
> 
> is there a way to restore original memory page for clones? this
> behavior (unless I'm misunderstanding) seems suboptimal
> performance-wise

the standard uprobes seem to handle this situation by removing the brekpoint
from current->mm, if the uprobe->handler returns UPROBE_HANDLER_REMOVE (for all
uprobe consumers) .. and the uprobe->handler does current->mm filter first in
uprobe_perf_func and returns UPROBE_HANDLER_REMOVE in case it does not match

this works also for optimized uprobes on top of standard uprobes

but we don't do that for uprobe_multi and I think we could do something similar,
the code is there, perhaps we just need to add the filter

jirka
