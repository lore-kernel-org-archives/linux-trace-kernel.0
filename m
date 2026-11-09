Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794220749;
	b=IxoZqQfEXnnk89G8wLkMe+PMr8CjoWzGok8MpoKjZqscXiPIopYxqoLDGTiQHwp7Y50u
	 /s0U5iiPhHwqPGRo6idE3KqJ9kzB40FOAwBWNpVCRloMoT+8GJvBLatn2FI2DLNBDdpQU
	 P0BuOpfqP+ypm+smYP0JVOCh1YDyBa2wUjoCUt4qcSKYnRCGIS+VCa8yoDoJrPi3Buvya
	 J5Kr61Mq4Lkn9y7uCu60ni6ykOVeZAYEseHn+KHzzt4qmHdIWU7udXPd+tGdaXr4dl8PQ
	 lyeXBpGiVOxDyULhIgLe6zdMsHbEmt1qKcNPcesFQr5YgqH/9JWnFxO1Xt89u8VTcTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/eIsMAaHkqwUQsjvZEXSAGpGx27AZeYfKjqTpQ4IRgM=;
	b=H3z+OrDwMurxZ/lQiv5EHdAV/0zLUKYimU+FFih3460iecPm3BoYSkjOCad1DNxhu0nb
	 YwiEB7xPuVdT7a2A1u2UQglChiS0hvne/9QkFi95vJomDLdtl1NHN7UlYL9GMQKPJnqAl
	 BsuuNxlzEU39tXaDOM0Wc8KgW72F9u1eXLiTryh8Z4lZe10O7dSCnCq2ksa3e9Py+2SO2
	 nmmqwJ9Eaj8lZyVFRUn/Tm+QsFQ7m/Aw7U/iN1NoQzmCN9q5lea/wGKrVU4Zg4Ec05cXt
	 lScV86g/Bfgp1vLHRf+vOpAbuwvQ2OOnXCfiNe9MpLtgg3gUvkwM6ICIKYa2fvw5Bcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VGIbVNvV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0D606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 10:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VGIbVNvV
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4c9abc1824so99824766b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 02:39:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794220748; cv=none;
        d=google.com; s=arc-20260327;
        b=jJLGhD3I00nGwnMu4UxG+4ukYbezWRKgfpLlLpUW5YW+T6JHAhBUUbCs8EaoEnWrRN
         EF38lltkJ1dgT89tLuuQXs0Z3BQkpMm9kPz12wpiA2wOdbbIOA2aMONhZCchv5+yhvmO
         SWkr5B+0o0ZCw2LPaQWjWh3+jM2aFvlUFClX4liQKn6vcBHUYDHpX7QxpKn3+uQsC79V
         9JMRubBt2NBCZN/eVdSk5/akKLQbdVMrY18RPUI2Uj/AOuQYJSSRdymQA7U8wf8KegQU
         EBnRxi5uO2NuqI0JjZlH540YSKKHTkHyxrH9anhUtB7IWz+kHof/uKNSRjQI48IcmwNy
         gONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/eIsMAaHkqwUQsjvZEXSAGpGx27AZeYfKjqTpQ4IRgM=;
        fh=s+egq1Wj7rTLb4FwSSGpx+4PFbwxMZBkUjp4arxvSmM=;
        b=kz81mCOxMTqa6on5bkbQWEarN6RRjI+UHJci2UVNKeliWk/nj2h/sasVBveQudGPfM
         8BNloR6yBYPpDMHa3QRPQgXktKusdVxqdREeVWRrIMp3S9dtF5lKWwNJgcUihojWclhv
         3v/ax4AMsnEe5jX6Ca4iAnmNVodIAvZQn5ZFztxIXDb0Y6NbbJvuEn7GLyeLVcTh+ek/
         HF/4M0fU1lyeN5posufQXv9YQ7rPfine/MuLqUulDIPzsD/+0wYST67bjPqU7FfEYPE3
         EYnyeDY/G3I7VUpkEWNt7Dw7AS86579YEOWgGBaR3fiZsl85OWNXRfDJ6G1CTL8Cab6Z
         SDAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220748; x=1794825548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eIsMAaHkqwUQsjvZEXSAGpGx27AZeYfKjqTpQ4IRgM=;
        b=VGIbVNvVsyFdyVGxvWFvdEUXU1j6X8yC5ogwXQcUWLwRi0U9lHYmqXEsUYPuAlp8IE
         tX+t/SUgLN3XLG6z2p2Y/lZqWVsJqLoB+7rxDdsmvFc2rsI+l8CeRW3vgQ3IIhg3buuy
         e9aMj4HGkKDv/xKUX0xE0euqGfMqCGdFUEAncaoEvuuz0d7EfKO9Grr/YwcxY3UFajqw
         qVZyWvAb1DIIGDKzkH4t+2BbXnLJJA3ZvaqSzh3C3CYPOCkvEW8aroj/z8imrx1Qc3EP
         4EVVVvlKA3EoKi/EWIWnnWylWMObmqaKWWnTNOdbBja5jmcrKvNdZq4Ikntm8wmrB2Lc
         08Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220748; x=1794825548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eIsMAaHkqwUQsjvZEXSAGpGx27AZeYfKjqTpQ4IRgM=;
        b=wNmg7CYVXg5CQXX6i/vGd3md9205jhoXL7lUGuem2iEHAnnnuwlJrQa1/9bPQqNSZT
         dFojmhueOQ9l/SaJxOSHYgWssxyTndhzkJvzsBUEUoZvYpskKQ0Ft/wSVwvCW0eE3KrR
         NULI1C7ko+9e3bGJiCy7QpWykdo4chtObf7/Fhhswa7Y1lOiBNHKjhYlvR77vfcuWBV/
         +bjoIs9l+kRLad6t4fNlZ9W9c2RxcB9de9uuINNXria5BaMnaBedBLxCB6b6k7C9RM02
         NUCEPd3o+c3HkFBb8Lp6X+JJC7S7lzYJZZTkg9+LS2kaVVKq35eXV+ylUBbxT/OwWK9v
         Lt8A==
