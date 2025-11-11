Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BE342537
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868865; cv=none; b=i208ukJQz/8OEqELBfU7HXBayR0PJ0Y2ZkOGT8iylAPhGJsUf2fttYkqBGm113hXCY9scVZ4Pwlog0hzcTcKz/H2CO7QzINg8SIDwrr/tRaGsblC5IfI+odnbHcxszvBtVAZP8WSr6Mt1LDWuP9oPyljE5EEOpOk9w/jQC04bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868865; c=relaxed/simple;
	bh=haChyGDwKRZ9L+wSPxgovAlg+vrVWqA+m8tlPgoIgUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChlJtXo25sm/tOMibSAvq5w5Prjf2vTK3Aho+zc+DxoE8oE8vdv4nMKZN5BAujh2n1smnfhZW2nXhPG516S29/siBUyyC3S+fx64rHnStArIEVUvMMX5sV3e+FHbJufXLbF52PINkLhWK0PulHcdcq6eOYLPm5KY4ANltv1+8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA8pv61W; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA8pv61W"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so22882a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868861; x=1763473661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBzO+mXtLSjzlqpu0X8GUg0PfYd6eR/HUmvEOL2AIZg=;
        b=PA8pv61WO1KTmC/IsRvGQr339IuAy+aOlkmSMgfBHL0yiSSvlMBD1nujD8OouWNOw7
         Tyzg2Xbrai46SR3zjpujLAOiuAS268pxffmvRMEWSnXBdUAfy180FplJm3lutS1KiezA
         gpj3RKfbR7ttYWBzGJQICky78Kb6an0SCt+i5yibSfn+IhlwTTgCqjJDzXGw09COys2M
         PtmkSswJeWixM2NY4AZq0yZQjTY9z3gdW60FkNwsLlSVFpkEvVBDvXoL7pvtDMV78DJ0
         J0LmsSLci9G41VPTXDUMQ2I0ZurIKYJNnpDp1q9/yQAjnHkJDt48BJvm83skccFg/b+W
         /LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868861; x=1763473661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBzO+mXtLSjzlqpu0X8GUg0PfYd6eR/HUmvEOL2AIZg=;
        b=R4CrgvUPWSMCAfT2VB+X2i2uYkFWFU1FTUjmRDq+x6BHDEWxbrD8X1yHTYcyc/rvpq
         deSeOAImq3ntJoP10tVZm53cb8F2oGtRVfMC7zoW/drIi7nA1qUbobBmG+oGoTH51DB7
         InM0oAQFmptXkAui09KV+6x7n/xJA9vbEf+iEnSn9tPYePQo02znbgAV5c5Ho1QVLHYu
         RDtWxv7YRtcQhcBDV+EXuBJc+f0yTx0ftmPSL0UACVe8gCtVuWYtNSegai6Od7AzEg4n
         8fCFtT2As4MLDfgAsm1IcFZ1gVIS4eGhKADG3G+ZqkNxDQNheJWgGaKRGWsJYCM30xT3
         KRRA==
X-Forwarded-Encrypted: i=1; AJvYcCVgSS15roM5QNNTZvnff1d16r/v3k1oXSaigArePbScgglJJ+aKu8YSCVSbAjT2Qg1aeMzRwLiTWJCHReGq45dWYTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nL4mNTh+oNQCOn8ywwG47p+sauLo7UCVrmYj3XqZpCJ3JXQl
	ktNCfrrCuVH73fxmgOIqQbDiOVkCU4mDrZ/eU2j16LaOIqPeASNaqw8ZzyQZjuLQ1Z/g3UE9rHc
	KGKZdywssg6Oey5Gh6dy1KmszGdpnjHg=
X-Gm-Gg: ASbGncunjXPcrefYwgnQE/StBEkoUMLxx8MDus3QWu3h1dUGlvRfwdKZ7eyVX67G29o
	WSP7hm8fQrRKnSLBP0Xs5OJQXAOC9f7nlO+3B+kny3LRpsnZWg6yLieTtprYAPhDSlar8stggZt
	Db+5aeeVlduhCGk68jFC9XXTAdnja4N0EJNDf1/Fk36OK7dsMAN8nMlsr2dWoY/srorfbDo76fa
	fVowYXw8nnQdmvXg3EVjV4Ey0gp0Qoqb6O8QnldPqrW6n8KkcfyEBrQ5I5BRw==
