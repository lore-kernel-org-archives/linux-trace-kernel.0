Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7CEC04A6A
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  9 Aug 2023 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjHIPxg (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 9 Aug 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjHIPxf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:53:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF11BD9
        for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:53:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-56518bb1552so23612a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691596414; x=1692201214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIwKDuY4Cird/U1Q4TEwDWgypIViAxxEznjv74enuWE=;
        b=YK0mzmoUhg1/WVZtS6i8IvR/ir3WbY3Rml52xGJOadNilW86RJYMM2B1S9qtS+mNV8
         02EqKkCgXbRPt5+IpTJAr2MJn/YLBb3P2HkVGUczy/s7EtkXYOCUyVH57NhCvoeG9/Ck
         +xY9zswP8Z/VRCt3kljF3dnGZyZi8QXKvdLrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596414; x=1692201214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIwKDuY4Cird/U1Q4TEwDWgypIViAxxEznjv74enuWE=;
        b=hO0WnXGcJlDgy7ZXlrgxd5GzxZRNxmA5Uo3kUlxjpJNNTOCTFJcjjI8pKqV7nvem3N
         zU5oV46ISwjrFlil1bTOsekad3fHU+9GGb7rLSm5HzVvLtw3JdEnFv+3SdJuCJj6/ozy
         EYYItrPD1j3gk/7uQv3wW1TM6/dLnUaCUxxNAUU8+ntZSuK1HnlngQyK37hJbEkDfPfh
         AbZYCPaCTlCvXDLhTNey9p3S0bl418AJG7kuPc619P1s9EA3ZHK2Ihvqnx/knvpG+QFS
         xolzy7kk4xo7qtsAHe26zRu77Uskf46eGvBzOOftxACyeubG1fsXgL+tCItHMV2YZtD4
         D5Bg==
X-Gm-Message-State: AOJu0Ywo3t8p3dLpn+dFizd0YT1IkfPib0t+wnWRyg8BNyZIickJZYaE
        qwfaT2/jS0C6f/tjUPdZtBUAEOE6MwHDg/+jK3eefg==
X-Google-Smtp-Source: AGHT+IEt0SjbBNE/0A3+xFiamsHpiZ+DozfqOsjQmlYXrs6lu/425svIyeL6FcV0FsKSoHWBUid1vMOwONcyHbRTk8I=
X-Received: by 2002:a17:90b:2281:b0:269:621e:a673 with SMTP id
 kx1-20020a17090b228100b00269621ea673mr2333395pjb.1.1691596414341; Wed, 09 Aug
 2023 08:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139092722.324433.16681957760325391475.stgit@devnote2> <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
 <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
In-Reply-To: <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:53:23 +0200
Message-ID: <CABRcYmJGPLAA+HKFA0CZkEZJ0j5GvXBDDAVA7i8Wv5PDMvYQrA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
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

On Wed, Aug 9, 2023 at 4:16=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 9 Aug 2023 12:29:13 +0200
> Florent Revest <revest@chromium.org> wrote:
> > > + * tracer, define the default(pt_regs compatible) ftrace_regs.
> > > + */
> > > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFI=
G_FUNCTION_TRACER)
> >
> > I wonder if we should make things simpler with:
> >
> > #if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTIO=
N_TRACER)
> >
> > And remove the ftrace_regs definitions that are copy-pastes of this
> > block in arch specific headers. Then we can enforce in a single point
> > that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.
>
> Here, the "HAVE_PT_REGS_COMPAT_FTRACE_REGS" does not mean that the
> ftrace_regs is completely compatible with pt_regs, but on the memory
> it wraps struct pt_regs (thus we can just cast the type).

But in practice I think that all architectures that chose to wrap a
pt_regs in their ftrace_regs also do:

+#define ftrace_regs_get_instruction_pointer(fregs) \
+       instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+       regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+       kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+       regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+       regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+       override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+       regs_query_register_offset(name)

And are just careful to populate the fields that let these macros
work. So maybe these could be factorized... But anyway, I'm not
particularly a super fan of the idea and I don't think it should
necessarily fit in that series. It's just something that crossed my
mind, if you're not a fan then we should probably not do it ;)
