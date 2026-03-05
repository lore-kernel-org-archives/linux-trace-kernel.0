Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA032773C6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689265; cv=pass; b=VdBjQLKHbxzhznMhbunTMyzrBgiP9iZvNxdJ09wffpuk+hNaaSGJGf5Bi0EDx4eNiKMXggTwiYhCwPB7A+Vb0zdmEbRUiJ2iYKBx6Sgr5RfxSxlycHItJFiqnCAUR7xOJdtNtI2xTz8fxOUATUhC0QyzZa+IN9JViS8nfwBsK64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689265; c=relaxed/simple;
	bh=M27Yna8X0zrfWHnR+isYLz70HtJwqqK1k1ckUICdl1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb13TGuvLJW/ihI49O3m9Vaycq7KkdiPneZQ2jHsOscJVwulPpvY+GQWKxEbboVzttL+rMMkgODg5tlvD8QNd0vSup6UwjyPRMah+KbsMasfQZIApgnxy5dngotAdJ5TArEOwPqDuQSH4Ic6hvss+6uT9ffoRXhFjqUJeL++38w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nps2Sm00; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nps2Sm00"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986a347d4bso75274337b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 21:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772689263; cv=none;
        d=google.com; s=arc-20240605;
        b=eHP4DcZC2SZGtN5YD33nj0qOoOsF1lZiNCK7qOXq/XkwKA6K3Bu4P0ks9OMnukyDpC
         RPz+bjTlogyHIv2IbuOUhxWdVU/x93CRMFKVJTlcJLZSHwxjCBJj5vPGyZapT0jqP/Vj
         IWhJDNr2nFp6fV+DODKjymYUfOeLJqTAOrheclcJEaafJsgpQutHddEeKs8/pP6q+qCw
         U1j2cOE8FwwuLp2eu6BdzOkMbf5dcJz1N7EA14GXN7YbdBsdYzn2xMU1WSgTdOhxdfPK
         NeKgT+BndMOcBAKlPruDwfUC5pkekLSwLGB3pdeLUtvq66RqcpGRv9782Q9CypYWqHOG
         FmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        fh=++hs1WfFx8vP8kls4usFh4CwNgtH3GsNB5VacHLKIow=;
        b=gl3w/af3Q4LJApJ9zzim0gdOwEe0oIJ/gk3C++fS1I6U0aODaUnw7dpx2NAv0OJyGI
         eDmTZMyx3nyxy17k9zmDa3Ycgts33G0qUYyicr+N6Q9HID2Pdyq2LkEdf62I8loUG48k
         2ewcBCpCwRvuLB+9mIAU3KvPXgAIB3t9FBdTLU6qHmsSOpDsaR8rL9VBgB3oVPAGCR6O
         z2qHA6sJkGA3nC3Ts3bAWDVI3t1C0aG4CJdNrj0yZrl1kFJTJ5zE5G7aaGvfyyAUC/ri
         TFSZmIu3ry0EOKECx3aWAMO4TVFx3PKJaqWTuPMVTXdv3Ynoydpkp9TBnbBJnVK/q4Ay
         st9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772689263; x=1773294063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        b=nps2Sm00SxUNhSZgi8NMp9co3N4o2zS+phWsf6o3zRz/paU8T/4mmhnrtVSADdxB0e
         JwH03ltlVKUW558AzYGVVOWsHhESz4tK1YCYw9MPSuiT9uDBWHoxRy5nhdq0MFlNFzyc
         LFop4jHMxkJRjyjiYek+KEmk0HooOwATOWPGd3RO6kob/YgVzSmeqnJJKLkyPDqXDj/G
         5pN/xrlESiNLv5G3Xv75HkQbiY68JHWt46kCkJy2Bcl0U+YikR9+H6O8/YK8mQLIAIk6
         m8eZkEseiLZV0lTAJlkTI43fZ7TALcDN5EFWCYZtJoMwI1LhfcJc9tfOahjQDuAq67OP
         auqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772689263; x=1773294063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        b=nUmKXqAHSG5BfTDxN0pBN5hs2g3tpd3YA+YEKR+HKSc9hsg5tyiKb1zhnAyS3NncnF
         lCyV/jizn/zGsOe4vaRvyyO6yOUzMjrQSj3l5AWd+snzDyrBr5d+9DMFyGh74F8Bk5Yl
         h9+CPe2X5uWJ0cD1kU6mG5CE5L1YJ+6OoVamEXcUC+f4hX6Z+qp27/cKoazPicrS4nhd
         5OjoAnA4oEblIdtxLyrsfMnmMM0tZdgx+GJGd9pD8s30f0UHsF9/FzIyfIj6yKTifcT5
         Vqo88k6ud0aazgzLXqjI2OSmYyqK0hmczw/5OCPj0RRPgo0iNJTkQRWOM1bTK1FvYAyr
         Kh+g==
