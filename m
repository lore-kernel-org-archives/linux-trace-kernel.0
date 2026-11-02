Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793644355;
	b=LhI+wy7iw1xuvWd5gFJkI/klaR3XFYI5VD6T6n4VPqLCO6yF2EPIIReJhg6/rbPFOfzp
	 F4oTEb8d1QnwppMQswvUeHsoL4/VGFKGMMAtw6h1GsFMxg+RPnBOQ5LAWrXI395V8G7aN
	 v9i6MFxZ6QUQUVwDFNTA5SBNV2X1R7eIt7CeyEqLyGLHJbVP+JpfTt4gsc5YjtDi5khZp
	 ZUUwdJrFTLCb1u1QpweJgRsA/hjlsnL0Zb5aQhyjxMJdUV1h/u3/Xvk4DF9nxpSEFSdyN
	 OPJgttqMWTmONOOJ0ouM4eIti+C0O3cBhfcrD9QZqFGY24dURCPAXgDH3AQmcZWo++Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nttkeTLi+DUbV3NO9jcK80KbOp2wliMENbBClfvgbfU=;
	b=KjlhYuLNuw4cFlISvt6N3pjqwEOYuI9aMSt1uV00xnRVd4E0PKyboMhjhJRnNNTr+nnY
	 LtlBI6qoSztoJgjq4Kwvd0pqOpS+Mh0Hk79U7j8VppmKybIdLfP09MjHoCb3wDU62NIRW
	 ZExToDQJX4+peYZF8zZJ4zOFWNgag+nD+StxXG3tEizUmgw7xm+RXl6MkPdOP03S618dx
	 IqS2LiTxtt9CNFRaadEu2Z0jAj7imN0Rp0wyRWACP+GgAfmI7W7xy3Oor1pt33aRhJ0Lo
	 ZeX8d3XIF6wLonPSVFPvTGMYFJqMCSaBV24+ZaLiTWfC4/GSWR7lIs8MU6VJCJAf7sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTckfEwP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C9606A326
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 18:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTckfEwP
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso508944266b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Nov 2026 10:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793644353; cv=none;
        d=google.com; s=arc-20260327;
        b=hxUkQ0pqSHnGqVwS2KwTzVtlgSPVkMHZILGFhlpF5m8bXJyLDlM7x2cVzX3gCoNb7C
         2l/xMdjSMA2VM81TC2cUYfVzF/hpQ5bpb/baI7dhOqnBm+gfMLxkefa9tMxGAS/fXGWb
         WU9fBcsMFKcYTScCo9efhreiCrL1GgiscMqVi9E7tVmeA8AvkftCvdza6zEs/i39mgXX
         O/5MpjW4RFGZUkgrU5jxvhn8nBV1P9zJEZzfy8EkAD7a0QCF+GKGfLGY+nxDfeBE1rYz
         2b4dPEtDOqScmXGHMvomVQYMlbaVwQTspLLY87UyH8jjKly3Fih9GAy4iRFYyCbxMEqj
         SE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nttkeTLi+DUbV3NO9jcK80KbOp2wliMENbBClfvgbfU=;
        fh=AHlTgTyV2mHXClZDdExT/Xt31eqbUHOy/Zv9jgvz01o=;
        b=fXi7ujySTH2QY34ik8wEyqP5HqD1lDci4gicZH1AWslBLXoAcui5RDOTTdzhxyrRcG
         6rH/HwEGRUdbhgPPl9iQvOwQ5A+qR44EvhlQ2fCX17M6e0GixTzPgiHBXKtzSbQ7+2hm
         jfeDy+MU78YIUz6hAL5swD2o3aMIjzBbots7UYf8K/E/9Ap6BldIZoyMbhYKS9n93jes
         /iL6XVOnH7g2Edo4S7eA5l17kscjN3fdoyPTrj0Gywbahz0cztPO8R3z52htL7/BxCzJ
         e+AT9yKWUsqzdtZp+HKre7v70t56ZhAhnHNzuEcmdNKyEvMKd26aCYeqzlH06GPWpUBm
         z5kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793644353; x=1794249153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nttkeTLi+DUbV3NO9jcK80KbOp2wliMENbBClfvgbfU=;
        b=aTckfEwPvbU5WirlHYTr+6JAfSTlUkOSyygxWhocwnnkphtAVlXMITaCE0TPTVvJmy
         Zy1wMkrMoIHllESdvAzwh1t1+9IjTk8nuMAD8yyDD1n7+BEfA5b+GqmOs0Le76nPGbEs
         MC2395WkimzvjwUhnZLLjMynuuxPGiNcmxuiaGX8/jd9OApJvxm4zergCD0/RrDxcjdP
         x7HXTbz1OlYGHS+Nbd4AVqKVSJGisV2nAMA9mteM+2eWbaOrHTij/wWrchpT3VAXuV7A
         Fo8GTfqxX405NPc/uMLshy5h0qOK36j2g6F8fVgsO5EIOJsC2hBESoeLbLpQFcB9HxA3
         4kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644353; x=1794249153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nttkeTLi+DUbV3NO9jcK80KbOp2wliMENbBClfvgbfU=;
        b=GZS94Q4Rb/5jyiVhrdnFpXSWd4OSyVunCGJikUbnMaWKVfS37CtoEPVyVQV4Y8YCi0
         Juu8BAB5gsUq6bgIGnpzCEi6eLRRkBtet9tnENS4r4jMXCL+oqSXjdJYG6vN+XtqJznP
         Pk2xF2leIRzEXAey2YKAWF5rNNPLs6sb/mvcp3YxPKLiXrb3AT3H+RerzI9lJNkP6FMq
         hgXczCeFiKy78q+Il+41/wcWSx55OPtClptlO3ChMH3nZFK8FNyNP4UAAKl1lLnRD7lW
         WVaztXY4UfKKjpDO6cIJQ8axTOmeUFjX7fAqhUPiSFr/XkIzNiOgE0nsrE0Syu1wRv0Y
         WuRw==
