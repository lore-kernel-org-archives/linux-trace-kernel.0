Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76739FCD1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625165; cv=pass; b=qHCj6qYFHk+ZCgIJmJsXzK54g6pCvtLWi6bTzox0FmjW1Fz6tP35BFO4Gid0HsLSlSqvtxSodWSrgz/6f6Qm+PdsMTaHN0lL+Sv0BJGHIRmvTtYJFoWYWR6Hq+36Qlo9UMmx0o554lMFV7FwIh/sjnCmpgp+eJ+IOPY4G8Qq5JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625165; c=relaxed/simple;
	bh=VekVx6oVI9uxYLcdxQxGgO4u8pOxcIL9EWHkrdmTRaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3eMNQ/XqGwl+immJLKP9zHKp6hO82WevnqrvKO52DK5yLellJ+Vm5rixxjh3V0+xjbOYSWCvow8RYHseetbyuYHEcpOPNGpk9k9RwQLUJIPbctQxfadN+wLEgBdBFcqPfwOXiDSGnwt+S0+bLdLV8+CnSeTN25hU6RIeeoGAb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar5UYVz/; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar5UYVz/"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e0553bdso63440947b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 03:52:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772625163; cv=none;
        d=google.com; s=arc-20240605;
        b=MgL4/dDqGZoTX0CH0AS9n3rgPluSSI3tahXWrEPfFx8dJfjA5Pn5KX5DCisHFkVoty
         EVeQGpZiv8frk47JF5QhJ077KnKzw3gFpl0d6W1wWza/LSfjhb2lwNTxSqjg1wb+Fys3
         pdE2ankfllBQfsEdECx9vY5npvyk5vKP4lJIxpGFRKYMzbLF/lQ0KZR3MRdky9zzqi1r
         RZgM953E8rqTz2bvoJJa8Dba0Dwbmkv90tHc1az2JKVEv8rIRI6tvyUpML3yTKacciQN
         RyZ0z/MhgxDaZRy/rYWF8c66YpP/aL3ymmJBvFD80/fOPHbVNl6BemCwl3e2aRAwZAC3
         Uduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        fh=u1oQEMrtmXmnXryalStr+iRp0lbjaw7BhjmNNBTL/Rc=;
        b=amX5+DbQrVmojT+46KrQer6HOBHCajEtXSLHS9BgM4bdAvjPFsp4r4f/Z0Aw3VcRAj
         C0VuXhbVzvMN6ntpBOiYe/lwnRkDnyEkcqUIsihbshhd2ntO2I1cPInXVm/X1+NpfJnG
         s5sMBmopji3MF1XD2vUS0ycKWya9Be1CUg9w/L1b0Tf97XNK9xwCR6gymiPQKAtCtsX3
         Y3wWT86ZFtkuqv65b3dGn4Qxl+OgU4vQ1EuAS2l04OwsiS1/bB40XdUb2GNrZDT+tv8a
         YfD00DfyZJYRpzLO4JFK6QmmRF4V8BZpe/WGtQ6RNDPfwFXl0Gm9BbGjSqwGbpfzB0CQ
         c7fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772625163; x=1773229963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        b=ar5UYVz/Quc0n9FsJhOXQ9jv4l6CsERCD/gSEDqQsrRKAynhqQGm9f19r4XS2QoaOz
         a6l6GNK62gHyGVffkjnWgcuPMqUrZ1Us4HQQxlW8DDRktqq7qAswieSA98Yb38dYtfVG
         4GWATXw24fdbU2m5VC2cUDvJVit/DGxXEImACj9GGrcjklhUrlSFvscuIFFq8Q6e7AVp
         GTadexnpdiVaOCil16isIJr+6byoYwLMg03lT3k5LlXOqs7WwxAMNh/QxYTcrMfYxpoN
         5qRQ4i8iXAwfzVr+FgK97YUNg2fd5C+J9RcirRCFbr0x5insuKQawfU/N6u5OH3pQEi9
         mFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772625163; x=1773229963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        b=kIIWcRlRmyzuTRjsA67BlIcZqeb6Dte3B68K3S5mYKP1cl6rUfc8MLV13gf7k9sfD9
         vqlYnN3IMQ8qS1BncPP5Vt1ZItJWiKmDMA5h49NtJrjJJmlGVJ0aDETE/eAIGXikutIk
         hvPz+zp2LUT0Ul2IRXRm6oj1ALVR0zDvGxsS9isOL0qgUDA3TJJpwqdd9aNDjArwwxKJ
         8UEQEpRbnIwhhZgV4mmjrC/MKgsGh49/BqIRoy1Kz8msnI8uQuy5ElUVpD8P2qVjjIQx
         hHx9GK65GOH7NV3rO3UgX0QgV+5duiNia/X1/+AUwtAhpvjkQTqN+NLXPSdzBberrb0o
         s0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ld8ubGSIKhnBJvhZE8NTeI5Dc6oY0+CD3CTLVRDBBVp06f1BaDqkokbQw1FeUdBmeWzLPu7Js0csqEhD1yPPlrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzQ4z7M9ql2BgvpIeypeyuVG1o9Tw5P0Vfe+HSzO2kctgbvJB
	WhBCNoX8j0o1iG6Z7ANvWnSYRVYek1NApTt05t/ctoaFk5pFn58MwjBFurM6ZEFn9QBYz/Ah7IQ
	v9vptRChxdwk3gIqXsYaXav9KlbKEQ3U=
