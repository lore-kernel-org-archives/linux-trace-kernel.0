Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAB205E26
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076954; cv=none; b=WelaKxDBu4ux/Av+Iil4qIe4YasocUimt0SvREkFkcU/vwkmm+QQHXcdFFImGJ8z+IsVFza7S/BcQvHxCLMcdqAWmmKbOFYYCzvVZfvedIWaFGU2vpwXAhyjTe782+eTq2DFm9yNpDOVyMROkmc0VnK62ryuqsM9PPTZMufqY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076954; c=relaxed/simple;
	bh=qQJj2PxE0wgWVyijv5e44FztLR8rDOrosMOIQw42Lrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6uiKAit4M5YpvLHCz5X57UEM4i7bWfO8YhpZRdQSWhioxgfGLtwALL2S7Dd4pu4HFKTK0mzYWo+1RYrcJVIVUlvactojxMOlNf4UVSHx5dCjPy3eFQcmCXiOdSPcgUh72vd7Z2ucHsDq9FlqIwK10xsF52R8IQtAcgwoHJuArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVsNE7nO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVsNE7nO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752076951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HLA0apV9FPRrE7B8rdlEI+bX804yCXSblvUWA2sVczQ=;
	b=aVsNE7nOyWvd52Yy70VPn+Ar0OF246oqscI0FzSfJSwkzZtZ2cohnMxh5KQ1kwBrcgYN7m
	bmYkd7em1fMaCfwzoJS8Gc8nmWDM2kUt0gQ2dlyKDjzphZC5jvdiRYUZPXwes90OX5phIq
	INei0v5V/ueVUmIWcR5jDPii6Zi61Yw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-4HifoSFxM1qh1PPIOOWybw-1; Wed, 09 Jul 2025 12:02:30 -0400
X-MC-Unique: 4HifoSFxM1qh1PPIOOWybw-1
X-Mimecast-MFC-AGG-ID: 4HifoSFxM1qh1PPIOOWybw_1752076949
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45311704cdbso83915e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Jul 2025 09:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076949; x=1752681749;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MDV+jWx+iU94ZsVEjqYCAk3hcfaskhkPy0hE9SeE7Q=;
        b=egG1xDKvtrlzKer9o/k16jM75NkfvBd9Hd6zIB/fDt11SSh7Rbeinl+VCB+08evfZB
         OQmvAfA2GKF/9iPmcncATQIYTmE0Fc1gGizLVbve+I98lY6sr05ptcR0PXPi0mDNe6/Z
         au1vx3WSlMy5vFaL/OqrKwqg3ofNRhLS9wHotsSm/CiUIyhVCxjpSkU6Q5MhQO8WuYty
         +0haakS231h6GblpNIRDESK4UvT5IqzIymzDq1SWoxQtNOq14zQjFxgbIII6y+lC4B4Y
         EPFh7cSPRLL8hvXO9rtRg1uR4CohS2kflk/nm3GlHxhhyvqHnZUl1/VuQJBVqa3oDHXX
         0Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCWubuFYYAOJqAwGZRsUpHowF5cat5txlh7Fs4HkjqcLY4LHvz2bXTOsaovbBWmTWI8lsHXhBXtnuPsvme/yp7RqPUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgic7n+5fVYHKcliJDz9kGRdWCKuNIeSIj9nRZVuqHfE996Ga
	BsEPJD/UJ24V5Ea1tVxYdpNGr7uhBu++qY1cq3R+cAbwV7pvmFuurITRcV75oMREyah/N2ak5+Q
	RZO4UrJ3pP2GM+gEd+XIP44hS9sqBDlU0UYXQciWCDrcQouuHNq3GVufLICEJtmdbWf2Uo7Rn8A
	==
