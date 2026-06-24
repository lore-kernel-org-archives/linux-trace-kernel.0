Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E01E0DE8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318018; cv=pass; b=YvfklJiPH5x0uOAIvnMS8x5XyNCn11/bMo2Z4ktNqSjYDmAfuuR1tpmYObwYlco3FrZwcu9NNoYr+11rFXRq9LFQ0AcMtvBKb5gJ6JVofwSu/VsBocu9VXWFQ4J0XJQW5uWOAb3O3GS40qxJr2wc0NXXnLBWO8pIiI1zUHBd8as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318018; c=relaxed/simple;
	bh=7+HGRSlqdJih01JQxz7CwJB9/dPv62GeW0YZ8I0HIHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4U1rdd5za5ede7ZY27SvR577QCrgTNiLHwkPZUbdwCCPQLsEFeTjK6bFHbbcbL+XwBVi1HAYQaaX1r1WylaStlSh05szvoT+1wSGzUpEicLTMZH8O9gFHVkzSl77isxq+rX9cjYl5FOTZslinia4H4v6s2Jktcu0a49sC+MIhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR4GBgjD; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR4GBgjD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c0efc7ef797so199939266b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 09:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782318015; cv=none;
        d=google.com; s=arc-20240605;
        b=TEYPuc7qNurohiwhNoI7K3hsWyRgfzXo8lbZIFPJd7am9xPPhfG32UnW6vwIaY/b6q
         uOsKE5YQQOrn7K2tTmgKR2CU5cX1wpmyTFDQgSsGcBl2mepR/5H9FNHw80r56uJAw9kz
         q8yoporDGRQP/A79tuRMyifRtp83YX9knE4hE0S5pgfUjQTFOeqclmjpx4EiVC/q3qgQ
         sTgxpctUxga5lNBZL256mL0NOPe19sr6mErJx259vab6XNjFEUMYYObIlcd43GE+oKmH
         TOPIMCIKdzHor6EZWi5Wo/exP+fx5Q6xj02KGiAlUuhJ46DlKdvg/A8gGdwWM7nkqMO7
         Nqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVGyAcMAXdtqbouju9WLTO44dp8GYbeQwRe+PfNn/GI=;
        fh=9QpvErHFwrcTq71X74uX0Gfs1azFpuP+WADZObX6zi8=;
        b=i4HqBHMdnw5DTgDAj9pDEjOzbwZNadzn5KlsYeKP9H/+zmkDgourYgxOBC2EalbGPu
         rYaj/avGmbSiKljlCINrnBKLJDCCWpZM8lGJX1M4VVt8o1pIxc3nTXQnHjlL91A8KotI
         2AFy0t6itNP501AMzq0nWjYDQ7P3hzGh0FC6TP+8obxQ8el/KVDzSUyLEIIDe5GbWhXw
         f4Nx2sOsEdbVOmo9YdG9bdgiOlxZt/ylv6iO+x3rg2fju+crZux1jCWKoJmp033fPi9t
         4o/UHRhWI/Oo4YXPkfNeG4BxwGtpAXuoMb3Xszd6UJur28w4cv6pF/3mOE7imkaXSdXv
         CQBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782318015; x=1782922815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVGyAcMAXdtqbouju9WLTO44dp8GYbeQwRe+PfNn/GI=;
        b=lR4GBgjDwybabn38Fj5OK3S+ujhLbnbyCsUjKNRUeUYVyo6s3BB+kkB/xPD5Be1VgD
         o7FOpdcK7lctdY9x/8tnp/zM3h659pd15AMKDTATvNUygGs6isRmpImXb+CaFVg6BcBW
         VzV2fEe4jcJ3eLtbh1P/pnb5SSmL25Wb2UcCzYDdBSOltMSyhU7sj18dwiCAgGC4wyV+
         yCK5Lx0RpV6L8kWgTLu5lMRCbkZyGVxdrkIji5qfFQ9Lzxt0dWUXKieN0sf+CSIAomvF
         8HZKnXxHRVmPod8kX/u4NdXTckOCx2pODgzPKsrDbcIufb31fiHXw5bI3x1nT8ya6sra
         IucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318015; x=1782922815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVGyAcMAXdtqbouju9WLTO44dp8GYbeQwRe+PfNn/GI=;
        b=Lc3ScjVJjl2z+Voi5WwCTt5rt9NtIftdYhwa4QPl7xPpD5q/h0O2J1GGL9e7U/6VY+
         CPqpFaNUPOyDxsPXzewNsglFSUC1jdcTDwctDrgQLucTEVPFvzFsgfuUO9Jg2ne0WYe6
         m3d/u+KpPm/tzDux/CAN3WfSzbVYF3D7XkTZmKR9kg+Tbm3qRAvXRlu/9Gx0DeK904Qa
         nnIwU5S5eXAQ4mVAxn7ECUe+NIAo+OtEbJg2l9GKQXtGXBlf+PPCYRctbmyMeUD5opYG
         L3aYzLk5jzAxsVNaexLqC4jL67NCxK/E4FHMQWOj0kLI8+Rm/3GLv4MfF0AxMAG+IM3n
         TVpA==
