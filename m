Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E625DD1E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023687; cv=pass; b=olihCaK8aFK3Mny4s8ji3cIdyE3R95pHNSXSfXOCDmj1Sh/IFORtTJGjs9EUZTf+S9xXxMtFjXxhcEv5dSM6j0+YngzyBBZn2xEqC/1aAerTYqLlw7wah14ipTf2hPe78+4q6YVNZBl+kzKTt6ltrN5DRHDt22AvVVJ/JxroW6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023687; c=relaxed/simple;
	bh=ArRb5Li4I5zm9vW2pN6vXHvRZgL/NSLUxj38XACQLHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVQd9wxaWuXj7ne5isDiC/815HqyXfxPfv4jAibSJHb4VK1LhLty1N+i0kibgPJMczfg4RbMWHMV99GqsflRgc427m4Bc4bLbutTvB47lF4g6QSn6AdyFSLbFmWoTRnz44IF0KbGDfeWd3CLp51wOaeoxSw+HL3UAdcUasKzKoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lApO2HjX; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lApO2HjX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986d231b3cso138856517b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Mar 2026 19:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773023684; cv=none;
        d=google.com; s=arc-20240605;
        b=B/Puvu69Ul21VBi62y3TNWdPrZcBDz2NbaK30qRLAPmKuUrjj03fwnlUI8Im3kj9cx
         rQFOTkHqajuH53DRQ0K6OnXpB4M2pDofA6ovydZ3wzo09wtGW3DNzxQGk9FeJmzsZytY
         1f26yeillBsro4lYGEvJN06/QYuFZx2p2wRwicN09+3T0LbHTJ6oZZVqmpEIR4K1MUx6
         xhzM+Ji8UrCFxUOuQNhokfSofsltAJXvNgsa7jMJjeXufnJk98WpIgO9cCZ8oS1JQ+Ur
         uUkwJF4HL0i5aiOrSG4jvqOUgyc8xhiBgf6O8vlcvM2BbRKqdHCChRanYNHP5yNMkL/9
         Gupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKAY8tUmGNwJhd/F7pnirLa9VDEJIqmLVmxW8N9odk8=;
        fh=3yg+otbvxG0zpdE78yjhQJvTXHCn9x96Hzb+mqL5ib0=;
        b=dnUpo8UHWESnnKdTYWUofkBNuZ+RocACrSuIdPxoKg4KKQJzT1MVgX9HpgYMrkBvOw
         vZgj7/u0gaRoNFut+091ya5cx6M+0nMzX+8hMU5JHdrp8V7F+a/VjhpzUmc5L5aPYZQx
         uXF745eNPSlCgGeq0Nh5xY5RuQOs0HsJtmuUcdLDzSv/p5XSWPZ+ga5OWY2c/Rl1A4Ca
         BYs6H5zaRKHKHe3If+K2FGl/Ydnm6PP8Ad4f05wgKMXS3h/VEvzGkhGpTJwiXItrqELy
         nGJ7X+33i0bed5UdbyYGskGnRcPRsa5ocrdxHKR/1i9ILn8I72ntzIPutSW0uScJuiJa
         BgEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023684; x=1773628484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKAY8tUmGNwJhd/F7pnirLa9VDEJIqmLVmxW8N9odk8=;
        b=lApO2HjXee7b5Wl5995T/t8o+caEK/pESKhOMeWmoHnVz1LIZDPs3OAWRUwLZmry37
         Za2NtP9dxxctaOVbAlgVPddRtLlvAFVmD/YA0zrJuGEfZ0BILV5YJVgPEf/I3f/XoahM
         Hri3ho9u8jjxMI2+7SD1sQ+JoFeUXtU85WgwaM17AZEMpRdx43CiH3uAAgngSflGVWwx
         tqOa2cHg81Ot03rraXlnwVucSWSXLKjlGV7oK/bRNWlVp4D6VWym8o4Ah9c98S1/WryT
         zCQFO/D++A/KEFPN/n+nOAaKjFTZUPv4OlXFVS5nJYiPsUZmbEw3ZoUYZvp9eNmy5p9V
         uygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023684; x=1773628484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKAY8tUmGNwJhd/F7pnirLa9VDEJIqmLVmxW8N9odk8=;
        b=TePNzPQZSTNkqRG0AcLzgvn+GpxLwRrFBDHlh31o1I9o+PQyNxmYMBW1OwylYM39l0
         jzo4jvvCR3oCXQSCGQhhWnJRrpEqD94jHceVNlx0jIXTIc2aYWpzQKdvg9UbVnc9LaCx
         w+/C+apjx50LyeTZBJ+nApY8aHYHSEvhvTmWxxyuGKVKi8O9STNfeKG7ym9bd6mNh/HF
         7xzIkKPHtyACZOsJuk1JmhHEuVnlPBiVZAc2ycEOdScdXvbFXGESGdq6i0Gu+Nfo1Dsp
         QsTAHLmQKsRZzD8gMLlvM2MxN12vYEbwTFvnHJ8mkYWTVcRFj+7FqhHl2sKTawoHcL0c
         /NMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZtI1kky9aamMSCJDChHH6rHrtXmufcW/y8lCj9igamBrbm5fiJqy853CqzCMLldRMngYQgsRl7Wvoa2whByZFjSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRDGkj71KT/9ZHh1I5mZbFvrVmNnge60p3WKvlmXzfmqlAozJ
	agFccK0JWMHWxcLHHZSUaPCInKzIlCwB8H30pDwmRdkg2OGjekN47BtgHPKAPNko/uY2a6HDyjV
	kBBSlHDCBm1D5CfRGNpLWlxhrLJzWiew=
