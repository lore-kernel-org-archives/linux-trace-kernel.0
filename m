Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A82F0699
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605474; cv=none; b=nMEu3FzaAum7DNX21vgQNoBzKRB2VItyaXO4dKxVyQUBBdROIbERmF4r5hTIURTHipPmGpItJbaoTRDGDJZceJudnSfyjUz35iaYIj0IRn54JK9yegeONRLQHfznzBaeUCkLKBgvaiTgw6jkBaYTJGNSlBXHnkJ3QDSEYspzPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605474; c=relaxed/simple;
	bh=gODZ/MHwTIo8UoO1UWReK9OH6XLJ3GVJqSYs95B/y9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9Wz8z5/Xdc5Jt95mNntLqDEsmHjnh8le6B77hXyzABMR2mz4/rPPADkbcRTKeJjnzGplNwTAXdg12eSesi9OYp2x5EeUIwy53yEfmcJrWC5in70xjzBgsynIDvLMX/OSL35GWcH7CCiJj+GAIoS59UJun1PN/sYZSM5/Bejr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPFHLCgu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPFHLCgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767605471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EO6pUILQau0Fr+bTTUGYHii/2inumz/dnQo6yzDsF8k=;
	b=EPFHLCgud/8WWlIozbwwLMP0tan/UXpUQeml2NFjmOIeIUhT8QKyX9209R8TF//ubBb7pN
	k0zdxN1JXfbDfmLr4mgHWU4gsiyCITK3QagKFpIX8aWBKikyCqfB2SFlyFIOQwIyeWPJK3
	eqJn6aGfIxxfMzG2ok6bqSFVQdxO5Xc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-6tND9ADWMOacOLxkVm1XjA-1; Mon, 05 Jan 2026 04:31:10 -0500
X-MC-Unique: 6tND9ADWMOacOLxkVm1XjA-1
X-Mimecast-MFC-AGG-ID: 6tND9ADWMOacOLxkVm1XjA_1767605469
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37fc5e67cd4so57644651fa.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Jan 2026 01:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605469; x=1768210269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EO6pUILQau0Fr+bTTUGYHii/2inumz/dnQo6yzDsF8k=;
        b=JuiJ0sYTBt0hKHx+C2tXYn1JJ1ICa4AC5pfcxBYphSQOw/wVSry1DpWsN47Jfssj2g
         XH5yOu4WmGDr1ALeur0CQuQUX2sGF7jT43yV1Hrm9LF+WdrQy9o2ZxNv3DMEdFkuRZCp
         /Trt5qLufPvevOytN9oSXb54NLszyueP1aIt1lQJLSkOqe+A4GpT4Q0pNXbXI9kWKneX
         70TzXBX8DO4rvNeYwlnvgIaSaLORaYDj5njfsgiC9WzVUh06RzXzjnmb5sFGp6asKb71
         elYzqmeN/cb7dOmMHWm+lmQpG1BQTi5nSwvz9HGQxo3IXXlKjsTWKv950tp0fqX8JLex
         3Y2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfzroNGsujTwekkyVpDLRbRHbth1nQ6U+6cTJwgTJI2dlgTB9WVIXgjsUgr6OB8jydq96zoLeja0IN1pj2f81KGeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDiKr6jsCkt9DEoWzQH7h88jNhYXQCiJzASS7Y7KoHm6FIUd3
	i1S0cMzPMc4p2VT97o2Q8rbyIVbG9f3QGFj3Zf52xIgDjZt+RZwlfLa5VcbLMyeRehOKvbipR+X
	tpdWYiWr1IiqhLLav7LlblIqpR+9HxrZAckcCltDIXyjg4uMgZytZ3VcVrcb+KHhqX6eEmeBE80
	Du2lkrzwzq64orxGJuzWnY1snvmogmWqgfl4NTQOBbdwLCkeSN
X-Gm-Gg: AY/fxX7LU5iZIaGKtBu9gIS1svzPkTt5uBjzJoEkulPBdrwnZHrHlxKC46r6EtUSutv
	XcKYS663PXaoJxOJw148ckFCur6N8fHlg1i4TlrW2SBavvWwjY8IqqAH5N95X2DEi7Gt2jjkUPP
	jWLAHOKbAkzyBZanR3TPWyKzJrgyyPLPyOZ7RTpuvc6UJWg/uKGCgcDKQs+iGk0x1UbMWTTyCJs
	a0Emtog2PKwY6gP1kqIjYc3
