Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618E1C5486
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766036867; cv=none; b=QbNYaSCCkdsXNlTSmRmxJJH3KbQL4zXFmmfrVMmS9yXNgJ3neO2vvAS+FMLlPnezu61oT/w5orDJ28sVw4gM+3HzNrHNdYm0tENTmkmQBafGqk/LUlPvre06J5JNsj1qNN9llm47/hu+MK6ldlptPcgYvvaoGTTTbXzlfWjySqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766036867; c=relaxed/simple;
	bh=1WKmwxIykHwtmPt6271x4VTejLBDKzjIsnD15tHvQrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbWLLFR0fdV6tN5qH9dug9hTBRAGeO+HlsPkGxLtia0sktXhtOD8Byc1iX1gKjMpGCV4fruzsosco6OUF00Ij1Op40jojhIHFvf3ZxvfYg1SU4R3xnm/rBx5JTB07hBMd/TfYuAnK7BTAs1IPWu9TNE0AsO5zOUhYwp9QE7pL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH0m7WUo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH0m7WUo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0833b5aeeso3306825ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 21:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766036865; x=1766641665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaGJpOKqg8zQltJlD/AWg9VGkTrfZMf+YGQyTVj+MTg=;
        b=JH0m7WUocqhfDNNlh28e8E3NOcQyQlLreoOSnUiUXTsYO1/MpaJ6dkfIxh873/H5U0
         ws4eFzMNqhiCZK3F/XNhSurJj+zt0DmIg5LZ9BldClVgTgLjs/LHT6JoJuF5g9Lvo3jr
         qfCjLjT3aMUosUlQPFmBj1HryNqgEzY9g8k/4Vk+3WALrKvRx5W1HJMPLf3ml882+1qj
         rDCXXmfHBLJxoqjjcGHvKpRmhGUeVA7EFDvMa8BV3fux90X9UxWuqcVwI+GSL3mV30i0
         6V5sWGzLZQS82JP/GZk1eVnhTHunrjrwfXUdkzX/F6uPZUUJzro39SapKHr45Rr34nHY
         WUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766036865; x=1766641665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaGJpOKqg8zQltJlD/AWg9VGkTrfZMf+YGQyTVj+MTg=;
        b=feoG78H4RWb0jBf59LGvCMILf/gAikmormFngPui5db3AcEKH+jE98l+E04o0IhaNP
         OaAqSQveVNa+wdiu7s58OAffrHLqW7SKMc9Xm8SlO4chrTxYHfLRJvKji4b3eBhaa3p1
         rmh9fOYPL5AGrGEABWMrFSlXpuPTJSDhgGaKR2g8dYPw/l/3qSZmDv/9zPPWZ/I0WTIV
         bQwSGM+BNBCn64p8DvMICBOJQIKRT1lvzKnUJO++JuTI0vfXnRvoVh71EfyLkRppFDot
         2UD/YIOH+mCljFFG1sXDJjwFUPA5L+IiPt9AsDFBA6gZZD6IbcomnJognqYGLD4f6L5g
         Cerg==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ87QoNRtqseutrHytlw1HnCveoGfPz5ywcLC/0XKSNJZZ6vd7d2Ugmp6fv0DZEJgYnrW6igyGL0NMZeWwKlqRE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvb0HiONsaHhqIuiAYe4zZpctlKd42OtYrT9s2Xxm/ac5POX5r
	G2ffh4LlZT/BL2ChZ/Oe0qOAkWoXCzAjb9Q3TXg9UmsMGTHRVWdeN0Idd/F8Aw==
X-Gm-Gg: AY/fxX4P8UsItAlrq4lg1vcwOw8NPlv0Fh0vojIxYHesHDStGJ2EWriAmAQwTe3hpK0
	Je31Q2C2kkRYiOUFLblwxgOJ0IYuVg7ITnlrlW17aKYXJNG1S+AixT7akMXGOC35Brv6FKtixMt
	o61EWOCCVdr9IgL5JM/KMNBMfPQzOAD7Jl8pibCDxaGl21oIi8lDYDs3aIde7xrwMammh5m+Vko
	gLaNnezyj9WR87+rLjONx9WAX5QWFGRJpuVo9f5d+aLQO4lAz+QbnC50Rs0Skyt3KwGhYP8p2hx
	ptOzXcf9kZ077XVTMigeF0zaKC+MmO5Qj1x1jr4baQ3Wv5EErJU+XYtZu2bQWao+Cw9tjDdYH64
	Kjuo3QHB5cf3vHekF4WSD0TRRE8mAShXEhBO0eNFJcldCMAvZL0X8L5QhVCAfcyzVMS5njFpPzp
	HDPsXqOaE=
X-Google-Smtp-Source: AGHT+IHIeJZ6pUO0IWI3BZr8YKRR4WYcObEmm4ye3CL4DoHkOxJXpQslAZeBIjOMe9+OleYRLYL1Lg==
X-Received: by 2002:a53:a090:0:b0:63f:bd67:7c52 with SMTP id 956f58d0204a3-645555e7c66mr12186194d50.29.1766030374328;
        Wed, 17 Dec 2025 19:59:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-646636e8a2csm581612d50.4.2025.12.17.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:59:33 -0800 (PST)
Date: Wed, 17 Dec 2025 22:59:33 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aUN8Hm377C5A0ILX@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>

On Tue, Dec 16, 2025 at 09:24:55PM -0800, Randy Dunlap wrote:
> [adding Kees]
> 
> On 12/16/25 4:13 PM, Andrew Morton wrote:
> > On Fri,  5 Dec 2025 12:52:35 -0500 "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > 
> >> Tracing is a half of the kernel.h in terms of LOCs, although it's
> >> a self-consistent part. It is intended for quick debugging purposes
> >> and isn't used by the normal tracing utilities.
> >>
> >> Move it to a separate header. If someone needs to just throw a
> >> trace_printk() in their driver, they will not have to pull all
> >> the heavy tracing machinery.
> >>
> >> This is a pure move, except for removing a few 'extern's.
> >>
> 
> Hm, for a pure move, this shouldn't be necessary. Anyway, not using
> FORTIFY in purgatory.o fixes this build error.
> Or maybe there's a better answer.
> 
> ---
>  arch/x86/purgatory/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -62,7 +62,7 @@ PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_C
>  endif
>  
>  CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
> -CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
> +CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS) -D__NO_FORTIFY
>  
>  CFLAGS_REMOVE_sha256.o		+= $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)

That happened because the new trace_printk.h includes string.h for
strlen(), so all kernel.h users now indirectly include it, and it
causes, seemingly, a circular dependency if FORTIFY is enabled.

A fix would be dropping trace_printk.h from kernel.h, or switching the
only user of string.h, trace_puts(), to __builtin_strlen().

Notice, Andy has concerned about this on the previous round, and also
suggested __builtin_strlen():

        https://lkml.org/lkml/2025/12/3/910

I deem to drop trace_printk.h from kernel.h - it is more aligned with
the idea of unloading the header. The original motivation to keep
trace_printk.h in kernel.h was just because a similar printk.h is living
there. But after all, this is a purely debugging header, so no need for
almost every C file to bear debugging stuff.

I can actually do both - switch to an intrinsic and drop the header.

Guys, please let me know what do you thing.

Thanks,
Yury