X-Gm-Gg: ATEYQzzgBflFydBcAE3DFvzlGte+eXEYx6hF6uRFW2xk5R8dQGjM1ivVHgTb+sgwqlc
	5iQtvC5oRjE4Zrc9JpwpdHfshHfrVXA5bUXvUW1b1SePSab7/w27PRqgmpWNdZ5rXNGrHhCcz59
	Hux74cP1kaLulIgv8agMfpyxHacVvK6ghRRRd138I6TKkevAzfO65rXaarU4xeTei91N/3PuXcz
	dWO7jEy/7j/ygd3xUd3jvQquREgKnLzz+yeut/NLEI1GuzRN12HsTg6YKUGDrFqpogEjxJscyzn
	1zuMHbRL
X-Received: by 2002:a05:690e:1208:b0:64c:fdb0:894d with SMTP id
 956f58d0204a3-64d07185811mr11343304d50.42.1773023683806; Sun, 08 Mar 2026
 19:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin> <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com> <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
 <20260305082125.35d8539c@gandalf.local.home> <CALOAHbA9u2sHSYRF_kDKpf2d_UADQFu-1BMWFhBTo3mvgf6kFQ@mail.gmail.com>
 <20260306100047.7c4725de@pumpkin>
In-Reply-To: <20260306100047.7c4725de@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 9 Mar 2026 10:34:07 +0800
X-Gm-Features: AaiRm50iDdiXD-_RvD8Nn69yibWAI7Y35JFbuH0rnn-jz517KrJX-lOFc1fCffQ
Message-ID: <CALOAHbBdetsUV76vnzOw60-48hkjVs2nJa8Nzxh-jNvtr4E5iQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: David Laight <david.laight.linux@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 6:00=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 6 Mar 2026 10:22:11 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > On Thu, Mar 5, 2026 at 9:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Thu, 5 Mar 2026 13:40:27 +0800
> > > Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > Exactly. ftrace is intended for debugging and should not significan=
tly
> > > > impact real workloads. Therefore, it's reasonable to make it sleep =
if
> > > > it cannot acquire the lock immediately, rather than spinning and
> > > > consuming CPU cycles.
> > >
> > > Actually, ftrace is more than just debugging. It is the infrastructur=
e for
> > > live kernel patching as well.
> >
> > good to know.
> >
> > >
> > > >
> > > > >
> > > > > BTW, you should expand the commit log of patch 1 to include the
> > > > > rationale of why we should add this feature to mutex as the infor=
mation
> > > > > in the cover letter won't get included in the git log if this pat=
ch
> > > > > series is merged. You should also elaborate in comment on under w=
hat
> > > > > conditions should this this new mutex API be used.
> > > >
> > > > Sure.  I will update it.
> > > >
> > > > BTW, these issues are notably hard to find. I suspect there are oth=
er
> > > > locks out there with the same problem.
> > >
> > > As I mentioned, I'm not against the change. I just want to make sure =
the
> > > rationale is strong enough to make the change.
> > >
> > > One thing that should be modified with your patch is the name. "nospi=
n"
> > > references the implementation of the mutex. Instead it should be call=
ed
> > > something like: "noncritical" or "slowpath" stating that the grabbing=
 of
> > > this mutex is not of a critical section.
> > >
> > > Maybe an entirely new interface should be defined:
> > >
> > >
> > > struct slow_mutex;
> >
> > Is it necessary to define a new structure for this slow mutex? We
> > could simply reuse the existing struct mutex instead. Alternatively,
> > should we add some new flags to this slow_mutex for debugging
> > purposes?
> >
> > >
> > > slow_mutex_lock()
> > > slow_mutex_unlock()
> >
> > These two APIs appear sufficient to handle this use case.
>
> Don't semaphores still exist?

While semaphores may present similar challenges, I'm not currently
aware of specific instances that share this exact issue. Should we
encounter any problematic semaphores in production workloads, we can
address them at that time.

> IIRC they always sleep.
>
> Although I wonder if the mutex need to be held for as long at it is.
> ISTR one of the tracebacks was one the 'address to name' lookup,
> that code will be slow.
> Since the mutex can't be held across the multiple reads that are done
> to read the full list of tracepoints it must surely be possible to
> release it across the name lookup?

That's a great point, though I'm not entirely certain at the moment.
Perhaps Steven can provide further insight.

--=20
Regards
Yafang
