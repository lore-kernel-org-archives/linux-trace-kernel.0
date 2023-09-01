Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360D0CA0FE1
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 06:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjIAGSw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 1 Sep 2023 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjIAGSw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A391
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:18:04 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-tEbdxz8NNyujic8afw2ZIg-1; Fri, 01 Sep 2023 02:18:02 -0400
X-MC-Unique: tEbdxz8NNyujic8afw2ZIg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4136ec108ecso17287651cf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549082; x=1694153882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCoHUy21Y+HIbtl00/+o/mR3wL3CsEO4zSXXLcm78Tg=;
        b=bKEES/GUuNhzvOHqoywF7zJVvsueQ6ob417TprA9Eb93jZYHZnd7mP79epS+SKvJib
         Nz/DtZE62LUGd0MXByg5u+3bPqxSAEv3OyjeNbwRuHsJ37i9KRw181BErbz1Eeds8m/8
         G3es3IA1EZN89gmq9Mxsl4QWq7En6jIoGyOhGBB/RjWH6AKjeSCT9o+NGzkpRT9ZtcNg
         UIL3hVBUrxnDeVVN7Td2aacYvIMLDdg/QyAljv3nbbmzDkowkUaaxgv03whgywLnbubq
         KXRtRYHk407gZYCxV9WHAio3Hp3/LTfLsxycPdtpoomRJmtIcfzYpCxivrZ0bTqsNBuX
         stEw==
X-Gm-Message-State: AOJu0Ywktro2J7HDu+nZAGtvVu2awg3CQcbRWDpH/TrtALTv6Rk/m2OW
        Qwo8WenwFX1JEEqPYzeyywlQjt3M1JLCAsVsenQHoGZcUAruq8cbHcRGqVXKmIu5WrRf19dXGvN
        pRFLnp8mP6V0AGAIO2LUBuT6FcrYQTzD8l6/7etTmD40tGTaD
X-Received: by 2002:ac8:7d56:0:b0:412:1e4c:e858 with SMTP id h22-20020ac87d56000000b004121e4ce858mr1914052qtb.36.1693549082435;
        Thu, 31 Aug 2023 23:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF8Qj0L34On7VCvINdaprG6njP7EEdfXIQ5lwObVY15Tfc/HZL0XMnvJG3rnOKeETsZkTiyUuElX2TEmOia18=
X-Received: by 2002:ac8:7d56:0:b0:412:1e4c:e858 with SMTP id
 h22-20020ac87d56000000b004121e4ce858mr1914039qtb.36.1693549082189; Thu, 31
 Aug 2023 23:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230831063129.335425-1-leobras@redhat.com> <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
In-Reply-To: <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 1 Sep 2023 03:17:50 -0300
Message-ID: <CAJ6HWG6y=mRPJrGbx0YYYepz4zVORL3cb_=3J+CcfHUQ5rUr+g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
To:     Guo Ren <guoren@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 3:58 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 31, 2023 at 2:31 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > call_single_data_t is a size-aligned typedef of struct __call_single_data.
> >
> > This alignment is desirable in order to have smp_call_function*() avoid
> > bouncing an extra cacheline in case of an unaligned csd, given this
> > would hurt performance.
> >
> > Since the removal of struct request->csd in commit 660e802c76c8
> > ("blk-mq: use percpu csd to remote complete instead of per-rq csd") there
> > are no current users of smp_call_function*() with unaligned csd.
> >
> > Change every 'struct __call_single_data' function parameter to
> > 'call_single_data_t', so we have warnings if any new code tries to
> > introduce an smp_call_function*() call with unaligned csd.
> I agree to prevent __call_single_data usage.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks for reviewing!


