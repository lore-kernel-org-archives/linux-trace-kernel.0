Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12B396585
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316293; cv=pass; b=VFpPh8huxZKxYanIG1v6hYn4jlO9M+/1a34GGY/1SM4hZXz9Furw6ldhnlqbPEgVuQJtrVEeg+GMCnJiaGwXKWTercvHaJAJTOQ2qwmN9Xt3cHuwnW9ObYfEwqv+lr91Rpoufv7yZ/Zd0NSSfeQcx/m/zUI7BM6NoV5TDIoUWp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316293; c=relaxed/simple;
	bh=n0g7ltFuYfHeB3lT/oFe6WHRBYKRGW2vhL03GPn2aJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr+9TJjbovJPv1+o9zmXlwhsA+nbNPnr58VVbCyUbPWTBxMQ4yFzvvbWbnlmPtZQ9jgEO18IhFhP37o/DW2NEPT48jQKIKKEMzjbAQiAQnIEHKPKJqNjBm5LMJExLGRNH/eCIfxiXJ2NQnFZvndFk1S7Kz4yaVeYZulMoQxxoUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtN2XqN2; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtN2XqN2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52faa58bff5so177461cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 23:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790316290; cv=none;
        d=google.com; s=arc-20260327;
        b=JJY5bkujYFUn8+NxOjftNOgVm4D3ugroNGNGA0aEk+oHfCJFG/N7mJ126VEdWYkDmv
         PjfCSLI2IaqwYMXzJj6w7s9x9K2h/X4ONAxYBd0St7QnJJrsvFqRoHA/vUkvV1fRJeak
         MF4XWLjuf3vhPGysrdW3mmBwUsNenyqPqIepaNPC1gGDH330wpK5jwNgbAOkuJDDj1I7
         OgveGbdK2nY5MwbJAZeLJoESJU22ZOqAPBNZ4rJJVm+OZhAaLYo/48d7Xnx2VN36EztG
         fIgHujG70xub5+2ZutaoFdjO3PgxiAlva6++/UWY+IGyF5V73dT/G+u+5773izPgr0mn
         /k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFHv/NXcVHJN5o88N4eEkFmwnshWOqOMekRqytrwOao=;
        fh=ln2/zcodK6szBwhIl7+XH3Dee+CluflOowZfdW4tKlk=;
        b=hNdkrdSMJW31TQNRwx0oLisHvfpUoTeiOTwJLb1WJihAmz32awfoGPmdRi7kMXQWlc
         M2mOef7YOfSsX2x3C/oM3j381OVo89/XKnyoIuSomfuHq4aw19bvcAniwYPjn03RaRQa
         Ccs5SpKSMlqeJWkCmNbBZ03Xo4b8CtB0V2sPclT42YEh22A/eB41cPGEk/lswM7ZaqET
         MEn0KGM5KMlfmrNykU1HdyY+q/BihFB2w+CJOPphY+ewDtBW3OuTL9EXqlZRHj0Wf5bG
         8mRxUlgbSM5iTZce3upWd7eQPGFdfyfW3FQ6WW7Js3I4q2jqCJpI4ZiaF0UHQt/eL/XL
         ff3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790316290; x=1790921090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uFHv/NXcVHJN5o88N4eEkFmwnshWOqOMekRqytrwOao=;
        b=EtN2XqN2MlO0waffGopAx9mOE+lFQVZ1aHVYdOxsGeI8PKGrS0OhjipWKFbzmO34l7
         OEsV8/IsOxcQ6LWni7uviclzclVq1/FXAZFzoKLx1OB6Gx4mdUFBffQEAKq9Jpy6D8V/
         4COa40Sat3qreKEDLCMF8/vnfLkjMBPzJdjvaf+6n5EoG9nenf012kXdTG66HyW/YN3R
         3JTw0wd0e0o3bBYtmbvNiA0u5ERDTNLWnEDZc8Z9QIwapACln2BH2k5DtBS5I31UprMR
         uTw5/R9hNa/+awBDiFdO3qhFWzxtqKfnkbxPGglpDxIhcZNz7Ag7+PTUbGES37Lm6YpK
         K4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316290; x=1790921090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFHv/NXcVHJN5o88N4eEkFmwnshWOqOMekRqytrwOao=;
        b=skT1gEPPs7dQq3Gyz3r0LXYgJvKc2MBZLwb+BE0IRpgEvsBHntBXdn07z6hpFktcNh
         9bSVoy9sRXLpXPHWyoenibX8J0eC9yV9qK1gqLqpKq5p9Bp10NZyKonOIkg20ewaphQP
         SW/XKjt2H3pCc6iv2TGLJAtht115D5IlQxOVaw8F5utg6sqqCyn5ly8p1lseoZyIBSa4
         o9RkzeAo57W38vgf5TFsippr8QxwUqVbh3tuqHi6aDRab41Z2Qp9+KtYoymCH6lFO5zd
         USEcP8I21MN8F/zqnUsrupS+632sbZLaXTAJoPTyDLCdJEm5rREi4ezeUKm0/wkYYs1J
         sdMw==
X-Forwarded-Encrypted: i=1; AKwUvBxcP79cPWO4URX2XNE4p4A0nLzKr+awF3+ZXYIn9D5GFhX4aOPC5skOA0HTYW7lmnURtmDz20cVf7+EncFXhVjL8Xw=@vger.kernel.org
X-Gm-Message-State: AFuF++m1BXV+l+k2x1SxMh0dHPTdOlC222GgLP+PKTyWStzT1QAy9WCy
	mQzph6G1q1ahV8h6DBAevajjfoE9Crnzo52Oq7uFEWSxePJVCShJpTC8FwwpGKhv1fwdp1RV0kg
	XvCh86VMVKIH6GVB/DFJ+00Liw2UR8SIJZ5afoyki
