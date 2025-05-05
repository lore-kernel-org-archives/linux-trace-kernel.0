Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349025CC62
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 May 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459793; cv=none; b=DzgOOJYeMUnhlHmYvl45uEHDdrx8QqeyAce91ywKoSIU2EJAZqmEHpA0EUBXlnHbeAgeQZDqVTTmy13aHCRC2LmkC1emWwntxrTGGM8SCvOpjjHYcEgOgymnOWMgLd9AsfRdLPR+NvD9Vk5H19NGCEvSfMCXy9/hTH9++HXcuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459793; c=relaxed/simple;
	bh=1hZxccIbWniJZ+0x/jSm8xcr1oxitOmB1wV1lj698qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoUa68k/pMYht7ScsgbTpLIvCjrybgbvaNwO0svRWwg70tTZrsviMIl8tWwJxsnxRngNTbbm2Ld3OZhZpoQeUypcXFW7DIAOaUjYXSkgxSEl9p9K+Aw7q0ZyjCh1c3VcvlqrUKZmpLvPlm/1vc8YRMRwqEqRIbWZU5K0zXI6cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d82VufKh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d82VufKh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so3683929a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 May 2025 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746459788; x=1747064588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXTYmNfnp3L8OKmlj5S0ckFXV6E7LYKVxcLkR0qYEOA=;
        b=d82VufKhzjMsGqOtJbk3fahPsBlmuC/yC8+kqfYTim6p8la7FuYydZUgfWp0/O6AKG
         vL7v2wrjFO5upfFulHIabTa5su15pclaYGS/EBtLp8j0TaUgW1K2+SYvKZOCqbn7RfqE
         /kdnwBMsj8uTZyM2uY15LfrnQGC0v4uPsI8jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459788; x=1747064588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXTYmNfnp3L8OKmlj5S0ckFXV6E7LYKVxcLkR0qYEOA=;
        b=ARTzWK4NLZXWwHY4wcEyI4pac0WYBQdYi8e12xko79U+q1AUzVGRJVePdFDzePhHtx
         +Lwv3otWPfaJf+n5qyMciHAyOvahiZP04EZOkXx/Lc0gKJAyt/KGk7vdLRtiIFNy6MI6
         +aBnaYPQqg1M3uoA3NW4xSPJTCgYyi/ToVHcvfKwW30AVfxd6osPzwghgiTDakX0B8qu
         obrLZKZrlOYaWPrVnHME2G14Wvo7dWL76qOWwZKwS9dOms6xqsqi8MnfBAZaYbF5nK77
         Vw1kShNEI/RnYIsJg2xHrAZ1d3GNzScVBclkQguRsgiJlsGtCwz2mx2qEne4j1+lIBl0
         JSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZOBbyuwSzYwT/JNjGu9qWLiXHZLT0vEweRM+z1sSdvC/gkNok0TkKx/V7VbaGfVUbKGteJIPAsCE9HPcaq3yldo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWdcqPlcyfy4UmPj9L4e3+GbZkpYSQgwrs0rP1adjwGR9Rh6G
	SINX8HG7MobI2C6LYRDUXeZq+Nh7ZvgkC48EKi0Sq1csXMrGG6dXU1jsoHCHPAVWNtRDJ69zIkk
	=
X-Gm-Gg: ASbGncsc3D6rjgPMlCsW4li7v2igJZeLapuz9j971FnmG+yb7NI21xtSlZ+B5IhbneH
	X+u0UYOuhzLWB8ocXGGxB/bJpcDfndQzhO8wJiaQ4CZQcvBJzxOQEAB7X9UwjgksmNPsnPLQflR
	e8bSH86S2U6rYXp5EiFikoXpyBPWeiDOoZ0plKP/5YxUb+2lUVAAjs4a8nNLQiskt7YcRd8A/dB
	7vVhiRS7kia/ed1MDgsNtZYgitTiOVIVdeZXCgfERtPsQYyZjxBghNJBT13Q+ukGolbteQMPiGo
	9+Sg+xaUx5kKWOgbCOfmUocck1ElcHKqNWzjxSdH5/8WleTXVk5MOijS4IY9hsxenlexMLt6UTJ
	cMhPFCy5W
