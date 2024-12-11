Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7737246322
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927000; cv=none; b=Z3E1125TBiEwgg6/rVIMTbCzSM/+zw3zBKOO3nbzwf50At8juIfe7oLTL6Zf8Vc/qKIhaN8MBPH7mk1z5r8Lm9AGy+GYhfhFl5nYhiETCVllMQOybMiGbrlekxev9AuTQiHb8y/FgwKHMpox67tQbUQOhq9kOwqwPbdMoT8RteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927000; c=relaxed/simple;
	bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSsPMl6dsnyOUqnV7yTfh6A1eYiska1DovD/2Fw6QqJXJCzSRc6RqBiPTinBSNwNzhzd5fz4p32zc/ZGaQf1ojDcejtHezQOt6TdAoYVf35DvSJqftEIbnA+cq5FrPn17iC0XvTLzrExSxRVekv6XJCu7FmVlbvkHGPKoKv0zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9apzlzy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9apzlzy"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso5211218e87.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733926997; x=1734531797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
        b=g9apzlzydgJ4Q6ULFHgnRbTsqlj5aB0C5meVMSK/UNmDqyc/uQbfs5PQAtaCz7K7ja
         FslTws/n3vsJ1uTp8N4P8ryGEvGlNOn32LK1NjPHQp1YTN37naNtQtJO74iy+/9XeGKW
         Bz31Qx5DQjQUYfoJqhGsuPaJJy+4sF0WqZZpxgar/5vPUfDfwAQeE3Ox3rpxRcofCqHY
         fd1j2dxIQV56PQq8Z5wmeHtasKMFRG0STSNmaink+s3SLcKCwZmJkIrSwXI3LFO+NJ3r
         VDmhohhZR9mSRoPR25jxYQjV9fbwdwZZmGNYJi9rP/3yMYDZNqc+UibLYZrQSiCurd5e
         UK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926997; x=1734531797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
        b=LOk+9+vmAxZiH9l71o2LW/UOK2FTBGrrfP0ocUpu+W9Sy17uJDSKcFofPiF4Tp8kq9
         Hf3vk9y9mZOZk5XpTPjwzetbx0v7hvTsuf/sGroi1jh4nWx60BCjqHnjPfRY+hI337mh
         yCJJ1ht6a5MMQbGl4tKk2qNqc8jowrP/befPZwvGt4vlqtP86OOfoOWu9h52+gYb+Nwo
         3InHLTHVIcdxJHI+A5CWO3mw0x3LJUWR7XMeBLLRS5+Cl2KHPdoN9P68w9zfZd32VkLS
         d4f4od5kPMwgPz0elElaRXJvKQdHuzUCelrdypm3sEFSdVRdM9bY97aTNfpMchrce1Bj
         UdYg==
X-Forwarded-Encrypted: i=1; AJvYcCWI7wFp7N3isYILE4hj0JN4Gh55HHgLafCTsF7IR2LZ8uw7Sqfi8UFC53lhVlrQ2Kcd+HNJ5E5BpoD5u8ZFq8YWSwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgm2lWN4aWtRHFhhJUwPHJSSGOtOehjPu45T7pu/OF3yZxVQqP
	X3oG9cI8dDi/tQz5PdNM/8ZwvlckVriOrro3Gdf/YipC3+mXkQULfVTuZzYgDejLaIxLpmIRFNq
	XvnLoSFxS03QtOrx3PL8o0PCggnQGA8GhuytPY6Dql/sDTll7
X-Gm-Gg: ASbGnct2KBniHO+MnyaGC/8booSLDivGR/jR1MuAuYHvkoxBs7i2tUtHxBVgQ9a5JrG
	fhifxBtPrfGg4Ek1EUHf4+b0h5AOXU1k5VA==
X-Google-Smtp-Source: AGHT+IFwc3R4PMoFIypjPPrlyu+bP54qbrkqb6SdTFcVtmAjqvNQet3Sk08y9AmHyRfPr3eq0SXHvcppFqWjVobZmrI=
X-Received: by 2002:a05:6512:6cc:b0:540:2292:50b2 with SMTP id
 2adb3069b0e04-5402a60af0emr966019e87.52.1733926996913; Wed, 11 Dec 2024
 06:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018214300.6df82178@rorschach> <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
 <20241211082427.01208632d3dd5486abb3e090@kernel.org>
In-Reply-To: <20241211082427.01208632d3dd5486abb3e090@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 15:23:05 +0100
Message-ID: <CACRpkdaEXUxSuVzztcVOh2VMzPHr+6jsrEC1w6ecWEd0qzgU4w@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:24=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:

> > cd /sys/kernel/debug/tracing
> > cat trace
> >
> > Gives an empty trace :(
> >
> > And:
> >
> > cat current_tracer
> > function_graph
> > cat set_graph_function
> > do_idle
> > cat tracing_on
> > 1
> >
> > So all *is* set up, just not performing
> >
> > I tried to figure out why this happens but I'm not good with tracing
> > internals. Any ideas?
>
> Interesting. Does this happen only on boot-time tracing or after boot too=
?
> If it does not work only for boot-time, cpuhp_setup_state() may not work
> before starting boot-time function graph tracing.

If I boot without any tracing enabled from the cmdline and:

echo 0 > tracing_on
echo function_graph > current_tracer
echo do_idle > set_graph_function
echo 1 > tracing_on

I don't get any output either.

It works for other functions, such as

echo ktime_get > set_graph_function

It seems it's the set_graph_function thing that isn't working
with do_idle at all after this patch. Why just this function...
The function is clearly there:

cat available_filter_functions | grep do_idle
do_idle

I can also verify that this function is indeed getting invoked
by adding prints to it (it's invoked all the time on any normal
system). Does this have something to do with the context
where do_idle is called? It's all really confusing...

Yours,
Linus Walleij
