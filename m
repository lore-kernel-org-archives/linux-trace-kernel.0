Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931611D9A5F
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502395; cv=pass; b=E22hsM3VQ+wOirPA0e+y05G5l8A+JGOLjjaM9wOvUhP5yrxzOmjiF92ZJhIaY2h/xrXI8VVf91R2G51u9qKsujN24oCqPxzsJBovncStKopwltqVE0nq3ODwiBI4gda/lZ4z58yev/svX6uENlyvSDS5GNNxrsJbIaOcwOwKiS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502395; c=relaxed/simple;
	bh=BDQNW8ZvNX/V2i20uKVZ4uTLX1c7zmnxZH47HzRTh40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag0i6TrbN1Un5qRsr6Y9WEBTq6SliBF1RvY96J/iRxzqIcZqTpg0dFlpgRrZVm17mKJqs4veSVZUKJPKVZ7PWkiPYgfmH9Ri1/GVxBCpTA37+qNikNDVHiNrGtDssLzFwczfPkCfGQw0N+uuEi3Imqd9I9gQDJpj6XOPNe7yaak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrLmQFqC; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrLmQFqC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836c4474028so30655627b3.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 09:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787502392; cv=none;
        d=google.com; s=arc-20260327;
        b=fibPWsFvWyBji/Ko5d5uzPwC6ls7+iRR3fsAgGuhJITER9/ZxbTA0WHr3WzO7VqzgW
         7mJQc1UWOliMVRTIxO5R/zfTMkRr4woYPDt3NoUoOo/MnC/+6sZRciLK7hXMlZav/nJA
         lCm4TyqOzwO3TCPuvvLv8wdqae7LRZ9kP5xK9gbrmD2n3/ge9WsXV4V6trlIqn7RXOSN
         1QK+zyfx4D57zy5fDGwUrhUZA97o/Jc02ixkMYhDNUo+i7Km/oU7Qjs1O2r2K5cxgRVG
         tpTv7HfE/kY+4akyp7IE0hve4o9hXU+Hcn9HodeSJT7yGpr9inDmXzIPc018NzIV0non
         Y/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        fh=8dIcXq5vbKloC4dGp9oHMBQnOerfs/1zI/Ph9UmpbwE=;
        b=Dz0FXwiRxCC99y/Myjj0FhArKQfJwXAQN+eyDwKRnpy93UwA1csXm6v0jNwB4yIlmS
         F4p3EpfgioUDIRFUI+5klgMkKZwQGPRI+IM/RHOKltDhkmz1Sz8DfK7/hNRhnB7obYeg
         k59P0KrWaxcoQqCvCKFTOyeYnS+WzolGumqJbel8QQkeELcx4wD5mNKUs5x5EE9mCEo8
         lBmCZoEg3iWFezVDwI/iHVzeINClPYPfdj2yX00UCKyjfLfZ5c/UhFX2KxYauZy5kWml
         4HxJZ2LjTliI3XV97yj1u+igtceKSs/3wwO0AGgVLLGcBsWR2atERv1axDCOwlQpOdQx
         Fe0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502392; x=1788107192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        b=QrLmQFqCL0ewWZ+m3afsYDif0Tx+uC1fkpr/BN2+bko3Vpde0jUujoMsK7ZJnrrbVm
         L2h2nhSqjw6bjv67wAQm/59WDtZfy6FjhfTxgTU/n3rDFBolog/SRcv6K55dtjzvvZuQ
         HlmY1I9C0lFYR2OH4WMMVHxa51MOii3xlyBL4jTk4ay+Q2Pb9iCu7jTCoAyurV2cWw/8
         aNP4IRkEJ48q/ae47evKoWqgBQ9YJP58e8FkQBnFJp//GxRzs+oxQ2Z6AsTCcmPlA/BR
         3jUxsqCgdBdjiucGJJ3AfcBnmA7UTAkkHN56LzFH8BRZzcHYcAVxs3OOK6XLDnm2s7qU
         p6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502392; x=1788107192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        b=I9BdUoi2QRGGcZC775KYbVC/Iv8OmDca+zxzBRKui7GosFe5OhhXNvMOUO3r+CV23f
         X5MtzUAR9cd3EXFdTsOtEExbTCwV8GujXB3BOMtG4I2iFsgRY2FFtQEvUaDnoAs445qr
         zSh4u2If8myySNRK+RzJZJEuaU4Lk369SJyJ6cS5/whP1ZwMoEwGLn6efr8H2Errsf5/
         g5oif0iPeTBWdEeG7yuhosPjZRjqvgXXtqyePkTyYNMXTEJVveegnPgpf840B7IfcvMR
         SeUb8JPOoLR5yDHHgUL1sCQmoy6w0TompmIjtQzD7dG9o4lF4WPp7px4hMK7zlloVYe/
         ydig==
