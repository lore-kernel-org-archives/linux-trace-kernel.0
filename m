Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4326656D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591817; cv=pass; b=QqoAuGyFa5haPMRGciqztJk4xZuRURevgPqsa82NjmiQIpa8EO9jD8Qs9opQv/BUXE7gB3VcqU9QLU5K2/r/t6IuvMyOFzNug0JiThuiIpklj5Dxe0Mehu37hckED70uejYBSgLozi0mTetoKgk4Fng87dRUyRHTHfWTYXbCtxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591817; c=relaxed/simple;
	bh=Z2JW9LIkFMXkPvHGM0Dgtv4gTXM2c3LF5UF6k5I8+HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bubT0H375B6e+sdhbTmnTA4kFpsAPm8TbKd7F1EYw9nQJVr6IjDpXT9VIFvuV033BDE3rfxpAEHi0RrZhYWT3qB/p229j3z16lYvjrxdFyEdsVrxwoa3BT/OwRsEe9iWkM10dnzVKVKWaZyHhcb/3PkV0RtFLkTFn+WLSnNUXyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKy3OKgn; arc=pass smtp.client-ip=74.125.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKy3OKgn"
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6af61a7c893so137699a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 17:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591813; cv=none;
        d=google.com; s=arc-20260327;
        b=GG67lg4AnYUEzQHxiO3KfuAOvugibITUTdrnCynZHS4nEIo+IpRZJ2s8DnYbaCX+Br
         +WYjJhHLNEoOjyf0bVkSWbBhZvL2KUC8UbK/GsUG6pvSbAsYgfTKfEeCxs0dGhLb8+xd
         eeFkz+ER8aZgphxoNNwSSd3znzYfGN7/Rrlx/FFv5IDAwduJzZfZU91pHYvpXBw2Q1q/
         vY8aalOIjijUKNgJBWfJ85chWVd6bdQkBWwxzCO3oEZ8qVSqNUVlpiEEQjnYpm1uy5Y5
         IbvZkxZ2lERYMgG4Pwi0sACFc05lnVCd51tbZS9bn/SvXgTYtw82ubftE6iLKPK3cD0M
         wdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        fh=BWQktv2USCW1kaAnT0Tmx4w0grTPkhdIN+ymY126TZg=;
        b=b1abYg7YMVdIUntDnUgeK/Z0TcaI7nGvo4zZjRRI/uBaPk1MWq663e6Bg5NK+7KFkO
         En+eIK1LFs5R6W4CUfWyssINZL9cwGsMw8u5lXsfzr+vqmT0EpgGI5llZMQH5e6ejR5E
         tibgasJrpGCoZfNW91gPJyiavbej8KalGp4gimUeQFF4lbg0WKdl+iKAoccDHwwBeLPX
         7f2lnhAdOtrU8JZRDjG2WwsnXuZDetBR/DRXmGSLgqYPy4WIsvMo6EBUSm/Hp/I0lY81
         8ES5EOl4HZZK7770GPrgJKFHHZWhqGzZOCCUSJpA57v2xAqQKCePyDJQ7h54JIBYVllE
         W/dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591813; x=1792196613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        b=PKy3OKgnPwyLIooBy0jhvouBj7Pts2kStw9yCGybwCw0Zd6Vw78EP+e0NvTWdXxc7P
         me7iCECjOF2nrYf3saNcKzp6hjJxxdHo0wEtL6NdK0hppcsSqbTmwZDFbCn2JdQSc0AX
         65sZRhZIeshp6nri3dCAKUlkwG6nc/XnYf2CvB3/V51sFQskjKyfIKFjukGr02eSdMbE
         7YOfdFnsXWsUJ14Gj2hfSTqs34NCsS+dUP6pw40zZeEpPDtXqq2a41bODSFAOXwfYhz8
         DBM1Vc6QlZeat3OvG4GD7j0GHQexUAxSHH1IH3kTuYdzl/U5MD6MJ30dwtvIzkJ6hFod
         Fe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591813; x=1792196613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        b=W/QYbW9SOKHZALkG8iFeuOQOATMbnBciIrVsAvww3Nc5BSVdQcLhHrXxbRByXKsSgT
         JTIAPv6IWW46GaU1yX6Yzp4Je5Cj8G/o7zRDKvccPENjoXPqYXgqo/2ikR8Y+nJk0TC8
         fS5KftZyiYAOmkSlAFEI8mvroonWbFcs/+SIGw2I+9qFtXwfjU1RL9R2kTgxDDnvIFrr
         s/gz7cZp5Rn2/1YM38XLYtut3J5vmppoDQHv652RB3y4zfmmUj8mi6Cp7O+exlPnOPra
         wingSAcWYP8o64Zm4HyvGFHql3cEmYm0T7aUzmDVehkmQ8syHS62tX0j4lCMKOtIKInG
         vY8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzlGyXhW3788roIYK0oEgue6/nGoDCpn4XKNG7NFKgWA/VUkfy9EvdaHPQ4zvUnrzMccvWNZkktjhd/UEgg70V8AQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzykIkV3OuKeCJTXpyhVKqj4yjLsidkTzJDon11ZbaMWsVyqgA
	g6XU3dZYTm7ZYFqkvI52RavLgSw2RGkNDTj/05hqlSEZz2Npb8gTN0TrVk9IIq4pTkqCgKMAKOC
	puWg/RN3/k12uazStVujQ3tSJlE30Tw==