X-Google-Smtp-Source: AGHT+IFP0FuqM0yhKHSoBdPjP97vvll1I7DWDIDzF8bj+ZIcWBz1zQIEqx5YwoSccS6mBD4f8xI5cM+023m9whJuzpo=
X-Received: by 2002:a17:907:7203:b0:b70:b661:cfcb with SMTP id
 a640c23a62f3a-b72e0410257mr1371826066b.31.1762868861200; Tue, 11 Nov 2025
 05:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011164156.3678012-1-dolinux.peng@gmail.com> <20251110154337.774db22f@gandalf.local.home>
In-Reply-To: <20251110154337.774db22f@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 11 Nov 2025 21:47:29 +0800
X-Gm-Features: AWmQ_bmmgh4pGUV55tc_XDOjeHyzORXKIv19acRME2IKux_0Vl_lB60OtcS1XOI
Message-ID: <CAErzpmtjuq7nrrLPd=Av3p_5TzWD8HwEU1FMNmYZxiBgfZRaFQ@mail.gmail.com>
Subject: Re: [PATCH] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 12 Oct 2025 00:41:56 +0800
> pengdonglin <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
>
> Sorry for the late reply. I finally got around to looking at this.
>
> >
> > Currently, funcgraph-args and funcgraph-retaddr cannot be used together=
. This patch
> > resolves the conflict by having funcgraph-retaddr reuse the implementat=
ion of
> > funcgraph-args -- specifically, storing the return address in the last =
entry of the
> > args array.
> >
> > As a result, both features now coexist seamlessly and function as inten=
ded.
> >
> > To verify the change, use perf to trace vfs_write with both options ena=
bled:
> >
> >  # perf_6_17 ftrace -G vfs_write --graph-opts args,retaddr
> >  ......
> >  0)               |  down_read(sem=3D0xffff8880100bea78) { /* <-n_tty_w=
rite+0xa3/0x540 */
> >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
> >  0)   0.079 us    |    preempt_count_add(val=3D1); /* <-down_read+0x3b/=
0x160 */
> >  0)   0.077 us    |    preempt_count_sub(val=3D1); /* <-down_read+0x8b/=
0x160 */
> >  0)   0.754 us    |  }
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> > ---
> >  include/linux/ftrace.h               |  11 --
> >  kernel/trace/trace.h                 |   7 --
> >  kernel/trace/trace_entries.h         |  29 +-----
> >  kernel/trace/trace_functions_graph.c | 148 +++++++++++----------------
> >  kernel/trace/trace_selftest.c        |   1 -
> >  5 files changed, 58 insertions(+), 138 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 7ded7df6e9b5..88cb54d73bdb 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
> >       int depth;
> >  } __packed;
> >
> > -/*
> > - * Structure that defines an entry function trace with retaddr.
> > - * It's already packed but the attribute "packed" is needed
> > - * to remove extra padding at the end.
> > - */
> > -struct fgraph_retaddr_ent {
> > -     unsigned long func; /* Current function */
> > -     int depth;
> > -     unsigned long retaddr;  /* Return address */
> > -} __packed;
>
> I really like the clean up, but unfortunately, this breaks user space.
>
> We still need the retaddr event, as that is what user space expects.
>
> That said, this could do the same thing as the func-args. That is, it can
> add the function arguments after the retaddr field.

Thanks, will do in v2.

Thanks,
Donglin