X-Forwarded-Encrypted: i=1; AHgh+Rp/gEZaf4FVJp3yrOHtfym0IUHxgCndDgA76kn16sMxmvCFKbZ/PuLRjLCX+tSbvajtTwP+o1qJD5+arge0PfELCz0=@vger.kernel.org
X-Gm-Message-State: AFuF++lKK0AosE90EHULDDateKeSkuR1xZIfx9Tu0H+EtsPycgKiIjMZ
	PP17sHlKjjQSjklqexQjDLygBVFA/xPaGHD7JtoMbc24xUzC3c5Q3iUWKRYNIZ38aicJETYMap+
	HvdfKcvnObxgTuUYCgPSgpBcffqLY2u0=
X-Gm-Gg: AR+sD13VTE8eALdVc7YL2WkrzoCZ4xUKMRgQClyyxCZZoI3rQ/x0SIVcSuGEVQZ26aC
	LEuNOplsWiqiijqosz6NbF/y8+cauKyH0BnddE6YBNjOxkF8ZeTtAkI9ZJgOz02SjAW5T9PEb4Z
	6amYFqPPnLjoQNS14UzgSRcjxTjjAC9JkpgkKYkdqyKF8PLNrO3AfKATVElVfuyjtmIFMMil8k3
	0kWpvPU99iI1sdtPH91mWnCansVMqHmxHjiSZLSc5zFNmZiipi0y0jKLvdakKKYDyK18CQAeFOV
	DEamdKaa51TtMpMwg+UpmSalBBUVkbKItb+UBWbmKEg1rQ==
X-Received: by 2002:a05:690c:9989:b0:81e:c436:c530 with SMTP id
 00721157ae682-849f3dc401dmr83521097b3.14.1787502392507; Sun, 23 Aug 2026
 09:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
In-Reply-To: <aosT4H14zcowzU_7@redhat.com>
From: Keke Ming <ming.jvle@gmail.com>
Date: Mon, 24 Aug 2026 00:26:20 +0800
X-Gm-Features: AcwNN1VxhhHuJWSyjEp_qM83LgCzGJOv75Nr_zBbmcXDfn0tfuYCz0EE7A_cDJU
Message-ID: <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().

You are right that freeing the partial utask is not enough. The child
may still be unsafe to run after uprobe_copy_process() fails.

Would it make sense to keep the cleanup and additionally send
SIGKILL to the new child when the  uprobe state copy fails?

Also, should the existing "dup xol area" failure path be handled
the same way? At this point dup_utask() has already succeeded,
so the child has inherited the uprobe task state. However, we fail
to get the xol_area needed for the later setup, so the child's
uprobe state may still be incomplete.

Keke.

On Sun, Aug 23, 2026 at 11:38=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> (Add Andrii and Jiri)
>
> On 08/22, Keke Ming wrote:
> >
> > dup_utask() installs the new uprobe_task in t->utask before copying
> > return_instances. If dup_return_instance() fails, the partially copied
> > utask is left attached to the child task.
>
> Yes,
>
> > Free the partially copied utask before returning -ENOMEM.
>
> But why?
>
> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().
>
> Perhaps we should change uprobe_copy_process() to kill the new child
> on failure, it will likely crash anyway.
>
> But I don't think this patch can make the things any better.
>
> Oleg.
>
> > Signed-off-by: Keke Ming <ming.jvle@gmail.com>
> > ---
> >  kernel/events/uprobes.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index b25531331902..0c8a664a0fe5 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, stru=
ct uprobe_task *o_utask)
> >       p =3D &n_utask->return_instances;
> >       for (o =3D o_utask->return_instances; o; o =3D o->next) {
> >               n =3D dup_return_instance(o);
> > -             if (!n)
> > +             if (!n) {
> > +                     uprobe_free_utask(t);
> >                       return -ENOMEM;
> > +             }
> >
> >               /* if uprobe is non-NULL, we'll have an extra refcount fo=
r uprobe */
> >               uprobe =3D hprobe_expire(&o->hprobe, true);
> > --
> > 2.43.0
> >
>
