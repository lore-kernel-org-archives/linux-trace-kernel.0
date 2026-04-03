Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3398371D1A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249740; cv=pass; b=ZiO+E6vaqOD4osC3A5bpzRmuCeOOcunF7scrR601rFGo3eUcAFXnFjAbh14TWwZXofq5h/9YwGwE48RrdN/mk51NmTvHC/Gl95vcU4RH2WhBMTcmXe4sNd60sCY5c5+7tjyaxuBkjjPKoOrzcJ+U5r9h95dgwo7+zp+YctdrfFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249740; c=relaxed/simple;
	bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ/RiXvj+xryknqsW1IZ9zwiFox5AJkwjKLRFNWxnkk7m3zhlJrBOMlKUJdGAq650rmR6G6yCODN0VB6tZu9T3PvgTsKtTFCT5RDJWzIl5QIB6WoXGGZYQnNc3YF5jOqI8JNf4X17xGLa94XY28d+quUm0oKkidnJ73ofroaoVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUvAmWKp; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUvAmWKp"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so697180241.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 13:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775249738; cv=none;
        d=google.com; s=arc-20240605;
        b=VtBAJ9Ua97lI1NawxXM39togosm2MB4bf/ZtUXd3IDlRmnjEzb+525BYHTY9STMtXN
         MOUwStL2Dp5ecK3dG+IUxfQDNBZ0V3JYMacGMs4yoozncNmLreluxw+7izrFAAAZ4yE9
         dI4Bkxx7a5cAinbxLbNmvf42dazWlX2HP4RUhD9GrD2klHWzsKYGENxc9P801upCWa9O
         9vR9w9LvY2/G+hGNT8MpswqvLAw0AjqBSkfDqkmV3Kl0qCewOJgzdBUQrqWY3EZJm0Qh
         ZLm022cDNLBS87dHLObjcb8p6fUPmvDxT08edwWLiKwm+mrC2bPwOTdToJmN67qK3VYb
         EyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        fh=8zm+UBt4uqRGVxsxUYXK23kVxFUBj3WZaqL7fo1DPBg=;
        b=AyEIMI+LKi3UZOauRjRxUaoR1ZBCrpb4P663WzRePBtfoj9AMBlRv7l4jIPAGj6Ii1
         R1C+h7X0uko/0wk72YEAli8IykQheX6l63w6e9uY3oQmmvybItyebS6yF/4ZF6KkVxdC
         8Bav8/kgP5jIfhx0+PCVhTyjVzkvEy+VDIKefR332OZlaC7GKXMkIKZTWUmaLgMAbRof
         ODLCXWJOSPwBOzUIxXWERRnDEI8TdISPUmI+h0VqkPBxc3rsbh6QHUAos+PR/RkjMNwb
         BQXJMwgH+crc3ElG2v8+SacmebSseZx74gYNLxsCkvRSrevTyw5b3M0nx1/rW2xeJelK
         wxpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775249738; x=1775854538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        b=mUvAmWKpvN/9LbApy+wztqY3qewQZwuDLW3ValldzBtNBP0+fu5uHtoGWZ0sGlTCwx
         zOUMdcFVPwFvdyK8KbddaZIAHpbesm3s0VY857T9dH/eyQ+eEngRz69TwzB4n87ykIn6
         LW02Lx4OSBBalkO9vXDfbfjppm1Si+yX7rfCULkaSsR50CAAcH/v0JZ3LGxROuxKkMvj
         7dEEu+5JV57dqwxxbU61QqhHEW9jggHwG35XnJT0fzGIptpPPUdXIA0bCAIn2JXiYjp/
         gqj3mgy668Npm0GmsrxL6t5fnF+FFAs8Fhr1IZBD4rp7LyfaoYgFG6oeuQstnpltgag5
         5Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775249738; x=1775854538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        b=DeyL5p5z+Ef/8RQNtGQ0eGYdCnPZIaLlSfITa0A8KkXZJVIWKDjIJYr5AZ7eQzcYEO
         gBcoQzMIEwh4KP97F33aBn3aw6i3jlG5O1GQmrVzwKC+i2WGyJR841n+JIZc/NqF8fzk
         xbFrbJV6aIl1ahd1mKBpglMeg0IPBxBjcvyzxMqK+ACL4jlNbRaxHvA0Lty1Mje5ljYu
         F4K+tTUO9q94I1P/9loxcw1M1fePGO9wncFm+ZTIKPwIVFKoaj22cpsGBRto7iIjfhPv
         HSpkcTov/KdaRNbaABCuCeJDMtsLBgj/AFCFomGuZVepcwqPSr1ibbUY5ZHOvsqNaIMa
         7gYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXprnQ/Isn5ztZuqDsIG4sSi3qurkAJb4yCqd8C+FY0pevWpWFJHLtWe/HGWWVEpX+dCv9pQn02ukpWN9+AKfB9+wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMPQXZHGPlkcHURCRl/f6fP3hzfZQ3mzCON9ToITPZuPaL9Mp
	HVixRsJgv4tfJnEQzhEsB7kFiUhmTnr2VgKZA+9jhQG9PWA2kJlawkF3YmS5AIcu26m1Awg3ZaA
	rCaDDywVzONBNhNGWx1anOQU7iFs/l/kJClqqlgn7