>
> /*
>  * structure shares (partial) layout with struct irq_work
>  */
> struct __call_single_data {
>         struct __call_single_node node;
>         smp_call_func_t func;
>         void *info;
> };
>
> #define CSD_INIT(_func, _info) \
>         (struct __call_single_data){ .func = (_func), .info = (_info), }
>
> /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
> typedef struct __call_single_data call_single_data_t
>         __aligned(sizeof(struct __call_single_data));
>
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  include/linux/smp.h        |  2 +-
> >  include/trace/events/csd.h |  8 ++++----
> >  kernel/smp.c               | 26 +++++++++++++-------------
> >  kernel/up.c                |  2 +-
> >  4 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > index 91ea4a67f8ca..e87520dc2959 100644
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
> >  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
> >                            void *info, bool wait, const struct cpumask *mask);
> >
> > -int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd);
> >
> >  /*
> >   * Cpus stopping functions in panic. All have default weak definitions.
> > diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
> > index 67e9d01f80c2..58cc83b99c34 100644
> > --- a/include/trace/events/csd.h
> > +++ b/include/trace/events/csd.h
> > @@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
> >         TP_PROTO(const unsigned int cpu,
> >                 unsigned long callsite,
> >                 smp_call_func_t func,
> > -               struct __call_single_data *csd),
> > +               call_single_data_t *csd),
> >
> >         TP_ARGS(cpu, callsite, func, csd),
> >
> > @@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
> >   */
> >  DECLARE_EVENT_CLASS(csd_function,
> >
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >
> >         TP_ARGS(func, csd),
> >
> > @@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
> >  );
> >
> >  DEFINE_EVENT(csd_function, csd_function_entry,
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >         TP_ARGS(func, csd)
> >  );
> >
> >  DEFINE_EVENT(csd_function, csd_function_exit,
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >         TP_ARGS(func, csd)
> >  );
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 8455a53465af..8c714583786b 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -127,7 +127,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
> >  }
> >
> >  static __always_inline void
> > -csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
> > +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
> >  {
> >         trace_csd_function_entry(func, csd);
> >         func(info);
> > @@ -174,7 +174,7 @@ module_param(csd_lock_timeout, ulong, 0444);
> >  static atomic_t csd_bug_count = ATOMIC_INIT(0);
> >
> >  /* Record current CSD work for current CPU, NULL to erase. */
> > -static void __csd_lock_record(struct __call_single_data *csd)
> > +static void __csd_lock_record(call_single_data_t *csd)
> >  {
> >         if (!csd) {
> >                 smp_mb(); /* NULL cur_csd after unlock. */
> > @@ -189,13 +189,13 @@ static void __csd_lock_record(struct __call_single_data *csd)
> >                   /* Or before unlock, as the case may be. */
> >  }
> >
> > -static __always_inline void csd_lock_record(struct __call_single_data *csd)
> > +static __always_inline void csd_lock_record(call_single_data_t *csd)
> >  {
> >         if (static_branch_unlikely(&csdlock_debug_enabled))
> >                 __csd_lock_record(csd);
> >  }
> >
> > -static int csd_lock_wait_getcpu(struct __call_single_data *csd)
> > +static int csd_lock_wait_getcpu(call_single_data_t *csd)
> >  {
> >         unsigned int csd_type;
> >
> > @@ -210,7 +210,7 @@ static int csd_lock_wait_getcpu(struct __call_single_data *csd)
> >   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> >   * so waiting on other types gets much less information.
> >   */
> > -static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
> > +static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> >  {
> >         int cpu = -1;
> >         int cpux;
> > @@ -276,7 +276,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >   * previous function call. For multi-cpu calls its even more interesting
> >   * as we'll have to ensure no other cpu is observing our csd.
> >   */
> > -static void __csd_lock_wait(struct __call_single_data *csd)
> > +static void __csd_lock_wait(call_single_data_t *csd)
> >  {
> >         int bug_id = 0;
> >         u64 ts0, ts1;
> > @@ -290,7 +290,7 @@ static void __csd_lock_wait(struct __call_single_data *csd)
> >         smp_acquire__after_ctrl_dep();
> >  }
> >
> > -static __always_inline void csd_lock_wait(struct __call_single_data *csd)
> > +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> >  {
> >         if (static_branch_unlikely(&csdlock_debug_enabled)) {
> >                 __csd_lock_wait(csd);
> > @@ -300,17 +300,17 @@ static __always_inline void csd_lock_wait(struct __call_single_data *csd)
> >         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
> >  }
> >  #else
> > -static void csd_lock_record(struct __call_single_data *csd)
> > +static void csd_lock_record(call_single_data_t *csd)
> >  {
> >  }
> >
> > -static __always_inline void csd_lock_wait(struct __call_single_data *csd)
> > +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> >  {
> >         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
> >  }
> >  #endif
> >
> > -static __always_inline void csd_lock(struct __call_single_data *csd)
> > +static __always_inline void csd_lock(call_single_data_t *csd)
> >  {
> >         csd_lock_wait(csd);
> >         csd->node.u_flags |= CSD_FLAG_LOCK;
> > @@ -323,7 +323,7 @@ static __always_inline void csd_lock(struct __call_single_data *csd)
> >         smp_wmb();
> >  }
> >
> > -static __always_inline void csd_unlock(struct __call_single_data *csd)
> > +static __always_inline void csd_unlock(call_single_data_t *csd)
> >  {
> >         WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
> >
> > @@ -376,7 +376,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
> >   * for execution on the given CPU. data must already have
> >   * ->func, ->info, and ->flags set.
> >   */
> > -static int generic_exec_single(int cpu, struct __call_single_data *csd)
> > +static int generic_exec_single(int cpu, call_single_data_t *csd)
> >  {
> >         if (cpu == smp_processor_id()) {
> >                 smp_call_func_t func = csd->func;
> > @@ -667,7 +667,7 @@ EXPORT_SYMBOL(smp_call_function_single);
> >   *
> >   * Return: %0 on success or negative errno value on error
> >   */
> > -int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
> >  {
> >         int err = 0;
> >
> > diff --git a/kernel/up.c b/kernel/up.c
> > index a38b8b095251..df50828cc2f0 100644
> > --- a/kernel/up.c
> > +++ b/kernel/up.c
> > @@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
> >  }
> >  EXPORT_SYMBOL(smp_call_function_single);
> >
> > -int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
> >  {
> >         unsigned long flags;
> >
> > --
> > 2.42.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>

