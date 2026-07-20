Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F62F549F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543040; cv=none; b=dmwRTmIoRkLHQX7a4qqNRpyPujauS19hVMmhz8HGEdha9htJE932mCvKfYo+mFZx/NwEZxUVProkoB7Xtn8XySAEQGvCzegWIu3WmZxyXl2DbulMGk+jeBfQxxB+2jpNYO4FUYFZKMya4wWjSzyhcL59YTqxHWJw1CUqIb3OUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543040; c=relaxed/simple;
	bh=YyLE+AznQJ54MwE7h2NDPtTRt5fHXIjoI0Udh7yo4BE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkWeunbUEkR/cIgtCY5Mw++rONf0OQNlWdupfyuYSCWM5a6zC+753xjPmoFsI9mrEth4EjsonoosTxfCBo/0uwDpRnYI+pwivZPqHSDQMnTcrRESF2kPUZctZL6aCJv8AxgJcM40ajCAi7fj3Wq26l8Yue3JsAzVvq3ksehntjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDJJqQPm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDJJqQPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784543037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YyLE+AznQJ54MwE7h2NDPtTRt5fHXIjoI0Udh7yo4BE=;
	b=fDJJqQPm0x9N07FuHcq7n+fv73/736FCVn/i0eCunzFftOWrdaiJEDhILmjKbTVy7WwFlp
	O/StwKOVMmD3LwpsUHwmy2svpcpxhY4PUMkpuAgtHX5tkKbdhQ+y36T//AZl8z3yYyEzhv
	adq2eoPo4w8Jid7ruUs/SuTdFGQAPJA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-uJEXo0otN2yVWyP-Zd1JfQ-1; Mon, 20 Jul 2026 06:23:56 -0400
X-MC-Unique: uJEXo0otN2yVWyP-Zd1JfQ-1
X-Mimecast-MFC-AGG-ID: uJEXo0otN2yVWyP-Zd1JfQ_1784543036
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c158b6e31aaso388403766b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543035; x=1785147835;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WAv5EUl+JFD4SVu+gscTK8t247FQIOCo32WIsrCCt+Y=;
        b=BoFxLRyxZYM1GEbTE3j4NjZGQ4xIKiJcn7L0a+HrLTogtOfo2UaqPo2T9A/3pZxR7S
         uRXyc4Vbl4cDnioqcYLrGLiSlZyy8QNTZEErcsBfrjEzwgIxc1SumbEn3+tIW1KXqyS0
         DvccnCErjMSaTtlE0/8pU298L8f66SCx4zWa3kqAY7noBJvZJ5nxsd+kvtXJt7IYLRPX
         bxzjuWmGqNCRI3yJuQ9t5V9knf4hhZklls2otEnud8gqheMvfz5Oxjng0YYAnHkw37Om
         u/oKcZcYV1aKopdJ+V63wd63I6bQRIW9+D4M3rm4k3HdjYB8JjZys7k/26vlOmFKVFLI
         mehg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8VnfaBm2jE0PTQyU3RIS/ENz7202wLoTixif/59ViaduMrV7UoXSj7WwccETauiiCmGwZyT7WBVoRigXYqn1s9H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUR0dj768zPQDfoS+PSQ1ntRqkt036Ntu9l6+EzglgZ5Pzk8x
	bocbHwLPbi7niyg3NkLwOmIOqgOjIlVdZXfTmz6nd0j+AUUqHxx0CCiXtIP9Yd3BncFhB5K4twy
	uaRF84rAAU69YZTaAkbabBl5/EZ+5belbMPix0skPeZz4R2sk9GtRI8LrjnxqwJniPSf3hsLM9g
	==
X-Gm-Gg: AfdE7cnoVkePiITrNVtrNznin2Ctuxy+Zq8/MAaE8RjaAv1rsi7PESS7ahwik4G+hLE
	vDphEt9Vfpc1oEqbC3rWBd4/J5FnkNbBJO0hzNyLGzF9+fLJcdIyJ40eo9Hi6cDbmGMWOUxfev/
	Q95Yi77wycqTk0CqWCp3eYmhA4brYgdMSZRuZ0W8hQehiMd/kZ/NKJ87/0B4t43/EaxHSiZHz8u
	fN+QwpOjRQobYufs0+s9DEQ2l2wW8bndllWeCVUWkjPHj7/CZKli+m3YMCHPLBt/EI6HhfI6wN6
	AlRxc7MyI4aSgpr8jM3i8y18TEf29NqQmzgSWlqaallaZUfhwDGEooBhmxVJkaqce8UMVAfgvZg
	iMwC9+/4LvXtATyjcOvjR5He3kCI08sHxSUHTAbLXqrIrUIXDD5BXgXp7subUB9aKRje14w==
X-Received: by 2002:a17:907:7254:b0:c19:7908:c67e with SMTP id a640c23a62f3a-c197908cfdfmr130463666b.4.1784543035549;
        Mon, 20 Jul 2026 03:23:55 -0700 (PDT)
X-Received: by 2002:a17:907:7254:b0:c19:7908:c67e with SMTP id a640c23a62f3a-c197908cfdfmr130462666b.4.1784543035150;
        Mon, 20 Jul 2026 03:23:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1735f20279sm432764766b.53.2026.07.20.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:23:54 -0700 (PDT)
Message-ID: <d8f56e1ee667a2dbff9a87c8d10ca0c9c49d08ec.camel@redhat.com>
Subject: Re: [PATCH v4 1/8] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 12:23:53 +0200
In-Reply-To: <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: HeUTNIokz-xyoYZHgCTnL7PBrU81rJ1RsUb4KWDWvzo_1784543036
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 28d3c74cabfc..83199f90afe8 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -365,6 +365,12 @@ static inline bool ha_check_invariant_ns(struct
> ha_monitor *ha_mon,
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_ns - prepare the invariant and return the ti=
me since
> reset
> + *
> + * If the env has not been initialised yet (first entry into a state wit=
h an
> + * invariant), anchor the guard clock at the current time so that the fu=
ll
> + * budget is available from this point.=C2=A0 This preserves the documen=
ted
> + * guard->invariant ordering: ha_set_invariant_ns() is always preceded b=
y a
> + * valid guard representation in env_store.
> =C2=A0 */
> =C2=A0static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon,=
 enum envs
> env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0 u64 expire, u64 time_ns)

This hunk belongs to a later patch, doesn't it?

