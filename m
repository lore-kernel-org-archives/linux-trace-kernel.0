Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F7F4F1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591672; cv=pass; b=oOo+AVEcTRPfpO+A0f2aLQl24D2pV6EAe7zhtKh4AsoVWNQbelX9M4OaoIy/UM1zjgDqrVnXoa7DA1+sXE3fGNdxWBvc9ZBslvacYw+Bl8MSqN57h9Ev3bEagH7xcyDpxA2VZ46lWhJ0hy5TXGdA9RAwocGxeertcp6V3AFWqhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591672; c=relaxed/simple;
	bh=HxAWx+vouM1rFRwo1u+RrW+BszfFH2h14d83b6DcrnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEahN3hfjXYVElVrVgmP6bmXEuPs9ynqGCCYL4JnI1XhCX7vT8fRb4pTODeYc6ZUzDHVAYNIvKgsIeUDOs5Z0L7W/LKBJMYVz03CDupk9CI0I467cPKbYlDW9bWBcwcZFROC3sWMyXgovmrZSpbevuaIP/ozXPFTxgY75g8misg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPyBHTUI; arc=pass smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPyBHTUI"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-35178db8192so46099eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 17:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591670; cv=none;
        d=google.com; s=arc-20260327;
        b=cFQ1UozehfBS6LGO7n+ldmeQeS/tbJMkszn/n4yw2xnM58MlBbm9LoRMN9x76sdEqH
         VGiL3qvIQmzq+bgVeWzhP0iDcKTA12xSLDCKYezVe48zw12jIaCyn7PD7NgYSJAWjZdF
         wRwBz3m27q1ByC8cGgaNs4ldLWZytyEiHhO9z69J+qzKaBVlBteWuGoTfgSz4ikNr4qe
         E+oeNWTmHbyn+CQAYjxV1rdWspQ8ZVdT9qnFRBR1+PJqApDiwRceGpYh7s1Of3nQM/dw
         WuhYXOPlDhvGgdtNrNopgS5BqFSlFqxzKS6KrvCvPmeSlpqN98Qq5hyenTu3RgIGSN71
         zTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        fh=RpmMjUSu2DOUVwMrz52szUkVqJ3K1KSUR5XlG7RdM/E=;
        b=Xb1jRlXiBZYAt9nuW/CztVaVYKOmGAoNwitSQNfL/WlThKABUqJR5LH6nrbTIv57Iz
         8geWKb+xzXX4J2co+skf3VRUd7jJcboyZjBlf8ms6Fa7Ve9Adpt79mS5n11Y6F+B2tH1
         HGnfoIzuaqGFOGNgg1vNgXIfOavVG9RaEX0AMrRbPj87sDR9xIqlDMRRoQmbwmVGhrAm
         vAA0s9/l7v4D9F7VPlJnUGiF1hi+71lVOusjOFiH17CvOiPV5FMilFT78maq/CR6TcKS
         +IMu3pToE4sLpWOhTHNK5fiF0UQv2eDZ3uUHv723pgrequOwAUpBayMdoMFhP+wkZeGR
         r8rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591670; x=1792196470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        b=RPyBHTUIJTLM8EDj6zM7bb9At3/8AemAI460eoEv86Ei1zKVoA7WRdwl00JV7G1Saj
         ZKZqW26LLe1XP+D3H65FGqVBKPrco8y/6j2wZ7xQ87yUZzzWKvHAs8PC8CNker+5PuJI
         SPmBu5KTyVtkA+KYjhrP6E3Hk+gIRtC2UaJYQAq+kEk6Qhmvqt/nFGzBcxi3D1c+ppnW
         r2zvrlRzfC2iNF5UefefezwJeMwVzWxrhis+TOX4Nj1RpmlG8pOYEXA5KNaaTwgX1c12
         +CTg6m00q+Toh4/pRlB518jQ+n0HcNGsmDQrTuXFihQ3rwe98moyfk2Ol4Jak8+kCNLJ
         DLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591670; x=1792196470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        b=oOGuTTKn+gyDMSx+JbWzSbtv2/zbUaxP4c8UBbA5ou6nmXebcN6JXtxd4/gxMQv2U9
         MhEf3iXpD4sAqdtDU8oqaY56jO1HAIygf+QsMGpNs8PWqmZsaehHG/hSnEZKHnbVHPf1
         Geu2FnWVvPiRnBXSQFZmOwy0hYn8wOTSz3yIb7CYnriAvhT7x7QoGZtOJy5u8d87kmhp
         ae69O2NGdmvSry5F8FobzIEXLRqn46UhvBTLN87GG+TUcitbomGZg+FlngSJYorR0zsn
         BQo1XKn+gAW5bTFpCx67he93K94/OOKFyQCCZrVJPCzarJWJgc6j01FHJZT7u4gEbek7
         65Iw==
