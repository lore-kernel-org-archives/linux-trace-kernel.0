Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B063EF0B8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535741; cv=none; b=P+SglIodzy1omgmmKy5cB8rKPVSFF7v8zZDPWK+ugdIDM4AZEQ+78zZzwRK3APARcgWylC4iETET3mmr9HgRw6f5GYWNnGTjm9x9T8fwl/75A3MI7guQfgkIuFqFhaGC9sdWsOlwhwyDtJUc9gkrBU/s/XOd0xr+D3Zcp3YUPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535741; c=relaxed/simple;
	bh=q2JJExAxC2TtzJzsIROiri0j+cMXu1NLqvz5H532HlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHybAxcWfrOwbhlXxE0kW7Ija3g/7tXFoQG42I7tinm5OL5XULxOHG4cFccWdsU+iuK+QfxbulJjw5CClMy8I3BGGDBJGeOZTq7it9+3+g6z/CYippY+0Zc3pWwnpQhNJqeCDAi9XSkTXbwr/86AsDfHctysaly4naEyNwpwZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMX+7Yl5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMX+7Yl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDNXTdEhsZuDSlsnR9FJK78Yt48gWyWFipvm9YpyX4I=;
	b=TMX+7Yl54E8NxPQNA/TU6tJOqQX28cGqXAO+VQ7Q5Fm49e0C5IGv+RgchMHgaOQ0IsEeF4
	AHXD/iA0xpYWldBRA0nP3sw4V6jR2Gui7cxoRnQrKMXn7M7OjCML9s0z62GudrdKm5txwn
	Hdzeuk060LPI9UFpuFCH94e378JZSpQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-mw8gdmpVOQaHPUfoKzcjoA-1; Tue, 03 Mar 2026 06:02:16 -0500
X-MC-Unique: mw8gdmpVOQaHPUfoKzcjoA-1
X-Mimecast-MFC-AGG-ID: mw8gdmpVOQaHPUfoKzcjoA_1772535735
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-389fd3214e3so48620301fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 03:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772535734; x=1773140534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDNXTdEhsZuDSlsnR9FJK78Yt48gWyWFipvm9YpyX4I=;
        b=eaxs/DBNYMkpGMJXW54W1niHM58EGkZZEC6Lmkf00oaOFmIGHmYKJ+9oqPc3rDnQzF
         D2k/2jH8IGn6+vD9deQM3S/d4cRFU6OvWabPZ1+epiVz8mwB5vrnt5MPQdy9UZF5f6wh
         8T5WB9PYPW0lGoLLnHh+97GsYLj2s1pmwaBpMJ8IqU8g3UQo4nKo3rKWUFcL0X78xgI8
         JOxuazPG3guhEIHluqFEblNvuOrQUGJQz1APBj1MV0q9l+HYKXEE3//58qpom2gVKi+O
         OuNTCRrOmcauueKfv1+eZN21WdPE4hPUOSECC9vOkK11n390QSiR7uhV60BdG9cZdWQH
         EwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXC9UawWVbdFs73yuEjBKYS+eErzAk6pklxkcJyVSkGK3eloozfVw95AW06dctKHKOaZMzERR5l6MVuHXG2s+q12v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5KxiqjxpXNmoHG2U9B4puyIh8Hay+KEr4FU1gLydUqPx1p0y
	wzD8xrVyduCuLonLwznUO9Cidc/++AitEIeEiIyiYPh2VWFOLqEzHZk6ZoWxaTsn3+S0iuaPaqr
	poLy9HKPrSLNDYn/TjSRWcSqKZjSzGZi4W98VvbeSQKJRG4rt6zDIUYyn1nPjThwd8W1pI18Czi
	iljbfDXVGyqtAUTPvdu4C9qG9f1rnsd6UuWNR0pyngVW6j0DzF
X-Gm-Gg: ATEYQzxp2PtwSS2GjLHg96isr0FGp1dyHVne3WrJI6dhhXMK1RQLGATYRc+HyKWsstW
	IibWk6LWMj5hXvb/CfBMoBRpi5tMmrROOqBkSdpYrfUFl1R3BFRI7sqTtZQJsBbCrA5SVIxXnFL
	/6nIT4Nj8+ozD3OX0UIV+MaBHBuYlYIMAGVsHmc9PUAwGqgxxBtsJDSG2/po1Tpplm+mDy5FPiE
	a7/WIk9xtbkXCYvtN8FZUDDzCqIYQfOXA+dPtpKReVPomWmt6t9MTywiGK7yUbRtRQ=
X-Received: by 2002:a05:651c:304c:b0:389:ee95:e238 with SMTP id 38308e7fff4ca-389ff111fe7mr92003191fa.1.1772535734479;
        Tue, 03 Mar 2026 03:02:14 -0800 (PST)
X-Received: by 2002:a05:651c:304c:b0:389:ee95:e238 with SMTP id
 38308e7fff4ca-389ff111fe7mr92002891fa.1.1772535733857; Tue, 03 Mar 2026
 03:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-8-wander@redhat.com>
 <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
In-Reply-To: <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 3 Mar 2026 08:02:02 -0300
X-Gm-Features: AaiRm52aB5mNrgSUriPTM8H-k-A8l6JJMEcw91RR_l_OtUtdxH2_hQHzgn0B_OI
Message-ID: <CAAq0SU=EqDsHNxPZAbn3PVFm24UdKsF3BOP7f_8fBUAnooS-ZA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] rtla: Add strscpy() and replace strncpy() calls
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Haiyong Sun <sunhaiyong@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GZAg9wIPKPL0m7JJt03hAFasegldo3bUZPNO9sVOCNc_1772535735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 11:33=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> =C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > Introduce a userspace strscpy() implementation that matches the Linux
> > kernel's strscpy() semantics. The function is built on top of glibc's
> > strlcpy() and provides guaranteed NUL-termination along with proper
> > truncation detection through its return value.
> >
> > The previous strncpy() calls had potential issues: strncpy() does not
> > guarantee NUL-termination when the source string length equals or
> > exceeds the destination buffer size. This required defensive patterns
> > like pre-zeroing buffers or manually setting the last byte to NUL.
> > The new strscpy() function always NUL-terminates the destination buffer
> > unless the size is zero, and returns -E2BIG on truncation, making error
> > handling cleaner and more consistent with kernel code.
> >
> > Note that unlike the kernel's strscpy(), this implementation uses
> > strlcpy() internally, which reads the entire source string to determine
> > its length. The kernel avoids this to prevent potential DoS attacks fro=
m
> > extremely long untrusted strings. This is harmless for a userspace CLI
> > tool like rtla where input sources are bounded and trusted.
> >
>
> strlcpy() was only added in glibc 2.38 [1]. It is thus not available
> on systems with older glibc, like RHEL 9. Using it for strscpy()
> implementation causes RTLA to fail to build on those systems.
>

Thanks for pointing this. I will fix that in v4.

> [1] https://www.gnu.org/software/gnulib/manual/html_node/strlcpy.html
>
> > Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
> > buffer sizes instead of magic constants to ensure the sizes stay in
> > sync with the actual buffer declarations. Also remove a now-redundant
> > memset() call that was previously needed to work around strncpy()
> > behavior.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
> >  tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
> >  tools/tracing/rtla/src/utils.h       |  1 +
> >  3 files changed, 36 insertions(+), 5 deletions(-)
> >
>
> Tomas
>

