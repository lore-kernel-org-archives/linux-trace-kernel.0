Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C3328B7F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538080; cv=none; b=Bx1Bb2M+cbMDm+IFVxaPnRmNQcFFuiJh6GRSjMbwQSgcCN3jSJD2oi4MSvghLGtfuIK2vIqezCfjsMVckikc/Za2G1oqBHffuZJIDouAKO6ZIUD7AxUHUNaME6XUFoGKCoROKYU4raqDE6OGRuNcM6BJyGf/hiTJTz6oi9eaCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538080; c=relaxed/simple;
	bh=hIFtKQ3FtlY3HFQ/xsX8PZQ3ou39v+kavljWws218lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+yMWgrgtZvaFL0dA+sxlJU8WA9icPBw8HZPPGoNlzAta/0DzkklAaMzqEWFP36LoVNkPMGeHxcpDDjTVgHFgKknmUBJtlTL1r5CHRSfTEwfcwnr+oO1jPB/KSh7ZEm56rtl1/zXaaKlEa8OiIV9shg2g//BENUd3fMJTBpQ298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRp2zXn6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRp2zXn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786538077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hIFtKQ3FtlY3HFQ/xsX8PZQ3ou39v+kavljWws218lo=;
	b=gRp2zXn6EhhL35HAMdUSXeZP9icEwtLillAB3y6IPEJ+eQz4abB7YG/7wWsz5vInouxdc/
	+vBK497aXviM67mGw0lsoNgAcjvTqjoDfxqPcpjx2E18FTCNicbVgGuxjVVFp3SOYD5/fM
	DtdSIxMsOwjeA80DeQmz6RrlGvU4utI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-mlhSO1s2O4GXBytR278RRw-1; Wed, 12 Aug 2026 08:34:08 -0400
X-MC-Unique: mlhSO1s2O4GXBytR278RRw-1
X-Mimecast-MFC-AGG-ID: mlhSO1s2O4GXBytR278RRw_1786538047
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49545071724so9243725e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 05:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538047; x=1787142847;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nv5ly0m1D08U/TFFN+ZAY0FDeBAmpfUnhFFvB/yjXXM=;
        b=IwsgyMuqisF8RWRbsQHawwxWUnd7bwM15VhBmwgLKrw90mShrKbI2R2PIiI8t9oYb6
         jrMRYnXJrvNRFA0Jp0xJi6m2Ije0SLrXsu2qrcRcvadDfj4OiID/pkkK8kp0+KEfY0i2
         i1QwG7dI8Zehhwik7seSPS6aNnOw/NA04n0hOED1RBqCO87tX/BeUjUCxeG3e1Zj8lFq
         kynlgyJncOJ0h+xg2jddXcIE/H87W5TQjz89B1RlgyXZo30SfnOr3A9ErTgbwiRmHzF3
         EdsaquUR/vbWMePXSYajPMtrT5DvNcgAjjjwwqyOrPgFkunC018eCM/H6K/OhHARbQTb
         CXCg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0lFy0dTnP6fg/o7ejsQNIJyZi2wvEt85FBMtWODJ5rCRVoJ7XvxZIIWsBrxZm/PA3qBoKbw3KXl8F1eWM2Czgt4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pWGL9Yb5emgb4hQWkpSf+xTvL1wfdQdsHAzAw4v5cBtfiBNs
	XthWcz488IM5LVSip4vmgJrn61N5EwKXlK4ETFfQxU+yoxquaKpiGq9OdhjvHbXC0uhtHGSiC15
	14+KtB/u+TSs9fATtJGawP1OER1gQIg03P/fzMw4SzWOFBUZYKJgAs8qoMgQ3qbsNzJ7Umu7sMA
	==