X-Gm-Gg: ATEYQzyaFOlWhcMiBTj5/fSkcgGRofcF60EqthRg/bdV3jsJ6Qr+UQ2act1nAlAblVT
	gWD60lvkdj+QVHcj861B45tigPMz6lp7ah6RPlX7dtgOqMCo+fuHA4jxANFXRtxNO7v6H613ymm
	gYmQhfdYftYMEq98l/2DDRoLwVXn6PPoGMLDEwA5jo+B9YeW6Lz7ORWpuCCK83CIbvBECf7gNnk
	auVB4GNlLS1aQbpjRBfYAF0SlxxpHZldGtt57PLMx2JJ+GPwNSrn2WhG2JvyRaccXhPIleZg+A0
	jU42iPeT
X-Received: by 2002:a05:690c:6184:b0:797:d1c3:fa8 with SMTP id
 00721157ae682-798c6cff6d5mr11616527b3.66.1772625162592; Wed, 04 Mar 2026
 03:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
 <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Mar 2026 19:52:06 +0800
X-Gm-Features: AaiRm50HAnHucaq2QbXVGRKnqcxmQD2ibZjAONGti34NosYd6G-Q-R1cb7KsCTE
Message-ID: <CALOAHbDmmbcK-0mG=44rw3wbaTwS8drzYD-s2gg8g+rPQZNLCg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:11=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Mar 04, 2026 at 05:37:31PM +0800, Yafang Shao wrote:
> > On Wed, Mar 4, 2026 at 5:03=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > > > Introduce mutex_lock_nospin(), a helper that disables optimistic sp=
inning
> > > > on the owner for specific heavy locks. This prevents long spinning =
times
> > > > that can lead to latency spikes for other tasks on the same runqueu=
e.
> > >
> > > This makes no sense; spinning stops on need_resched().
> >
> > Hello Peter,
> >
> > The condition to stop spinning on need_resched() relies on the mutex
> > owner remaining unchanged. However, when multiple tasks contend for
> > the same lock, the owner can change frequently. This creates a
> > potential TOCTOU (Time of Check to Time of Use) issue.
> >
> >   mutex_optimistic_spin
> >       owner =3D __mutex_trylock_or_owner(lock);
> >       mutex_spin_on_owner
> >           // the __mutex_owner(lock) might get a new owner.
> >           while (__mutex_owner(lock) =3D=3D owner)
> >
>
> How do these new owners become the owner? Are they succeeding the
> __mutex_trylock() that sits before mutex_optimistic_spin() and
> effectively starving the spinner?
>
> Something like the below would make a difference if that were so.

The following change made no difference; concurrent runs still result
in prolonged system time.

real 0m5.265s user 0m0.000s sys 0m4.921s
real 0m5.295s user 0m0.002s sys 0m4.697s
real 0m5.293s user 0m0.003s sys 0m4.844s
real 0m5.303s user 0m0.001s sys 0m4.511s
real 0m5.303s user 0m0.000s sys 0m4.694s
real 0m5.302s user 0m0.002s sys 0m4.677s
real 0m5.313s user 0m0.000s sys 0m4.837s
real 0m5.327s user 0m0.000s sys 0m4.808s
real 0m5.330s user 0m0.001s sys 0m4.893s
real 0m5.358s user 0m0.005s sys 0m4.919s

Our kernel is not built with CONFIG_PREEMPT enabled, so prolonged
system time can lead to CPU pressure and potential latency spikes.
Since we can reliably reproduce this unnecessary spinning, why not
improve it to reduce the overhead?

--=20
Regards
Yafang
