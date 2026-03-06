Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9A24A06D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764449; cv=pass; b=C9MB/Gw2TNAfjN6SUyr1rJ2vXtc43dYWufvV9P6MCXssNzqSJxHizGxVLxL/UrgqMawyp4S9CpHuiBTfhcM7NOo+cL8+GorI43ZSa1UlTLoyBAYy0tmmjejL2F3vuBbcVAPqqXap2ZO0pcoe3hzU3avs1miD60MxVMBVPGTrj3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764449; c=relaxed/simple;
	bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxKWCrXgx0rVEJsxx3MCiDVXcy9uHxqewig/XXuHAP4iMkGzDCsA/bYiFUBYdIpV8UOUYFmV+yBKILMPVsPlqIcnp9xJ+pSlDSswrqZ0jgT5N9M6f8ZjrZ0YJqwkqwt7cvUNhOpis72CnqCz0GzXUgFnt20j753+zg34DxeEzWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5uvKtJM; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5uvKtJM"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c31ca77b4so8679077d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 18:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772764447; cv=none;
        d=google.com; s=arc-20240605;
        b=SlhM8lKBjUM4vstnt4EC4kzqpYjm/tqLsrCnCaHlrSLFwFq19eOvGSHdt4ji79baIr
         jrAQADH/NTQMRb8iFMYSbZqIJ45CL9PCEsl/JuG1E9kVRmfWFEpqbdU/LOijEY11HDhk
         orCXw30Qkts4IZnJf8OSFzDcIxp5musVjBlUY6Opd1V57eA7Ghu3bvpsUhD3N9RcPHN0
         4fV/mXVHRG8wPTCjOZuMvh4U3+482vM9IQv6lrnPbnHHGHdStrtpYVTMzjoaWmH2Oi99
         Ljfc1+xV2PS5G8KEQ/sBdZSB4Qk43r4WZTH95e8our4pdC3eh+L6ar+aJI1p3FZY7HFN
         SUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        fh=X8zJsJ1eFGXHODhEE0qqU/kj9X0XSyLk+6BcJPsVwnQ=;
        b=NGJcmTGtfawXLbZq4f7W2GU/LJD06Zwl8O7jflcNDt/dKi70OOuLdh4iZUf/PP9hwo
         X9XLMOja6y4UIHk3qF+kfQ76/zYbFmjfw1twlhuxpjrARUdoAt6UiYsaONCpfHCBCp0+
         RC17udDF+dLj0eYk7KEsIqI4eU1dhIUWUQSJQ1rcteR8bLktQJNd+tcEnG8JBjc7eZBN
         Y0v+0XlIA2pPYxBxcAHG194mpJZr41tFzr7gbxLBW0SxBAbR6A0TOKCN5jn+4ZxpOhrP
         2nmJAL0wd+suPm9bmmLEPFU+C/nH8ObhMVAbI4KjXTcowfzo71mjcpvQBp7x+9gP+9wd
         SQ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772764447; x=1773369247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        b=l5uvKtJMFy6Klzy6UETiPdK7lJtMghAKmtB10NWxKDZUOHfkZ+rZc3tl9EjECFy1NC
         VUiAskk32+Ga5cpem+iOE9QcXQbrxRhYM/bG+xN5pYbLdAs50rb+Rasng/CtbulS9Z4o
         jMRx5/rKK7hQFEkovcOcxX24F/3TCAFK7FpFIZqjvl/td+mI0phJYlah1BWT3W87gJ/J
         iNN11XEh8+ABN1AKUP3M/O6V8JZAy5ywFX/C2LI8Di5reX+4EIVI8Mzk7xCd218eyzLu
         BxyIJ3/4mWrmofradpYKKiejywXB2ZiSwD+pgA2243tkgXcWHa4kT4d56yc4uv+Nw+52
         TVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772764447; x=1773369247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        b=qrpbmllTcB5WrrVEmN9qFrZOr4wUJyUwBHtE63ghK0mVqCGBTGZ8tuqc/tMT71729K
         6pOGzvIAQZVn420uApw6+uwNOwDlveeC+hlUjLY2jxDQoRsLOgmhpc8hSMGrKZnqGzde
         6sHlPTGB++AfuoVfYKZAoD+Kncsp9zgumY562gzKR/T0RfYMB5p+iKKMuiDpGRLkeX3z
         joQD8XeW7XMHMOc/+Fv3SaGnbHeXqIV4/zfbYh0yl83rboSpmt6DRKOW3QP5c6qIxBgr
         GbETmDW26hEUw5YJy0b7Su6hUWmTXSqrcobuh9wL+NOoH3SNx3n7AlADI0BFUNjpS/Nc
         OQxA==
