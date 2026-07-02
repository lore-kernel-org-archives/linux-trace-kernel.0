Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5042B31F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982245; cv=none; b=aETzBld9p6gTJh+hLRyO2m8AoEipoS5joTJGHJKJfrf+6HuJ0yY+vbGCfehEyGHZoZMnqOe5Q9LoBPRSmdR5Xoywk7vWbMYk/ijfca12SCa4Sk7NS3vTmSsonDDDgs9NBYuV/l0veyMq+b7optXgvEwMY/pyBsVhZh1mKlH0sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982245; c=relaxed/simple;
	bh=TVyHDjq3n9BaQsZt6d9MNUiOV3MOGfdZqQUNZLARX1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHUhk4FKf8Gpv2lUyLf9BhYMgLG0D4259qPUvoBY0n7ctq/6DB2SmxDxARMV4mkN631asUaBTYv8MK1VH5A2XNcF0lM7qJ5A+/29QRhnBRXirbqVBS/b2+e0s2m4KCuA6a6XdqzwoF77U7QNeX/QM6wKRZ6Nbuv/kVz355ufy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bdc96b0714so792902e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 01:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982242; x=1783587042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYA90lXyBEl28iS+9Msp9HKhMvzT25VUpA92377UjxA=;
        b=OxgHyHWobodHnQKpCKpF1Wuwc2Ch7APGidcZG+CXQC/B+2AnmZsRXCEvMBEe0x8dZL
         gBYRIZrtHkvhV9ythMetfoXPeWMKmxXxmM7Z5IJymsmq5SI5xv4xe+wA5Vk4Xfm12GPI
         ZOUVF5W4y2SkKdCmLmjGFJ5zRGjz1UV5a0QkMObfNJmHAlbaGAzGuLdF4aZtSq+Kd+aK
         uiZ5TiBSwU9rKX7ztFLe2scx5MnQmiDoyyCQIhStDJxffzCyoxp+DMsSoo5rkj8YMYSU
         8BJlB9KueTUCeEPabcAeC01GEc/k+xbtvEwmbsYnedQhs3sByYDyFf677R6R2wSoufO4
         6YIA==
X-Forwarded-Encrypted: i=1; AHgh+RpC+/UgLQDJZBK/lfEr6OvZZYEvLnhvVVtfjFfyVrVs1PLn98jAXsD3ZGpD6qULmEjZXRRg6RcyGs6KhKzcbVCMUpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bHEmSJwmbfFW46fxEbHj0YZ7UZthAP7TSn8m8Gep+2xFvioP
	21PUZzrYg9Xk+YQF6QZuoJgBxMKRzcE4oAfOXViL3TulzTFgjiITNSggVYs/pHdUQKQ=
X-Gm-Gg: AfdE7cltErMCtU0EN4bR9p5PwMvZpKJM5PlG6mA30Pw+5umiZRAH1F88H8nQ76g5nYn
	8YA+bnmv1TWVf6gEK0AgSqJO4LkbC47C5GFreh+lpqrPCk81Z5QqJ81lXDYj1wt7sQRfOoanOHS
	DsIbd9CTNOwzJp8T8X5SdezGBpNifaF9iMZtoED5EKETK0nlb0LjH61Vcyt6EjHatfXTVuHjpiH
	FM17scTNhTtraJalSVLMn5kBViYQc+LBMn5NA+xYM08rQoGvfBsKfMgh6gbaX2nyARrfGXSKoow
	7gIEHRSaDP25PyQdYoZV2+oXlvlw1iP3nyke31Ff1GqJG2eO27+fvdxxalUa/v/kbHiXfw2qPN6
	0vKHTb6ejMpv1i/8/ic7Pd4bg+eDDJii2hD03ScXWC7yOT1kQYbowJeverM2gUWUhQHYP8dUNCD
	LAXT9w0aS/zFiMtRS3tjzShqx/sTLn2jODL1TpVPkzLxQZrWdnTA==
X-Received: by 2002:a05:6122:3786:b0:5bb:d233:70bd with SMTP id 71dfb90a1353d-5bddf516321mr2392873e0c.2.1782982241911;
        Thu, 02 Jul 2026 01:50:41 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdec77b3eesm607759e0c.9.2026.07.02.01.50.41
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:50:41 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-96358d0a024so1200385241.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 01:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplMMS4cNRDzmzVh3CwE5w4FVOPd5Fz9rRfvBJSH3ePB/JHCCJS6Spz8hJUxjGR+vLQE52PtDBunWfm6NS7o1EQmKM=@vger.kernel.org
X-Received: by 2002:a05:6102:370c:b0:738:b13a:c81b with SMTP id
 ada2fe7eead31-73da862da3amr2544496137.7.1782982240811; Thu, 02 Jul 2026
 01:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701132744.6a7fc68b@robin>
In-Reply-To: <20260701132744.6a7fc68b@robin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Jul 2026 10:50:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVO1FgspBK4ZhMeubfRi2VPeJLnfRLG+Ar9d-YpNw0QNQ@mail.gmail.com>
X-Gm-Features: AVVi8CdfeDss_PqFlSChXxT9AJqiyqb27FDmjhqZTPLHrHWtYw20XH3C1NZsznk
Message-ID: <CAMuHMdVO1FgspBK4ZhMeubfRi2VPeJLnfRLG+Ar9d-YpNw0QNQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add a no-rcu-check version of trace_##event##_enabled()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Carlier <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Jul 2026 at 19:27, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Tracepoints require that RCU is watching. To prevent them from being used
> in places that RCU is not watching, the trace_##event() macro always
> calls rcu_is_watching() even when the event is not enabled and warns if
> RCU is not watching. This is to make sure a warning is triggered even if
> the tracepoint is never enabled (as it is only a bug when it is).
>
> It was noticed that tracepoints could be hidden within
> trace_#event#_enabled() calls, which are used to do extra work for the
> tracepoint only if the tracepoint is enabled. But this also can hide the
> fact that a tracepoint is placed in a location that can be called when RCU
> is not watching.
>
> Commit 9764e731ef6ab ("tracepoint: Add lockdep rcu_is_watching() check to
> trace_##name##_enabled()") added a check to the trace_##event##_enabled()
> macro to make sure RCU is watching when it is called to make sure not to
> hide the bug of a tracepoint being called when RCU is not watching.
>
> There is one case in the irq_disable tracepoint where it is within a
> trace_irq_disable_enabled() block, but it checks if RCU is watching, and
> if it isn't, it makes a call to ct_irq_enter() that makes RCU watch again.
> But because trace_irq_disable_enabled() now checks if RCU is watching and
> will trigger if it isn't. This is a false warning as the code within
> the block handles this case.
>
> Add a new internal macro __trace_##event##_enabled() that doesn't check if
> RCU is watching, and convert the irq_enable/disable tracepoints over to
> it.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdXud_RpWag_hFqa2ByBGRxg6KnxGL1ObCWZrpTsk3TfAw@mail.gmail.com/
> Fixes: 9764e731ef6ab ("tracepoint: Add lockdep rcu_is_watching() check to trace_##name##_enabled()")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Thanks, warning gone on all affected platforms.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