X-Gm-Gg: AYBFou3uE2KyLd62/ovcnMRmAKN/1LR87s+tO/L05EpDJIj+tikDg3v5qhJHpwNefAl
	ETIoYmPLUKecR4PgnwZrAtekkXlabBazdnDTN2U47BS9fFIMFAYHdpSSMoWaGdLtw1SeDbCfzqM
	J7VHj/mmcHyBz96mLgxcZIVbtLq19rvqVfN+8lVe6GEVR+gYhs5EqQ5rV0AxtqQ2eE/JsQQnzkZ
	D0ZdZS9QXZk4u/YC62oLFWHENXeIkEvDckOPci7EJKkyH5dvaJPF8qcbyaS02xps/TP8oWcRKT+
	+YXnhfWwvRfzEgty4nTuGWO6KvQcURg6CsCfF6H3c4PmxnDF1fynPA==
X-Received: by 2002:a05:622a:d3:b0:532:c8ca:5ae9 with SMTP id
 d75a77b69052e-5330e14c38bmr7040531cf.11.1790316289698; Thu, 24 Sep 2026
 23:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com> <057359f7-0e8f-416b-8b5e-0b60c1c936e9@linux.dev>
In-Reply-To: <057359f7-0e8f-416b-8b5e-0b60c1c936e9@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Sep 2026 23:04:37 -0700
X-Gm-Features: AclHuK_lwpEJbAhWtQShe8aDhh_guZmjVwfh6KH-R_FEbCl9ftq7SLG9YWrva9A
Message-ID: <CAJuCfpGmChqsz5SMHaaTxJQLcj200USvxZ6SQ6vrAr6-M2Vg_Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] alloc_tag: Introduce selective tracing for MAP
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:52=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Abhishek
>
> Thanks for your patch.
>
> On 2026/9/22 05:26, Abhishek Bapat wrote:
> > The existing memory allocation profiling (MAP) tool accurately maintain=
s
> > aggregate counters for overall memory accounting. However, relying
> > purely on aggregated counters restrics the visibility needed for
> > targeted debugging.
> >
> > This patch series integrates three new tracepoints (alloc_tag_hit,
> > alloc_tag_mem_alloced and alloc_tag_mem_freed) directly into the
> > alloc_hooks_tag fast path.
> >
> > Enabling trace events globally for all allocations introduces a severe
> > baseline overhead. To limit the performance overhead, we let the admin
> > select specific allocations to be traced.
> >
> > A new IOCTL is introduced to allow privileged users to determine which
> > allocation tags need tracing enabled. The IOCTL utilizes the
> > pre-existing filtering mechanism to specify the allocation tags to
> > enable tracing on.
> >
>
> I think this cover=E2=80=91letter could go into more detail.
> Also, the cover=E2=80=91letter doesn't include any how=E2=80=91to=E2=80=
=91use.
>
> Looking over this series, it seems you expect users to first call
> ALLOCINFO_IOC_GET_AT to obtain a tag, then pass that tag into
> ALLOCINFO_IOC_TOGGLE_TRACE.
>
> This behaviour is not reflected in the existing cover=E2=80=91letter.
> Before reading the code, I assumed I could just pass a module
> name to trace all allocations from that module. After going
> through the implementation, that turns out not to be the case.
>
> Because patch 2 enforces a full mask requirement for the filter.
>
> struct allocinfo_filter filter =3D {
>         .mask =3D ALLOCINFO_FILTER_MASK_MODNAME |
>                 ALLOCINFO_FILTER_MASK_FUNCTION |
>                 ALLOCINFO_FILTER_MASK_FILENAME |
>                 ALLOCINFO_FILTER_MASK_LINENO,
>         .fields =3D params.fields,
> };
>
> So to trace all allocations from an entire module, users have to combine
> ALLOCINFO_IOC_GET_AT, ALLOCINFO_IOC_GET_NEXT and ALLOCINFO_IOC_TOGGLE_TRA=
CE
> together.
>
> I have no strong objections if this is the intended design.
> That said, we should settle on the expected usage model up=E2=80=91front.

Hmm, I don't see why we should limit how users filter tags for
tracing. We should not enforce them to filter on all available
attributes. I think it's easy to fix by adding the filter mask to
allocinfo_toggle_traces.

>
> Having corresponding Documentation would also be quite helpful. That way =
when others
> ask how to work with this feature, we can point them to existing written =
material.
>
> https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/mm/allocat=
ion-profiling.rst
>
> Thanks
> Best Regards
> Hao
>
> > Abhishek Bapat (4):
> >   alloc_tag: Add trace events for tracing allocations
> >   alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
> >   alloc_tag: extend allocinfo_filter to support tracing queries
> >   alloc_tag: add a test for trace state toggle and filtering
> >
> >  MAINTAINERS                                   |   1 +
> >  include/linux/alloc_tag.h                     |  94 +++++++++---
> >  include/linux/codetag.h                       |   5 +-
> >  include/trace/events/alloc_tag.h              | 122 +++++++++++++++
> >  include/uapi/linux/alloc_tag.h                |  17 ++-
> >  mm/alloc_tag.c                                | 142 +++++++++++++++++-
> >  .../alloc_tag/allocinfo_ioctl_test.c          | 111 +++++++++++++-
> >  7 files changed, 462 insertions(+), 30 deletions(-)
> >  create mode 100644 include/trace/events/alloc_tag.h
> >
> >
> > base-commit: 8d61431ed2607386b427752505379536eb634ce8
