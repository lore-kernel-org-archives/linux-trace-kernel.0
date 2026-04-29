Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DD1547C0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499253; cv=none; b=nfUL0LBaNezbwxkigJgH9YtY2EiYNmaCay2WPLY9Be6MJaiZRS4e0DwoOLTboynT3qSwHbGFMURnQ5X2VdRbnRaZNl8h20GTImthKe5942yF1+03x7SwRtMv25k9r70hrzchrLCXR41skNCGgixWPPaF26Q/6pm/6hiEOsTtBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499253; c=relaxed/simple;
	bh=rK9c6EtHS68OzgcIJdBQT5oLUKcLN/3nmmxams7EhQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BROfmVgRBIGC/XcO49XG96ZrhKaE7je4v/Yfh+kik4VwnyO8XZCT4/vSDzDf5aKwX1Cr2IeI47mKtDgNoZ/YZuJjF1aN1uIA5Uh9KGXMOQw2O22vKex4sVAascgqEymO9KCkLxZG+G/JIwVHpnKDYDTbqI3MoNR78oOHiIa3Nr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjTNAzUw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjTNAzUw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so141414f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777499250; x=1778104050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaLxc2VtdwmOLRiyOYeHaZXfR7Fifyq8Gol0GSWhrxg=;
        b=KjTNAzUwBjl2zQ1Co5KQJri1KHi29hnhgVTyJsQTSxl3B7ZO5pV9zsdJDTJNE6xf/2
         2uvb8nrZvJnOGTCr2eMeI1Ttqxp8tuVRjxL/8WVJ7pDXZbR/7GVhQp3FXVx2IWOwzeZr
         GsKLVt3j1qtgPmBcXL+a7Vq7PHDqDgH5Vi6/DuMvlWOOedOKwNYbT95/Dvbmx0l49TA+
         G8IV45858hWDBRlllgqS0ZC/gMRPKR4vxIKiD1UkoWT8gps2GJDbXl2YeWfczmMLcUre
         7Gm5fwfY1pQWRS0v1XPJJkH6mlqad7HN6Sfaoy/Wpicup6+a76GThhynmTth0wv09lDw
         uIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777499250; x=1778104050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaLxc2VtdwmOLRiyOYeHaZXfR7Fifyq8Gol0GSWhrxg=;
        b=mgp5e2RBGzNqgYUNL/Wgf4hnLKH2WY+EztZCxmbDf0vrkarWWkjoVm3R+aQiJKm8Wz
         3N52lES9JblwKFm5AV+V50fme7oTbJAOU0oGu+fK72a+ySm+zZTRdL8Xw5jdOF4qMxmD
         aMlBIjzzbCVOa5NWWf7+2P2b0NYoS6/d0fpEwNb7D9EXBflfSU4ogtuPeSwJA7rgqKlV
         VFnxRTzJPZTiqSNKxMoqgpsrJql1RI0frzV3REfuL4EO44xhKeOQbE72/I8ICRoCUobg
         1nd87PqvXhgEFsO6NdvFUMUeC5M6z5e4tHvjyJj+XZ9iqP1ifIgjA8m6nzu8y3WJIOja
         p/Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9g4AUdwLmsRzMYBUUJ1UZioslU1Y4nUxA6deSk7c7vaXN0LrrSv9cqZ/ILx9qh/boxC+TIhyI0w+XPZ2fnHQEfBSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEShnPHoHX2FTTmru4Xe0uqypaBn/5RNyvru8xrtgvhjvvk9HO
	TFHGA4yiGzoVSQYGyfrszfwmkbST2/5U3FOEntCmMvl6HgJAoUMzuy29
