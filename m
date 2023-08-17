Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F707C2FC0E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349151AbjHQI55 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349157AbjHQI51 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49761273C
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26d1a17ce06so258506a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=Vv30KtUNN9X3DCyhblLuDc+5QN4WH17sIufZ4s2NysSZxDPAObOK+RQyUycSz2de/P
         +5sbf5cr3N9siROdEc+KFYHwsvRTeWt/wpORXfGzN3xt6SAxiaiMDS1az3ZVhLt3Ccii
         eHYiAasnpVcYWg5gJFYzO1+AjlDV8bzyQ2Vu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=D36rJ5Nlhdm+4vDmARVoHygkTKAMxy8vL3H3n/z6XwuZ99VupqOsL4LmOJsFyiFcwP
         lyt3VE19kiXyXiDD8Lgs0gqFm790SE3ZiHWHs9rVoo7IpqDoQ+HtMtsdjynNjanz3BPI
         zkIDMdoYHTX68gsJkpBxWSk6cVDQ5fAucWvvXrg1aLQaV7o+2WNKZfegNxwInsShUckp
         jo84nVpQk7ZqImlfjFRl00AH4LoAZ95omm9hoBkq83MzVbGjCszARHm1rwqAFYHH0Dto
         CZr8Y46BNf6xbM41ZuZbG1tlI0nGKmPZ/d3+kxwu3TrT1ah9wdQkS1GKh5U1VKyMdyBi
         qj7g==
X-Gm-Message-State: AOJu0Yynso2jljaDC4DnglC69LZR0V1U+A+w7YzO9mOZgI03LbteWgom
        2lq44xaWRHjwxndFEAniOQkhxmRioqKn8Jy4N9XwGJryNOpc1e3C
X-Google-Smtp-Source: AGHT+IH6xIW34cUhfbm6uS4lGucin/ng4/m/ryyfJico4mCTUTYGDYajeDn/M+ly4sI6E4iuomTaVqg6vaPiGhO2ztA=
X-Received: by 2002:a17:90a:d34a:b0:269:3498:3bad with SMTP id
 i10-20020a17090ad34a00b0026934983badmr3496202pjx.14.1692262644742; Thu, 17
 Aug 2023 01:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:13 +0200
Message-ID: <CABRcYmJLbb0_fs2beiNA2QE468JkxB9nHnmQcQW4dt63pPBoFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
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

On Sat, Aug 12, 2023 at 7:36=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 3rd version of RFC series to use ftrace_regs instead of pt_re=
gs.
> The previous version is here;
>
> https://lore.kernel.org/all/169139090386.324433.6412259486776991296.stgit=
@devnote2/
>
> This also includes the generic part and minimum modifications of arch
> dependent code. (e.g. not including rethook for arm64.)

I think that one aspect that's missing from the discussion (and maybe
the series) so far is plans to actually save partial registers in the
existing rethook trampolines.

For now the series makes everything called by the rethook trampolines
handle the possibility of having a sparse ftrace_regs but the rethook
trampolines still save full ftrace_regs. I think that to rip the full
benefits of this series, we should have the rethook trampolines save
the equivalent ftrace_regs as the light "args" version of the ftrace
trampoline.