>
> >       TRACE_GRAPH_RET,
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index a7f4b9a47a71..b618b6a673b7 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -16,6 +16,12 @@
> >  #include "trace.h"
> >  #include "trace_output.h"
> >
> > +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > +#define  STORE_RETADDR  1
> > +#else
> > +#define  STORE_RETADDR  0
> > +#endif
> > +
> >  /* When set, irq functions will be ignored */
> >  static int ftrace_graph_skip_irqs;
> >
> > @@ -29,19 +35,17 @@ struct fgraph_cpu_data {
> >
> >  struct fgraph_ent_args {
> >       struct ftrace_graph_ent_entry   ent;
> > -     /* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entrie=
s */
> > -     unsigned long                   args[FTRACE_REGS_MAX_ARGS];
> > +     /* Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS+STORE=
_RETADDR) entries,
> > +      * and the last entry is used to store the retaddr
> > +      */
> > +     unsigned long                   args[FTRACE_REGS_MAX_ARGS + STORE=
_RETADDR];
>
> I'm thinking, if it is a different event, then it can still use the same
> array. But retaddr will be first, and not last.

Thanks, will do in v2.

Thanks,
Donglin

>
> >  };
> >
> >  struct fgraph_data {
> >       struct fgraph_cpu_data __percpu *cpu_data;
> >
> >       /* Place to preserve last processed entry. */
> > -     union {
> > -             struct fgraph_ent_args          ent;
> > -             /* TODO allow retaddr to have args */
> > -             struct fgraph_retaddr_ent_entry rent;
> > -     };
> > +     struct fgraph_ent_args          ent;
>
> Where this could still be the same.
>
> >       struct ftrace_graph_ret_entry   ret;
> >       int                             failed;
> >       int                             cpu;
> > @@ -127,11 +131,19 @@ static int __graph_entry(struct trace_array *tr, =
struct ftrace_graph_ent *trace,
> >       struct ring_buffer_event *event;
> >       struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> >       struct ftrace_graph_ent_entry *entry;
> > +     unsigned long retaddr =3D 0;
> >       int size;
> > +     int i =3D 0;
> >
> >       /* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words =
*/
> >       size =3D sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeo=
f(long));
> >
> > +     if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> > +         tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > +             retaddr =3D ftrace_graph_top_ret_addr(current);
> > +             size +=3D sizeof(long);
> > +     }
> > +
> >       event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size=
, trace_ctx);
> >       if (!event)
> >               return 0;
> > @@ -141,11 +153,17 @@ static int __graph_entry(struct trace_array *tr, =
struct ftrace_graph_ent *trace,
> >
> >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> >       if (fregs) {
> > -             for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > +             for (; i < FTRACE_REGS_MAX_ARGS; i++)
> >                       entry->args[i] =3D ftrace_regs_get_argument(fregs=
, i);
> >       }
> >  #endif
> >
> > +     /*
> > +      * Store retaddr to [0] if fregs is NULL, else to [FTRACE_REGS_MA=
X_ARGS]
> > +      */
> > +     if (retaddr)
> > +             entry->args[i] =3D retaddr;
> > +
>
> Move this up before the args.

Thanks, will do in v2.

Thanks,
Donglin

>
> >       trace_buffer_unlock_commit_nostack(buffer, event);
> >
> >       return 1;
> > @@ -158,38 +176,6 @@ int __trace_graph_entry(struct trace_array *tr,
> >       return __graph_entry(tr, trace, trace_ctx, NULL);
> >  }
> >
> > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > -                             struct ftrace_graph_ent *trace,
> > -                             unsigned int trace_ctx,
> > -                             unsigned long retaddr)
> > -{
> > -     struct ring_buffer_event *event;
> > -     struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> > -     struct fgraph_retaddr_ent_entry *entry;
> > -
> > -     event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_E=
NT,
> > -                                       sizeof(*entry), trace_ctx);
>
> The reserve would need to use TRACE_GRAPH_RETADDR_ENT if retaddr is set.
> But I still think you can consolidate the code.
>
> -- Steve
>
> > -     if (!event)
> > -             return 0;
> > -     entry   =3D ring_buffer_event_data(event);
> > -     entry->graph_ent.func =3D trace->func;
> > -     entry->graph_ent.depth =3D trace->depth;
> > -     entry->graph_ent.retaddr =3D retaddr;
> > -     trace_buffer_unlock_commit_nostack(buffer, event);
> > -
> > -     return 1;
> > -}
> > -#else
> > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > -                             struct ftrace_graph_ent *trace,
> > -                             unsigned int trace_ctx,
> > -                             unsigned long retaddr)
> > -{
> > -     return 1;
> > -}
> > -#endif
> > -
> >  static inline int ftrace_graph_ignore_irqs(void)
> >  {
> >       if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT=
))