X-Gm-Gg: ASbGnctxdVmZDYLo/S8gj47szugQt7G978T2rht+FydgEVdbpJW/o9QbJzgRLhNKc18
	AexyqcYoXu77GptMAlFYSDmpoVS5gBpcoSEKrb4nNRl4sfkkIZ9B30DmYF9RBoImhWZkwPAVN1W
	iVXraY8ecdnX47+XXedx7TS/Lj8an2Gks63W4sSmCKn4dniA3O4vzGsuWER4yiDTSDbJkFr5a+n
	YT8eN2Zale9kLluobvLJFVU4RqkZFCGjntiKud+26FxShTeeH1FUfLKzojeNHJafJtNMxBQV+5Y
	7hgPcUttTix5d8Ek/ktRZRBL4twRYENacm5ziNPu61Zxtj2U
X-Received: by 2002:a05:600c:444c:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-454d53fec78mr29710125e9.32.1752076946297;
        Wed, 09 Jul 2025 09:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJdb51k7SVr8Zh7SvHc5+UDRIZH2uJc6ylYrhVlJe0wToVLnEzM9gYXOOUm8CZV5p5CNnDfQ==
X-Received: by 2002:a05:600c:444c:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-454d53fec78mr29709435e9.32.1752076945624;
        Wed, 09 Jul 2025 09:02:25 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d508cbdesm29617235e9.33.2025.07.09.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:02:25 -0700 (PDT)
Message-ID: <eacbe956f6815bccd4110cf3f82ffe76c0c4e09b.camel@redhat.com>
Subject: Re: [PATCH v11 02/21] printk: Make vprintk_deferred() public
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 09 Jul 2025 18:02:23 +0200
In-Reply-To: <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
	 <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FwfqKxOIzIrNZyjzr8HyT4MIVve7MOs8ndUWnNKX9eM_1752076949
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-07-04 at 15:19 +0200, Nam Cao wrote:
> vprintk_deferred() is useful for implementing runtime verification
> reactors. Make it public.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
> =C2=A0include/linux/printk.h=C2=A0=C2=A0 | 5 +++++
> =C2=A0kernel/printk/internal.h | 1 -
> =C2=A02 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 5b462029d03c..08f1775c60fd 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
> =C2=A0
> =C2=A0asmlinkage __printf(1, 0)
> =C2=A0int vprintk(const char *fmt, va_list args);
> +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0asmlinkage __printf(1, 2) __cold
> =C2=A0int _printk(const char *fmt, ...);
> @@ -214,6 +215,10 @@ int vprintk(const char *s, va_list args)
> =C2=A0{
> =C2=A0=09return 0;
> =C2=A0}
> +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
> +{
> +=09return 0;
> +}

Was just running tests after rebasing and I received a kernel bot
warning from an unlikely build without CONFIG_PRINTK [1].

>> include/linux/printk.h:218:20: warning: no previous prototype for
function 'vprintk_deferred' [-Wmissing-prototypes]
     218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
args)
         |                    ^
   include/linux/printk.h:218:16: note: declare 'static' if the
function is not intended to be used outside of this translation unit
     218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
args)
         |                ^
         |                static
   1 warning generated.


I believe this ought to be static:

+static inline __printf(1, 0) int vprintk_deferred(const char *fmt,
+=09=09=09=09=09=09   va_list args)
+{
+=09return 0;
+}

Cheers,
Gabriele

[1] -
https://download.01.org/0day-ci/archive/20250709/202507092300.Isx1ydMp-lkp@=
intel.com/

> =C2=A0static inline __printf(1, 2) __cold
> =C2=A0int _printk(const char *s, ...)
> =C2=A0{
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309d..bbed41ad29cf 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -72,7 +72,6 @@ int vprintk_store(int facility, int level,
> =C2=A0=09=09=C2=A0 const char *fmt, va_list args);
> =C2=A0
> =C2=A0__printf(1, 0) int vprintk_default(const char *fmt, va_list args);
> -__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0void __printk_safe_enter(void);
> =C2=A0void __printk_safe_exit(void);

