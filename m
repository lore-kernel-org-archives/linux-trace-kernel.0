Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843642FC895
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049604; cv=none; b=U++WnSd3H7QPsVCYoEvuqZZtMvPFsNydhEyvK3Jfvgpw2ylMNxsE7rakcvHUORI0Pd8YERMKtk32oECFPapptoC3CMK3K9S8vCasft3QHN2gKjM49E972N383mM25xTjPZPV1mZCsfbUciBYbjIaefPF1j4uGAnU7V18vfdZWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049604; c=relaxed/simple;
	bh=7IAIbw8sUkJ3o5wJTa1jHQt6cOZpyAPl1Nc270silZc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnpUoblZEIw3czgY4fs0HwjB3+UxaT1T/gXPIdy3cACkUVd3SF3dXkA1q8Acpu7LRtZ4jtfVp1lWivaCj10YstJVI9kooEjTTRorF6NXvbRATuae7exvwKNpjzGGOxOoel+r4mez9qYFrHD30lEHx1P6u4gFKOsJlE3miohdN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jByxble7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jByxble7"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1489318a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049598; x=1763654398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSWIHRyyO3hooO64JACSCpnVieSk/9Ppr4dvEYGltzw=;
        b=jByxble7o6DshXjcI0EPPa7DkVmHoAFdAPxfcaruTGYZGcp2H6gq9OE3fuNEvaoMNW
         Zygpz6ycJ1HXX/mcIv5pCOtvk6YAmKuzWju3ritevEYKcWQ8p9scRqkgCzCqmwDCenDX
         lJCbFYkLXLMTnULmLJ+6pPgvWZNQP0kMnkP4k08fsp3LDFDYJlkrlp7b1BTocKL6o9rb
         heQ3Z/Bv0xvEpjvcBTkWMeJkCTbDjzgJXc4TT5HygIYBb5ppvWpN4DeBjHNtMTFnY3lg
         q9djjueyjEecbXx1BjRtaFcJ8gDpX7UmVcQg83CpgwRQ/VBIuxGNLVpIXVcxtx4XMKFA
         9bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049598; x=1763654398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSWIHRyyO3hooO64JACSCpnVieSk/9Ppr4dvEYGltzw=;
        b=ExHHvCjF9tT/O0+MEhTE1lcM961RfNf7DLZ239Gyeof2Sl+5fUm3mE+pVNGZ44mfRh
         XPs75NyG1Uz8/YdCiJfOagR4TfivaQNwpSiut8HIetx7cCQBcZ1TJipoNHe6LSjErq/O
         55IbRFdxvQ2pqp//RDYEGcHYQ6SFhPL7Tyzh8qHhbJHzzNA78psMlH8lFhv+pG9vrCz4
         EfXMYn3jsFatZ/B9nICyQIPTm9zODGKw/Tec/AxtOMmmS5xRb6t+HEMzOWGQUsy+rKUH
         IerWAX6+a+qQofdEWD8aTIuSR6mn6kFmpJdF8ihcYW60MuyuRzRIJSF8QjZfTQwySWGG
         oWJg==
X-Forwarded-Encrypted: i=1; AJvYcCWIZK4Dfflwd9kaynM9SMJSKjci68rzUYz/htW4EeKt5/9J5uKn6Iw3tfPboeSzNcT7X91GqwuAZFzLSu+92LRnPhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpOTE0ZK5/FAMCfL0UM+UgWcHrtnIU7tpa/448R5eVuMFOaSY
	n/qAXcjM2gQkYsMUsPhGfAP4CLrIki8UL+p5RhClnzBXApP5ZmkLJpuF
X-Gm-Gg: ASbGncsVwsl9uOwg0qUj3XRvdxXnzlKXhPyzzlZSFw42YdvXbVj3Wt3Cor5a5xMRjLP
	UtJstU+1nzKwWzdkdeCJ/e0tVe75ntru6ql1BPjEg8twIOGVyOxVcz8GLJql7oKcyXgEB9940aO
	YHju/zjmHCEe/3qN+lJuAsUw4riBBC0ebWJJgiSTqhKKPZMb0r2IhSS3uWMJQK6oArA56m6oX23
	lHUQ7e0N3vCD/D7cdW0BOlEXtzxFtQh18zVbJAm8Eej9IQ40xlEUmBmdRGtGlyvLmDZ2y9GoDrZ
	iUq8lHae5IWhpX77uNgvqIaFaXeUiDRxjWg3PySq5/gsUCIprxwhERdEik5iD1MgXcEnsUoFlK1
	prCVrw9+i63TgJ4JqTWHVAhrLrbXKceYU10uxkCNM2Lip4f6wvZ0o7qS2Plcs6vKuhstOySfmWA
	JtbsCHW101nYWBNeAywTcyeKk=
X-Google-Smtp-Source: AGHT+IFoy3Qrt2T/zWrqrEncmeovSM7PWIvEMpppfNPTs0PN5vcTlJFJgXzZBDKyyQYJxY9NrZnMDA==
X-Received: by 2002:a05:6402:40c6:b0:640:c454:e9 with SMTP id 4fb4d7f45d1cf-6431a395d46mr6335604a12.4.1763049597599;
        Thu, 13 Nov 2025 07:59:57 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b2615sm1675323a12.32.2025.11.13.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:59:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 16:59:50 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 3/8] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <aRYAdoHh0S95C4wA@krava>
References: <20251113123750.2507435-4-jolsa@kernel.org>
 <c341189e76b2cf9bb2fe712c074bdd652f73edd5ea2f409655b2d78a62bd332f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c341189e76b2cf9bb2fe712c074bdd652f73edd5ea2f409655b2d78a62bd332f@mail.kernel.org>

On Thu, Nov 13, 2025 at 01:02:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index e23e6a859..ded3a306a 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > @@ -568,6 +570,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
> >  	return -ENODEV;
> >  }
> >
> > +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  /*
> >   * This must be implemented by the architecture.
> >   * It is the way the ftrace direct_ops helper, when called
> 
> Should this stub function have static inline qualifiers? All the other
> stub functions in this section (ftrace_find_rec_direct,
> register_ftrace_direct, unregister_ftrace_direct, modify_ftrace_direct,
> and modify_ftrace_direct_nolock) use static inline. Without it, this
> could cause multiple definition linker errors when the header is
> included in multiple compilation units.

yep, also the other ones are missing it, will add.. thanks

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793