X-Forwarded-Encrypted: i=1; AFNElJ9/8yKWvvc28EfBbSa+u1pahcbbZPuKrEEh1l/Lyq3wwaKRcn3rqQWPU0Zf+ppGUEWJ3W0k7GJSN3CFmwaJ4aO9juA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ96pk3CzzSKGn09IFtYAlEP9tFjAItYynp2QQORR7qyv1o0GI
	ZIJ0FHxW7OB0XrG/Egi2Vdmi21trT0QpYLivMfizvJrfMrq8u6YuxMqqFLr5L1Y+xUVtREbarbs
	MWqZO5NGU85EGYCKabqSREKak/107kLQ=
X-Gm-Gg: AfdE7clhEKhK57mD9+b6A8LeRvqcZ3PKJ8mAg/UVmSCiahsdWoD5D00x44wBjCTG/aJ
	lrmAYGSzXuqBKwG0TUslOfAL5QxTI26ryZuxfFWqYtCHQR7zZdLwH60FbJqgzYKGrVNW+9ZWjVT
	8KYkVyNp1QwjqPaVNaunpUnmflma/dy2jOiCZhkwTiO5woGtnhZCFin2Da17Z4SA8+LIQQZgcyr
	4xq7PtRolit0OL/nqIdfcRBeVAmDzx3iXBrTSee2G4JXn373caGr3Pxy4ZK9+jxFLWYmjpxZ8Ix
	U91/kORBJM+X
X-Received: by 2002:a17:907:cf8c:b0:c03:6cf3:9d68 with SMTP id
 a640c23a62f3a-c119d55cdf4mr256081866b.15.1782318014542; Wed, 24 Jun 2026
 09:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417231203.785172-1-puranjay@kernel.org> <20260417231203.785172-8-puranjay@kernel.org>
 <aiA1JwbwCI1Z4GG9@localhost.localdomain>
In-Reply-To: <aiA1JwbwCI1Z4GG9@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 24 Jun 2026 17:20:00 +0100
X-Gm-Features: AVVi8CfRmWC9TKvARuv1ZykoMkpovN7-YrJ7i0v3GpWSqr9-oPHnZ0QdkLgXeic
Message-ID: <CANk7y0jxYOfx6c=YGx9eEjA8Ttyaq6vkv-SsmhK-z9PC1HTJAg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/10] rcu: Wake NOCB rcuog kthreads on expedited
 grace period completion
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

Sorry for the late reply.

I have sent another version addressing all your comments:
https://lore.kernel.org/all/20260624132356.516959-1-puranjay@kernel.org/

Thanks,
Puranjay

