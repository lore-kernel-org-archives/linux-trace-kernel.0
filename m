Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021C36B071
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995797; cv=pass; b=r9wuZtzQ1uLmYm23wAZKebhZdRto98BPQBNfgvnrHauKokeC/csUTKJMb7uqh+1zfcIbs7mJykVN4sUhqs0Tq9nFfNQQB2KbOD0cus92BIzQKNnII1SZKkx6/vgYuOC6cYw+hgB8ntHpshiajSqBWtTjy1tP1lHCZwdQN3BKZqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995797; c=relaxed/simple;
	bh=SVTNVJLn1VqDWx0HDz8tbsYxcEIfkMoVv4id3LOHg7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDi0cijOb2o4jHTwWn3pYLLtbxxS3gVMtj3oZYo7jWcspdeEg01Wz3gAAQU1IdbTIjTOsxYMMWSHXZTzaXSdMulVwgW+poYMPQEVhcfQcfH+atKASeh1Tmzt1sm9BfLG+gHuu4JQ7698A5TnPTifJzQMJgV1HgRzN4BPRGCOOSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrduKbKu; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrduKbKu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7986e0553bdso33470387b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 05:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775995795; cv=none;
        d=google.com; s=arc-20240605;
        b=hY2ooEmOVnDt+J/zI3jaqt+NVX66dUGk3zJ2rkcYuBY9MgRN3u0YTYNxpQMBYEH/kK
         4CDr0Uc151l6czyuOgABWYN5PXdZJilPYyZylegY4Yug5eWfeD7KXcbq3nOCYAAMn72o
         N22ZGS5XfVWRAt+MFtJdykNuIXWsv+6i7IZi0ybwm/hpANpJPAxgXWu+2uWfcm97xDwx
         YuQjcoWhmR9WEAkyekVHZCF7jxqazrVlIaTy+BkqY1zItdNS7reHUnZswY8yHA7sFqYM
         UOuVCx4EeECDsS/s2L5J3+gU2cIkDXYzB4DUy9IqJ0ZRWdPrAGWAkTJP0oprLHwk88ts
         H8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        fh=MZ/sNo4TJQoTfQsyqqm7Uiww1gf54VY73PKo/jvSZFk=;
        b=PoiVTOF7/fveNGi77/qxM6URlaz/pZvx59wQdqoA0TPserFTwMyKoawrapDEKjEmmC
         pCKQPRDpS45GKTv+9Sfr0k1IJte3AYKpqrV3fYkusQMgthnIyXwRepKOVABRCk6nLJCU
         2aK99AqHY3OzfQyqCIYl2ysW4ecMuhKwWChZA1BTFtBRMqBDmeF8W/lhyc0C8RbqoSUD
         9XiVWGZAUacEnuGakXmRXCisvIx9KOGl5BCbUozX9NeB22/i2+9KknYC4ryh6Z8uPMA4
         yYDmSIsPSQoyXx2cpDMRDnDV93s928qMHksA7vsny6lqDZ5DIwh0IYRwuODLCgj+s55a
         vHfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775995795; x=1776600595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        b=jrduKbKucOJ0CrdEhOzQjksun3glLXXyDIsHC29QDod3cu+as1tdU/z//zLc3j771F
         Ww0mpRkjrNeekX5PJhDel6R4DMkc6Ea5uPdNN8QAEvd2w2v9BWeqEgh81fUyMRKCYoaz
         PKjzJ1ADdJLkpXk9OsWoHjE4qpRTULett3nyv/g16kMfC/HsuxD/CBtq7KDTa/Q50WfX
         IGmN9R4IaIlJhNnocOiKpGnjeqM6Ob+Ym6X/+JxHmIEuW+GzceECvAJan3e9NKQ5tB8t
         4SnhUenVs+FFcdLic6qX9rVRaofoOzUPQ6B4l5TAYm2AmbSyukIT2c/v4XbvLqPuvyd4
         SlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775995795; x=1776600595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yi7Jufl9MZ6r9E9T+DntWdpQRPYoo/vSgS2eY9Rp+c=;
        b=ddlr3iNBEFnWS7rpF3b/1y/4/jtggN5nOtLCWkcAd4LumADGkbeAC2UtSmmvK02t+h
         81yaQ+X5IxcPdabz0J3bqKA4YQSfyQl1Ko51GkUtRnifIQxEsk1a7QaXGJqQloWbrqZr
         WJ7+Yud8wPJJx3mOO3764TPtf29Pd63x/OOAU5+zVwSMNhgoYiLP/lMm/Yxrl+2khcfl
         ktpfwWRz3cm3TsxaQk9+JTbQegVfuQ+jE7Yir4wDHxTHg57R+XRNsTdSiAWQatf17lm0
         1LJEH5BytTwzeBgyNzWyar78QP/k1VzRipo6+qJL1oOYWEZWU4pCTRcoAWK/Pf0Fe79S
         Lw4w==
