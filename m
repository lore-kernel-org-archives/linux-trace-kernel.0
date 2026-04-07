Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A4487BE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531854; cv=pass; b=Ymq1vDgXI1a5ah2bIQJWCb0ej7x9MhI7PYYb5dEmnVEOtPDJ2QV9rEGDzVqKG5ShwEVSm4PTcvoFKAxyzg9wEgiYaap6YlA6KUfu4q/C4WDgucIyKDhd/43ewb1j5FXety6Q2+F8jc+9FcpqKh9Np3drBvSi/TqZEkZ5CMd0H6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531854; c=relaxed/simple;
	bh=6CnKNasyITD4j1QE4XtIgi0X7ZJLQxlz/57w101u5co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDjEJZlS6qMiS09jNkw0dI9LamiNajKU/Bol2Zq4PfOSpUtb4CxLp68MEs2Vc52SCLnC926YosbqUutKY3W2LSA2AFflSxgTP1LYE7UsmV64sQYbu7qNybOztHC0qtN+1W26Jqggp+mJYX3LPEvFPq11lACY+oTnLzzrIzk6fBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1kt9KFh; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1kt9KFh"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ea87af213so80746477b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 20:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531853; cv=none;
        d=google.com; s=arc-20240605;
        b=HbhgxygKbMcma8pqQuav9dJcFiCrrO4RekUmDP+r4QuGsnWoI+SNs+vPUSV7ePXbf9
         6WEA+XGeg0VXVq5tob0yGAVJSnDpg4yIpPe0zCRpu3ZQl+58Qs21fEC5rqCiM5PKjZ3N
         +cYRXaymygVEDJ1fnAisXe/TgcwNrpfGlC9Mp396QKGgn4DNiYZuO6UiqcX4grxXUjEE
         F8SHl1uI+H9b2+so5YNfiZfzNzEtv16H93fK9D4UHaX7SilKNVKznv/xUAMndkWpRanE
         v9YZSJGX1AZ4UrlDTxU80xm4viMLW1S6p00XZYB3UsbjqIC99ShlgminYUg8Y0LftX08
         6qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        fh=aN258enkUWLQvsq7RhHl8HwpwOJSMq4vMufaycdSpus=;
        b=T6ybx/ujdqJPXgQFSeLEirkbAP70S8EVuKgvh56NdnZG1Vi4givmt2TsxiMcDMcG4x
         Xg6xpMtzKqw6jS5r+NBuGTgFyiytUNvlgE11OonRDkaDcCNqjDaSVJob5Yjr47ZafaZZ
         hd+WlXwBB4xeVjBst+Ou8nU9UqA22QEUKZ3zdOclkQh5QzUBmS6dH4BIsaJqulCCwVFm
         7z2B8IrGWUVv0UFtrhfCOiGYk7WHmgG1/Ljf8k0iIl6fudn/lZ2vMEwCzx3ncaYe5UKs
         9ZKMguLGYeCm/Essse9jyj3CrgtNbbp0dzvr+QwVQAF+eyuu/qDyDACyXTLKavJ3H65c
         /kjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775531853; x=1776136653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        b=s1kt9KFh5RKKNomECIut4vs912QYz8t6mRnyIuks8WbKpdymCjd99HDaBQf0ZMKu6A
         tDF/q+L3Yodlx5dhvQwJRmFlggUPqJ27A4GcIL5YagBNkhdyJgOAO/i78q55J4SE4lJa
         GOlx12r59F7wbWfjlmfta+70FjXODYtV1mxacIrr2aLt3UYcZQPptsdMxfm8r3hXfui3
         k3dd3JjxvPwJ2lX1Q/yU8jxr4fPtof5A9s1rSbgeIMZWXzTYbVPCQccBCiDPi8+M3gRF
         tKHUgYZu8stbCmEgclbqWCzC24m8QVX8b6FVHIR3Wt/hCVON11rxhaFDQ7y++FnpFhGF
         4n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531853; x=1776136653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n13KGfoQXw/JheUE7BLN4ftaWLYzsgUyZfU3shLQ6UE=;
        b=searNl+5Eez9RAP5blPTc9Ba5zmY30oxzcurwtNWpyCWz1naBktbFJzc9mGJAnw8cl
         g0jzX9C0QPTd2ILzlUTUQVy4wDVCyi60WjZziA4Z3V0yfwpYs6/PX68f5VrzBQQiN3r4
         OBmKJHHyQ7EoTJiwOEnPELzlanBDEnQFEWM1eTGNfOAx3E8Gn4DmZ6VqKK2Up9Omn+5D
         xo+iOCe8TYHRvPpYeERyT4PMOjzLgV+Yt9I9WHNhCmBKPGnNNgc09bEBPl64GaPHV4w1
         VdDxgVNMfOgpddgMkR0C1kBFggraoy8ANdnh/QdZjYHtym9fC6gpd2VyxDwBLR3qL6vu
         0+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbqyp7VyUZ2IfTJO0a+lTct0nZzQmcfxlFdCEkiUQU4a1W3vAxzSLsjCYnsK9BHkuNKMD7HhaSlV0PbvPXdvywCew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80uNHapq9ObQj+jadPaG+aH8GR3y9V+P581WxKWK1BCEJJEIu
	8IOTYsVVUyu4BjPEBP3IP2O8y98snBDjzPCIB1/Xtfg8wsvpVb2lrFtqE0I0fR/FwSXhTILSFer
	QxO7AW+b7NDyn0LOaYU3TryWy+4i3mUg=
