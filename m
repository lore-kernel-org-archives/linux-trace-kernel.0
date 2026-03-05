Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DF4503B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677067; cv=pass; b=DhW2MWpXngRPxrfudwvMtaQynEtpwmpPcMWYfG4FVdksXz6SfALptQd9gl/txVVtx8xLrWEpJfbX6Dnu0Z1PIfLWVKSl3qH18ykUg4xZopwrttQMDg4M/mRkvmVgxrhLqLeYR9rW7mG4+9w3ep9jmzQSVU5xSnZkxM1eLkUrWfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677067; c=relaxed/simple;
	bh=AnImdXsVFvgLb5gdQL2K8lpR3s5gIBl6dS0AXo925Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZolZDvuz4BnODKiFedoErCGWi3NEQizRLlaLt9fmHo5lIsmvxeV/afr1Ix5qYrmyZR2Ld4fq7EbAZmeUR+9oGt9EOC2Zh4yW4wLPtVDrJxKOoSH3n1bVFjBAPKJOUBFj7W7s1FFrcu0DzjFvzHda17Pcjn7aokVhQSm09FlO3oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIeLP0ui; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIeLP0ui"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79881805788so75629387b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 18:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772677065; cv=none;
        d=google.com; s=arc-20240605;
        b=Jl4OQxQZcyjNicIHbLh0907jdUdrj84nHgQwhIszauNHnYRBnF5XqO1OxlTlB0Pq62
         9fgysZQNSe7XmHU7eQIpEuqN4Qw0Misbxt7ozK2W+a5qdMq1EL58EkqBJBkcq3sGwPcc
         g4I4QXw5CHrQU37M1BHnRo1iqhhr5fnKOS4H4/4YxwYu6zcWH1pYBJW5tZZqm0Q9tUZx
         U/7a0CZonvH/UYXLHbZ+a8E2dnaQ6qseDbFeD5EHa5yXN+ClHwtUMEeez6O+MSPWpirj
         eVcKFtcpdgi6CV2ujHbXL3CbSVB+BzXcsylRBR7L6nmu6keNaNk7nXoXq+up/Okc1Hfe
         QH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        fh=aZAiy7NEgFzZllfaE5OWhsFnj8FQVRbqvVhN1Kj1NMo=;
        b=YR5EhJrk/77T/ETpb1q4AJs+3h1oyhONZOAZ1Mg085l3P2GYXspguNL0sendJwVUzi
         77rWRanvOXqvUx7wWCW3fd2YVBe9SKa4csH1/9sTx8fXYidBEGoaN1wWfMbUNo82gCz4
         cAfq/0oXagND6Vf8GEjrKudW5VLRKLRaiY8Rayo9hwG8PY5db5ZJVg0+2LRzPCUW+SPb
         vXpOYOOm8iDaX7DqF4mAmqxxvtzBCd1oc9TzPL0n7UhmyR64+6TEoMGGIscUENyyEIab
         +fx9QVIbVBKhkKQ3un10s0+BXeJQmdDRw6uMFj45KCNtPR06fg3QZ6ggNq+WPj/gGFlH
         dzxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772677065; x=1773281865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        b=CIeLP0uiXioiAn+yJeMS+VZxBUBQHDAPMiP1F0lhw5fDCIE/T+z7PbaOwq2eotoevA
         Zfl+wkHFL0t82IHyxI5Ybs+n4ZHlnFMeuPT41R+vPXzy1sDzK8OzjVtec0KqATdb8JaS
         vN3QUQdPwXwcZByTBdEhTBs51eY9lXMMECO2qnu6F8jriN7MecT6JnkBfzMLyJoLQ59l
         tFpmZZDO0sTPJAv4H7kuNwD9zY28QXLhlrmmPYmwSifOK+1Up3nPxXitX6cGlV01MDfm
         XpE9HMUaxGdjtAmhpXyX8NHE8zS/BFHkThttdnHCTdOR5gGNIOrmMDLJZ8mwJpVKVvJr
         74Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677065; x=1773281865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        b=qD19yW7Wo0E7LJuh8kVynZbyEw2rLN8Fhp8NrU3mk8GoV726DR5s/3STYkxUi0mXTt
         PR86/A0oCu6gnouJxDho/lBRgnaCHtUOS4eEgccXo6e3FDDpL3+tuUUtc2KmTgm3jtz1
         2+uXVQscv8eHIBPK4iAVLR2Nq7Mvwl+zoPmGGCG9ZE4aEBeEm397hqKnAu3BHU804UJz
         kg+yTB2NhvHHJAWh+PnEleD9U3PBBU8CcAyQM4h3dHwJsCiGh6NsC1spOEXeV3x9B7IW
         21oRs7yKkfCU0TNB5fmggzIGRhky08A4Vh2twPblSpjhmrlNxWjdD+51eApjjehD9O1x
         +72w==
