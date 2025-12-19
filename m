Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF134D913
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166236; cv=none; b=DYW/NIRlb0EUyVFwSIGu4yhL513lgOQinU5qPnhsxcr3L3PIoDyTy0GldKgeBYYX2zgMMaAl0UEZzz+Ukg8xqZpdTK9ZairmR5GOhVTu/VAGxmX7Vzg11nUNrfe5p4eQ18OrKlv8CTptWOGDwxl1t1bfqf754G4KXnGkNjE/gIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166236; c=relaxed/simple;
	bh=clJOmcKBoIw88yyLKoGsGuFZz1HxZegEl+3YdMQFKMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmrtsbZLDKs14jKdgjD3VmAwC5YCxN12fmEo+fV668n/1NQ/PvutqjUM0itSVROOqstcbOl+yxLlDSiCZxdxYMNekUU7UD5aFNDcRELa998RPBye4+0bsnKDbTOGpB8vBqGreh2KXy6ffeZgKa2LNFUThdGInQHy9U4nyBb/TYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=EKmKx6cq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="EKmKx6cq"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a2dced861so29749191fa.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1766166233; x=1766771033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=EKmKx6cqr0SKapJQjrfCqcQiCJxEOFpQA2bZrGPDQusRExrdzSg3O1cg8J1T1F5dq7
         HfCYi7J/PCL7b89wyYON+ZJtrp0ohFzsJ8hliEHDNCzVeYT5ZR0FjaJWmw7z0gVZBU3k
         VnTbSjiBfsG/mkpXxhBFIuh7WkNMfIwF4nezT0CJsdUN0d4XeZTbWOfHDA8FIeSWrc8s
         RCR14tbgbCqSiu8h291hp+zTNA7OyazxxPQXPQzBRL+XH9iNXpLbD+XsXJzjiinRm6lz
         SFv16SuySrm8CfnZOQbaWnQ2bxvm/ieh3XeW5U2AhEvwt6eKDtoJOOQdAfsVxotyzUda
         lWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166233; x=1766771033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=kiuTcZACmH0ntBow8ASSJW3cHb+vLSwYkmwBZj/eU3/fxlxyRxAOZiSnc4EhVtomLd
         8wVqTVnHXxqjzbMkHI66rrAQsxkTJv4N2UvWoJ/jzlUBmBZTj1kL8fVyebma1RtC7hLL
         Ar0ulwdiHB/lQMSZrJqyL1DGxoRyrtDie/MEppO0cgXaN3tESOpirMRhFP6l+ZYSZMmG
         DVdPpGb4dKF4hfm4cMXtkduYtJApJktjBqCY+vdf8hkzlW/Qe69dgrqye87VAKwTdTeu
         a1RhrVVv1B7k6VtGLVurWgJumqwW1XKTUPxHYVzsmpWQb9OSqQ8yhMisMcLCDwIiQ+PL
         UxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzzMtsshDxSonSv95ZT2NwFaFpKlCej+qIBZ4hGYCERaF24fjDPP2HVbHD7ihIdbnqCWEZGnROjN8gOcPXeLRsp8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKfGUmajnE5QACsX1KXcVoxBEnsz4zwtJdE4C5KPVV7EgmHFx
	yTClYn090oWOCC2njOUOui5fsOCl0qIKufqkX/P3mSzkv9UUckdiTWh3eEqlwS+Qr+r0rooewwI
	g383/jybvVF8y2iCk+vvunSFVsujFP58=
X-Gm-Gg: AY/fxX7iXom583G/C8RIVz9qcaId0TWv/GTAed/mPl7pJHUo6EvEmvYBDaL7wrEOHVO
	mdt9Wg1gaihHGRu31toJJo7IeQhyuRuMFbi+nh5LwaTKcor5TpjEytx+5lPouoDmJ/HH6yxBJlV
	qhdwhNQjgO4zirKttkdoiLV4Q4ifSLaiV9aRrq3KcQ0+SVC9A3qALntWhKShzH2Dx5dOVZ+Sgdm
	WwBePcMrI58a3byYi/MI8FvoUO0rcyLpGIW6bTIt8o8S+Kg3wo5+wYYlfbJoAzQ/uYAg2GgrFh4
	p3RA7RxqYLkogw+XJVb22ZpPucpVlQ==
