Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEC30568D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146460; cv=pass; b=TbfltqqeFcDQVcseiOXL6P2PZOkOWkC6x/p6wfekAWy85LtNz0q+4Uj6uPgmeUi+X+5e8FPYLX4slV+V6oDi9RKu70Az0YebkrA4wmep+3sH/HIe/qNQfH4XdgQzdz3ndt1fpHaBky5usyiagcFHEDUyFa/dCxr2tou1M7nwVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146460; c=relaxed/simple;
	bh=wEyF0FF+0amOJx0bechc/sCZKlR8Fmp0P7fBfvS3dCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApmoXk5u6YBiu2kNfnWK3TppNmuDBLWXzZaQ0B0xUoe7frQusE1qEEc48A5KbE7/OLEtdPCIYVoc8+dGZWUBsfQnr1oRCQ+vN+V9MUqADLNR14bg0ltlce+kUqdrmYBPZw2Rk0BMPb6Httkm1c1EWxNhJC8eVvACuGU2R9/iWPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=fOq4rzMi; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="fOq4rzMi"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-654672a6d68so2932068d50.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 16:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146458; cv=none;
        d=google.com; s=arc-20240605;
        b=LdcwJwZGXTqyqHcWDe06xLcYNzvL2g89AaSszKHOD413jAmmaTs9gBgEEPJBZS4MSs
         eCMvhn69mRzWi5X/EK+sfC6zr+JN98HyFH+pOg9VyJYYDAMrpv9phEWNhdw/oCVRayKo
         LuePkC6rdSfvLILkRSGcj+ZoAgqtBLFYnzpPNbnYga8Uqcq9E7dRdJ8G6AwG6r0zbgxP
         NAVLDQi3tcJiAmWGJXLeP4IRtMZ7ldB1XFW3A1XGR23+rn1XoVcyI04kIxtbt8KuerJ/
         cxwWWzmZKpHSJvdygTk7nzPojvPBkEL4i1XRvdpBMCAIOYHho3aGD8bNCOT6AfphW2LE
         Vz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
        fh=jFw1kQI5H1wiDQ27T1qeTUmkNlJOVyC6uL2bR1YSh4E=;
        b=gO1zoVEx7NoKkKDDJcGMbe5/P8xklrKSRuDmmviMkBWIvXyr3UWUdEVi5WZLM4bNDD
         UkHlkojE6LcUd61R1TWaW2o6MxefvlMCY+vEcDITf0pA1uG86OyITQJ13rSJ0YaZwXGQ
         w+lXNOSlWkOZwEckHu6QYD4M0eEg+aONv8rZl/liX6Rvh/bTVlBHKSbsnj2JBuT4PR9f
         XSqwR+2Wmuo8TXemcIhjlTaSPyvhKPi76Gmt1vATQTO7WcsgMDhan51mP7EuV+Yg+2fk
         Hv014T/QLwu06XByARbtY4fsU+eqb5XP37lCwkPPofWOu3OeHG26CxNjgKUFLm/vMK7R
         zhWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1779146458; x=1779751258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
        b=fOq4rzMiAuBleN1uDzFodTmzu864lGlN4m9MohCgwRb9cJ5J5TUMbd0wkFwtSKtfb5
         fib1ZqwEeaiLNp9cqVOw7i3UR1NP/AITYe+9cT2tN0oQiGEj8kzgyieZSfJTAykkBfjj
         mvn6AV2wOhT4AiRyBFSplZzuRQ5NHCWSbwo4qcI0ImbzQf3oKnoZAmbs2XnDKYxk0OQ8
         HBulHI8LICmo3DKNWL57IHUQixmsAxkEOcfnnubnuvR86lA4OPi9YvLAxQ+4yZueQh7J
         yuFCx5hCGV5t+Qt2cnMtG7UmVcuxkVJtKi6tKFhCpeFHOolvZBjQcZfAG5oNaEWqQ94U
         flwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146458; x=1779751258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qyiC/6ER7XJQAQS9fYV1hi++02Ay+WfrOqQ6ixqtbHQ=;
        b=g0yiPTk6tJj2cr1QHZz7+7nbshMF8rdCpOcIUzZOrFBIzU2e4TQUdBPgkhezluGP21
         tIlFYe3j1EPYAYMIfZRfJBcefdgz0FbmVk2CWK+r7YqBhRTwCX7qxDa82bQobedZ6y6Y
         c5Jwz52s5rsZm56yCOUAiz/NUKjIr7KiAy/jG7rhPaAEv89JM7dfqDgPWitc4bYJ4gdB
         ks4vP0YUIs0ClRiCR8mWHP5wPp2y62+4gZkSV+4q0iFFX+2U8wONrBvkn53wNXlW38ky
         PiyljLFn0RA2A1ABtKRDeXcakNk9kX3xQC1Phwnbk12kG+bxk5klV8rS9wBvkAFKczOz
         CrHw==
X-Forwarded-Encrypted: i=1; AFNElJ8PtN+Mt/HURRZEiuOspGS6fRSpKfxLw+X7CjnaPT1oG5O1L31SNMA4NzwCdLv+M7iejs7aM/n33acCNVPGnEmq9iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEpkJHfYJlNWs3G40aIDGdKpV07Q5thyFwU9MkB843zQm9ZCd
	JBkOlekDJ6DxUoP+SnNwoIjcSjI9i3oyKaa4pC8xegqrAaDaiIdeI74RHiHgHRs58RMdUWmrTd0
	z3/iZbeknBQBYg9sYUdZ42Un1R3HrcV7eWDccdLxtpiDfR2aE3VCEW7RNXfKi