X-Forwarded-Encrypted: i=1; AJvYcCVbcT+2ph4VOyxSLkqpgVNEQfZRvageKLa52FxF85QjcR6bNN3Xs9+hw8+tglLSRPnJpfocMgABd+8yTbZ+BiAmJYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJKBXu7Aeqwh4jcEXl+ScRLRP8Ts9q2/kCo5f0x9cc9M5+BaG
	r8SnMfadzncdz1D6TOt6om+zV/vZsxHGQBM1K2QcpOpxWaUrrptkAZpLJwFqE3ka/Ur1L1V10Od
	qtaCUTG0O+6y7x8U7D2/T7poc4w2o2vE=
X-Gm-Gg: ATEYQzwSEwlAVjIEmZ50wk/1qc+i5ogJsvNNS1HXK3HvA4qFQk8m7HZcfymVGr8qWyj
	vStMfpJnJFjR3frc/j0XfHEdEpWjQkMTPmw60IAE9O93aO5ANANNBHC1WiRzpzoaAuQ84tdQXmu
	fcAsC8obidtN5qSWNChG5pUw9boqnDr4dWIoN3VCy4m0+A8CHwrwGgayMCgyLr54LrwPpuqDG7A
	G48+759hI7YTlmB2Ls3+F0eIj6lhzpHo7edTAUKGp3kypSwpXQourA/50/YciIrYZLseFok/66S
	2llXxVZGmjvmboiuAtQ=
X-Received: by 2002:a05:690c:6983:b0:798:806:2c7c with SMTP id
 00721157ae682-798c6a3d49fmr38703247b3.0.1772677065588; Wed, 04 Mar 2026
 18:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
In-Reply-To: <20260304214447.3e5817ea@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 10:17:09 +0800
X-Gm-Features: AaiRm517NI-rro-7jVK939vPf8BuH7oxAu9WZEv4kjAdWxvubVT-CJWzMHbZ090
Message-ID: <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:44=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 4 Mar 2026 15:57:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 4 Mar 2026 09:54:15 +0000
> > David Laight <david.laight.linux@gmail.com> wrote:
> >
> > > That might still be an issue if a high priority process is spinning.
> > > But a %sys spike doesn't imply a latency spike.
> > >
> > > Is this using the osq_lock.c code?
> > > That will have problems on overprovisioned VMs, it tries to find out
> > > whether the hypervisor has switched out - but ISTR that is flawed.
> > >
> > > In reality a spin lock shouldn't be held for long enough to cause
> > > any kind latency issue.
> > > So something in the code that reads the list of filter functions
> > > needs to be done differently so that the lock isn't held for as long.
> >
> > It's not a spinlock, it's an adaptive mutex which spins while the owner=
 of
> > the mutex is also still running on the CPU. If the spinner CPU triggers=
 a
> > NEED_RESCHED or the owner goes to sleep, the spinner stops spinning and
> > goes to sleep too.
>
> I think half my brain knew that - otherwise I wouldn't have mentioned
> the osq_lock.c code.
> That all reminded me I've a patch that optimises that code a bit.
> But I do remember thinking it ought to have a 'I been spinning long
> enough, time to sleep' path.
>
>         David
>
> >
> > Honestly, this still looks like a non-issue or a corner case that I don=
't
> > think requires these changes.
> >
> > This looks like one of those "Patient: Doctor it hurts me when I do thi=
s.
> > Doctor: Then don't do that." cases.
> >
> > Why is a production system having multiple users cat
> > avaliable_filter_functions to begin with?

bpftrace is a widely used tool for online debugging and dynamic
tracing. However, sysadmins may unknowingly run multiple bpftrace
instances concurrently without realizing the potential impact on
system performance.

If this is your answer, I believe we should clearly document the
following warning:

  Warning: Do not read available_filter_functions concurrently, as
doing so can significantly degrade system performance and potentially
impact production workloads.


--
Regards
Yafang
