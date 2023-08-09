Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98436C001B0
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  9 Aug 2023 15:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjHIPjS (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 9 Aug 2023 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjHIPjD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:39:03 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC92D73
        for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:38:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56ca4d7079aso4810641eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=dZcu+9OCCvDLKeSC8+efZ2t+vflJAufUebNBSxKiPMXcivRTCQnANXkWc+eUMIOfP5
         niV3udOO9xEsykqD1etTNR21tWhoh0SdlANcSTLtFgIor0e+TCSi4toemI4fNBG24Tcs
         mm9be/Lb7kIaAwrSUVBkeEXK+XV7nwreJY1i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=ERo+nC+a0nIOk+8QI/+3Vn7rNh3EwuTrgedKoQb2OtfMo9vbDn9eRwR46Pnu/sU9Jm
         x92rybf74CmbukAaWV9VP4ZMJux5wybl5bRVFlFFGdaAHanc8Z5KBwc+VsQiU+6EXKjF
         hRsvJVHfZg4Ti7Ct//Ms2Z9zgn4P4HOdHqVI3lBpkL3M+i8+MoQdhuc0YQsS1lKFB3NK
         RNN7cuSlX/QQ/NWci2bfXxrjUy+IPYDWUcZEktPmnWY1QpDBaOwxxKHrd53dpBybrMYx
         OJZjSNQj/+biuRzbeBjpWME2CXXtBapRWa73FU8pZrmAIsvDT+RiGxN7Q86YJn3t7gJN
         NOsw==
X-Gm-Message-State: AOJu0YyL4Rbr7tkfJ6LtPCXfYjZkLLy7ila4IJwH/Lh4L3eungbm6+tR
        W6r5HE5hwLNHzT0XNoNbp7SNTZ1mAxpPktdb8I116w==
X-Google-Smtp-Source: AGHT+IH+aYrEIoM4XMzeEh0db0LKZFpFauBuv8UFazpm8vaS77/zQP9gsRXuMtjL++12niCEpG3Eo4HXLokCZLkpirY=
X-Received: by 2002:a05:6808:23c7:b0:3a7:8e1b:9d65 with SMTP id
 bq7-20020a05680823c700b003a78e1b9d65mr3596640oib.47.1691595491693; Wed, 09
 Aug 2023 08:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139095066.324433.15514499924371317690.stgit@devnote2> <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
 <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
In-Reply-To: <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:38:00 +0200
Message-ID: <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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

On Wed, Aug 9, 2023 at 4:45=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -132,25 +132,30 @@ static int
> > >  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > >                    void *base)
> > >  {
> > > -       struct pt_regs *regs =3D rec;
> > > -       unsigned long val;
> > > +       struct ftrace_regs *fregs =3D rec;
> > > +       unsigned long val, *stackp;
> > >         int ret;
> > >
> > >  retry:
> > >         /* 1st stage: get value from context */
> > >         switch (code->op) {
> > >         case FETCH_OP_STACK:
> > > -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> > > +               stackp =3D (unsigned long *)ftrace_regs_get_stack_poi=
nter(fregs);
> > > +               if (((unsigned long)(stackp + code->param) & ~(THREAD=
_SIZE - 1)) =3D=3D
> > > +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> >
> > Maybe it'd be worth extracting a local
> > "ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
> > "ftrace_regs_within_kernel_stack" ?
>
> Yeah, maybe we can make it a generic inline function in linux/ftrace.h.

Or even just above this function if there are low chances it would get
used elsewhere :)