X-Gm-Gg: AYBFou2lZ/q5LPY3zha3Z5p9xQFY22wpKuGywU20Xm7/Omm5ubOuYcINQQ/BxtuJhf+
	k9lQNDmiMcZAEPNtfcVhP9sD1tPxdwfRbQdAoC0ma5PF8veEw//OOhVkXVD8/BdpXkmyWxq933k
	lpxXnBb7nDC7bl1byRDRmX53niSPHXKq2ES0I3Zfde6ga5T2FXmWlbzzKKPtKM7Ur8SkpICB0+m
	Qls0MFar7zdB6jSEkjGYwjVGGi6+nRMHK/zthHBsTixZ6UKOguZLAUfVZJBb6ci5a4t+B9r0+4R
	l5MIVvrwI2O6n60l8hKc3HBlQ21mJ298DShgfW3GMG6A2/+iZLU1q2S1ve141FoG5sCe
X-Received: by 2002:a05:6402:4490:b0:6ac:9a44:d412 with SMTP id
 4fb4d7f45d1cf-6b17c25d32amr3176429a12.7.1791591812741; Fri, 09 Oct 2026
 17:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261005100435.1211485-1-kunwu.chan@gmail.com>
In-Reply-To: <20261005100435.1211485-1-kunwu.chan@gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:23:17 -0700
X-Gm-Features: AclHuK9H7NRLbSCaBe_aB3pxVn0sHlmdw2q3s22R7c9utOO5Z_szeWimYSsPy00
Message-ID: <CALa+Y17i9wN=0oLbbrsPafJY_KNEoKwZPLdLCrMq5Nf2k3aVKw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SJ Park <sj@kernel.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:04=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com> wr=
ote:
>
>
> Hi Ravi,
>
> I agree with SJ that this would be more useful as a general quota-goal
> tracepoint rather than being specific to NODE_ELIGIBLE_MEM_BP. The
> target_value and current_value fields are not metric-specific.

Hi Kunwu,

Thank you for the review.  Agreed; I will make it a general quota goal
tracepoint, as I wrote in my reply to SJ.

>
> On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> > evaluation.  The tracepoint fires once per quota-score computation when
> > the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> > context_idx, scheme_idx, nid, target_value, and current_value.
> > current_value is reported as the quota tuning sees it, after the goal's
> > complement setting is applied.
> >
> > The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> > occupancy as basis points of eligible bytes.  This information is not
> > exposed through any existing external interface (perf stat, /proc, or
> > sysfs), so the tracepoint is the only way for userspace to observe the
> > target and current eligible-memory basis point values at quota-scoring
> > time.
> >
> > Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opens=
rc@gmail.com/
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
> >  mm/damon/core.c              | 16 ++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.=
h
> > index 8851727ae162..2c7249cc7c88 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
> >                       __entry->esz)
> >  );
> >
> > +/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
>
> The comment says "Per-tick", but the event is emitted for each matching
> goal in damos_quota_score(). "Per quota-goal evaluation" would be more
> precise.

Right, I will fix the comment.

>
> > +TRACE_EVENT(damos_node_eligible_mem_bp,
> > +
> > +     TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > +             int nid,
> > +             unsigned long target_value, unsigned long current_value),
> > +
> > +     TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value=
),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(unsigned int, context_idx)
> > +             __field(unsigned int, scheme_idx)
> > +             __field(int, nid)
> > +             __field(unsigned long, target_value)
> > +             __field(unsigned long, current_value)
>
> Also, context_idx is currently always 0 here, since
> damos_quota_score() only has struct damon_ctx * and no context index.
> If this tracepoint is generalized, it may be worth considering how the
> context/scheme are identified rather than introducing another tracepoint
> field that is currently always 0.

I kept context_idx for consistency with damos_esz and
damos_before_apply, which carry the same field and also pass 0 today,
since a kdamond runs one context.  I will follow whatever SJ prefers
for identifying the context in the generalized event.

Thanks,
Ravi.

>
> Thanks,
> Kunwu
>
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->context_idx =3D context_idx;
> > +             __entry->scheme_idx =3D scheme_idx;
> > +             __entry->nid =3D nid;
> > +             __entry->target_value =3D target_value;
> > +             __entry->current_value =3D current_value;
> > +     ),
> > +
> > +     TP_printk("ctx_idx=3D%u scheme_idx=3D%u nid=3D%d target_value=3D%=
lu current_value=3D%lu",
> > +                     __entry->context_idx, __entry->scheme_idx,
> > +                     __entry->nid,
> > +                     __entry->target_value, __entry->current_value)
> > +);
> > +
> >  TRACE_EVENT_CONDITION(damos_before_apply,
> >
> >       TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b63e60ef8990..6ddd15dc4f55 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct da=
mon_ctx *c, struct damos *s)
> >               highest_score =3D max(highest_score,
> >                               mult_frac(goal->current_value, 10000,
> >                                       goal->target_value));
> > +
> > +             if (goal->metric =3D=3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP =
&&
> > +                 trace_damos_node_eligible_mem_bp_enabled()) {
> > +                     unsigned int cidx =3D 0, sidx =3D 0;
> > +                     struct damos *siter;
> > +
> > +                     damon_for_each_scheme(siter, c) {
> > +                             if (siter =3D=3D s)
> > +                                     break;
> > +                             sidx++;
> > +                     }
> > +                     trace_damos_node_eligible_mem_bp(cidx, sidx,
> > +                                     goal->nid,
> > +                                     goal->target_value,
> > +                                     goal->current_value);
> > +             }
> >       }
> >
> >       return highest_score;
> >
> > base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4
> > --
> > 2.54.0 (Apple Git-157)
> >
> >
>
> Sent using hkml (https://github.com/sjp38/hackermail)
