Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C9317715
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763770; cv=pass; b=LiBazsnn02Oig5/xvUPIangixT6Oxo6o7ykEauakC5dcQKzpJdA3f93+3LcQFSlzP4tHwxz2sz/IuJM5zQ/TFRd5JYl7v4TlPMWm9adMbptJ/JY0IahrAIG3oSu70OALZ37EGyTjDFLpN08s7O/55Bw3YXPvUJPukafpElezMb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763770; c=relaxed/simple;
	bh=36+GLnvjJ5wULuhs0ecsYidI2Ew/OmF323KJtini3BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRdW7fI/Thv1yaJwB3S3W+GJJL526lUhFABuGHkYV29cDSTJs99OyLVE7N34stm8y/OslZOxuo1WAwCRlGqUmSaQ5+GStuGDntvBSWp8lG/HF7xxmC+0EsviEvVVNsGXqbqUgwYw4UDPKqkA18T7gHX6CqLp98UMyeDlWr1Ubik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsBz9o/D; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsBz9o/D"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad9238d8fso8588143d50.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 18:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763768; cv=none;
        d=google.com; s=arc-20240605;
        b=cehf4BF9VpZeI6MEEf21eaCURlniB9IKl2IPdjtV3Uis6+/l4V7ycLHIIuE44Pr/xQ
         x1eGhFOPGrt0unvFZyc0X13TH6CS+Wa2cXwOgr58LglwrDgvE3u93N6dIemRm/1fgXq8
         1gdUGPnyjKa1mtdOY0ilzwVW5hWGwHZjVfyXR75RiFKAauB/GPsqGotxuNuFn82jFMFy
         1itFyWQG/WREm8yKXt5DlcWG6sKfrTEXWJRFsmdNoBz2+px21kXY/KfI7A4lAZu6qKU5
         aQkbf7V1E8aMuhpWFKFVXB4MynX8uAbb1VUUA3ctPWJrdbOoRjQhNpuccVqi/w6TiQuU
         WRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        fh=CJTKOg4y/0/3F9p5gw9Ra2hGLrjxvnksBPdLZsCKvWQ=;
        b=DZisU9uyKbcNvx1Xi2excuzZc/rlfEYSmOY9NMYriiT0YDmonFvs/wyCuYkXeRmeqA
         hfIhf/6S4tvOxb1Z+aazjH5ZlKKPXBxrWR7Vkd8KnAV7+LM9YjWYYlYQCraVByv3Wjly
         61hF+iZSjpoI7FSbXe6qN45BL0ahod2G8kSq7Z6kbEa5inQojASSuk30wGHcF1mUNB85
         ke0VL6nJthR+XAVSeUYM7pwoyxQbTplQq9LWDTghE39sS3tIS/G0qOeFdyGdNmmE+aW3
         kMNJceNswxiBP5uYAlkrcjIC+ZfBgR0UoiLvgR0b7ODoCnyP7qfBFcGFRV2Nkwz2G4DP
         5zWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763768; x=1773368568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        b=AsBz9o/D/N1VRciB7rbTzhjDzZxBQJUALB/iL1fOPqg14gW+3mCX/p2hboxnk9NxOZ
         PhRqz4Oh2zRV7oiWlk2rbRGjbHxvJc/X72hT2L1YvXhJ15gx+0VAvS2Sx4jWcQmNIrq4
         tjJhCXo69E/NE5yUlmavMkhXknLVsdrxJaXIvwuSlbY+SOXgo13oGcSYYS06VNFI2ylU
         RSPu1cTeXe0n07kv+Wi6QoxFz9XdK2AWxe8MPcVuJfjKokEtl4S4hNJ/M0saL40Ngxeu
         GrCquRFI+2SPQPg0ysVDsMLusSRK5dHJMwXOeh7mTKz5nfunpEkim8HyqGwVRIlt6KQv
         lfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763768; x=1773368568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        b=tkEQQ/4+sudH9e1NTW9fzfq6os2+phB1H3wobnIyrjYvjswopRgtsvTZLetb6qsmTj
         C34ebvA42POPvtzZpL7IwIzWH1Jig6pjDJhFwwCMBUWxXpKA5cL8i7+zzteB4yZusj5I
         Gp+Y7gItrOdG0xSNYMgdrju38tiNjRCsKlLAu3wGeABmo/S8DxKs80OmikGpcbkO3fpQ
         JgyC6x9d5YiuO7hBLsgIiTh8wOdE5gM14WhVKNaeqFykbCA0MTKx4ghlozpIpwZPftrj
         po11UbuyKiZSUCOoYmrpSu1pel9b/xeq2GVBq4k/EOCxkpAvxwSeBM9c3nsLTM+2MyPc
         B+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVVSLX/ANiYXSnK8lHMmRom4oQ2WHY2zH9d8fY8C4fBIDnDAbZCJSg8T32pe8frtsymO4U0YZlj3FThZh0YcY9rnuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2PV5JAhDUxv8TapVsi9t6vL2nu3fUTY9jkpMQKeQ/bb5Lhr7j
	WRZwa2MkUj7LXamgW7sIcoL9XvhnKB4s4EHJzkYbZAi2OVFFzPs71ANj24M42jq755TRTOJblxG
	cBLhmLseLwUzS8MnUKkcfnQYTMQih9dI=
