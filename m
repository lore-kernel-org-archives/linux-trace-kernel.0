Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C012D7DD7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 May 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647076; cv=none; b=HxRfE+W1FC+ROws06p/CDxOWRp52duS4YaTz2148Ny0vev++VCFqJr5Fg90Q0ewJL2ly46i0xsc8BRyK2TgPAKKXOfma8veZj/AQ8aVrgOvpbB15VAYQ+C7dCQ16fH+eO0QGRmCfaj2EVfOkKfEuuoqPhP9bJtgRhVJpo7yQ3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647076; c=relaxed/simple;
	bh=bozvPF2fl+Cy1uzEhleN0qsghG5cNdUqL5pLy1F5XFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gij0KosZ86DwlGAXzHJrShDg8ANQHR30wdiYsIb7Mbx5maaHHAwCTla7ElDDvc5xGHgRbe7BBNvxqUOIPnPrr4RmUT3k5AZ/Dsmq6GT+9QcpkwSJjsEjzy8gy8V6h90oju/kPeLAZf7Ei1xFckoCpSPB1Laev1FgvlZRF6BOGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFcD++LN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFcD++LN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2503753efso20124995ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 May 2026 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777647074; x=1778251874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrNssFo/f9hfSn+Mb9ahlDhFOC1usxOBllM0KCMdbzY=;
        b=VFcD++LN8aWKqaoJyXnl0lO8detXT9yzQUkn2t7AgHj3zk+XGfqe3bLUC2yIOSBVXF
         8S0SuHfzb4eEhxdHD0Pbc7UfN8QocJHNQy8w+judH7WyzRK/X0ExjTJZfFMyj5S30X6D
         FcQpjKpcSwCdlqjPoxfU6YZm8eHBfEmdhRjOIr5D3uvDfvoPgUhQzAEy4fcswZTuggAS
         HPEHfiX5RNDNp2Xpe8YiibhkBhWyNhTB104/0BOMp79KdUNBhykSDHtbN5PupqUBZcGd
         7frMBB1E1K5uDNp6FwSbjrxNUmaLkdcv+A//W/TIFq7MGEpD7PlfVxh0J/AYMJYPtXEW
         3bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647074; x=1778251874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrNssFo/f9hfSn+Mb9ahlDhFOC1usxOBllM0KCMdbzY=;
        b=sEhnzJ/eUxsHBA/Xl9S97cjWzT9PtrwNhZCU2XmbqdCbZGL4HNLo0svMN+FbTWe5sa
         mS9ri0zUVbPjyktUGz9ytgnRNg+wgXyrwi7ebj3yXtHawvHwqoA7I7RBIoNoR5kiDHyt
         gIAmrLLMS8A3NLRIADuzooMVoGAhjE9YgBqF9Iq7cHn7EJW34wJMD0E+9r6a2FRcBOva
         1qQZwJrTeMUkNuFqxvMhmqtLIS4wsRyKfJamD1QjPD+/1+UeCIE3vH7L11HO2hiTQPZB
         v87M0P3L7zn6Dl0THGNmKzLck5L7oc/0oE9OzKORuChRLqWce1FzlgpjYiLAM2GlAoc6
         M/QA==
X-Forwarded-Encrypted: i=1; AFNElJ8mwud11hF9bdce3098qF5fSReiFfGFyJ++gTFaUhfORZ6XFx7m+MjxOUIWv3ExWul6gwytO7+qMyhO1rurhlIFGcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMD8tC3VYhJUYSCzxqu87PFipfrVxZIzX3YZ0CiXFmkdrj8iw
	3S2Lyx+2inWAnRhNxzV+W6MSipA7VoS7bvgVEPQP5B5Rh7TYZ/h9JWwWiNo0HdOh
X-Gm-Gg: AeBDievAFu7v7B0VuyuRQ3S83MzQIBz/O7cCGAsFNF9cwXQ/+cObbWiHS7dl64Eih3f
	fw6MGA9J9v+bI6JE4HlAc0w164zwucc6GlMJyY9w6MzOESeJEeUlgfub1+d9uVLn/Cb0oFNTq31
	h22CdbgdIs/dLY+c1uEslOSJUPaHCt0EonIVVc4QrUDjbNNiizsePVFQwcj2yH6EEs9FZ3UIhlc
	7xqnAZtDKNIwZKbBrpKy+1IWo4J1YN2vgee2xPzfzy4GX+K0Ow4n+7qIv3Yq0Uu5oOrvLDgGM5R
	c8ChyhF1yICnyQBiZJqDi2YOvORP+NsZZwGr2BVtrmoEHxkNRj5Gy5Y0JRBbMSGyajGBbCxf4AH
	5g8tzcEjG+0eDd32dQJ2zXdb9O0S8ut+SaWPkXrlPZl5fFYHx8iZ5GwamDu26nszTgHV0MuvS1m
	hwfxCbQHXR7xnIrnAeHPIGEGo8b9af3g==