X-Received: by 2002:a2e:a99f:0:b0:37b:965e:c149 with SMTP id 38308e7fff4ca-38121621639mr128014051fa.24.1767605468641;
        Mon, 05 Jan 2026 01:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr1DLvy+9EbpiOlVz5HstGmrBGbIC1maNfg3awC022XTHLPHMRlGsb3xfqjqHg6MEH2kqj4ln0MydSN6u/AJM=
X-Received: by 2002:a2e:a99f:0:b0:37b:965e:c149 with SMTP id
 38308e7fff4ca-38121621639mr128013951fa.24.1767605468135; Mon, 05 Jan 2026
 01:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112152529.956778-1-crwood@redhat.com> <20251112152529.956778-3-crwood@redhat.com>
In-Reply-To: <20251112152529.956778-3-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 5 Jan 2026 10:30:55 +0100
X-Gm-Features: AQt7F2qsXCRXa45lr7IrOJi0mMAj9_8nsMy-COlwaamxw6cSt7qwGui5xcial-0
Message-ID: <CAP4=nvRnpNKupDWCpe7EPdQ=9QJgBx0ZVZEfCTLYb5ghG+Y-_Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] tracing/osnoise: Dump stack on timerlat uret
 threshold event
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Attila Fazekas <afazekas@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nBoJiedpyxZXvLDa5ZdNRFlE71yB4DUTELExrsi6WV0_1767605469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 12. 11. 2025 v 16:25 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> na=
psal:
>
> Dump the saved IRQ stack trace regardless of whether the event was
> THREAD_CONTEXT or THREAD_URET.
>
> In the uret case, the latency presumably had not yet crossed the
> threshold at IRQ time (or else it would have dumped the stack at thread
> wakeup time, unless we're racing with a change to the threshold), but it
> may have at least contributed -- and this is possible with THREAD_CONTEXT
> as well.
>
> In any case, it helps with writing reliable rtla tests if we always get
> a stack trace on a threshold event.
>

Thank you. The omitting of dumping stack in the uret part of
timerlat_fd_read() looks like a bug to me, I don't see any reason for
it being done for thread latency but not for uret latency, especially
considering the existence of the -a option. Without the patch, -a
behaves differently with kernel and user threads - with kernel
threads, it will always dump the stack on stop tracing if possible,
but with user threads, it will only dump it if the thread latency is
over the threshold.

The help message says:

   -s/--stack us: save the stack trace at the IRQ if a thread latency
is higher than the argument in us

but just like in the case of [1], the current behavior (without the
patch) is not natural and no user is going to expect it. (Yes, the
documentation needs updating...)

Compare rtla -a behavior without the patch (auto-analysis without stack):

   $  rtla timerlat hist -a 20 --warm-up 2 -c 1
   ...
   max:          3        18        30
   timerlat hit stop tracing
   ## CPU 1 hit stop tracing, analyzing it ##
    IRQ handler delay:                                         0.00 us (0.0=
0 %)
    IRQ latency:                                               3.73 us
    Timerlat IRQ duration:                                    10.66 us (35.=
39 %)
    Blocking thread:                                           2.94 us (9.7=
7 %)
                         swapper/1:0                           2.94 us
   ------------------------------------------------------------------------
    Thread latency:                                           30.11 us (100=
%)

with the behavior with the patch (auto-analysis with stack):

   $ rtla timerlat hist -a 20 --warm-up 2 -c 1
   ...
   max:          4        19        23
   timerlat hit stop tracing
   ## CPU 1 hit stop tracing, analyzing it ##
     IRQ handler delay:                                         0.00 us (0.=
00 %)
     IRQ latency:                                               4.10 us
     Timerlat IRQ duration:                                     9.65
us (41.79 %)
     Blocking thread:                                           4.58
us (19.81 %)
                          swapper/1:0                           4.58 us
       Blocking thread stack trace
                   -> timerlat_irq
                   ...
                  -> common_startup_64
   ------------------------------------------------------------------------
     Thread latency:                                           23.11 us (10=
0%)

Tested-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>

[1] https://lore.kernel.org/linux-trace-kernel/20251006143100.137255-1-tglo=
zar@redhat.com/

Tomas

