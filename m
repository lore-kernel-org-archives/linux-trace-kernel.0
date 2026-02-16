Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E482263C9F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270005; cv=none; b=kBcYtBcYZpB3s1lTbIeVKRvj4F9q3IV9F5nQHJ8JDe00DKE8bUWIFiDcnciBOwtBKyOW+1GcbNzwbmtedVF/RnuTlqsHRV229lvpnsIlOnii9GQFMy2JaJk1dedHhTr+wOaAm61lEiMu3ZtbuBoTJuVabtknILZLKlXOTQkDSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270005; c=relaxed/simple;
	bh=ReTm5Skva/XkkmWwT48Tv+NgXaAUQdks0hBWLSlgAYY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EVRwDyuysCQgb90MSnPVt25h3OMfZ8wt31nIUZx/4MEDV4fmCLPM6TV/JgneaOcA8YlbQtXMmf/Ht6Ci9LRDL03qRDHLCu8alWiRHWUGP6ZayqiwyNfVQnq7KTekcYx6DbV/PzHOGIoOWD307tAaxocprQ3ShbD7TKh8AHIg9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcBdJHo+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcBdJHo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771270003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReTm5Skva/XkkmWwT48Tv+NgXaAUQdks0hBWLSlgAYY=;
	b=GcBdJHo+tW90UrCQf47b2v+sbgAtOYC0LO371HGr87hhMx/GzUHp0zwDTozvr5qgvqe0UT
	990IYdGacUgZGuQksQzX9Qobjbdlcx8ffttuZotOAd5JxlifeLHZB4vQnYDTCwuddFrEMm
	MVVL8GhiQvGFCV+Adbkjepihei1tDAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-DRIlBtD0ObK6fdajVMgCIA-1; Mon, 16 Feb 2026 14:26:42 -0500
X-MC-Unique: DRIlBtD0ObK6fdajVMgCIA-1
X-Mimecast-MFC-AGG-ID: DRIlBtD0ObK6fdajVMgCIA_1771270001
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b7903f3so25853885e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 11:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771270001; x=1771874801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReTm5Skva/XkkmWwT48Tv+NgXaAUQdks0hBWLSlgAYY=;
        b=E7rK6rvUs7mAFYoUw1e4WwQtY7L7mJ/fob5rwRuwlWS6wBPWkoZA6h0PpI7F69Qxna
         NgCJaLCtI0iO+sMyuYZpJBJCtJv5ntXFEDTsEQoU1DsDkMr784gNV87gJuuLYoqAb39P
         aRKqLhdcJxWv+4y/CFHdLCUQHThoHPbWVqWQQu5wiQhucRsabDXjEUoSYt8Nlh+BBtmm
         YEegTy9oNSYqqM/lYCy+LrSAcevnKZZlJaz2WihJ5TNipbf2F/JM6NAqOFHYU0HkTeU+
         3l0GfyQq3NudSGmBpXn3xklXZ43VACy2L33IWJDvKm8gyyU4NkPxGi7BH/XDmKR5prQV
         Edbg==
X-Forwarded-Encrypted: i=1; AJvYcCXDFwHGBtZQOF5dOCkD3NrORbqsXyNS2peWFB05CjhfrZk/gTYW55ykWJGz1VH+r2ljf/CWZu9y3tjLe3tubVai9no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrkkm1X69eeFIitWCb87DeTRUPcQrINmuTaLpa3nmk6NKU2bt
	wnB53fb5fe9lWI5nyqW/Lx6SFpZX9V2nIuPLL+Y7eVDOJ2Z+wNmT59SsAGyatgHHYgBFO3GLGDz
	tySRqRjECkVtlzi9xxh+g815eVXSkxKZJHlsyUHBmIY5Rkud8lmp1B3Oxgrlpa3/ilej6SliAcA
	==
X-Gm-Gg: AZuq6aJLZVRx6Ny3SkqpDG1E7BmG6OWoGduJFG9qM7i2QHycvUlL1fLMJPo/AT4D6Qf
	Ds2tvQ8sCrCTUlS9VaHsBzz3s6Fd+iCym1qDNVnUz5/AXN9GLFUcM8+v0moow9oAio/RhsreGrJ
	5yN5hH8tfjfJvE7R7Av3wNi7GPYgOGm3iaZRTj9u1P8EWlWEpU77Ik+zQQ32eb7NbGn3huBYxX/
	FYRhprqvkcWOQqLZT4c/lufoQx9ZXKdfMKfXVbgGmh2pew87f4rZWWy9Qk91aA8CJJ8NfkYVj3F
	jlltFa3u/0uPMAhxnFjMt+lbwgXXKirXpRnsCX/mb+6RJp5cPVSEL8rhYShmrx82DXsBy6Z1nrN
	PmdNaJpY63NQhIIdnEw==
X-Received: by 2002:a05:600c:1381:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-48373a1ad50mr195765395e9.13.1771270000670;
        Mon, 16 Feb 2026 11:26:40 -0800 (PST)
X-Received: by 2002:a05:600c:1381:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-48373a1ad50mr195765095e9.13.1771270000223;
        Mon, 16 Feb 2026 11:26:40 -0800 (PST)