X-Forwarded-Encrypted: i=1; AJvYcCXcCje9ovIDhn2sWG9EkbbzdXMxHPTQlUyE0R/bBTKyHm8+Mocn8IucI3iqiQPl5i8eykaCMmRzWMlL+nml2iWuwKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6kPe+3l7fzjgp0+YZYr7tYm2KinBhqzLINngqpK6ux5+KXk5
	8QEPxhFLL7yiJp7SnhhG1524dzgzwzuTE4fdZo4d28ufzxJwN6wNGOIzijDiRuJmABmZ1X2Vome
	KGPnOnMAqzddkIyywiXW5uN2uuCl2058=
X-Gm-Gg: ATEYQzxHohrQbsb9lDNndUb31IQc0gDIZ/tNAElhVE4RL6LTakK0z9uTJ+MVolMD0IQ
	SEMUFob2zSBZRqS3QFVmOMMTLnOyQ1Oup8STOEzOugXuUpX0p17Lh90itqMSNySBlVh8DcycHwC
	2ee14wyGlwM7Z/2V3mFGvvjUJm79Y6vRTLJDV0ZQ7Se6AbckkcwviZKaRVkUuVlHQt5t0w7wOZ7
	4+aHN2d10gwpR3OHmo/1N1y/lBCoe7anvgqEPknLkhxJC/4/bP2H0wJiFB2ilEt180kYb6EkHCe
	CwzfItFz
X-Received: by 2002:a53:b465:0:b0:649:cf3f:b318 with SMTP id
 956f58d0204a3-64d14280ef0mr534531d50.54.1772764447184; Thu, 05 Mar 2026
 18:34:07 -0800 (PST)
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
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com> <20260305093254.61facfb6@pumpkin>
 <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
In-Reply-To: <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 10:33:31 +0800
X-Gm-Features: AaiRm51g6v9S1i2W6an56fo2JJwlLhr-3uILfFxDkrGsMtVSRH2Heri_rvDMBdM
Message-ID: <CALOAHbBnmFjauN0V3L4xCiyJFBDnGOo3_qF302iXWcWp_fqw5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Waiman Long <longman@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:00=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 3/5/26 4:32 AM, David Laight wrote:
> > On Wed, 4 Mar 2026 23:30:40 -0500
> > Waiman Long <longman@redhat.com> wrote:
> >
> >> On 3/4/26 10:08 PM, Yafang Shao wrote:
> >>> On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodm=
is.org> wrote:
> >>>> On Thu, 5 Mar 2026 10:33:00 +0800
> >>>> Yafang Shao <laoar.shao@gmail.com> wrote:
> >>>>
> >>>>> Other tools may also read available_filter_functions, requiring eac=
h
> >>>>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>>>> impractical solution.
> >>>> What exactly is the issue?
> >>> It makes no sense to spin unnecessarily when it can be avoided. We
> >>> continuously improve the kernel to do the right thing=E2=80=94and unn=
ecessary
> >>> spinning is certainly not the right thing.
> >>>
> >>>> If a task does a while 1 in user space, it
> >>>> wouldn't be much different.
> >>> The while loop in user space performs actual work, whereas useless
> >>> spinning does nothing but burn CPU cycles. My point is simple: if thi=
s
> >>> unnecessary spinning isn't already considered an issue, it should
> >>> be=E2=80=94it's something that clearly needs improvement.
> >> The whole point of optimistic spinning is to reduce the lock acquisiti=
on
> >> latency. If the waiter sleeps, the unlock operation will have to wake =
up
> >> the waiter which can have a variable latency depending on how busy the
> >> system is at the time. Yes, it is burning CPU cycles while spinning,
> >> Most workloads will gain performance with this optimistic spinning
> >> feature. You do have a point that for system monitoring tools that
> >> observe the system behavior, they shouldn't burn that much CPU times
> >> that affect performance of real workload that the tools are monitoring=
.
> >>
> >> BTW, you should expand the commit log of patch 1 to include the
> >> rationale of why we should add this feature to mutex as the informatio=
n
> >> in the cover letter won't get included in the git log if this patch
> >> series is merged. You should also elaborate in comment on under what
> >> conditions should this this new mutex API be used.
> > Isn't changing mutex_lock() the wrong place anyway?
> > What you need is for the code holding the lock to indicate that
> > it isn't worth waiters spinning because the lock will be held
> > for a long time.
>
> I have actually thought about having a flag somewhere in the mutex
> itself to indicate that optimistic spinning isn't needed. However the
> owner field is running out of usable flag bits.

True. Introducing a new MUTEX_FLAGS would likely require a substantial
refactor of the mutex code, which may not be worth it.

> The other option is to
> add it to osq as it doesn't really need to use the full 32 bits for the
> tail. In this case, we can just initialize the mutex to say that we
> don't need optimistic spinning and no new mutex_lock() API will be needed=
.

I believe a new mutex_lock() variant would be clearer and easier to
understand. It also has the advantage of requiring minimal changes to
the existing mutex code.

--=20
Regards
Yafang