X-Received: by 2002:a17:902:fb04:b0:2ae:b9cd:d2ce with SMTP id d9443c01a7336-2b9d444be80mr25456245ad.27.1777647074386;
        Fri, 01 May 2026 07:51:14 -0700 (PDT)
Received: from nova ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae67196sm24798305ad.79.2026.05.01.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:51:14 -0700 (PDT)
Date: Fri, 1 May 2026 22:51:11 +0800
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <afS93-RqEJhImJaC@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
 <20260429134226.49e95e9d@robin>
 <20260429224728.339a632c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429224728.339a632c@pumpkin>

On Wed, Apr 29, 2026 at 10:47:28PM +0100, David Laight wrote:
> On Wed, 29 Apr 2026 13:42:26 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 30 Apr 2026 00:57:07 +0800
> > Qian-Yu Lin <tiffany019230@gmail.com> wrote:
> > 
> > > The macro trace_printk() uses a hardcoded identifier _______STR
> > > within a statement expression, which can lead to variable name
> > > shadowing if a caller happens to use the same name in its scope.  
> > 
> > Has this ever been a problem?
> > 
> > > 
> > > Following the pattern in commit 24ba53017e18 ("rcu: Replace ________p1
> > > and _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a
> > >  ("min/max: remove sparse warnings when they're nested"), replace the
> > >  hardcoded identifier with __UNIQUE_ID(STR).
> 
> min and max do get nested - so it is important that the 'local'
> variables have different names - otherwise you can get invalid expansions.
> 
> No one is going to have: trace_printk(fmt1, trace_printk(ftm2, ...), ...)
> it just doesn't make sense.
> 
> There is a slight problem the ____________________________STR might
> be used by an entirely different #define.
> Just using _trace_printk_str[] would make this pretty unlikely.
> It would also have the advantage of making the .i file a bit easier
> to read, all the UNIQUE names in min/max output make it really hard
> to see what the output actually means.
> 

Thank you for the suggestion. However, _trace_printk_str still carries
a theoretical shadowing risk if a caller happens to use the same name.

> > > 
> > > Since __UNIQUE_ID() must be expanded once to remain consistent across
> > > declaration and sizeof() within the statement expression, introduce a
> > > nested helper macro ___trace_printk.  
> > 
> > Hmm, so we are replacing one name with underscores with another name
> > with underscores?
> > 
> > > 
> > > Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
> > > ---
> > >  include/linux/trace_printk.h | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> > > index 2670ec7f4262..060eccb40838 100644
> > > --- a/include/linux/trace_printk.h
> > > +++ b/include/linux/trace_printk.h
> > > @@ -2,6 +2,7 @@
> > >  #ifndef _LINUX_TRACE_PRINTK_H
> > >  #define _LINUX_TRACE_PRINTK_H
> > >  
> > > +#include <linux/compiler.h>  
> > 
> > People are already saying that trace_printk.h slows down the compile.
> > Does this add any overhead to the compile?
> 
> A little - nothing is free.
> 
> 	David
> 

Indeed. I measured compile time of kernel/trace/ring_buffer_benchmark.o
after make clean on an x86_64 machine running Ubuntu 24.04 LTS:

  - Original _______STR:                 49.8s
  - v1 with __UNIQUE_ID (compiler.h):    53.5s
  - compound literal (no extra include): 33.2s

A compound literal eliminates the local variable entirely, removing
the shadowing risk without any extra include or compile overhead:

#define trace_printk(fmt, ...)                          \
do {                                                    \
    if (sizeof((char[])                             \
        {__stringify((__VA_ARGS__))}) > 3)      \
        do_trace_printk(fmt, ##__VA_ARGS__);    \
    else                                            \
        trace_puts(fmt);                        \
} while (0)

Qian-Yu

> > 
> > -- Steve
> > 
> > 
> > >  #include <linux/compiler_attributes.h>
> > >  #include <linux/instruction_pointer.h>
> > >  #include <linux/stddef.h>
> > > @@ -84,15 +85,18 @@ do {									\
> > >   * let gcc optimize the rest.
> > >   */
> > >  
> > > -#define trace_printk(fmt, ...)				\
> > > +#define ___trace_printk(fmt, str, ...)				\
> > >  do {							\
> > > -	char _______STR[] = __stringify((__VA_ARGS__));	\
> > > -	if (sizeof(_______STR) > 3)			\
> > > +	char str[] = __stringify((__VA_ARGS__));	\
> > > +	if (sizeof(str) > 3)			\
> > >  		do_trace_printk(fmt, ##__VA_ARGS__);	\
> > >  	else						\
> > >  		trace_puts(fmt);			\
> > >  } while (0)
> > >  
> > > +#define trace_printk(fmt, ...) \
> > > +	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
> > > +
> > >  #define do_trace_printk(fmt, args...)					\
> > >  do {									\
> > >  	static const char *trace_printk_fmt __used			\  
> > 
> > 
> 