Received: from [127.0.0.1] ([195.174.33.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm30290967f8f.23.2026.02.16.11.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 11:26:39 -0800 (PST)
Date: Mon, 16 Feb 2026 19:26:37 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <83a7c025-51d8-4031-b072-60f711ad2c9e@redhat.com>
In-Reply-To: <20260216172707.1441516-1-mikhail.v.gavrilov@gmail.com>
References: <20260216172707.1441516-1-mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH v3] rv: Fix multiple definition of
 __pcpu_unique_da_mon_this
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <83a7c025-51d8-4031-b072-60f711ad2c9e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qiyCvvDff4ZwK3pdMn906ElPTWBbOgS68TDjvj0N9Sg_1771270001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2026-02-16T17:27:23Z Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>:

> The refactoring in commit 30984ccf31b7 ("rv: Refactor da_monitor to
> minimise macros") replaced per-monitor unique variable names
> (da_mon_##name) with a fixed name (da_mon_this).
>
> While this works for 'static' variables (each translation unit gets its
> own copy), DEFINE_PER_CPU internally generates a non-static dummy
> variable __pcpu_unique_<n> for each per-cpu definition. The requirement
> for this variable to be unique although static exists for modules on
> specific architectures (alpha) and if the kernel is built with
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU (e.g. Fedora's debug kernel).
>
> When multiple per-cpu monitors (e.g. sco and sts) are built-in
> simultaneously, they all produce the same __pcpu_unique_da_mon_this
> symbol, causing a link error:
>
> =C2=A0 ld: kernel/trace/rv/monitors/sts/sts.o: multiple definition of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `__pcpu_unique_da_mon_this';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/trace/rv/monitors/sco/sco.o: first =
defined here
>
> Fix this by introducing a DA_MON_NAME macro that expands to a
> per-monitor unique name (da_mon_<MONITOR_NAME>) via the existing
> CONCATENATE helper. This restores the uniqueness that was present
> before the refactoring.
>

Thanks Mikhail,

there was actually no need to send a v3, I believe Steve's was simply a sug=
gestion for future patches.
(Now actually the reader following the link would wonder if there's any dif=
ference since V2, I'm assuming there isn't).

I'm going to take this patch and send it once 7.0-rc1 is out. You don't nee=
d to do anything else now.

Cheers,
Gabriele

> Fixes: 30984ccf31b7 ("rv: Refactor da_monitor to minimise macros")
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> Changes since v1: https://lore.kernel.org/all/20260216074727.47292-1-mikh=
ail.v.gavrilov@gmail.com/
> - Updated commit message with details on when __pcpu_unique_ uniqueness
> =C2=A0 is required (alpha modules, CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
> - Added code comment above DA_MON_NAME explaining the rationale
>
> include/rv/da_monitor.h | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index db11d41bb438..7511f5464c48 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -20,6 +20,12 @@
> #include <linux/bug.h>
> #include <linux/sched.h>
>
> +/*
> + * Per-cpu variables require a unique name although static in some
> + * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules=
).
> + */
> +#define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
> +
> static struct rv_monitor rv_this;
>
> static void react(enum states curr_state, enum events event)
> @@ -183,14 +189,14 @@ static inline bool da_event(struct da_monitor *da_m=
on, struct task_struct *tsk,
> /*
> =C2=A0 * global monitor (a single variable)
> =C2=A0 */
> -static struct da_monitor da_mon_this;
> +static struct da_monitor DA_MON_NAME;
>
> /*
> =C2=A0 * da_get_monitor - return the global monitor address
> =C2=A0 */
> static struct da_monitor *da_get_monitor(void)
> {
> -=C2=A0=C2=A0 return &da_mon_this;
> +=C2=A0=C2=A0 return &DA_MON_NAME;
> }
>
> /*
> @@ -223,14 +229,14 @@ static inline void da_monitor_destroy(void) { }
> /*
> =C2=A0 * per-cpu monitor variables
> =C2=A0 */
> -static DEFINE_PER_CPU(struct da_monitor, da_mon_this);
> +static DEFINE_PER_CPU(struct da_monitor, DA_MON_NAME);
>
> /*
> =C2=A0 * da_get_monitor - return current CPU monitor address
> =C2=A0 */
> static struct da_monitor *da_get_monitor(void)
> {
> -=C2=A0=C2=A0 return this_cpu_ptr(&da_mon_this);
> +=C2=A0=C2=A0 return this_cpu_ptr(&DA_MON_NAME);
> }
>
> /*
> @@ -242,7 +248,7 @@ static void da_monitor_reset_all(void)
> =C2=A0=C2=A0=C2=A0 int cpu;
>
> =C2=A0=C2=A0=C2=A0 for_each_cpu(cpu, cpu_online_mask) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_mon =3D per_cpu_ptr(&da_mon_this=
, cpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_mon =3D per_cpu_ptr(&DA_MON_NAME=
, cpu);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_reset(da_mon);
> =C2=A0=C2=A0=C2=A0 }
> }
> --
> 2.53.0