X-Google-Smtp-Source: AGHT+IEzUjB+FpOG7en5ENRP1JUhGXwhkiplYABU4cIiIWW6Ie2DfW44+3tJNsSL30PKwCr8YxJuPA==
X-Received: by 2002:a17:90b:5785:b0:30a:3dde:6af4 with SMTP id 98e67ed59e1d1-30a4e6925dbmr18268344a91.31.1746459787982;
        Mon, 05 May 2025 08:43:07 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47625eb3sm9104633a91.38.2025.05.05.08.43.04
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 08:43:04 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ae727e87c26so2815366a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 May 2025 08:43:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtgyg00RWVMiGSJhbpdmkB6MEBPeH0oNjcIVwIl8qG9HMlIM40aj2DGlnHar6Kbn9B42CEsdBlcWuhlF1t3xPjhQs=@vger.kernel.org
X-Received: by 2002:a17:90b:520f:b0:2fe:9e6c:add9 with SMTP id
 98e67ed59e1d1-30a4e5c5d2dmr22184245a91.18.1746459784032; Mon, 05 May 2025
 08:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502205147.283272733@goodmis.org> <20250502205348.643055437@goodmis.org>
In-Reply-To: <20250502205348.643055437@goodmis.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 May 2025 08:42:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEnL7ztSfqAHS1Y=VwwYSyT=rfE7ZiUPLnDnMQNTcPjw@mail.gmail.com>
X-Gm-Features: ATxdqUEbLIdnfk4KhX4VeDp15dHAX0mPiplezQT4DJTJ5-tAGVeLSoklxA5bYvU
Message-ID: <CAD=FV=UEnL7ztSfqAHS1Y=VwwYSyT=rfE7ZiUPLnDnMQNTcPjw@mail.gmail.com>
Subject: Re: [PATCH 05/12] tracing: kdb: Use tracer_tracing_on/off() instead
 of setting per CPU disabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 1:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The per CPU "disabled" value was the original way to disable tracing when
> the tracing subsystem was first created. Today, the ring buffer
> infrastructure has its own way to disable tracing. In fact, things have
> changed so much since 2008 that many things ignore the disable flag.
>
> The kdb_ftdump() function iterates over all the current tracing CPUs and
> increments the "disabled" counter before doing the dump, and decrements i=
t
> afterward.
>
> As the disabled flag can be ignored, doing this today is not reliable.
> Instead, simply call tracer_tracing_off() and then tracer_tracing_on() to
> disable and then enabled the entire ring buffer in one go!
>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_kdb.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 1e72d20b3c2f..b5cf3fdde8cb 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -120,9 +120,7 @@ static int kdb_ftdump(int argc, const char **argv)
>         trace_init_global_iter(&iter);
>         iter.buffer_iter =3D buffer_iter;
>
> -       for_each_tracing_cpu(cpu) {
> -               atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->di=
sabled);
> -       }
> +       tracer_tracing_off(iter.tr);
>
>         /* A negative skip_entries means skip all but the last entries */
>         if (skip_entries < 0) {
> @@ -135,9 +133,7 @@ static int kdb_ftdump(int argc, const char **argv)
>
>         ftrace_dump_buf(skip_entries, cpu_file);
>
> -       for_each_tracing_cpu(cpu) {
> -               atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->di=
sabled);
> -       }
> +       tracer_tracing_on(iter.tr);

This new change seems less safe than the old one. Previously you'd
always increment by one at the start of the function and decrement by
one at the end. Now at the start of the function you'll set
"buffer_disabled" to 1 and at the end you'll set it to 0. If
"buffer_disabled" was already 1 at the start of the function your new
sequence will end up having the side effect of changing it to 0.

-Doug
