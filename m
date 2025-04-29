Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0E221DB6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942476; cv=none; b=j9DE2C9WalhnDwvEUVqArSVxrsXOyON9wfvCXmPWnex8x9Rlr//lIf9rYBIIAKMhUFy79i1ZzxJTRBJzoxKARUzFQnwpubwNA4/KtD00Bmnyr7egvoo7mRfD5c1U8I3XUhfSzTDGe02Xdxy9RERyGzzztpWfbkGveF5afRZVKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942476; c=relaxed/simple;
	bh=XONU6hOy5Iz9FcV737mMQg63PFTxrpZ6Gjwz4oc4OHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKow4bfOtC239TGaLO/SlaU2YZFlG7fdplj8qgFSaD1VeMIJKewo8jHD8qEv8pZ35mHgwGPc6k/9DIgv5iyQyz6aHpmE1suzTC7kLE3IX7750avbnTRXwsYReXMJO2RPdwwZ5VtYK0yzKfzAUQ2+QMZ+0Y9QbQ0zFDvmrzyTpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb/NTlTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb/NTlTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745942473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XONU6hOy5Iz9FcV737mMQg63PFTxrpZ6Gjwz4oc4OHM=;
	b=eb/NTlTABcsMYh8Z1VaKFYk8Gonv2POzrUs2dzu4h0GhV7euiwY8I4c2NX7QTZD958heS5
	S8VZ92P8yhAD/v+sDktUY7HCNfSE1EEIW6tWRWuJc3nI5lw2e01sLMijnmYWacjeR9r8Qn
	avzGrQ/tXZffZOxqH4VEzqKBZMhy2Sc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ell9YPquP064eAPbEH-a2w-1; Tue, 29 Apr 2025 12:01:12 -0400
X-MC-Unique: ell9YPquP064eAPbEH-a2w-1
X-Mimecast-MFC-AGG-ID: ell9YPquP064eAPbEH-a2w_1745942471
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so27165795e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 09:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942471; x=1746547271;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9d4ihjEcZCGzfEfkm5oQUSnv2p0a0HdnyPYGguifKE=;
        b=Nqg4YYDaJOwtcdgAPdlFbtW7wkkTAmD+Rk+JLuM7Wdvx812l2Yu3LeFvebltkh46Bl
         tbPHp0Pnx2FAZUJiRYyguxFIav17VmzqDh45uYRWZvKXBne9ARDvNly4pRvqNk2mEryx
         FWp1EdmPWuu2d8c/N82aXaYTvN/fScG9bkSveJa8wvNHuOlJdZTg5oFIcJc3ioQGeK3q
         ylVI9IjRcvye+gPpnfpUjbvwVZbhFjgqqkikA4S82JcLbZzM826WeSmnoMOjO73TmSLQ
         HkoV0l0FRAF3Z7YIyi9VzCyafbXeTAbdWlcBMfOQE3EW8T5exZ/c5OuqSwy+qk2S038n
         Eowg==
X-Forwarded-Encrypted: i=1; AJvYcCWJPMwOuJiyN/VgOMoR/pm9zWhfnSaNcemkBj6rR9HwSosvS9X/m3xFJN/vrQ0/nmYE7sEG2ycBLzn2NbYR7W1TDqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/qeiL/WKp2TFeYHL3vC+PFxu8zpTKdXAsELK7TyIswFs+33O
	afsjLw5jenk1SrScGLy7ok0jJamSkjGDPM7JOd1cbx4qwjUcV7UQywcdVieJsHwwemQLWQsDquE
	Xwk5nAbPIzlbt+wFIF44srjmhuGH68FgImo6B9yVw+GZNuftOIInCQKSY/B7h+rAgz9RDfbR0H6
	VE0Q69
X-Gm-Gg: ASbGnctOCvqBrZ5ai/vA5idQ8ZsdVYcVVQjGFuzAFl3skGP7ObI9QBjGCr9UCJcBIpZ
	DfpgTuCfhY/Cbs+PksDrt3YmGwRvZAqRpjjXiIqMK1FZMIygkEa9PzkcBTNTz9KnzYExdiP7Wuf
	L+HTuwaZlB6R8qeEtxl0vNR59h6IMBbdJOENwNA7XliLpptYf6kY52m6+/jAyXO4Tfj98sM5FJl
	cXpALP92tzZgwHxptXwnx3d7Lxom2mFUU5BcmGIupyVg/lAJlBvy1utkrobP1yFEdVnb4E1KNjj
	4adI/RkrG78CzCxwhyPVNJmpl67QNJBViE4Tzw==
X-Received: by 2002:a05:600c:a03:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-441ad3c6602mr30614435e9.19.1745942470840;
        Tue, 29 Apr 2025 09:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMeuVr5PTAmj5isfFftY7IqinZh8JCUlTZsYw5t+if/pErZS1O8MEOM08+w3EhWkOz8GDbBA==
X-Received: by 2002:a05:600c:a03:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-441ad3c6602mr30613645e9.19.1745942470076;
        Tue, 29 Apr 2025 09:01:10 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbf030sm14248751f8f.46.2025.04.29.09.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:01:09 -0700 (PDT)
Message-ID: <bfe8322cf5817037af57f10ffbffcd9b30f43b42.camel@redhat.com>
Subject: Re: [PATCH v5 21/23] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>,  Waiman Long <longman@redhat.com>
Date: Tue, 29 Apr 2025 18:01:01 +0200
In-Reply-To: <57ea14992e148121fc010a200986e4db60ac2de0.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
	 <57ea14992e148121fc010a200986e4db60ac2de0.1745926331.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: umxiUB7GpDfvdv8aVwwPbisccdGgrm0WHatXwAzotKI_1745942471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 14:01 +0200, Nam Cao wrote:
> Add a monitor for checking that real-time tasks do not go to sleep in
> a
> manner that may cause undesirable latency.
>=20
> Also change
> =09RV depends on TRACING
> to
> =09RV select TRACING
> to avoid the following recursive dependency:
>=20
> =C2=A0error: recursive dependency detected!
> =09symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
> =09symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAGS
> =09symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
> =09symbol RV_MON_SLEEP depends on RV
> =09symbol RV depends on TRACING
>=20
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
>=20
> [...]
>=20
> +RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or
> ALLOWLIST))
> +
> +RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 and ((not WAKE) until RT_FRIENDLY_WAKE)
> +
> +RT_VALID_SLEEP_REASON =3D PI_FUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or RT_FRIENDLY_NANOSLEEP
> +
> +RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_TIMER_ABSTIME
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_CLOCK_MONOTONIC
> +
> +RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_BY_NMI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or KTHREAD_SHOULD_STOP
> +
> +ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_RCU
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_MIGRATION

So, just thinking out loud, PI_FUTEX is a valid sleep reason,
technically also BLOCK_ON_RT_MUTEX is something you are allowing.

In my understanding, the contention tracepoints already in the kernel
can track all contention by kernel code and are leaving aside the PI
futexes, which use the untracked rt_mutex_wait_proxy_lock.

In your case, you are tracking PI_FUTEX via the system call, which
should cover the above scenario.
Do you really need extra tracepoints to track this too? Or is there any
other use of start_proxy_lock/wait_proxy_lock I'm missing here?

I see the only case in which rt_mutex_start_proxy_lock is called with a
task different than current is via FUTEX_CMP_REQUEUE_PI, wouldn't
considering this one too make the new tracepoints superfluous (assuming
this one is even needed to be tracked before FUTEX_WAIT_REQUEUE_PI).

Thanks,
Gabriele

