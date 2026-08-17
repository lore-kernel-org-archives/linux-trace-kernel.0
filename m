Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B993033CB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950962; cv=none; b=qHGMUx+AnCRS7gnsQPjdiekudp4d6IXycK6+B9esfUvJifadi6tGPDo6vNhrC84qwAAqqUKuDRPZYSRDMtSOLx2LrPw7yk0DPFMfY9P/Rp+nU+GjwHZjoaUGZ7stLe2XwIXRqiuYDmDMBQQpMkZNkxRgsgYz/NoCtlOA5tTkHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950962; c=relaxed/simple;
	bh=v3z4PfSM6JghqMlh7wiK/S7MvWZveC5X5xWc2flFhdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFmESQpfUUizdVTMLWHI0kcISeM0paP0a9cgB8aJGFaGuqvh3zRBe7h9UjCQHUChERbGVqhC59YzEjdi2C5KIX9fN0d4KG5D0rChzL5Cm4rkbLSNA41gk4Eqf6BHXvMfh6EePysL/gt9YqAim+7kDOY7UnvJ9H87fqnHO4/gEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyZiIPi+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyZiIPi+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786950959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v3z4PfSM6JghqMlh7wiK/S7MvWZveC5X5xWc2flFhdY=;
	b=MyZiIPi+tRFRKDGmHbf1czEGQs16Qxvc36uvQXOLOga8aR7dBZ/pDClLY5cfbFWgUK2LPr
	CLeco1YLX4MHpSfGlzRDr3Je9n1+pbxWxXQoWRtQrgQ3LYSxI2x66DhqZii6TXFdSdnhok
	rtObg5VkgmZOix3g4W93O9xs9CGW8ME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-0ySl7t_TPy2gWn47qeR50A-1; Mon, 17 Aug 2026 03:15:58 -0400
X-MC-Unique: 0ySl7t_TPy2gWn47qeR50A-1
X-Mimecast-MFC-AGG-ID: 0ySl7t_TPy2gWn47qeR50A_1786950957
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496c06ba017so16599435e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 00:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786950957; x=1787555757;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v3z4PfSM6JghqMlh7wiK/S7MvWZveC5X5xWc2flFhdY=;
        b=RlPRgfbOUYaUmhJ/+XtwSGu/pLmq/XKIyvuQnVproMwrDt+rgyq1HRv/JUS2vdoi4Y
         F369R34tDKexOiW01vX30Qi3a57fBIurVvksAygoGPva04vAPfX1Lp19WjQpfPDE4WAH
         YMx5VUtYlR5hpNgmCJ666E02kZOOihwFt5xZTofQ3UElmnetHsNtfcruNw+l4SQhXGfN
         8cqR033EIDbG6JojTPZOZWZ9iT9Kw86RrUad6fgEILdfQTRoBjD3Od0zyqY8qKEeKeDu
         3ebyc4A3WDugXAANw6g1buJaVXrST84DiijXClK4uqN5sCHTegBPEhz9lwiKGk2lhdtl
         +GGA==
X-Forwarded-Encrypted: i=1; AHgh+Rps1/7zdOicnKFlJGKalv05/HXXQ2sSUxg+hZxEzoyKILLydcYJYjKYhjNNcPro4LfW2N5iy8r008G0k9sI1uKEFWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLKlYinNDWR0MAaztFRQ7LZ7ij1/FeEfSNNUSttTplzfNgmOv
	TPPg2RrHaOy52ybX0g6wINaawMGgMx173ctWubLuiDtrNpMG762pOMWhsXvFyX1/isHs7RXtAMR
	awMCIC540coiVK7UtZ8Y2c2kT3spxuKfiTpZU+XNpNnObaCJpOnq8HGlBUwTcE5Wf2yFVuEoltw
	==
X-Gm-Gg: AR+sD11E75QI3BIIk8YZgw4w/329oXUcxWwYuIoxzobYs8i40iortkaRhRIFsPFkI5Y
	KZCAEwnBhrQW2Lj4gGXlz7FEiAY/3oHqnc9TChcMJxGphnYvuiRLw1Hb4Xt8aHl2IhylW+scZL3
	hS/u6IzXI5bZNgd8pxEpPAfOAOWStXV+v2CXfCWDR/f7kiIfXIQaY120yhfE7AmVJDSTgVLDWOm
	X1SkdwHQTDw0/zUzWsVYrmEFV7DY5annCpuuUUz+TJ6unSmPVGFs4ijk9s7SLsrb3NCpaS+rjAo
	BxieZNmptlurTZz3pXyZu0pbCwNLvOlX7VPrkViLPc5x2giTn8gVkGdYeX/Q8olmKekqAYf3IEX
	tzK245DjzCmvO+bmkknDrIJap75y7TvapD20x1qWz9SXV4HtpxZOdy3NUMnKBfaIFQnAJJg==
X-Received: by 2002:a05:600c:3b90:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49987a4f131mr302421275e9.1.1786950957064;
        Mon, 17 Aug 2026 00:15:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49987a4f131mr302420595e9.1.1786950956598;
        Mon, 17 Aug 2026 00:15:56 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm158565235e9.8.2026.08.17.00.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:15:56 -0700 (PDT)
Message-ID: <8e9c771e8962eb9ebcc1f433571e9c45838a565f.camel@redhat.com>
Subject: Re: [PATCH] percpu: Drop CONFIG_DEBUG_FORCE_WEAK_PER_CPU
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>, Andrew Morton
 <akpm@linux-foundation.org>,  Suren Baghdasaryan	 <surenb@google.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 17 Aug 2026 09:15:54 +0200
In-Reply-To: <178656406317.2437052.7257990869957704195@slm.duckdns.org>
References: <178656406317.2437052.7257990869957704195@slm.duckdns.org>
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
X-Mimecast-MFC-PROC-ID: LtMImGhlQzUN4rzL_CjGVK-aucny8kPpv4lcgE2LDbQ_1786950957
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-12 at 09:47 -1000, Tejun Heo wrote:
> alpha requires percpu variables in modules to be defined as weak so that =
the
> compiler generates GOT based external references for them. This puts two
> extra restrictions on percpu variable definitions. The symbol must be
> globally unique even when static and a static percpu variable can't be
> defined inside a function. DEBUG_FORCE_WEAK_PER_CPU exists to give generi=
c
> code build coverage for these restrictions without building for alpha.
>=20
> MEM_ALLOC_PROFILING defines a static percpu counter at each allocation ca=
ll
> site and thus can't be built with weak percpu definitions, so it depends =
on
> !DEBUG_FORCE_WEAK_PER_CPU. As allmodconfig enables DEBUG_FORCE_WEAK_PER_C=
PU,
> this knocks MEM_ALLOC_PROFILING out of allmodconfig build coverage.
>=20
> allmodconfig coverage for MEM_ALLOC_PROFILING is worth more than build
> coverage for restrictions which only matter to alpha module builds. Drop
> DEBUG_FORCE_WEAK_PER_CPU. Restriction violations will now show up only on
> alpha builds.
>=20
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>

> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -24,7 +24,7 @@
> =C2=A0
> =C2=A0/*
> =C2=A0 * Per-cpu variables require a unique name although static in some
> - * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules=
).
> + * configurations (e.g. alpha modules).
> =C2=A0 */
> =C2=A0#define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)

For the tiny change in the RV header:

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