X-Forwarded-Encrypted: i=1; AKwUvBzdA3iV9XybRjPAUyQDsm3wj8doPF730nssFBfMrl8hFz0I1QFymgMvCWPRPIP3PRKKuOkOdXXaYPpsNVCceD3fw34=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JN3grfRqWUS14bODCZ4NJvC98GuhBZVw5j5+ZDoQhTHqEaSUv
	NqvYJ/ASghzOASaamF3JOCLbToUOguSo0cUc2QRFhTqJdWD4ps98ggp48angndSASX7GjVwUkGK
	gwRZR9wL8/eC7y2QyVjGiHL0dKL8xGtI=
X-Gm-Gg: AYBFou2qWF98FtQG5EviU++aYOc67nMWIkkV/G+pC5O7Lqd1Jev/r7Tx1Eeb62uzGNZ
	W9Ow7RCtpVSsN/Guj8dlQ88E6sErpCTiWboT00cSwrTqpRiiadb/of4wZNb/Ie+YWrElibiOJAh
	kv/CuLhN1+QTt6PZxdSQ4Z6tYVBbInMTlhfv/ew0qG+uJK01qp2/IgGk8ePsAvzXPDUXbijPI2E
	cYJSkxXGtUepsLp8GkwGJaoytvEcv7lkwaCukJ56d9gudaGOSDe5VYthontx5ywih5xvK9FzhqD
	Ak+ZEy/k9+Q8KWcmSn47dyYgbENa2/jL9BEpm/Zec2bJRdcmPm+NYOwBuFv+b7E2n/9bAbBYBDt
	V2FvlTJk08kDML5HVdm7i3T7qpG1U0C5rBpwvQ5uNjJfe+d8xVMJ/0Zqa+vON2DEsfhef3S8Jtf
	OmcEsQ+VIUMNtyT6Y=
X-Received: by 2002:a17:907:2d24:b0:c2d:bc33:7be3 with SMTP id
 a640c23a62f3a-c4ca7b804abmr968187666b.47.1793644352664; Mon, 02 Nov 2026
 10:32:32 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031175213.704021-1-bestswngs@gmail.com> <20261102111707.484df6f5@gandalf.local.home>