X-Gm-Gg: AeBDieuNOcHWxeIY/FJrBQGOLWZYafbWpfTNlHTKlVXPNcdcM030sFon6Znld7Qa1bi
	1u8u+TOD871eShFPuWRGAwsLOoK4jm8nx83ki5akPWNDCAs+UchqCds2sSrK38yaHDuvATs+BoC
	BDKqvuWaTV7DIneQdhQ5FBTEwSEiv7ByykVIGZUZSyebjf7cdD0zfEEZSYzOdJ6SUTrVVY54rYI
	HSie1sRxj1CtnXzqNJvbt0Eemdqf/CdIf99kMuOJ8Ky6SvGMyxE1Jv5CGyiIVcb3dsv7m8TUTxK
	q/GWD1YXHGAafvYVLk4=
X-Received: by 2002:a05:6102:b14:b0:605:26eb:cc1a with SMTP id
 ada2fe7eead31-605a512c49dmr1509501137.29.1775249737225; Fri, 03 Apr 2026
 13:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
In-Reply-To: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 3 Apr 2026 13:55:25 -0700
X-Gm-Features: AQROBzDS37OjmfrI7p7dlg7HXRfbNYrPo6MbDjUEgtIBQmy-W82lfbmdNqsszdI
Message-ID: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:19=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Add a new replaceable attribute to allow the coexistence of both
> > atomic-replace and non-atomic-replace livepatches. If replaceable is se=
t to
> > 0, the livepatch will not be replaced by a subsequent atomic-replace
> > operation.
> >
> > This is a preparatory patch for following changes.
>
> IIRC, the use case for this change is when multiple users load various
> livepatch modules on the same system. I still don't believe this is the
> right way to manage livepatches. That said, I won't really NACK this
> if other folks think this is a useful option.

In our production fleet, we apply exactly one cumulative livepatch
module, and we use per-kernel build "livepatch release" branches to
track the contents of these cumulative livepatches. This model has
worked relatively well for us, but there are some painpoints.

We are often under pressure to selectively deploy a livepatch fix to
certain subpopulations of production. If the subpopulation is running
the same build of everything else, this would require us to introduce
another branching factor to the "livepatch release" branches --
something we do not support due to the added toil and complexity.

However, if we had the ability to build "off-band" livepatch modules
that were marked as non-replaceable, we could support these selective
patches without the additional branching factor. I will have to
circulate the idea internally, but to me this seems like a very useful
option to have in certain cases.

>
> In case we really want a feature like this, shall we add a replaceable
> flag to each function (klp_func)? This will give us fine granularity
> control. For example, user A has a non-replaceable livepatch on
> func_a; later user B wants to patch another version of func_a. Then
> some logic can detect such a conflict and reject the load of user B's
> livepatch. Does this make sense?

I agree with this. The ability to reject livepatches that try to
change functions that have already been patched seems like an
important safeguard.

Thanks,
Dylan
