Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5D2BE648
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Jul 2025 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576321; cv=none; b=sLR1aDfNp1KBO3nQqVTMBNCoNrNfHNOcLeAcV2tGr1EdIF41Nsxl+fB0K8X3OkXITjQCUGtapZHFnbi5ivS7aCclK3sODnt/MQfLoDafze7SuO9dnhmVi8EUdRNMo3IgyO/VjPPQfY4Efhcb5/bcZWl0GElyFM99GZanEU/N88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576321; c=relaxed/simple;
	bh=DiJjAsxd3NLx6OvlELv3sKg3BSU/dtVOQuiuh5Nz4Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eikIsDkVWJwbiMjvdyk6fU4aKQoVwrerEM43Sd8KsvZf4dlo+85/uvh8zBQMxyORCpQi7HC1wWvtslluRoq1Qx0y68SU41hS5cmkBKuw+QD8TwfV+W1ClbVqveJtZEY42HVf2Y7YxodmBJmU9NkIKtkaJzGWeEDQUNZj9yBJqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AVzQ77Im; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AVzQ77Im"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade5b8aab41so60907666b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751576315; x=1752181115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XpibsVHxYqxJwhE/Mgkya5GxIWQIBQtSRQMl/dLvVIY=;
        b=AVzQ77Imqo9REfO/kKiLsqagdUITM63fRGqXnI52YTKLrX9TsV5V98i2s/XRl1vJHZ
         Ntxm0yd/MnaDmGZYWrxy/AuWeKbuN0Ulz1h35PLPS/eZMyMzA9UMYJivB64P0vxxJdGi
         ZJ0YCk6TMhCZiXr93SpB4yhtfxODcyRFrvqWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751576315; x=1752181115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpibsVHxYqxJwhE/Mgkya5GxIWQIBQtSRQMl/dLvVIY=;
        b=N3vrADeqkPSd9dgUf74YFSl9qL3vurhXmvw8rTCPu5Vcf/I9Scrap+rFzI1iyQ3Y9C
         tNu7ZYi9T1BmGGpjFLIbUU8ovnoMNYxI8Ld3d3xeHsRBRLKH9n9uVVm/NUnjme4lQqNC
         aqJbjdnvMvPfHrjOed18n08o7/vw6rSn0xc2+coBSvuaOLIbiKCnPywbNwqq2eTYmOjc
         eoKrCFBR5z9c+B4GN8SqwcnULAJkMs/nZYu2roBEHcBRj9wU8NkuGN7gSnw8qycg19QQ
         sXxA8Rq/SqcWMeSNWcXTjetws6Rbq1IlRcMLhsIEG5PdQBcZRdCV6uZ0UhdNy4ybBRt7
         voPA==
X-Forwarded-Encrypted: i=1; AJvYcCWZqMQQV9v/56P96uM7OS2M/IN8GjkSU4DmAIE+KiOHx7KO3BXSzWtSaLmuG/ORSEEZ/PNZ+y3o6rFTmXEth1bpT8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/YsWhF9BeDnFKV/+EE+54RT3VIdG07j2rZjWsI/AcUyiEEUP
	DR/i5NrWeDZToPIGVLVBiW+xMAgOASdgKA7dZih6FQViJcrp01JXFYRSpKrC0zKMjpnBLdCLmmg
	0qRW3xG4=
X-Gm-Gg: ASbGncvoTnDtnKCtJCWVjqxCPGRNlvazg66Ek2eafDbQXbe/WKuvIYUvCx+nuCTx2ec
	LA9PO3NW0PUbbIrtTMtbBuk8y7CmS9UXVJYannjP9JV3k+Ib8JZnBfd29MNXlrOuVYr5ftvga+o
	cXFqqAlTXreOiPYvTFL04N4AK8uZzn6+J1ysoJ3e2rr/OXj3xcBpg6kBpTSXv+sdqpBHhcNSWcv
	F7YgRw6G2G1Z+jfL6TQmHUpkZY5BoYArrDegaNFIW8qAYbf3p1YK6Amk7e8rwCJrioSCdiCglaL
	AAwvLhlghiWuEEpjUAz6y1WY4cc7u24OFkMYYezKrehToGBNSRhw+IgObKwCIsdhFuBcvYXptkU
	ginBYVy9962VE+DljE9hByGOas5njU3n7CKoC
X-Google-Smtp-Source: AGHT+IFldfU95Kmf9ZiGP80xYp/G+jyCmVSpStgj175jv5reRsP6pcBNfUCaVUj27gIlb6jAIapDpQ==
X-Received: by 2002:a17:907:3d8f:b0:ade:4593:d7cd with SMTP id a640c23a62f3a-ae3c2abad80mr924172466b.13.1751576314915;
        Thu, 03 Jul 2025 13:58:34 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5474sm39147366b.77.2025.07.03.13.58.33
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 13:58:34 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so526855a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 13:58:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQQhv0E33BF+6/wGRJd+9OhsgOVHSdk5Eotkd+pa6mU4A4Mjbbu5/xQWCm9ekzZC61afuBGo1ihPayZUlIW+VIUs0=@vger.kernel.org
X-Received: by 2002:a05:6402:d0b:b0:607:f257:ad1e with SMTP id
 4fb4d7f45d1cf-60fd33621b5mr42848a12.22.1751576313551; Thu, 03 Jul 2025
 13:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703115222.2d7c8cd5@batman.local.home> <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
 <20250703152643.0a4a45fe@gandalf.local.home>
In-Reply-To: <20250703152643.0a4a45fe@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Jul 2025 13:58:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
X-Gm-Features: Ac12FXwYVzSrl3kui7aMRaxe8iQweZ7A051wIMsfyQxmbAoaWneINGskzeXmSE4
Message-ID: <CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

" part

On Thu, 3 Jul 2025 at 12:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I always thought the "HAVE_" configs was a way for architectures to state
> that it supports something but doesn't necessarily enable it. Whereas the
> not "HAVE_" configs are user selectable.

I don't actually think we have those kinds of rules in practice.

We have very random Kconfig things. A lot of things are "architecture
just selects the feature directly", and the naming is a random
collection of ARCH_HAS_abc, ARCH_USE_abc, ARCH_WANT_abc, HAVE_ARCH_abc
and HAVE_abc.

And those are the patterns that _try_ to be some kind of pattern, and
ignores all the "architecture just selects the feature directly".

Honestly, when we have *five* different syntaxes for "this
architecture supports feature 'abc'", I'd argue that not only isn't
there a standard way, all those different syntax forms are just
confusing.

I get the strong feeling that the reason people have those different
prefixes is literally to just group things together alphabetically -
ie some people use "ARCH_HAS_xyz" just because that way they can put
the "select" statement next to another ARCH_HAS_xyz that they also
maintain.

And then in addition to those various "arch has", we have the
"GENERIC_xyz" Kconfig entries that architectures also select.

I think those GENERIC_xyz Kconfig options may actually have more of a
pattern: that _tends_ to be about "I'm not implementing my own
version, please just pick the generic version". That one is one of our
better patterns, I think.

So the reason I dislike the HAVE_xyz pattern is exactly that there
_isn't_ a pattern. When there are fifteen different patterns, it's not
a pattern at all.

That said, maybe it's better to have one place that has that "if
FUNCTION_TRACER, even if I despise the nonsensical "helper
indirection" just because of the random naming.

              Linus