X-Forwarded-Encrypted: i=1; AL+hErG2+SAruSmCmWm2UxqyIIATn8cAYBCXKkNJm91bIspB2TfxtuaA8bxro3+XPt80wyHiQqCPuaZJ+CMe9SQu1WuASzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z++c/82UKcQhUhjw4zShJDRTsKzu4NTc2DZEbUB3Sc6mgJO2sZw
	RQcAYUudS6cnwY6nR1cNWK1EXVdASYthycD+CVxHicg/DKvHibojzv6flDreLCgldTx394kXwqH
	wO0+nAHlyHOWcgHFz0ddx2FXvYNm/gH4=
X-Gm-Gg: AYBFou0CspBoONBzLBRacex0AE1oKgYwzK0R0QGip+UPpquJuWjjA9vmb2met18WiZC
	hgkG4g54Z3JST/2xPFJV++kvqTtExoi3vCIGGpK9vF025tWEe1Uhi9o6ePmdiieK5PkhTKe+mEH
	a8moVRFY2YqyK3bWuopeaIvHpgQhdewamuw+93FcU42uJciXsE7GxZpHKiiRt7EPdajr/Ccjk7t
	tOxvXtT8gA4yg4tHYfgxWoNAsHa+C411y1azQl24WCMYHg/B1YOR07wB+H3v7JvwmJb/nSJGxGr
	L/mVLIkaichZM/yjuzfSOwWyYqXTOUQbznBWsL+yHwM0vniNvfFJixAfh00llMiw1rS0IZG+iRo
	RaoHQQnoW4Dyg8x9ebp7aa8+XDSQEVuQJQv/GIq8kR0WM/7TDIEyX0RqkMKf9hS9+Mct6Fw==
X-Received: by 2002:a17:906:dc90:b0:c2d:c800:d797 with SMTP id
 a640c23a62f3a-c4d6d993cedmr266362666b.6.1794220747418; Mon, 09 Nov 2026
 02:39:07 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104222558.863948-1-christian.aurichzm@gmail.com> <avGSispr9aIXliex@google.com>
In-Reply-To: <avGSispr9aIXliex@google.com>
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Date: Mon, 9 Nov 2026 07:38:55 -0300
X-Gm-Features: AclHuK8ccQMojETpg1jmz4EAo_aPaizrS86AeflgjE514t4iJOlZFDHwUpAXimg
Message-ID: <CAPDkpGre=z=RCS_ffBKTKV_GsQn4ejyknVwNPFmjkhGTORZy5g@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Do not WARN when trace_rb_cpu_prepare()
 fails to allocate
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Vincent. I took that reply as Steven explaining where the warning
comes from, but I may have misread it.

Steven, the same si_mem_available() check fails silently for the current
CPU in alloc_buffer(), so whether mkdir WARNs or just returns -ENOMEM
depends on which CPU runs out first. If you'd rather keep the WARN I'll
drop this.

Em seg., 9 de nov. de 2026 =C3=A0s 06:29, Vincent Donnefort
<vdonnefort@google.com> escreveu:
>
> On Wed, Nov 04, 2026 at 07:25:58PM -0300, Christian Aurich Zanettini Mart=
ins wrote:
> > Creating a tracing instance allocates the buffers of the other CPUs
> > through trace_rb_cpu_prepare(), which WARNs if the allocation fails.
> > But __rb_allocate_pages() bails out on purpose when si_mem_available()
> > is too low or the task gets killed, so a mkdir in instances/ with a
> > large trace_buf_size is enough to trigger it:
> >
> >   WARNING: kernel/trace/ring_buffer.c:8094 at trace_rb_cpu_prepare+0xf1=
/0x100
> >
> > The same failure for the current CPU, or in ring_buffer_resize(), just
> > returns -ENOMEM. Use pr_warn() here instead.
> >
> > Fixes: b32614c03413 ("tracing/rb: Convert to hotplug state machine")
> > Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a707c4f.13bfb6d0.1ecdd5.027e.GAE@g=
oogle.com/
> > Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@g=
mail.com>
> > ---
>
> I do not believe Steven is keen on this change [1]
>
> [1] https://lore.kernel.org/all/20260806174638.6012fa24@gandalf.local.hom=
e/
>
> >
> > Notes:
> >     Tested in QEMU on 05441d697f7f (4 CPUs, 1G, trace_buf_size=3D350M):=
 mkdir
> >     in instances/ WARNs every time before and only prints the message a=
fter.
> >     Same with a mkdir killed during the allocation.
> >
> >  kernel/trace/ring_buffer.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 1fd28a72e6ee..c018559ad61a 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -8091,8 +8091,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct=
 hlist_node *node)
> >       buffer->buffers[cpu] =3D
> >               rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
> >       if (!buffer->buffers[cpu]) {
> > -             WARN(1, "failed to allocate ring buffer on CPU %u\n",
> > -                  cpu);
> > +             pr_warn("failed to allocate ring buffer on CPU %u\n", cpu=
);
> >               return -ENOMEM;
> >       }
> >
> > --
> > 2.43.0
> >
>
> --
> Vincent
