Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C5FC0015E
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  9 Aug 2023 10:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHIKbk (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 9 Aug 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjHIKbj (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:31:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C561BDA
        for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:31:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-267f8f36a3cso3748494a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691577099; x=1692181899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrsBW/bweVeFGqbEFObsS1CtKLg/RluEI+jdzyDd8LM=;
        b=kp02DhCnBxtJNEdhc8TGr3zPEgGJBqMF/pETbjcWuL0nXrjP+kKw0BOzXHRxFwcyAM
         Vq8Hq5ZfzKbUUdWMo1HU5Fcs0/p6L5bWv0QDn/JdNjf17WFIdtpK+/8ZCMJ/+33eXRRQ
         4pxdlIMTwdRerAi8Zu921N0K3QfZVD6rf2Mg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577099; x=1692181899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrsBW/bweVeFGqbEFObsS1CtKLg/RluEI+jdzyDd8LM=;
        b=cGQY3CfbQiTjxFT9kWVWOiWKzXfC68As0RR19bsf0RO/Rpd8JQQngnvGIActJL6wrE
         gKk5tUCSe1Bc37wAsKYq29DUVEe9wO/HQ5doqe6JNtqdMG77QNvBsAl0nKV4Cu2zpYra
         m5avj/nfZF8kalXUscdafTgUhG45CAWE8qNKf+tC0cjPDGbovNip5QRdCIC4NpgmCTfx
         tv+s9WMr2z3DgntCSa1wQgAe1i9kTGD/J0MLecZW6y+mRliPangQRzxKMsYmFO1Pemau
         xORgGQCLi3zFWbmwYyuAiw/LB++i0OYjso+yqOUKQKt4/hDNsHycfRRrFqWiScchAz/p
         ayRQ==
X-Gm-Message-State: AOJu0YyUUwfO94IPSyjq7la7gcveHJXM3cuHYD3TBJSvniB0QwwNIIho
        3kz391RQGRXmMfxYhpnTS+ikIODClfQXIAaGW4YpeA==
X-Google-Smtp-Source: AGHT+IELEKsPXhWoxXahSRpjgF0fdoA/3cunXQAk8442EDq6G3fDPOSobQiaBDQ1GIXYmi9D3LoxJGNFpIcwYMYj9mI=
X-Received: by 2002:a17:90a:6fc5:b0:268:2f2:cc88 with SMTP id
 e63-20020a17090a6fc500b0026802f2cc88mr898566pjk.12.1691577098828; Wed, 09 Aug
 2023 03:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139096244.324433.7237290521765120297.stgit@devnote2>
In-Reply-To: <169139096244.324433.7237290521765120297.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 12:31:27 +0200
Message-ID: <CABRcYmLFwSrfsod6y8-K1memLUZiJeb2so6pD4XaFUpwbLD9AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] ftrace: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
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

On Mon, Aug 7, 2023 at 8:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.

ftrace_regs*

> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  include/linux/ftrace.h          |   11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftr=
ace.h
> index ab158196480c..b108cd6718cf 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_r=
egs *fregs)
>         fregs->pc =3D fregs->lr;
>  }
>
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *reg=
s)
> +{
> +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);

Are you intentionally copying that tenth value (fregs.direct_tramp)
into pt_regs.regs[9] ? This seems wrong and it looks like it will bite
us back one day. Isn't it one of these cases where we can simply use
sizeof(fregs->regs) ?

> +       regs->sp =3D fregs->sp;
> +       regs->pc =3D fregs->pc;
> +       regs->x[29] =3D fregs->fp;
> +       regs->x[30] =3D fregs->lr;
> +       return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 3fb94a1a2461..7f45654441b7 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -155,6 +155,17 @@ static __always_inline struct pt_regs *ftrace_get_re=
gs(struct ftrace_regs *fregs
>         return arch_ftrace_get_regs(fregs);
>  }
>
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +       defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
> +
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *reg=
s)
> +{
> +       return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
> +}

I don't think this works. Suppose you are on x86, WITH_ARGS, and with
HAVE_PT_REGS_COMPAT_FTRACE_REGS. If you register to ftrace without
FTRACE_OPS_FL_SAVE_REGS you will receive a ftrace_regs from the light
ftrace pre-trampoline that has a CS register equal to 0 and
arch_ftrace_get_regs will return NULL here, which should never happen.

Have you tested your series without registering as FTRACE_OPS_FL_SAVE_REGS =
?
