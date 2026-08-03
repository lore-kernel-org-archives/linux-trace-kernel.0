Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F2305662
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738781; cv=none; b=Mz0WBt8w8vK/o30CpmP2klTDL0tw8kHG1BXRG6gpu7jQ47yZXAp4+7Y+N+ZnCMu5rrF6G6IHJgfDZ38dU2F/7biu0Dxh6lqZkJYd9tlH+F0oFHSRn1xgbKFWFMfbvIn49Wv6XTzgMcDjeCPmL/Nw+MnRl4moxZjEPSPDwp6elTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738781; c=relaxed/simple;
	bh=gRkNjiKNe9yC3jkn/521WzZV93WLyNreu/A5vhhHU84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Xy81h4I+CINq6oBrHTmQlzKswZ+R7EQapC4RJQxf/96NQTJjFE69hTL68NwwyKjV14y8/jOIey9pR9oF9GTnmTQTQmP+DXtf2xAz4XT9Fdwc4K7zHCCxKeSdDouWFCM+iq7n/CHZPiT4MUHxgq+k7S2S+/x/3Qkn5F2AL+HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSShIzUn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSShIzUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785738778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gRkNjiKNe9yC3jkn/521WzZV93WLyNreu/A5vhhHU84=;
	b=iSShIzUnFkLT2lHl6nR0WrzqaxrEC74mgp5OJU/MAgaf/K50oRTHxrFdvXp0+uqZMXvcRM
	hoorVk5Q5QoOJEDEvLspzTQutNSIA3+S+t21ZyidQi5lY1/KfhSz17+IKbQPYZ5fdsE/h2
	n6BItXkYvFyjVtGDGXk5QXCyj/7cXYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-6fzCae7pN4K7cKh0HSPdQQ-1; Mon, 03 Aug 2026 02:32:52 -0400
X-MC-Unique: 6fzCae7pN4K7cKh0HSPdQQ-1
X-Mimecast-MFC-AGG-ID: 6fzCae7pN4K7cKh0HSPdQQ_1785738771
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so10824535e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Aug 2026 23:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785738771; x=1786343571;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kGAtNj6fbec9IRK9NgGILxfD8V3oY03sKYmcAfJ90+4=;
        b=ZmRacAwYVrncq4CLW+maenSUHVUTPIf1/uFyefo/HsQ3spMGizZpsKmpTiUqnh99/U
         nQnkJwheo/vL7X2dFGuv8vp00Ahntrxw9eOZNm4Oeg2a+Z3LKr62TieHZjFeInAIPQWe
         Ndmbn6JY75vRYqR4DHYmj+CVKbw1cBE/ikwbj4McSL5stCHBY5ONo9ecXd5fZdWJHPoJ
         /irOXIP3Eb0uaH8wfZHstzEu+LCt7GeIJkFvs8r4gtK3yUuEZG0CGOqCJeb+xnCL1sRH
         GHs+ACk+zfMhiVRXoml1v16fs/irGNhnf2JuR2JLcjf3SQcMG8yYFgREI6b0Vz9FwZeM
         wEeA==
X-Forwarded-Encrypted: i=1; AHgh+RrVDvA2/thVhSo9Mq+MK5uYoh4EzovGRN2Z7k1ohaVu/KuW27naE8NMGfV8/N55zTMJ7fAG6zuFojl+AbUAoXA9A1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqp6hLMxczRGb1ub7mrKE3azcg8yudTh3dETqoXKvcUjwvzeJN
	JXTrN1ELCpB0+QFoJxiF+Fy2aE2+2UkzjN5Raqfb5LYQqGg8iRdc1wYIn98e+5K19KG+s0+0pn8
	mB8LrgokpxD7XUW4hJWYOvmvmgW8XaEP6iWaFitJTTKPUJzo7asD6TOBOEUTj2Q8tC54PDkRjMz
	RhudwkLA==
X-Gm-Gg: AR+sD12LMBwIKxBLS4rgW7jMuluKJsEK4IjQumZKSQfrGxt8SSNhjn8njD4mPIJb7Bj
	pyCz/UIJAG0YmMpztFWy9HmKbkH2ISwU/Vr+yHs/4Z/NkPhv+2S9vQ/up3gtYwGJJJYmI9I2n1I
	pw4oXG/UrQDTIsDrAoY1eUEWrrAfsF3rNMgPyHn5BhT4kzOqrjsQXKD/dk61Ix8rBSJqBz32Elp
	rCLNpW1JcHJeXEh7cajYzXyneH7hZQvS7oge3BbNWErz+0BQdYbeeLdRS9pEOCahnUIErkqxwpU
	WrWKb45UcA0HMQKH4QJQAs7Mv6wm2xl11vTYFmfrJ3IGGWG09yEAwUtfgcBX5nDJsQX3jzrAEwB
	2CL1QYZKl4tgf2a86WlggzIpbzG0f
X-Received: by 2002:a05:600c:e557:10b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4980c64b824mr121981085e9.7.1785738771200;
        Sun, 02 Aug 2026 23:32:51 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:10b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4980c64b824mr121980495e9.7.1785738770716;
        Sun, 02 Aug 2026 23:32:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ccbsm202690735e9.3.2026.08.02.23.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:32:50 -0700 (PDT)
Message-ID: <6943bc6d81388939512772b602f0c920ef0e5b01.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 08:32:49 +0200
In-Reply-To: <d228eefa5ae3616f3d96640583cc2be771a83c82.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
	 <d228eefa5ae3616f3d96640583cc2be771a83c82.1785695669.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: EqPXWEoGlsGeLMg6wyEzthlgz91kgtueqapu9O6i1JM_1785738771
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> rv_react() is exported to modules, but the reactor registration helpers
> are not.=C2=A0 Export them with EXPORT_SYMBOL_GPL() so reactor modules an=
d
> the tristate KUnit test module can register and unregister reactors
> without hitting undefined symbol errors at load time.

Nit, but I believe you meant /link/ time (modpost). Linking phase would fai=
l at
the end of the build and you wouldn't have anything (.ko) to load.

Anyway patch looks good:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index cd571b1649f5..228ed043bd73 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -314,6 +314,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
> =C2=A0=09guard(mutex)(&rv_interface_lock);
> =C2=A0=09return __rv_register_reactor(reactor);
> =C2=A0}
> +EXPORT_SYMBOL_GPL(rv_register_reactor);
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_unregister_reactor - unregister a rv reactor.
> @@ -327,6 +328,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0=09list_del(&reactor->list);
> =C2=A0=09return 0;
> =C2=A0}
> +EXPORT_SYMBOL_GPL(rv_unregister_reactor);
> =C2=A0
> =C2=A0/*
> =C2=A0 * reacting_on interface.