In-Reply-To: <20261102111707.484df6f5@gandalf.local.home>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 2 Nov 2026 10:31:54 -0800
X-Gm-Features: AclHuK_RS_m_JKgha0ai_vElO6Q9uMmQOpV38BwpRUYVl16bZIZB6jB5Pl8H4Yc
Message-ID: <CANgPUi1ev7Zb13Z4o=YdHY_JFf=7xXNHNVbR3KBDQ_p1rzUmZQ@mail.gmail.com>
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=80 09:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 31 Oct 2026 10:52:13 -0700
> Weiming Shi <bestswngs@gmail.com> wrote:
>
> > ftrace_shutdown_subops() unlinks a subop before rebuilding the manager
> > hashes, but leaves it enabled and managed when rebuilding or updating
> > fails. unregister_ftrace_graph() cannot recover from that partial
> > teardown, and a later registration can corrupt the empty manager state.
> >
> > Always detach and clear the subop once shutdown begins. Keep conservati=
ve
> > manager hashes behind per-subop filtering when an update fails, and dis=
able
> > direct graph dispatch until those hashes are exact again. If the last
> > manager cannot be shut down, disable ftrace and normalize its list, fla=
gs,
> > count, and hashes before the caller releases the graph operation.
>
> What exactly is the above saying? It looks like pure AI output (non human
> readable). AKA, AI slop!
>
> Is it fixing something when a subop is unregistered but fails? Where
> exactly is the failure? What failed? Have an example of what happened?
>
> Direct calls is mentioned once, but there seems to be a bit of changes fo=
r
> that too. Some of it looks like it should be a separate patch.
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: OpenAI Codex <noreply@openai.com>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/trace/fgraph.c          | 35 +++++++++++++++++----
> >  kernel/trace/ftrace.c          | 57 +++++++++++++++++++++-------------
> >  kernel/trace/ftrace_internal.h |  3 ++
> >  3 files changed, 68 insertions(+), 27 deletions(-)
> >
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index ed455b535..1a8e092ec 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1306,7 +1306,7 @@ static void ftrace_graph_enable_direct(bool enabl=
e_branch, struct fgraph_ops *go
> >
> >       static_call_update(fgraph_func, func);
> >       static_call_update(fgraph_retfunc, retfunc);
> > -     if (enable_branch)
> > +     if (enable_branch && !static_key_enabled(&fgraph_do_direct.key))
> >               static_branch_enable(&fgraph_do_direct);
>
> Ug that is horrible. If anything static_branch_enable() should handle thi=
s.
> Or we have to have another type of accounting.
>
>
> >  }
> >
> > @@ -1315,13 +1315,27 @@ static void ftrace_graph_disable_direct(bool di=
sable_branch)
> >       if (FGRAPH_NO_DIRECT)
> >               return;
> >
> > -     if (disable_branch)
> > +     if (disable_branch && static_key_enabled(&fgraph_do_direct.key))
> >               static_branch_disable(&fgraph_do_direct);
>
> Same.
>
> >       static_call_update(fgraph_func, ftrace_graph_entry_stub);
> >       static_call_update(fgraph_retfunc, ftrace_graph_ret_stub);
> >       fgraph_direct_gops =3D &fgraph_stub;
> >  }
> >
> > +void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable)
>
> What is this for? It requires a kerneldoc as it is not a static function.
>
> It also looks unrelated to the partial shutdown. Is his needed as a
> separate patch?
>
> > +{
> > +     struct fgraph_ops *gops;
> > +
> > +     if (ftrace_graph_active !=3D 1 || !(ops->flags & FTRACE_OPS_FL_GR=
APH))
> > +             return;
> > +
> > +     gops =3D container_of(ops, struct fgraph_ops, ops);
> > +     if (enable)
> > +             ftrace_graph_enable_direct(true, gops);
> > +     else
> > +             ftrace_graph_disable_direct(true);
> > +}
> > +
> >  /* The cpu_boot init_task->ret_stack will never be freed */
> >  static int fgraph_cpu_init(unsigned int cpu)
> >  {
> > @@ -1406,16 +1420,24 @@ int register_ftrace_graph(struct fgraph_ops *go=
ps)
> >       gops->ops.flags |=3D FTRACE_OPS_FL_GRAPH;
> >
> >       ret =3D ftrace_startup_subops(&graph_ops, &gops->ops, command);
> > -     if (!ret)
> > +     if (!ret) {
> >               fgraph_array[i] =3D gops;
> > +             if (ftrace_graph_active =3D=3D 1)
> > +                     ftrace_graph_enable_direct(true, gops);
> > +     }
> >
> >  error:
> >       if (ret) {
> >               ftrace_graph_active--;
> > +             gops->ops.flags &=3D ~FTRACE_OPS_FL_GRAPH;
>
> Hmm, clearing the flag looks like a separate bug that should be fixed in
> its own patch.
>
>
> >               gops->saved_func =3D NULL;
> >               fgraph_lru_release_index(i);
> > -             if (!ftrace_graph_active)
> > +             if (ftrace_graph_active =3D=3D 1) {
> > +                     ftrace_graph_enable_direct(true, NULL);
> > +             } else if (!ftrace_graph_active) {
> > +                     ftrace_graph_disable_direct(false);
> >                       unregister_pm_notifier(&ftrace_suspend_notifier);
> > +             }
>
> Nit, but I would have the above opposite. That is, don't make the current
> if statement the else, unless there's a good reason to. Because it makes
> reviewing harder.
>
>                 if (!ftrace_graph_active) {
>                         ftrace_graph_disable_direct(false);
>                         unregister_pm_notifier(&ftrace_suspend_notifier);
>                 } else if (ftrace_graph_active =3D=3D 1) {
>                         ftrace_graph_enable_direct(true, NULL);
>                 }
>
>
> >       }
> >       return ret;
> >  }
> > @@ -1423,6 +1445,7 @@ int register_ftrace_graph(struct fgraph_ops *gops=
)
> >  void unregister_ftrace_graph(struct fgraph_ops *gops)
> >  {
> >       int command =3D 0;
> > +     int ret;
> >
> >       if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
> >                     "function graph ops unregistered without registerin=
g"))
> > @@ -1447,9 +1470,9 @@ void unregister_ftrace_graph(struct fgraph_ops *g=
ops)
> >       if (!ftrace_graph_active)
> >               command =3D FTRACE_STOP_FUNC_RET;
> >
> > -     ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> > +     ret =3D ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> >
> > -     if (ftrace_graph_active =3D=3D 1)
> > +     if (ftrace_graph_active =3D=3D 1 && !ret)
> >               ftrace_graph_enable_direct(true, NULL);
> >       else if (!ftrace_graph_active)
> >               ftrace_graph_disable_direct(false);
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 673a54fdf..831f04de6 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3667,6 +3667,8 @@ static int rebuild_hashes(struct ftrace_hash **fi=
lter_hash, struct ftrace_hash *
> >       bool first =3D true;
> >       int ret;
> >
> > +     *filter_hash =3D EMPTY_HASH;
> > +     *notrace_hash =3D EMPTY_HASH;
> >       temp_hash.filter_hash =3D EMPTY_HASH;
> >       temp_hash.notrace_hash =3D EMPTY_HASH;
> >
> > @@ -3708,7 +3710,13 @@ static int rebuild_hashes(struct ftrace_hash **f=
ilter_hash, struct ftrace_hash *
> >   * will not affect functions that are being traced by other subops tha=
t
> >   * still exist in @ops.
> >   *
> > - * If the last subops is removed from @ops, then @ops is shutdown norm=
ally.
> > + * Once removal starts, @subops is detached even if rebuilding the man=
ager
> > + * hashes fails. The old manager hashes are conservative in that case =
and the
> > + * remaining subops continue to filter callbacks. If the last-manager =
shutdown
> > + * fails, ftrace is disabled before the manager state is discarded.
> > + *
> > + * Return: 0 on success or a negative error code if the manager could =
not be
> > + * updated or shut down.
> >   */
> >  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *=
subops, int command)
> >  {
> > @@ -3716,9 +3724,6 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops=
, struct ftrace_ops *subops, in
> >       struct ftrace_hash *notrace_hash =3D EMPTY_HASH;
> >       int ret;
> >
> > -     if (unlikely(ftrace_disabled))
> > -             return -ENODEV;
>
> Wait! Why this???
>
> > -
> >       if (WARN_ON_ONCE(!(subops->flags & FTRACE_OPS_FL_ENABLED)))
> >               return -EINVAL;
> >
> > @@ -3727,36 +3732,45 @@ int ftrace_shutdown_subops(struct ftrace_ops *o=
ps, struct ftrace_ops *subops, in
> >       if (list_empty(&ops->subop_list)) {
> >               /* Last one, just disable the current ops */
> >
> > -             ret =3D ftrace_shutdown(ops, command);
> > +             if (unlikely(ftrace_disabled))
> > +                     ret =3D -ENODEV;
> > +             else
> > +                     ret =3D ftrace_shutdown(ops, command);
>
> Ug no!
>
> >               if (ret < 0) {
> > -                     list_add(&subops->list, &ops->subop_list);
> > -                     return ret;
> > +                     bool enabled =3D ops->flags & FTRACE_OPS_FL_ENABL=
ED;
> > +
> > +                     FTRACE_WARN_ON_ONCE(!ftrace_disabled);
> > +                     remove_ftrace_ops(&ftrace_ops_list, ops);
> > +                     if (enabled && ftrace_start_up > 0)
> > +                             ftrace_start_up--;
> > +                     ops->flags &=3D ~(FTRACE_OPS_FL_ENABLED |
> > +                                     FTRACE_OPS_FL_ADDING |
> > +                                     FTRACE_OPS_FL_REMOVING);
> > +                     ops->func =3D ops->saved_func;
>
> Please explain the above.
>
> >               }
> >
> > -             subops->flags &=3D ~FTRACE_OPS_FL_ENABLED;
> > -
> >               free_ftrace_hash(ops->func_hash->filter_hash);
> >               free_ftrace_hash(ops->func_hash->notrace_hash);
> >               ops->func_hash->filter_hash =3D EMPTY_HASH;
> >               ops->func_hash->notrace_hash =3D EMPTY_HASH;
> > -             subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_F=
L_SUBOP);
> > -             subops->managed =3D NULL;
> > +             goto out;
> > +     }
> >
> > -             return 0;
> > +     if (unlikely(ftrace_disabled)) {
> > +             ret =3D -ENODEV;
> > +             goto out;
> >       }
> >
> >       /* Rebuild the hashes without subops */
> >       ret =3D rebuild_hashes(&filter_hash, &notrace_hash, ops);
> >       if (ret < 0)
> > -             return ret;
> > +             goto out;
> >
> >       ret =3D ftrace_update_ops(ops, filter_hash, notrace_hash);
> > -     if (ret < 0) {
> > -             list_add(&subops->list, &ops->subop_list);
> > -     } else {
> > -             subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_F=
L_SUBOP);
> > -             subops->managed =3D NULL;
> > -     }
> > +
> > +out:
> > +     subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP)=
;
> > +     subops->managed =3D NULL;
>
>
> The above is doing a lot without really explaining why.
>
> -- Steve
>
> >       free_ftrace_hash(filter_hash);
> >       free_ftrace_hash(notrace_hash);
> >       return ret;
> > @@ -3767,8 +3781,8 @@ static int ftrace_hash_move_and_update_subops(str=
uct ftrace_ops *subops,
> >                                             struct ftrace_hash *hash)
> >  {
> >       struct ftrace_ops *ops =3D subops->managed;
> > -     struct ftrace_hash *notrace_hash;
> > -     struct ftrace_hash *filter_hash;
> > +     struct ftrace_hash *notrace_hash =3D EMPTY_HASH;
> > +     struct ftrace_hash *filter_hash =3D EMPTY_HASH;
> >       struct ftrace_hash *save_hash;
> >       struct ftrace_hash *new_hash;
> >       int ret;
> > @@ -3800,6 +3814,7 @@ static int ftrace_hash_move_and_update_subops(str=
uct ftrace_ops *subops,
> >       } else {
> >               free_ftrace_hash_rcu(save_hash);
> >       }
> > +     fgraph_update_direct_func(subops, !ret);
> >       return ret;
> >  }
> >
> > diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_inter=
nal.h
> > index 3235470e6..3d5934b1c 100644
> > --- a/kernel/trace/ftrace_internal.h
> > +++ b/kernel/trace/ftrace_internal.h
> > @@ -16,6 +16,7 @@ int ftrace_startup(struct ftrace_ops *ops, int comman=
d);
> >  int ftrace_shutdown(struct ftrace_ops *ops, int command);
> >  int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *re=
gs);
> >  int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *s=
ubops, int command);
> > +/* Once started, shutdown always detaches @subops, even when it return=
s an error. */
> >  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *=
subops, int command);
> >
> >  #else /* !CONFIG_DYNAMIC_FTRACE */
> > @@ -52,6 +53,7 @@ static inline int ftrace_shutdown_subops(struct ftrac=
e_ops *ops, struct ftrace_o
> >
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  extern int ftrace_graph_active;
> > +void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable);
> >  # ifdef CONFIG_DYNAMIC_FTRACE
> >  extern void fgraph_update_pid_func(void);
> >  # else
> > @@ -59,6 +61,7 @@ static inline void fgraph_update_pid_func(void) {}
> >  # endif
> >  #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
> >  # define ftrace_graph_active 0
> > +static inline void fgraph_update_direct_func(struct ftrace_ops *ops, b=
ool enable) {}
> >  static inline void fgraph_update_pid_func(void) {}
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> >
>

Hi Steven,

Please disregard the v3 patch, as it was sent by mistake.

I am still working on a new patch. There are some issues that I am
currently investigating, and I will send an updated version once they
are resolved.

I apologize again for the confusion and for any inconvenience this may
have caused.

Best regards,
Weiming