X-Google-Smtp-Source: AGHT+IGBTzirJN0UMNYnb3SF06ff10PRsmk6ZfxGaQEVs2SJVv9RMQ8FyELJ0lDv89cOigRB7MBj/ZxfRIZYQuecn6E=
X-Received: by 2002:a2e:be1b:0:b0:37b:9674:f480 with SMTP id
 38308e7fff4ca-38113248ba3mr22256161fa.11.1766166232887; Fri, 19 Dec 2025
 09:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
 <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org> <CAN-5tyEjYRFrJ7Gc4S8KwAZUuF-uz6ovPa4-_ynt+GGVqJHN_A@mail.gmail.com>
 <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
In-Reply-To: <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 19 Dec 2025 12:43:41 -0500
X-Gm-Features: AQt7F2o2e0WOyiUDgBbJV-UEiZdMnMvYpMz7N-BnEynBqDbI0To7sXd0rYxMHwc
Message-ID: <CAN-5tyE1YazMhYJX5qT-YM=+h_rcQ+C9PZBNEEvwWRnWZtLXGQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2025-12-19 at 10:58 -0500, Olga Kornievskaia wrote:
> > Hi Jeff,
> >
> > I narrowed down the upstream failure for generic/215 and generic/407
> > to this commit.
> >
> > Let's consider first where the kernel is compiled with delegated
> > attributes off (but it also fails just the same if the delegated
> > attributes are compiled in).
> >
> > I don't understand why the code unconditionally changed to call
> > nfsd4_finalize_deleg_timestamps() which I think the main driver behind
> > the failure.
> >
> > Running generic/407 there is an OPEN (which gives out a write
> > delegation) and returns a change id, then on this filehandle there is
> > a SETATTR (with a getattr) which returns a new changeid. Then there is
> > a CLONE where the filehandle is the destination filehandle on which
> > there is a getattr which returns unchanged changeid/modify time (bad).
> > Then there is a DELEGRETURN (with a getattr) which again returns same
> > change id. Test fails.
> >
> > Prior to this commit. The changeid/modify time is different in CLONE
> > and DELEGRETURN -- test passes.
> >
> > Now let me describe what happens with delegated attributes enabled.
> > OPEN returns delegated attributes delegation, included getattr return
> > a changeid. Then CLONE is done, the included gettattr returns a
> > different (from open's) changeid (different time_modify). Then there
> > is SETATTR+GEATTR+DELEGRETURN compound from the client (which carries
> > a time_deleg_modify value different from above). Server in getattr
> > replies with changeid same as in clone and mtime with the value client
> > provided. So I'm not sure exactly why the test fails here but that's a
> > different problem as my focus is on "delegation attribute off option"
> > at the moment.
> >
> > I don't know if this is the correct fix or not but perhaps we
> > shouldn't unconditionally be setting this mode? (note this fix only
> > fixes the delegattributes off. however i have no claims that this
> > patch is what broke 215/407 for delegated attributes on. Something
> > else is in play there). If this solution is acceptable, I can send a
> > patch.
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 81fa7cc6c77b..624cc6ab2802 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6318,7 +6318,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp,
> > struct nfsd4_open *open,
> >                 dp->dl_ctime =3D stat.ctime;
> >                 dp->dl_mtime =3D stat.mtime;
> >                 spin_lock(&f->f_lock);
> > -               f->f_mode |=3D FMODE_NOCMTIME;
> > +               if (deleg_ts)
> > +                       f->f_mode |=3D FMODE_NOCMTIME;
> >                 spin_unlock(&f->f_lock);
> >                 trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >         } else {
> >
> >
>
> That patch does look correct to me -- nice catch. Have you validated
> that it fixes 215 and 407?

Yes, it does fix 215 and 407 for me.

>
> Thanks,
> Jeff
> --
> Jeff Layton <jlayton@kernel.org>