X-Forwarded-Encrypted: i=1; AKwUvBxb9GL6EPxisSq7fF5C7Qt1Vqlo/MVhJhGRPAh0A1MGOm5liESoHwNVsTlVLJw2drmV3ITYNctw6orxt8gLYxNuoOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYItFFnXU093/imnslxGY23cK8Dl5BiqyAO+wNir+BinowKkjHZp
	GvkeljNu6dg2jFporHb7UZkyg6SjIEDOPeubgBOYfaKSaKtpxfhh2gr6EEW0fwS+tMkX1jTLqqs
	23PFLUoQf9IuHbQjuZE2Rf7YBPWcPuA==
X-Gm-Gg: AYBFou0u/3vP/8/SUlwo5PAB+9NOppeCypuvW154scXUrWkzj1ji/HtmL5gnuNod0P0
	4M8xYPz3hkuMeIktajxKwonQtxumkxtnlWIxrdoDWlSStO6haVZz+SHW/tpM527fDvVBZ9KSd8s
	wCo1ZNuEkolPYZfvewmQyplvUKvQi9CaiuWZFQv/Lzo/LCld3UlTDwTsiWAJad4nSYDBFCYaaJ2
	0YlQfORUUWA88SOp7bm3EUhaOix+9JtKnrxQmnWWZmY2fIHw3ayuPPO44RHfOGaM0AtqZergpqO
	k4dEd02HPpTtqQ4ycvnrTvW/0mkAcS3X/MyjoGaIV+tSE7Aff+RCwt+J2eb0nMF6cFQ=
X-Received: by 2002:a05:7022:1584:b0:143:4d12:396d with SMTP id
 a92af1059eb24-16a61a6def5mr6220928c88.26.1791591669725; Fri, 09 Oct 2026
 17:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261004051632.71726836@fedora>
In-Reply-To: <20261004051632.71726836@fedora>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:20:58 -0700
X-Gm-Features: AclHuK9WQbXCtUH8jjgwOQuphF_nuOqJSSeO2P2D0u1Fn7EltapGuD6HQRfN-gs
Message-ID: <CALa+Y14+pGN+ZA90gALy30mvrmkTp21AVFrjfzP1AtYEo-uVPw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, SJ Park <sj@kernel.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 2:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Sat,  3 Oct 2026 13:27:27 -0700
> Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
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
>
> Can you move the nid after the two unsigned long values below. This
> creates a structure, and on 64bit machines, this adds a 4 byte padding
> in the middle of the ring buffer.

Hi Steve,

Thank you.  Will do; in the next version the 8-byte fields come first
and nid follows them.

>
> > +             __field(unsigned long, target_value)
> > +             __field(unsigned long, current_value)
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
>
> If you move the trace_damos_node_eligible_mem_bp_enabled() before the
> goal->metric check, you will save yourself a branch when tracing is
> off. As the trace_*_enabled() is a static branch (nop or jmp) it has no
> cmp branch, but the above will keep the goal->metric still exposed. By
> swapping the two compares, the goal->metric check will be hidder behind
> the 'nop' when tracing is disabled.
>
> -- Steve

Makes sense; I will put the trace_*_enabled() check first.  SJ asked for
the event to cover every quota goal rather than this metric only, so
the next version may not need the metric check at all, but the enabled
check will lead either way.

Thanks,
Ravi

>
>
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
>
