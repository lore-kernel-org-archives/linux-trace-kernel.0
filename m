Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E155C2FC14
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349160AbjHQI55 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349189AbjHQI5i (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A262D4A
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565e93f80f1so1801019a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=HJi/DlthHTk4VrLUlzPyhRI7bxeadkjObc5oNJKYFy9eYWno7RTr7MkHbC7AqqRrQy
         WIf23ddt+p8PwFW92IqOejdVm01tJw2gdu54JH9Q2z1EuuuNF7KoqL9bYtfHq+DR/Lg4
         NV6asjA8HFr/zxWH2ZacRMwaJ9YlT5KSrj8mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=ZAv1YpDRovzkrWuPcCVOdUP2Apu5M3/qHiCq0GsUTSny6l9FkZr2KwdCwYep2HT1PC
         IYVm88gN9m35+62C8TCpN0IEqa3+MGUjeqTdbBldZEazBVMgGhqrftcp09TC1jQ5+9mM
         bGvYEBZNatYoBE9ScBykCAd52Obw9wy6VRJ0N8cuAQf3ZxDhqlJ3xN5Ll28i6xpqsran
         0jKg5vQFhiysjf/vLZNQjL7Ng/feESG/GfAL5dtuwaEk9u8rbWkMtEK/QezT8P/4yU7L
         oOy82zjutvAjNbmnj0mZneALKMgvKsEuZ1/tAss83AUAaEhvKEhg2+uUg89/BI1a1Xln
         Fdpw==
X-Gm-Message-State: AOJu0YwfrG2T9D4n5QYCxpH37HNtqXYfiXSxs8RJ00wwxktbRuEqBOrE
        /mPC8n5uxnefEPjhA6EghUpu/XoeXfIWGqzdHWO6BA==
X-Google-Smtp-Source: AGHT+IHvsMZnwwNnaI1QyczKPAq0kpcZmxmcPZ8yv+5Kpilk9edjm2psrQLXI4TMLyfn8Fm/yzzYV0A8bXR9NKZIihk=
X-Received: by 2002:a17:90a:c086:b0:269:1e3f:a54d with SMTP id
 o6-20020a17090ac08600b002691e3fa54dmr3685525pjs.10.1692262657084; Thu, 17 Aug
 2023 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181861911.505132.8322840504168319403.stgit@devnote2>
In-Reply-To: <169181861911.505132.8322840504168319403.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:26 +0200
Message-ID: <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>
> -#ifdef CONFIG_FPROBE
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Shouldn't this be #if defined(CONFIG_FPROBE) &&
defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) ?

I believe one could build a kernel with FTRACE_WITH_REGS and without
FPROBE and then this code would have undefined references to fprobe
functions, wouldn't it ?

And then patch 7 should be "Enable kprobe_multi feature even if
FTRACE_WITH_REGS is disabled"
