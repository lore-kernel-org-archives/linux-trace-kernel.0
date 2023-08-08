Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ADC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  8 Aug 2023 17:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjHHRvV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHHRu4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:50:56 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D5CB4F32
        for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:22:47 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-447805165e9so2250227137.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691511748; x=1692116548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=WOVCk7gZhtAMiedeD2DiyLHxTneqOaK9lQCwmkhs/xVsUHc8FstRDuVU/iYIV5tMNU
         O+vetapoO3PVYzj1AS91/rcg4WCkNCobfeEb6dMurAQz45rFoX0NDKKgxOyu5kdTK5bt
         GWb1OD0Mjc3Qv/SSn241MmHn/1jTcFrJAeWwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511748; x=1692116548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=V94xX8vewAZx0iHNjMcyylPdMEkkcQxMhZiFR59haptWOw20b+fxGQQzrwhgyUGJ6T
         yjKP3HBdS5FB+X8JBb9lTVNaFE6Qy1acMcNNMBKeoUliB1DXZtrgCwyfrNVm7y5UgO0n
         pYNokm+CQBcF4yK8L8LxTGdur363qtT6sPo8+GzgucRnQXPXaKV5kWJb7gcNcON8mvSS
         QYHncVdDcAbHISsKga/L3UlDdIzpy3ZGJZCA9TAprEBTOE0ToiLmhyZ7aJ972PxgAj26
         zOAEP00ZOoJWFluiOP94zrLSKS2NYtIwQSkiuGsk5uvOSjV17n+9z7wSUUZ7ZmZnYyWc
         wfLA==
X-Gm-Message-State: AOJu0Yw3xeYXvDrk2cpmeQDw93OHz/8sxFwIm1IppgQpg72XVmPt7W18
        Qf9tC4R9wsAiOwYiginmTio8cyoFB+8xqD7ICisz1rFPKN1+QoV4VQk=
X-Google-Smtp-Source: AGHT+IGwh0ywunatAy5MeeHk5SP91VnhUNy/5ce/vmlO7FYlLbSHZH+fvMcUcYsWZGLmPuJjjJUiwXexkRhSyiHdIdI=
X-Received: by 2002:a17:90a:d50d:b0:268:ee6:6bdf with SMTP id
 t13-20020a17090ad50d00b002680ee66bdfmr9968391pju.47.1691504978388; Tue, 08
 Aug 2023 07:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 8 Aug 2023 16:29:27 +0200
Message-ID: <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs instead
 of pt_regs
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

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Florent, feel free to add your rethook for arm64, but please do not remov=
e
> kretprobe trampoline yet. It is another discussion point. We may be possi=
ble
> to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
> allows nest probe. (maybe we can skip that case?)

Ack :)

>  arch/Kconfig                    |    1 +
>  arch/arm64/include/asm/ftrace.h |   11 ++++++
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |    9 +++--
>  include/linux/fprobe.h          |    4 +-
>  include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
>  include/linux/rethook.h         |   11 +++---
>  kernel/kprobes.c                |    9 ++++-
>  kernel/trace/Kconfig            |    9 ++++-
>  kernel/trace/bpf_trace.c        |   14 +++++--
>  kernel/trace/fprobe.c           |    8 ++--
>  kernel/trace/rethook.c          |   16 ++++----
>  kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------=
------
>  kernel/trace/trace_probe_tmpl.h |    2 +
>  lib/test_fprobe.c               |   10 +++--
>  samples/fprobe/fprobe_example.c |    4 +-

I believe that Documentation/trace/fprobe.rst should also be modified
following the API change