X-Gm-Gg: AeBDietINvgmsRADnJ+3BDNzVsW1akjhbLP3o9QMne9UwB26esOFjyVc5By4qh73+JD
	fWaLP4M+OQ5vbFBScShq8lwJC1ZXAxQv/sNZPEXSFuCx4LA3nGJaAgltFZNm/c2ou+q1hgzMW7a
	DZC67VKJuJ7FmOhY/e5xPMU+KuMeEwSZvKj59Bbzr0m4EQcz7rKPHPZnr8m7w0HTNVs1b179MgY
	HaIFs7rA2QgOZ3+Zu6nQ0FISzC4MdvZv60zljJ2Zkj6ZQG9zi9sOoE/faJ3NDTo8w7B/rq/lt+5
	OAzT6B9s9UZsp0aB4L43da+D89HVxr9SdssvCVG2H3vMIXY3Ghw=
X-Received: by 2002:a05:690e:1c09:b0:650:7b9f:2cdd with SMTP id
 956f58d0204a3-6507b9f3331mr921741d50.19.1775531852696; Mon, 06 Apr 2026
 20:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
 <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
In-Reply-To: <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Apr 2026 11:16:56 +0800
X-Gm-Features: AQROBzAxg6OOezCNjm_WO_2NQj3cYCfJeAVYvX9rzsZKOm4J2VwnmP_iFBuGkkQ
Message-ID: <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Song Liu <song@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, jolsa@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:54=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.=
com> wrote:
> [...]
> > > > > - The regular livepatches are cumulative, have the replace flag; =
and
> > > > >   are replaceable.
> > > > > - The occasional "off-band" livepatches do not have the replace f=
lag,
> > > > >   and are not replaceable.
> > > > >
> > > > > With this setup, for systems with off-band livepatches loaded, we=
 can
> > > > > still release a cumulative livepatch to replace the previous cumu=
lative
> > > > > livepatch. Is this the expected use case?
> > > >
> > > > That matches our expected use case.
> > >
> > > If we really want to serve use cases like this, I think we can introd=
uce
> > > some replace tag concept: Each livepatch will have a tag, u32 number.
> > > Newly loaded livepatch will only replace existing livepatch with the
> > > same tag. We can even reuse the existing "bool replace" in klp_patch,
> > > and make it u32: replace=3D0 means no replace; replace > 0 are the
> > > replace tag.
> > >
> > > For current users of cumulative patches, all the livepatch will have =
the
> > > same tag, say 1. For your use case, you can assign each user a
> > > unique tag. Then all these users can do atomic upgrades of their
> > > own livepatches.
> > >
> > > We may also need to check whether two livepatches of different tags
> > > touch the same kernel function. When that happens, the later
> > > livepatch should fail to load.

That sounds like a viable solution. I'll look into it and see how we
can implement it.

> > >
> > > Does this make sense?
> > >
> >
> > I haven't been following the thread carefully, but could the Livepatch
> > system state API (see Documentation/livepatch/system-state.rst) be
> > leveraged somehow instead of adding further replace semantics?
>
> AFAICT, system state will not help Yafang's use case.

Right.

--=20
Regards
Yafang
