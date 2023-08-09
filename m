Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683BC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  9 Aug 2023 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjHIPps (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 9 Aug 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjHIPpq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:45:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67422690
        for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:45:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26965d55b85so1752972a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=g2Rd9S7zT+idb4+47/ERHXouRZBGGOCRT73xhqFGwMP6fyjn+TW12P8qJf7k/gkzsZ
         qC+W+EGEm+lTfjfiAxZHImGpnz5xkd8u3O+bVyrp7enLupSgiue0ZfeOWelvCA8L2j4c
         KuDJtiR16TYtdY5pM+6ZP5azoRI4F7RwNiM3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=JXygArEXCT8GOklMd2muMa/KCP4+dhSutGAemaBiFz+VjKh4VNBY9pwfHMYAKFjapH
         wXIkhdKpQkyPzgcFiwXPNeQXZf4y/kISCrj+1aSvqppTPgvUHl/lYrR0m2m+K/DcjYjY
         d32/ESn0ysnBTRqOEgBguY9zhcmp4zFd9IisT9yOC2Y33/hEteVihBczYwwf59oFVTe6
         KkM+MQarMURkz1cNhLwdo64yNSMy2oLilCectsOL7x2gFp1oBkuK1ZR9EG28hiyIxhPm
         a2JP8bLOJsdfZfmP5zC+mq/3bV1r0xm2tXHsS2Zqy0FxVOMpJJOGNI0R1ywmVdoXoexD
         2SMQ==
X-Gm-Message-State: AOJu0Yyuy4V9HPguo/zcXmuc1WJxj/ten4eglC8TO/hPVWTa7LkcyiRp
        t4RDmtTVXb3wYD7Ysgrzcxu8qlYbRDGG/+TD11i0Kw==
X-Google-Smtp-Source: AGHT+IHBZ4kYatHyLUGoLTHddPeNNj7sZ1QQclLt+arjVPf9Gkn4NPvdYAJ+X39a6ovMtsxWY04+thZMWC7k84sDJso=
X-Received: by 2002:a17:90a:6c05:b0:268:c5c7:f7ed with SMTP id
 x5-20020a17090a6c0500b00268c5c7f7edmr2316230pjj.30.1691595940141; Wed, 09 Aug
 2023 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139093899.324433.3739544465888158332.stgit@devnote2> <CABRcYmK6X6okNKNu9ZjgLEO+JMGL42j7idE8QPZ_EpYA9S9UZQ@mail.gmail.com>
 <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
In-Reply-To: <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:45:29 +0200
Message-ID: <CABRcYmLe05UiK+-mCq5LA0d1Xomdpb+R_5A5HLBLbuBqfBCwUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fprobe: rethook: Use fprobe_regs in fprobe
 exit handler and rethook
To:     Masami Hiramatsu <mhiramat@kernel.org>
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

On Wed, Aug 9, 2023 at 4:43=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> > I think there are two things that can be meant with "rethook uses ftrac=
e_regs":
> >
> > - rethook callbacks receive a ftrace_regs (that's what you do further d=
own)
> > - rethook can hook to a traced function using a ftrace_regs (that's
> > what you use in fprobe now)
> >
> > But I think the second proposition shouldn't imply that rethook_hook
> > can _only_ hook to ftrace_regs. For the kprobe use case, I think there
> > should also be a rethook_hook_pt_regs() that operates on a pt_regs. We
> > could have a default implementation of rethook_hook that calls into
> > the other (or vice versa) on HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
> > but I think it's good to separate these two APIs
>
> Yeah, so for simplying the 2nd case, I added this dependency.
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e321bdb8b22b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>         def_bool y
>         depends on HAVE_RETHOOK
>         depends on KRETPROBES
> +       depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRAC=
E_WITH_ARGS
>         select RETHOOK
>
> This is the point why I said that "do not remove kretprobe trampoline".
> If there is arch dependent kretprobe trampoline, kretprobe does not use
> the rethook for hooking return. And eventually I would like to remove
> kretprobe itself (replace it with fprobe + rethook). If so, I don't want
> to pay more efforts on this part, and keep kretprobe on rethook as it is.

What are your thoughts on kprobe + rethook though ?

If that's something you think is worth having, then in this case, it
seems that having a rethook_hook_pt_regs() API would help users.

If that's a frankenstein use case you don't want to support then I
agree we can live without this API and get away with the cast
protected by the depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS...