X-Gm-Gg: Acq92OFDqMwWeNGYhwTcKRWzz6dHLxwU3ZlQ+1v2Nqgsneym0+Qk3dygx4xcUeaJOot
	AEQ1X4XCw91q8EfHtL0OFUB55nWQPktPQ+P2wtc23dcuMZUcS49PgJLGgq7fEq/ZS2zD0kHl2X6
	V/NhY6cbzCegK4/jyZhArotSHQIOSHdpp8TlLyrQDQzCwZnCxj0r44q3B8e32vbD1AZHh6dkY8X
	6LFPv4npw5PnSj1+AFlg7AqdEQF6gC/tZWp78ygsMJ5IbyPBcl9Tn3pr7/CtXhvZh8kKVE8o5Vb
	X7c59nW7Kw==
X-Received: by 2002:a05:690e:148b:b0:65c:6164:f29a with SMTP id
 956f58d0204a3-65e22839e7fmr18959504d50.46.1779146457665; Mon, 18 May 2026
 16:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135932.2238842-1-vineeth@bitbyteword.org> <81783d0807a5ffac93f61eddba0d2f595d7f239f.camel@mailbox.org>
In-Reply-To: <81783d0807a5ffac93f61eddba0d2f595d7f239f.camel@mailbox.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 18 May 2026 19:20:46 -0400
X-Gm-Features: AVHnY4KAw0ZavPbDVfhEtyHlzriwrbmjQeDlQua14-BfS3GXG-7uIcLEub9UvWg
Message-ID: <CAO7JXPhMBd0xgDRO-gZ2HpSTnrj1OD67c39jrXWEKaowNc9GEA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] drm: Use trace_call__##name() at guarded
 tracepoint call sites
To: phasta@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:01=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> On Fri, 2026-05-15 at 09:59 -0400, Vineeth Pillai (Google) wrote:
> > From: Vineeth Pillai <vineeth@bitbyteword.org>
> >
> > Replace trace_foo() with the new trace_call__foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_call__foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
>
> The "foo" terminology is unusual I think? I always wrote it with regex,
> like "trace_*()".
>
Sorry about the terminology. Part of the patches got merged this way,
so is it okay to continue the terminology to have consistency?

>
>
> >
> > Original v2 series:
> > https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vinee=
th@bitbyteword.org/
>
> I'd put this in a Link: tag section below.
>
Makes sense, will do. Steve also suggested to put this whole section
after "---" because it isn't relevant to the changes. Will fix this in
next iteration.

> >
> > Parts of the original v2 series have already been merged in mainline.
> > This patch is being reposted as a follow-up cleanup for the remaining
> > unmerged pieces.
>
> So this v3 series as a whole is a followup to that v2?
>
v3 is a follow up to remaining patches that were not merged with the
previous cycle. The core api and couple of patches went in the
previous cycle, so this is for rest of it.

The intention was to send this v3 as a direct patch to individual
subsystem maintainers but forgot to remove the numbering and hence
there might be a confusion. Will remove the numbering and send it  as
stand alone patch in the next iteration.

> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
> >  drivers/gpu/drm/scheduler/sched_entity.c          |  5 +++--
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index b24d5d21be5f..cb0b5cb07d57 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1004,7 +1004,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_=
parser *p)
> >               struct amdgpu_job *job =3D p->jobs[i];
> >
> >               for (j =3D 0; j < job->num_ibs; ++j)
> > -                     trace_amdgpu_cs(p, job, &job->ibs[j]);
> > +                     trace_call__amdgpu_cs(p, job, &job->ibs[j]);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 9ba9de16a27a..a36ae94c425f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1415,7 +1415,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
> >
> >       if (trace_amdgpu_vm_bo_mapping_enabled()) {
> >               list_for_each_entry(mapping, &bo_va->valids, list)
> > -                     trace_amdgpu_vm_bo_mapping(mapping);
> > +                     trace_call__amdgpu_vm_bo_mapping(mapping);
> >       }
> >
> >  error_free:
> > @@ -2183,7 +2183,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, =
struct ww_acquire_ctx *ticket)
> >                               continue;
> >               }
> >
> > -             trace_amdgpu_vm_bo_cs(mapping);
> > +             trace_call__amdgpu_vm_bo_cs(mapping);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 5fc5d5608506..fbdc12cdd6bb 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5263,11 +5263,11 @@ static void amdgpu_dm_backlight_set_level(struc=
t amdgpu_display_manager *dm,
> >       }
> >
> >       if (trace_amdgpu_dm_brightness_enabled()) {
> > -             trace_amdgpu_dm_brightness(__builtin_return_address(0),
> > -                                        user_brightness,
> > -                                        brightness,
> > -                                        caps->aux_support,
> > -                                        power_supply_is_system_supplie=
d() > 0);
> > +             trace_call__amdgpu_dm_brightness(__builtin_return_address=
(0),
> > +                                              user_brightness,
> > +                                              brightness,
> > +                                              caps->aux_support,
> > +                                              power_supply_is_system_s=
upplied() > 0);
> >       }
> >
> >       if (caps->aux_support) {
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm=
/scheduler/sched_entity.c
> > index fe174a4857be..185a2636b599 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -429,7 +429,8 @@ static bool drm_sched_entity_add_dependency_cb(stru=
ct drm_sched_entity *entity,
> >
> >       if (trace_drm_sched_job_unschedulable_enabled() &&
> >           !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->f=
lags))
> > -             trace_drm_sched_job_unschedulable(sched_job, entity->depe=
ndency);
> > +             trace_call__drm_sched_job_unschedulable(sched_job,
> > +                                                     entity->dependenc=
y);
>
> I would be more happy if you sacrifice a bit of space here and keep it
> a single line since the if condition is already quite convoluted and
> challenging to read.
>
I understand, will fix it in next iteration.

Thanks,
Vineeth