X-Gm-Gg: AR+sD13fUDIeu0yW2rBrueqF1IwoJWKMB7dmV9SBQTW+FvHVpLNpNxTAnTbankYwp+T
	56ovclSX1JKnJcR48zEqMYQ3vPpIlgCD4sGhlIeA+gz+30AFTai9ld5It0u2TTiNWaLDnrPKAlk
	5gGdGI1tPUushXGZNxglkCrvBRXjbfFBoD/jqOOv8pXMv5Uc/JIq+P0RnjVFeuA//EddAIwo045
	tss5f9Apa9cIGMbhTW+xWzJIR/7YmWSUjE2+ZGbFNhrYrVo26KsU7E4592IVmsU7372RtcpY+C+
	tnzZx5hHE6+lOB9p4kJR8t4VKMDPLNuXYNdud1SXdI162XfjMVl4pN3OYGduWlcUXQmnzIR0KbQ
	gtK5S3RvxRvOAm3HtI1zUNZwlAdDP
X-Received: by 2002:a05:600c:1f82:b0:499:5c3c:41a5 with SMTP id 5b1f17b1804b1-4997bf88a5emr59165855e9.0.1786538046670;
        Wed, 12 Aug 2026 05:34:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1f82:b0:499:5c3c:41a5 with SMTP id 5b1f17b1804b1-4997bf88a5emr59164975e9.0.1786538046200;
        Wed, 12 Aug 2026 05:34:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150c088c9sm7294272f8f.13.2026.08.12.05.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:34:04 -0700 (PDT)
Message-ID: <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Date: Wed, 12 Aug 2026 14:34:03 +0200
In-Reply-To: <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
	 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZNlzRCMCukoxeYcaTE5ZRyrOyU2z3_Qi1nyF-MvRI2U_1786538047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Reactors must not explicitly take locks, so they should comply with
> LD_WAIT_FREE.=C2=A0 However, reactor callbacks can run with preemption
> enabled on any kernel (not just PREEMPT_RT).=C2=A0 If a timer interrupt
> fires during the callback, the interrupt exit path schedules and
> acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map that
> declared LD_WAIT_FREE is still held, triggering a spurious
> "Invalid wait context" warning:
>=20
> =C2=A0=C2=A0=C2=A0 [ BUG: Invalid wait context ]
> =C2=A0=C2=A0=C2=A0 context-{5:5}
> =C2=A0=C2=A0=C2=A0 1 lock held by kunit_try_catch/209:
> =C2=A0=C2=A0=C2=A0=C2=A0 #0: (rv_react_map-wait-type-override){+.+.}-{1:1=
}
> =C2=A0=C2=A0=C2=A0 kunit_try_catch/209 is trying to lock:
> =C2=A0=C2=A0=C2=A0 ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}
>=20
> Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>

You came up with the idea, I at most suggested how I'd like it worded in th=
e
comment.

Anyway, I'd appreciate comments/acks from the other folks in the loop, but =
from
my side this looks good.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 20 +++++++++++++++-----
> =C2=A01 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 2f5fc8d18dea..5830229210e8 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -465,18 +465,28 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0
> =C2=A0void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> =C2=A0{
> -=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +=09/*
> +=09 * Reactors must not explicitly take locks, so they should be
> +=09 * LD_WAIT_FREE.=C2=A0 However, reactor callbacks can run with preemp=
tion
> +=09 * enabled, meaning the preempting code (e.g. the scheduler taking
> +=09 * rq->__lock at LD_WAIT_SPIN) may violate that constraint.=C2=A0 Use
> +=09 * LD_WAIT_SPIN in preemptible contexts to avoid false-positive
> lockdep
> +=09 * reports; keep LD_WAIT_FREE in NMI/hardirq where preemption is
> +=09 * disabled and the scheduler cannot run.
> +=09 */
> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LD_WAIT_SPIN);
> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map_atomic, LD_WAIT_FREE);
> +=09struct lockdep_map * __maybe_unused map;
> =C2=A0=09va_list args;
> =C2=A0
> =C2=A0=09if (!rv_reacting_on() || !monitor->react)
> =C2=A0=09=09return;
> =C2=A0
> +=09map =3D (in_nmi() || in_hardirq()) ? &rv_react_map_atomic :
> &rv_react_map;
> =C2=A0=09va_start(args, msg);
> -
> -=09lock_map_acquire_try(&rv_react_map);
> +=09lock_map_acquire_try(map);
> =C2=A0=09monitor->react(msg, args);
> -=09lock_map_release(&rv_react_map);
> -
> +=09lock_map_release(map);
> =C2=A0=09va_end(args);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(rv_react);

