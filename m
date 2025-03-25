Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906325E81E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926232; cv=none; b=noewFEZVoNYVYLrOE1jUnyZSskDROps+h2vwb6vvnejt39foM7/1BHraiK589QHG2hYayRLWtvmyLeQ2BZ7o2MbV87zCHkvelEf82Ym2FNYE3LkO+ln33rOPBWrljJQDPF2SyG0ZtMTTaSO+7yziDOk2r4RoRcM9YOq0d+k/hOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926232; c=relaxed/simple;
	bh=G7r1GbsPLmnxGwSjE5gsz+gadLNPnSru255ddOGFLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZJ1dd1l6gUINm3ryybcs2KhDchFMS4kajtAw4VjIg9nr7/NRM5wx5/0/CSB5FPj7c+GTiKfEoPrPSskNHbUg9uhvyE6/p6piqBscCn5CdSDS+HXl0rRi0krIZoo0iVzqu2zmxwewkAGOzzysx3EQ+x8VriEIQYi4zui0TPTCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=HBOWgvPY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HBOWgvPY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30c091b54aaso59622001fa.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742926228; x=1743531028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdkDWndGvAqxTQdNuG9qdKJumGJGvc4+oXPHz+QmmLY=;
        b=HBOWgvPYNzr1bCgstHLM2glV6U+h8InnDtGkJ0ovgIRZyNkLAsJtv4WL2qTDH7Bkt+
         A5vWthwsvkdmo4Oe3Mr4KICzFINdxYgrgiDa56LI5LNQ804CDTjhdD3bXmoi2ZJU2v++
         HAmWArIMZaGOhqyel/2DaQHTYwAaA3LkZqCqJQIg6XJ+1B4dKyAWh5dF9UFN5yomP/bU
         RhiQg3qyt89D1p7r3vNtIM3AMsU5RBsNf33r/g7JhyrlPbPwquQA8BezFznNsCIUSIrI
         s6TdDZZormXWlMyQ90e9oDks9mzemr0MmV8RB7q9RHw1GXs9uyIXa8F/ae6Wg8lV8Lwo
         /EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926228; x=1743531028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdkDWndGvAqxTQdNuG9qdKJumGJGvc4+oXPHz+QmmLY=;
        b=HGF2a9ixE7Ae3l5JdDIRyJDdgFmeRwlm+gAkunirJ2Lp5hTuVRlz7yZp3Smc7LDOYS
         KuWAZ8Uwy3+LSxWh34E62FVZJrv7JSx2TZJQ17djfz/3jUX3g+eJsmjdnJ8Tek6xNN2w
         PsInM3+wJTJDnhJ0a23gYZZp7GX1dZtoKogWCbO95/4rsiD8c/KL0H/qZ8h9eVu7v8zB
         KB6w0TRT13Gcy+sOrNUJgG0nTOzCA9wBG2YcLIjsJyaj5E/W+GzlJwp+uVU8sQIuZ9zL
         UsEeNtVdjA2MO4UajDg3hWinHYS3xkD3pneP0GH931z+qJjPkE1Q1BRnL3rf7p0Ys1eH
         QmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX74CmUrn7kerOEsesEF+jUPkcgZWJzcyWaSxNKlhzi4u8XEFpw4BvcqUZtPsXipN7bfGCsQSPxD4hAR5BodfoozNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmTur7PqV/FacU6YqdBO51vTnQSc/1VyXMFfNyjrcH5pm13Hw
	XKmX2G4pS1OgT6jpmswqRDwrjZJMHzqb0T3U7fZTm9Xc9Hvt6nUOfGnbgJgN1domqoViWQatKxA
	ncRqoKctGUVtVl07wp/Tb+3ZpSYuP7F6cxgsT
X-Gm-Gg: ASbGncvxbAE/hdVRBI7GPOhTn/tn9cRdiBORN8p0a99X9EGMJILb14bip5tj94O0vS7
	nKkpWuharQm3Phtl0aqR3ERMw63zSsxhDMhT+RSFS4xIue95tVPw71mPQ4ZNheKqLO6LwzXox35
	HUgOuv3VhVRHBo/ql5AivXpvU3PBfVM7+DtwY=