X-Forwarded-Encrypted: i=1; AFNElJ+1nc6BnXYnqv1nDkUOWX0HFFbwRTccambMM3Zno3LTdaCrI4YOVobBShe/Xr6ctUNTCDZEerXw/kHFmPZLEJ8Rq0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJitMpHh72ISBmy2qWtcQj3ZYEy2vZp7bUqiGXm5dXhla4W0y
	iiYdMav7Z6sNa2n05Qj9qnwV7NPbFuTNwBvPikNCdIW6vvCfWb1LJdd/DwaskDugf8BL55FM/mK
	xhC3/pfHq7DTIF6EojvzSlpsY16uttLw=
X-Gm-Gg: AeBDiev4hGUH5BPkN53YVHsuDrksD7pQEb6mvqI68KnvVY1v5IIKuiWQfys9pfMzD5s
	FnzVc3c3ozCXU47ZZv2LYnxB213WqRrasepqYCDFkF90/suDXjDQfp2cGg286MUoHNR4t060GJT
	TfoR0uRsogcwjZj6Whf5oo0rCLkO0ykbkevc1cTQjb5+F4MMcU7nagiaxdZl3SfsAyhJ2bncqum
	eQmgkDG63gwhDam9YYasILTsGuo38W7GQi7YmRYFFBDOaJ2GjYYIaTknfEEBwHFjnOG/DE1H6BK
	HOYrxWiSI2M3heUz95yeoymuXMvdXz+URMfTR5mi
X-Received: by 2002:a05:690c:dc3:b0:79a:cc64:886e with SMTP id
 00721157ae682-7af7282b96bmr107487127b3.52.1775995794798; Sun, 12 Apr 2026
 05:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz> <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
 <adY_WgA54CDtWBq6@pathway.suse.cz>
In-Reply-To: <adY_WgA54CDtWBq6@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 20:09:18 +0800
X-Gm-Features: AQROBzCu-w_ClAxqsNaksL5y_dXr6lYJTZQFfWsBZznnXM9_LWPtoFPm4-st89c
Message-ID: <CALOAHbB8Kt-RTVUcy66Bx__Bqu_YWKjgJoRBRNTGXk=CNmXGPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 7:43=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-04-08 10:40:10, Yafang Shao wrote:
> > On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > On Tue 2026-04-07 17:45:31, Yafang Shao wrote:
> > > > On Tue, Apr 7, 2026 at 11:16=E2=80=AFAM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Tue, Apr 7, 2026 at 10:54=E2=80=AFAM Song Liu <song@kernel.org=
> wrote:
> > > > > >
> > > > > > On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Joe Lawrence <joe.lawren=
ce@redhat.com> wrote:
> > > > > > [...]
> > > > > > > > > > - The regular livepatches are cumulative, have the repl=
ace flag; and
> > > > > > > > > >   are replaceable.
> > > > > > > > > > - The occasional "off-band" livepatches do not have the=
 replace flag,
> > > > > > > > > >   and are not replaceable.
> > > > > > > > > >
> > > > > > > > > > With this setup, for systems with off-band livepatches =
loaded, we can
> > > > > > > > > > still release a cumulative livepatch to replace the pre=
vious cumulative
> > > > > > > > > > livepatch. Is this the expected use case?
> > > > > > > > >
> > > > > > > > > That matches our expected use case.
> > > > > > > >
> > > > > > > > If we really want to serve use cases like this, I think we =
can introduce
> > > > > > > > some replace tag concept: Each livepatch will have a tag, u=
32 number.
> > > > > > > > Newly loaded livepatch will only replace existing livepatch=
 with the
> > > > > > > > same tag. We can even reuse the existing "bool replace" in =
klp_patch,
> > > > > > > > and make it u32: replace=3D0 means no replace; replace > 0 =
are the
> > > > > > > > replace tag.
> > > > > > > >
> > > > > > > > For current users of cumulative patches, all the livepatch =
will have the
> > > > > > > > same tag, say 1. For your use case, you can assign each use=
r a
> > > > > > > > unique tag. Then all these users can do atomic upgrades of =
their
> > > > > > > > own livepatches.
> > > > > > > >
> > > > > > > > We may also need to check whether two livepatches of differ=
ent tags
> > > > > > > > touch the same kernel function. When that happens, the late=
r
> > > > > > > > livepatch should fail to load.
> > >
> > > I still think how to make the hybrid mode more secure:
> > >
> > >     + The isolated sets of livepatched functions look like a good rul=
e.
> > >     + What about isolating the shadow variables/states as well?
> >
> > We might consider extending the klp_shadow_* API to support the new
> > livepatch tag.
>
> It would be nice to associate shadow variables with states so that
> we could check which shadow variables are used by each livepatch.
>
> It is partially implemented in my earlier RFC, see
> https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse.com/

This patch is still pending acceptance, but it offers a nice
improvement. With your modifications, the remaining task would be to
integrate a new replace_set into klp_state and update the API
accordingly

[...]

--=20
Regards
Yafang
