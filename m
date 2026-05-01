Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F53421EFD
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 May 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670000; cv=none; b=gtBkqOulsR9v8u5zk655GV/qljnHQGztMxFyssbV+0XQ9cQJeS2/YfAbBbNhr+CZgIUlmo3b3ABeFdlh7bNaqWAmOgzExDnpbHsluAcwDwFoogEqPIucwin6kmmQNRIywDZKbeUGkwYbyv3mo1rSeZrhM4jTQboy2ZXX1W2oo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670000; c=relaxed/simple;
	bh=NvbUB9w6sa+4Wu7Si19/S3bep7cng1nAYKPLebrqTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOVBx33olTay3FDXdaXL+abaDcerSLtdQIzs4N8O1Ak5o8d2fxs0jJeBiO+PqZVi75lMQ5TPg1jUE2LE1Ek8jjyYZ/pww0GVBoHSeVvz6PSicq92MF6Tv8BLL/a4D3EVisGEXxJUUzNShXXjxbfYbT74f2GOocSHOK2AMKeeMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c26QGOFp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c26QGOFp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso18343865e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 May 2026 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777669997; x=1778274797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg5m7oNPpPp+73S0JR0V2pwRtY170K+LXcVuROlxjE4=;
        b=c26QGOFp9StWg4mOBgWstMfOYhSVuqyIXj8gjhXDKTF+IeusP73OJK4Ty15yadNNco
         cjSf0R74llTAPt135L/1uSQ6p4RSTm4FLCsHtGLC89qYX8MFH/0lI1qotpctPjOMHD6v
         cbzfoQ8X4yivIjc4RHApNzuLwImsNCVHUhEPz/tu87r1fI3Iikm8AhDOhtA5fYtVN/v8
         tfQ+AklYERgL3lrw/nIC3qpfNlJWuDgU/EdEUFse/qeaJ1WmLWU8Oeft5jH8vi2H1tQE
         7dXxnOHrU+2k+qCZ2XttzC1YhYMQOm4htsMb8oQCqs3iGrtnyhpg4Sd390GAgJBxFTar
         lFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777669997; x=1778274797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yg5m7oNPpPp+73S0JR0V2pwRtY170K+LXcVuROlxjE4=;
        b=kIUlI913LT4M/tKaFyYZXh5cQENw6XjAN+JhBx88nIEZ8YsAPwhslRhJ50Ml6Y0Rul
         DygtdJ0YOPNw9lldsil1HvuQhqM9rC+mIVCEPDc8v/pzIevmhPVHDUBOqZBovNZQVSDF
         6ImOFbwZOFZ4mLI6LVppNPRFQ2K29KcDeMRpg3kq/TUZpf2GEI9HualhjOZiLP6aazdj
         yAuUmaXwAaP/0FqczDeyFn9A6vQKeISbnxtLVOql4IdWfHA8+jSlpcMXrhcaRTtRJSNe
         SHN1a9sHK6oioOiVLkeovhykd+6YWXsjZpIobrtv9TBAqSzefXAAhgVvhlM7HlaBLc27
         RJ/A==
X-Forwarded-Encrypted: i=1; AFNElJ/sZRul4AYyoyuz2TvEExonOY3EUqt8FasRKJEH4oDtSVEODDh85d7mQdYNtISH+SNoJkye5cgzIq0TbF/xGlOYZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcr84u+OwnEWW5tTETB27SDzfAi/xCIfbT9zw64joBbzvtCV2Z
	30+kjMJAa47SFllE4MXqLMt8eU2IiKBl/lzsgHC0X+Z6Vcjc1lE/6Xa2
X-Gm-Gg: AeBDievziuXoZqL7zipAaKqEm0mOlKAbfrhF9pxRHuyLHcCKb6ynYB5K9AnaA1QTDI1
	xojLuY7BPkvR2U1/Fl8BWDOiA7PYQHiO3oxsiW6HwOXavQzv3wp9vhoO2Hs2OPscxoj7Tc3qOYh
	koeFeVfZQq90To2wX31+QJu2xIm8w0CTHUHjmwUu63RuULJdltNR3VLnppGGuAt2rW5iv55jc5V
	gdaLkwM1X4xH+a/51xAxJwE/3HquNDqO2BTlZjzd7hSa/GqPRFqJSICpt98vQKaiDIAJ/J7tpT1
	Ny7j3DzDgJ6N+eTR6xDA1Q3QItQ6eG24PAsIM66P7upWTcyiNnHMz1B2HlcqDUYnf/ecjg47T7o
	rp9W6cPi/ezS9CFLe3tzdZsJW3ZXwmPxYBFpNi1kUs710zSCjtPaUMC119s3aw6qKXqA6iTZ2j0
	QE7l9LClj3iwlUfBDmWnC6IYfVex531Zk6yggiyeYnoNeQMEUpf7BvgBz3Y4eExNiX5evsms0Ca
	rQ=
X-Received: by 2002:a05:600c:c058:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48a9866a998mr8312805e9.21.1777669997185;
        Fri, 01 May 2026 14:13:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fea704asm19701415e9.11.2026.05.01.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:13:16 -0700 (PDT)
Date: Fri, 1 May 2026 22:13:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Qian-Yu Lin <tiffany019230@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <20260501221315.1f709d6d@pumpkin>
In-Reply-To: <afS7UUAfzgiSzEHv@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
	<20260429134226.49e95e9d@robin>
	<afS7UUAfzgiSzEHv@nova>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 May 2026 22:40:17 +0800
Qian-Yu Lin <tiffany019230@gmail.com> wrote:

...
> Yes. I measured compile time of kernel/trace/ring_buffer_benchmark.o
> after make clean on an x86_64 machine running Ubuntu 24.04 LTS:
> 
>   - Original _______STR:                 49.8s
>   - v1 with __UNIQUE_ID (compiler.h):    53.5s
>   - compound literal (no extra include): 33.2s

That difference looks far to big to me.
And the times are far too large to be measuring the actual compile time.

> 
> I propose using a compound literal in v2, which eliminates the local
> variable entirely and requires no extra include:
> 
> #define trace_printk(fmt, ...)                          \
> do {                                                    \
>     if (sizeof((char[])                             \
>         {__stringify((__VA_ARGS__))}) > 3)      \
>         do_trace_printk(fmt, ##__VA_ARGS__);    \

There has to be a better way to align that code.
Although you should be able to use:
	if (sizeof __stringify((__VA_ARGS__)) > 3)
(I've omitted one set of parenthesis for clarity)

You could change __stringify() to work with __VA_ARGS__ the you don't need
the extra (); this works fine:
#define _x(...) #__VA_ARGS__
#define x(...) _x(__VA_ARGS__)
#define z abcd
int a = sizeof x(z, v); /* 8 */
See: https://godbolt.org/z/zo4h4nr9b

-- David

>     else                                            \
>         trace_puts(fmt);                        \
> } while (0)
> 
> This fully eliminates the shadowing risk without any compile overhead.
> 
> Qian-Yu
> 
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