On Wed, Jun 3, 2026 at 3:07=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Fri, Apr 17, 2026 at 04:11:55PM -0700, Puranjay Mohan a =C3=A9crit :
> > When an expedited grace period completes, rcu_exp_wait_wake() wakes
> > waiters on rnp->exp_wq[] but does not notify NOCB rcuog kthreads.  Thes=
e
> > kthreads may be sleeping waiting for a grace period to complete.
> > Without this wakeup, callbacks on offloaded CPUs that could benefit fro=
m
> > the expedited GP must wait until the rcuog kthread wakes for some other
> > reason (e.g., next normal GP completion or a timer).
> >
> > Add rcu_exp_wake_nocb() which wakes rcuog kthreads for leaf-node CPUs,
> > deduplicating via rdp->nocb_gp_rdp since multiple CPUs share one rcuog
> > kthread.  Uses for_each_leaf_node_possible_cpu() because offline CPUs
> > can have pending callbacks. The function is defined in tree_nocb.h with
> > an empty stub for CONFIG_RCU_NOCB_CPU=3Dn builds.
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/rcu/tree.h      |  1 +
> >  kernel/rcu/tree_exp.h  |  1 +
> >  kernel/rcu/tree_nocb.h | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 7dfc57e9adb1..40f778453591 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -500,6 +500,7 @@ static struct swait_queue_head *rcu_nocb_gp_get(str=
uct rcu_node *rnp);
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> >  static void rcu_init_one_nocb(struct rcu_node *rnp);
> >  static bool wake_nocb_gp(struct rcu_data *rdp);
> > +static void rcu_exp_wake_nocb(struct rcu_node *rnp);
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_hea=
d *rhp,
> >                                 unsigned long j, bool lazy);
> >  static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 82cada459e5d..0df1009c6e97 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -708,6 +708,7 @@ static void rcu_exp_wait_wake(unsigned long s)
> >               }
> >               smp_mb(); /* All above changes before wakeup. */
> >               wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
> > +             rcu_exp_wake_nocb(rnp);
> >       }
> >       trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
> >       mutex_unlock(&rcu_state.exp_wake_mutex);
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 7462cd5e2507..f37ee56d62a9 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -190,6 +190,31 @@ static void rcu_init_one_nocb(struct rcu_node *rnp=
)
> >       init_swait_queue_head(&rnp->nocb_gp_wq[1]);
> >  }
> >
> > +/*
> > + * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advanc=
e
> > + * callbacks that were waiting for the just-completed expedited GP.
> > + * Deduplicate via nocb_gp_rdp since multiple CPUs share one rcuog
> > + * kthread.  Use for_each_leaf_node_possible_cpu() because offline CPU=
s
> > + * may have pending callbacks.
> > + */
> > +static void rcu_exp_wake_nocb(struct rcu_node *rnp)
>
> Please consolidate the naming to match rcu_nocb_gp_cleanup().
>
> > +{
> > +     struct rcu_data *last_rdp_gp =3D NULL;
> > +     int cpu;
> > +
> > +     if (!rcu_is_leaf_node(rnp))
> > +             return;
> > +
> > +     for_each_leaf_node_possible_cpu(rnp, cpu) {
> > +             struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> > +
> > +             if (rdp->nocb_gp_rdp =3D=3D last_rdp_gp)
> > +                     continue;
> > +             last_rdp_gp =3D rdp->nocb_gp_rdp;
> > +             wake_nocb_gp(rdp);
> > +     }
>
> There are two waitqueues for rcuog wake-ups:
>
> 1) rdp->rdp_gp->nocb_gp_wq: to wait for callbacks on the queue
> 2) rnp->nocb_gp_wq: to wait for grace periods
>
> So you're waking up the wrong one.
>
> Something like the below? (untested)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0e43866dc4cd..436e12e313c2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2193,8 +2193,13 @@ static noinline void rcu_gp_cleanup(void)
>                         dump_blkd_tasks(rnp, 10);
>                 WARN_ON_ONCE(rnp->qsmask);
>                 WRITE_ONCE(rnp->gp_seq, new_gp_seq);
> -               if (!rnp->parent)
> -                       smp_mb(); // Order against failing poll_state_syn=
chronize_rcu_full().
> +               if (!rnp->parent) {
> +                       /*
> +                        * Order against failing poll_state_synchronize_r=
cu_full().
> +                        * and also rcu_nocb_cleanup_wake() -> swait_acti=
ve()
> +                        */
> +                       smp_mb();
> +               }
>                 rdp =3D this_cpu_ptr(&rcu_data);
>                 if (rnp =3D=3D rdp->mynode)
>                         needgp =3D __note_gp_changes(rnp, rdp) || needgp;
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 40f778453591..8f272cb4e4f3 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -253,7 +253,7 @@ struct rcu_data {
>         u8 nocb_gp_sleep;               /* Is the nocb GP thread asleep? =
*/
>         u8 nocb_gp_bypass;              /* Found a bypass on last scan? *=
/
>         u8 nocb_gp_gp;                  /* GP to wait for on last scan? *=
/
> -       unsigned long nocb_gp_seq;      /*  If so, ->gp_seq to wait for. =
*/
> +       struct rcu_gp_oldstate nocb_gp_seq; /*  If so, ->gp_seq to wait f=
or. */
>         unsigned long nocb_gp_loops;    /* # passes through wait code. */
>         struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep=
 on. */
>         bool nocb_cb_sleep;             /* Is the nocb CB thread asleep? =
*/
> @@ -498,9 +498,9 @@ static bool rcu_preempt_need_deferred_qs(struct task_=
struct *t);
>  static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> +static void rcu_nocb_exp_cleanup(struct rcu_node *rnp);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool wake_nocb_gp(struct rcu_data *rdp);
> -static void rcu_exp_wake_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head =
*rhp,
>                                   unsigned long j, bool lazy);
>  static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 0df1009c6e97..43c167a8a145 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -708,7 +708,8 @@ static void rcu_exp_wait_wake(unsigned long s)
>                 }
>                 smp_mb(); /* All above changes before wakeup. */
>                 wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
> -               rcu_exp_wake_nocb(rnp);
> +               if (rcu_is_leaf_node(rnp))
> +                       rcu_nocb_exp_cleanup(rnp);
>         }
>         trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
>         mutex_unlock(&rcu_state.exp_wake_mutex);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f37ee56d62a9..60d4182b9509 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -170,13 +170,59 @@ static void rcu_lockdep_assert_cblist_protected(str=
uct rcu_data *rdp)
>                 lockdep_assert_held(&rdp->nocb_lock);
>  }
>
> +static void rcu_nocb_cleanup_wake(struct swait_queue_head *sq)
> +{
> +       if (swait_active(sq))
> +               swake_up_all(sq);
> +}
> +
>  /*
>   * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
>   * grace period.
>   */
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
>  {
> -       swake_up_all(sq);
> +       /*
> +        * swait active() can be checked first because:
> +        *
> +        * rcu_gp_cleanup()                              nocb_gp_wait()
> +        * ---------------                               --------------
> +        * WRITE_ONCE(root->gp_seq, new_gp_seq);         swait_event_inte=
rruptible_exclusive(sq)
> +        * smp_mb()                                         prepare_to_sw=
ait()
> +        * if swait_active(sq)                                 list_add_t=
ail(&wait->task_list, &q->task_list);
> +        *    swake_up_all(sq)                                 set_curren=
t_state()
> +        *                                                       smp_mb()
> +        *                                                  if (poll_stat=
e_synchronize_rcu_full())
> +        *                                                     if (rcu_se=
q_done_exact(&root->gp_seq, rgosp->rgos_norm))
> +        *                                                        ...
> +        */
> +       rcu_nocb_cleanup_wake(sq);
> +}
> +
> +/*
> + * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
> + * callbacks that were waiting for the just-completed expedited GP.
> + * Wake-up waitqueues for both even and odd GP numbers because exp and
> + * normal sequences don't match.
> + */
> +static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
> +{
> +/*
> + * swait active() can be checked first because:
> + *
> + * rcu_exp_wait_wake()                           nocb_gp_wait()
> + * ---------------                               --------------
> + * rcu_seq_end(&rcu_state.expedited_sequence);   swait_event_interruptib=
le_exclusive(sq)
> + * smp_mb()                                         prepare_to_swait()
> + * if swait_active(sq)                                 list_add_tail(&wa=
it->task_list, &q->task_list);
> + *    swake_up_all(sq)                                 set_current_state=
()
> + *                                                        smp_mb()
> + *                                                  if (poll_state_synch=
ronize_rcu_full())
> + *                                                     if (rcu_seq_done_=
exact(&rcu_state.expedited_sequence, rgosp->rgos_exp))
> + *                                                        ...
> + */
> +       rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[0]);
> +       rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[1]);
>  }
>
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
> @@ -190,31 +236,6 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>         init_swait_queue_head(&rnp->nocb_gp_wq[1]);
>  }
>
> -/*
> - * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
> - * callbacks that were waiting for the just-completed expedited GP.
> - * Deduplicate via nocb_gp_rdp since multiple CPUs share one rcuog
> - * kthread.  Use for_each_leaf_node_possible_cpu() because offline CPUs
> - * may have pending callbacks.
> - */
> -static void rcu_exp_wake_nocb(struct rcu_node *rnp)
> -{
> -       struct rcu_data *last_rdp_gp =3D NULL;
> -       int cpu;
> -
> -       if (!rcu_is_leaf_node(rnp))
> -               return;
> -
> -       for_each_leaf_node_possible_cpu(rnp, cpu) {
> -               struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> -
> -               if (rdp->nocb_gp_rdp =3D=3D last_rdp_gp)
> -                       continue;
> -               last_rdp_gp =3D rdp->nocb_gp_rdp;
> -               wake_nocb_gp(rdp);
> -       }
> -}
> -
>  /* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). =
*/
>  static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
>  {
> @@ -684,7 +705,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
>         bool bypass =3D false;
>         int __maybe_unused cpu =3D my_rdp->cpu;
> -       struct rcu_gp_oldstate cur_gp_seq_full;
> +       struct rcu_gp_oldstate wait_gp_seq =3D {0}; //remove uninitialize=
d warning
>         unsigned long flags;
>         bool gotcbs =3D false;
>         unsigned long j =3D jiffies;
> @@ -694,7 +715,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>         bool needwake_gp;
>         struct rcu_data *rdp, *rdp_toggling =3D NULL;
>         struct rcu_node *rnp;
> -       unsigned long wait_gp_seq =3D 0; // Suppress "use uninitialized" =
warning.
>         bool wasempty =3D false;
>
>         /*
> @@ -718,6 +738,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>          * won't be ignored for long.
>          */
>         list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) =
{
> +               struct rcu_gp_oldstate cur_gp_seq;
>                 long bypass_ncbs;
>                 bool flush_bypass =3D false;
>                 long lazy_ncbs;
> @@ -755,8 +776,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                 needwake_gp =3D false;
>                 if (!rcu_segcblist_restempty(&rdp->cblist,
>                                              RCU_NEXT_READY_TAIL) ||
> -                   (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full)=
 &&
> -                    poll_state_synchronize_rcu_full(&cur_gp_seq_full))) =
{
> +                   (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> +                    poll_state_synchronize_rcu_full(&cur_gp_seq))) {
>                         raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
>                         needwake_gp =3D rcu_advance_cbs(rnp, rdp);
>                         wasempty =3D rcu_segcblist_restempty(&rdp->cblist=
,
> @@ -777,11 +798,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                  * numbers from rcu_accelerate_cbs() inside
>                  * rcu_advance_cbs() and will be handled on the next pass=
.
>                  */
> -               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) =
&&
> -                   !poll_state_synchronize_rcu_full(&cur_gp_seq_full)) {
> +               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> +                   !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
> +                       if (!needwait_gp ||
> +                           ULONG_CMP_LT(cur_gp_seq.rgos_norm, wait_gp_se=
q.rgos_norm))
> +                               wait_gp_seq.rgos_norm =3D cur_gp_seq.rgos=
_norm;
>                         if (!needwait_gp ||
> -                           ULONG_CMP_LT(cur_gp_seq_full.rgos_norm, wait_=
gp_seq))
> -                               wait_gp_seq =3D cur_gp_seq_full.rgos_norm=
;
> +                           ULONG_CMP_LT(cur_gp_seq.rgos_exp, wait_gp_seq=
.rgos_exp))
> +                               wait_gp_seq.rgos_exp =3D cur_gp_seq.rgos_=
exp;
> +
>                         needwait_gp =3D true;
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                             TPS("NeedWaitGP"));
> @@ -803,7 +828,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>
>         my_rdp->nocb_gp_bypass =3D bypass;
>         my_rdp->nocb_gp_gp =3D needwait_gp;
> -       my_rdp->nocb_gp_seq =3D needwait_gp ? wait_gp_seq : 0;
> +       if (needwait_gp)
> +               my_rdp->nocb_gp_seq =3D wait_gp_seq;
>
>         // At least one child with non-empty ->nocb_bypass, so set
>         // timer in order to avoid stranding its callbacks.
> @@ -838,12 +864,12 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                 nocb_gp_sleep(my_rdp, cpu);
>         } else {
>                 rnp =3D my_rdp->mynode;
> -               trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWai=
t"));
> +               trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.rgos_norm, TPS=
("StartWait"));
>                 swait_event_interruptible_exclusive(
> -                       rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
> -                       rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
> +                       rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq.rgos_norm=
) & 0x1],
> +                       poll_state_synchronize_rcu_full(&wait_gp_seq) ||
>                         !READ_ONCE(my_rdp->nocb_gp_sleep));
> -               trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"=
));
> +               trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.rgos_norm, TPS=
("EndWait"));
>         }
>
>         if (!rcu_nocb_poll) {
> @@ -877,7 +903,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                 swake_up_one(&rdp_toggling->nocb_state_wq);
>         }
>
> -       my_rdp->nocb_gp_seq =3D -1;
> +       my_rdp->nocb_gp_seq.rgos_norm =3D -1;
> +       my_rdp->nocb_gp_seq.rgos_exp =3D -1;
>         WARN_ON(signal_pending(current));
>  }
>
> @@ -1561,7 +1588,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data =
*rdp)
>  {
>         struct rcu_node *rnp =3D rdp->mynode;
>
> -       pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c=
 CPU %d%s\n",
> +       pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld/%ld rnp %d:%d %l=
u %c CPU %d%s\n",
>                 rdp->cpu,
>                 "kK"[!!rdp->nocb_gp_kthread],
>                 "lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
> @@ -1573,7 +1600,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data =
*rdp)
>                 ".W"[swait_active(&rnp->nocb_gp_wq[1])],
>                 ".B"[!!rdp->nocb_gp_bypass],
>                 ".G"[!!rdp->nocb_gp_gp],
> -               (long)rdp->nocb_gp_seq,
> +               (long)rdp->nocb_gp_seq.rgos_norm,
> +               (long)rdp->nocb_gp_seq.rgos_exp,
>                 rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
>                 rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kt=
hread) : '.',
>                 rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread=
) : -1,
> @@ -1684,16 +1712,16 @@ static void rcu_nocb_gp_cleanup(struct swait_queu=
e_head *sq)
>  {
>  }
>
> -static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
> +static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
>  {
> -       return NULL;
>  }
>
> -static void rcu_init_one_nocb(struct rcu_node *rnp)
> +static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
>  {
> +       return NULL;
>  }
>
> -static void rcu_exp_wake_nocb(struct rcu_node *rnp)
> +static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>