X-Forwarded-Encrypted: i=1; AJvYcCU3gT31qcgBWGookHD5qzfzXd2V3mJnWEQ2MaqBnTYBfGkMBwuxYXH+WevE2Zzd0gxoAAodu8bq5Jx7EeBpE8GTSWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZNHZ57B+0HSD7lbO31f0Hs9oAsLwjIwBgi7j4Iizl6ftdQxI
	BjZGUfAXnj0u0ok+tcXL+sQCJDjlNVQkPgPAPgbdbH601O6PDuUUbhYuba3p464PBBBPhBBN4bu
	hKSDu4Xr4lI4UJwnlEUlduoeT3ibFh7k=
X-Gm-Gg: ATEYQzz/xNe6vb3UzIeTb2yZuNGH6hbD6VrG14pha/mZyWxgYRwhwc+dIJ9YzaLJ29B
	Q0l1KHQ9SzOeaptW/rYvJ3zKqx+gpyQwdHm7rB4vV/qEIPtswkaOp9Nj4dF5ffhMm6s1jk+pf2H
	rkhVXb/iKPjFoYuwY1zH48MxXNQAlv1put4b6n0xjpAHsXh4ejYbqqsFWRpnHapVD6y+bY/vHpD
	L+XZogwHNzIqm9URTckbX551ETsv3QVcdf3pV/xQkzkBPe1aBp/h7Tid8mZupYDx2zhWer1qztd
	fr2FcmzG
X-Received: by 2002:a05:690c:385:b0:796:1eee:b8f7 with SMTP id
 00721157ae682-798c6cd98b1mr37817047b3.58.1772689263197; Wed, 04 Mar 2026
 21:41:03 -0800 (PST)
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
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
In-Reply-To: <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 13:40:27 +0800
X-Gm-Features: AaiRm52WUNKOCQbYrgnbjmYd-Z49f36R1X6n1pZRrztpXr21tW4EoYW1PsKhd0Q
Message-ID: <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Waiman Long <longman@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Laight <david.laight.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 12:30=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/4/26 10:08 PM, Yafang Shao wrote:
> > On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> >> On Thu, 5 Mar 2026 10:33:00 +0800
> >> Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >>> Other tools may also read available_filter_functions, requiring each
> >>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>> impractical solution.
> >> What exactly is the issue?
> > It makes no sense to spin unnecessarily when it can be avoided. We
> > continuously improve the kernel to do the right thing=E2=80=94and unnec=
essary
> > spinning is certainly not the right thing.
> >
> >> If a task does a while 1 in user space, it
> >> wouldn't be much different.
> > The while loop in user space performs actual work, whereas useless
> > spinning does nothing but burn CPU cycles. My point is simple: if this
> > unnecessary spinning isn't already considered an issue, it should
> > be=E2=80=94it's something that clearly needs improvement.
>
> The whole point of optimistic spinning is to reduce the lock acquisition
> latency. If the waiter sleeps, the unlock operation will have to wake up
> the waiter which can have a variable latency depending on how busy the
> system is at the time. Yes, it is burning CPU cycles while spinning,
> Most workloads will gain performance with this optimistic spinning
> feature. You do have a point that for system monitoring tools that
> observe the system behavior, they shouldn't burn that much CPU times
> that affect performance of real workload that the tools are monitoring.

Exactly. ftrace is intended for debugging and should not significantly
impact real workloads. Therefore, it's reasonable to make it sleep if
it cannot acquire the lock immediately, rather than spinning and
consuming CPU cycles.

>
> BTW, you should expand the commit log of patch 1 to include the
> rationale of why we should add this feature to mutex as the information
> in the cover letter won't get included in the git log if this patch
> series is merged. You should also elaborate in comment on under what
> conditions should this this new mutex API be used.

Sure.  I will update it.

BTW, these issues are notably hard to find. I suspect there are other
locks out there with the same problem.

--=20
Regards
Yafang