X-Gm-Gg: ATEYQzyRP3fm6+u4ej9w9Pe8UsuqS4ibQOEPRo8LdaRIgib1I95KVhfRVxYHnk9YxPt
	SbCEjv+SDcy3g//VQ3vDUh+YWSLHj6bhhN0kXJ+r4/Slow4oet5nyt68Pg6NHyI0EOhcJcu1WDn
	AveZkXLsrkDWvmdUPoRqXQiXQFl7gmZvB2sV4xdJpXgEyK0FSSs23l227ypzSyt2DEo0aXlckly
	Po4xuYSA5AhftyHYoJQUq346VvJ6tzlEtC4HE+IN7Cut11GA2uxVewsUvBt8A+DsPnRgs+t06Om
	DL54zOoIow3XEw6Y0tU=
X-Received: by 2002:a53:ecda:0:b0:64a:efa9:8e35 with SMTP id
 956f58d0204a3-64d142c713bmr469298d50.45.1772763768097; Thu, 05 Mar 2026
 18:22:48 -0800 (PST)
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
 <20260305082125.35d8539c@gandalf.local.home>
In-Reply-To: <20260305082125.35d8539c@gandalf.local.home>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 10:22:11 +0800
X-Gm-Features: AaiRm52hsuVqK9SgiYx4LF12Aqa_dGGhajOTkecgH3f554WneFjWnbX_KDwr0fM
Message-ID: <CALOAHbA9u2sHSYRF_kDKpf2d_UADQFu-1BMWFhBTo3mvgf6kFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <longman@redhat.com>, David Laight <david.laight.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 9:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 5 Mar 2026 13:40:27 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Exactly. ftrace is intended for debugging and should not significantly
> > impact real workloads. Therefore, it's reasonable to make it sleep if
> > it cannot acquire the lock immediately, rather than spinning and
> > consuming CPU cycles.
>
> Actually, ftrace is more than just debugging. It is the infrastructure fo=
r
> live kernel patching as well.

good to know.

>
> >
> > >
> > > BTW, you should expand the commit log of patch 1 to include the
> > > rationale of why we should add this feature to mutex as the informati=
on
> > > in the cover letter won't get included in the git log if this patch
> > > series is merged. You should also elaborate in comment on under what
> > > conditions should this this new mutex API be used.
> >
> > Sure.  I will update it.
> >
> > BTW, these issues are notably hard to find. I suspect there are other
> > locks out there with the same problem.
>
> As I mentioned, I'm not against the change. I just want to make sure the
> rationale is strong enough to make the change.
>
> One thing that should be modified with your patch is the name. "nospin"
> references the implementation of the mutex. Instead it should be called
> something like: "noncritical" or "slowpath" stating that the grabbing of
> this mutex is not of a critical section.
>
> Maybe an entirely new interface should be defined:
>
>
> struct slow_mutex;

Is it necessary to define a new structure for this slow mutex? We
could simply reuse the existing struct mutex instead. Alternatively,
should we add some new flags to this slow_mutex for debugging
purposes?

>
> slow_mutex_lock()
> slow_mutex_unlock()

These two APIs appear sufficient to handle this use case.

>
> etc,
>
> that makes it obvious that this mutex may be held for long periods of tim=
e.
> In fact, this would be useful for RT workloads, as these mutexes could be
> flagged to warn RT critical tasks if those tasks were to take one of them=
.
>
> There has been some talk to mark paths in the kernel that RT tasks would
> get a SIGKILL if they were to hit a path that is known to be non
> deterministic.

Thanks for your information.

--=20
Regards
Yafang