X-Google-Smtp-Source: AGHT+IEEWuzPv4jhYI5e9TnREp4dt9M5G/jSb7CHGQBe+UYbUlr8OZjHY6oWKj08v7HeJt/k8ZhE0iKgEMqBb+IUsYI=
X-Received: by 2002:a2e:be9f:0:b0:30b:f775:bae5 with SMTP id
 38308e7fff4ca-30d7e1ffc0emr64727201fa.6.1742926228467; Tue, 25 Mar 2025
 11:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home> <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
 <2025032424-custard-volley-bbb6@gregkh> <20250324150703.69665622@gandalf.local.home>
 <2025032548-happily-saxophone-4079@gregkh> <20250325081551.270947fe@gandalf.local.home>
 <CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com> <20250325140223.534df027@gandalf.local.home>
In-Reply-To: <20250325140223.534df027@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 25 Mar 2025 13:10:17 -0500
X-Gm-Features: AQ5f1JoXsnXMVfcaXuov1qge3FFsLlwswCC3ne_ge-cKSrjD8aBB-M3RKvv8OrM
Message-ID: <CABEuK15DRcNDj4Gscw3xuonJ5uCrqb34qB-+MzyAmxZn=h_X=Q@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, linux-trace-kernel@vger.kernel.org, 
	Kevin Mitchell <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 11:01:41 -0700 (PDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm not against you doing that, but it is specific for your setup.
>
> If you do this, make sure to test it by enabling:
>
>   CONFIG_FTRACE_SORT_STARTUP_TEST
>
> Which will verify that the table is indeed sorted at run time. There coul=
d
> be another bug that could make it build, but not sort it properly, and
> without that config, you may not know, but it will cause ftrace to not wo=
rk
> properly.

That sounds good to me. I didn't use CONFIG_FTRACE_SORT_STARTUP_TEST,
but I manually verified the section was sorted by checking the ELF
using a Python script. Maybe that is something we can consider adding
as a build step in the future?

Sahil


On Tue, Mar 25, 2025 at 1:01=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Mar 2025 12:52:43 -0500
> Sahil Gupta <s.gupta@arista.com> wrote:
>
> > On Tue, 25 Mar 2025 05:15:10 -0700 (PDT)
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > How important is it for you to build 64 bit kernels
> > > on 32 bit machines?
> >
> > Yeah I don't disagree at all, it is a fairly idiosyncratic thing to
> > do. There are some historical and business justifications for still
> > building 32-bit in the first place, but until we deduplicate the
> > kernel build, we will continue to have this issue.
>
> Note, that the regression is only the failure in the build of your setup.
> As your setup never supported sorting the mcount location at build time,
> that part is not the regression.
>
> >
> > > One solution may be to simply disable
> > > mcount sorting at build time when it is detected that the host is 32 =
bit
> > > and the target is 64 bit.
> >
> > We are currently doing this. I imagine the performance difference is
> > trivial but if we can sort at build time, we might as well. I have a
> > fairly simple alternate solution that isn't backporting all of those
> > patches. The core idea is to introduce another macro, parse_addr, that
> > is defined as
> >
> >  # define parse_addr(buf) strtoull(buf, NULL, 16)
> >
> > when SORTTABLE_64 is defined and
> >
> >  # define parse_addr(buf) strtoul(buf, NULL, 16)
> >
> > when it isn't. Seems like a fair thing to do considering unsigned long
> > long is guaranteed to be at least 64-bit and unsigned long is
> > guaranteed to be at least 32-bit. I can post the patch in a stable-
> > thread.
>
> I'm not against you doing that, but it is specific for your setup.
>
> If you do this, make sure to test it by enabling:
>
>   CONFIG_FTRACE_SORT_STARTUP_TEST
>
> Which will verify that the table is indeed sorted at run time. There coul=
d
> be another bug that could make it build, but not sort it properly, and
> without that config, you may not know, but it will cause ftrace to not wo=
rk
> properly.
>
> -- Steve