X-Gm-Gg: AeBDiesKCDUYrv7NJF+1GY71Ggd3C0IQcMsNnFWqlxNR4bIhlGVUH/AyEVSm0izQi0Q
	b7cIu/7qRpdtXcfHJrT1ZlbIvQKigYVeEPwKvUIhr3pc3Dpco+5JLiY4CV7/NhofVbvnMEAFrXx
	lQ0GIhPod2y9fIQTHzqDYBdR9CMG+o2v4nMXCJi8O2fdhVFiQPjaatod1NuSfYt+E12e58jwlLh
	6KgRnF9CZEUJNWgnj4fnO23upBe2gOjguo/NOgjT8Kfi98DwLS3AfuCy9a1y4Fd0BPdRQdM0QY8
	Auc1BNTwGsKm/Un+EuSHnKJgMTojwh15Yv50c8uAJMfwZ/ECiLozhHjdNxm8QbE8MKDcsZfE4JW
	rqHHF6aoyQzcs5ujtlo92K7fUJEMfkr9BcJLwKYZ5KTOh/37S+tLZ4K1XNut0tP6XT7cS11bB2n
	nhvQXHLiz65Ig26dN9fAtOLQi526w58uVzfeEBAcXGtO3tJVYEh/yb6x1OJ+TRyf/IeUAK9gsV1
	n0=
X-Received: by 2002:a05:6000:290d:b0:43d:1c7a:8b5b with SMTP id ffacd0b85a97d-4493ffceec2mr85031f8f.40.1777499250051;
        Wed, 29 Apr 2026 14:47:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b421721fsm7696371f8f.15.2026.04.29.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:47:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 22:47:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Qian-Yu Lin <tiffany019230@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <20260429224728.339a632c@pumpkin>
In-Reply-To: <20260429134226.49e95e9d@robin>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
	<20260429134226.49e95e9d@robin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 13:42:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 30 Apr 2026 00:57:07 +0800
> Qian-Yu Lin <tiffany019230@gmail.com> wrote:
> 
> > The macro trace_printk() uses a hardcoded identifier _______STR
> > within a statement expression, which can lead to variable name
> > shadowing if a caller happens to use the same name in its scope.  
> 
> Has this ever been a problem?
> 
> > 
> > Following the pattern in commit 24ba53017e18 ("rcu: Replace ________p1
> > and _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a
> >  ("min/max: remove sparse warnings when they're nested"), replace the
> >  hardcoded identifier with __UNIQUE_ID(STR).

min and max do get nested - so it is important that the 'local'
variables have different names - otherwise you can get invalid expansions.

No one is going to have: trace_printk(fmt1, trace_printk(ftm2, ...), ...)
it just doesn't make sense.

There is a slight problem the ____________________________STR might
be used by an entirely different #define.
Just using _trace_printk_str[] would make this pretty unlikely.
It would also have the advantage of making the .i file a bit easier
to read, all the UNIQUE names in min/max output make it really hard
to see what the output actually means.

> > 
> > Since __UNIQUE_ID() must be expanded once to remain consistent across
> > declaration and sizeof() within the statement expression, introduce a
> > nested helper macro ___trace_printk.  
> 
> Hmm, so we are replacing one name with underscores with another name
> with underscores?
> 
> > 
> > Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
> > ---
> >  include/linux/trace_printk.h | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> > index 2670ec7f4262..060eccb40838 100644
> > --- a/include/linux/trace_printk.h
> > +++ b/include/linux/trace_printk.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _LINUX_TRACE_PRINTK_H
> >  #define _LINUX_TRACE_PRINTK_H
> >  
> > +#include <linux/compiler.h>  
> 
> People are already saying that trace_printk.h slows down the compile.
> Does this add any overhead to the compile?

A little - nothing is free.

	David

> 
> -- Steve
> 
> 
> >  #include <linux/compiler_attributes.h>
> >  #include <linux/instruction_pointer.h>
> >  #include <linux/stddef.h>
> > @@ -84,15 +85,18 @@ do {									\
> >   * let gcc optimize the rest.
> >   */
> >  
> > -#define trace_printk(fmt, ...)				\
> > +#define ___trace_printk(fmt, str, ...)				\
> >  do {							\
> > -	char _______STR[] = __stringify((__VA_ARGS__));	\
> > -	if (sizeof(_______STR) > 3)			\
> > +	char str[] = __stringify((__VA_ARGS__));	\
> > +	if (sizeof(str) > 3)			\
> >  		do_trace_printk(fmt, ##__VA_ARGS__);	\
> >  	else						\
> >  		trace_puts(fmt);			\
> >  } while (0)
> >  
> > +#define trace_printk(fmt, ...) \
> > +	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
> > +
> >  #define do_trace_printk(fmt, args...)					\
> >  do {									\
> >  	static const char *trace_printk_fmt __used			\  
> 
> 

