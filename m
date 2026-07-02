Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A64C0427
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001146; cv=none; b=XB/0OEiw45wbha6UVy6f/Zh1FR8ZB9K12g+jXB0rbnSzc1wfLlznvl9LAsIz50vVYCaGn0NuQ9jCTLH1ARuPJR3oAAZYDlBgwkVBHg/hc5sf77bqH6GtonltJeX5sY6AvFTetpt3mvx38sBSdHPns7yJ2RobMVM8GsLOHdlemyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001146; c=relaxed/simple;
	bh=qUEcJN+VNY3vPIEjLWC2mXzZSPb6dO6MrsrL3Biq2n4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idTIyWBLTsPV2ZjWA3D8u/zNRgv2AzxAv86SA+ZnwGEJhuYTamVZLEGOt0tUA6O1L3q8kf0/rxeZ5s1aFKBXxv78fw+D/a4hlWpbJgX6/QtqzxGDfZZQa7Jd9QSLmgWXa8u0AoiqcrtVWN8U3lFlDhuzfyBXrsLfFvOs+kT+4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVQf1uEN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVQf1uEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783001141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qUEcJN+VNY3vPIEjLWC2mXzZSPb6dO6MrsrL3Biq2n4=;
	b=DVQf1uENZeUkbH7x6PSbhD2fH7UAYLCe7r/8vPOz9YSKgQKJcX3OoLXFJQXx9c1DttsuEZ
	T5q0oX2UkV/3iYYuxeYdOmalEIG2RmwztywOZDgjgweOU/xE37u5i2ACD4ngLYRMMlyrgJ
	IRqa1D861qVmZ2zdqjbyN05CA4xeYpQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-IszhSmrfNt2K_9OpMpxD1w-1; Thu, 02 Jul 2026 10:05:29 -0400
X-MC-Unique: IszhSmrfNt2K_9OpMpxD1w-1
X-Mimecast-MFC-AGG-ID: IszhSmrfNt2K_9OpMpxD1w_1783001120
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c588b6f2so5750795e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 07:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001120; x=1783605920;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUEcJN+VNY3vPIEjLWC2mXzZSPb6dO6MrsrL3Biq2n4=;
        b=XUvhjZ0WkrBelMNIDvAJLfD3KFMrBjgj0ZxXqrF039wbvoDbyuGObkmuge6rLcRrea
         3X9eBHxewS8odUeYZw89rdTPk85xiSP85E5XDo9OwVqbZ6ztOp2yk97EwIKHDVDGuE+C
         OV/8dKHdNBJu1jn9q+gG9S71SVVco8xfVOTEYe5rmJ62uKTs1F5ijolJCnjDamENdPvC
         vGiiIroRpvC2qrPSM6iGl1e/NAM1+h5wEjw3GjDXdkn3DFBCBEHLdQtOFfMbsIfpD/88
         s7Ld11yL3W+xPpiB9+AxDbtOeMJ3qsxaSHQQtPUdruToMQ+smORYe3POnMZyBPHIbP6I
         hJOA==
X-Forwarded-Encrypted: i=1; AFNElJ/1IQzRVnP4d2LLuQdgl5jbLTDCL0FhA7oaqnU3NWJjGv3tHvoS3gf60DpPI5pheFpIf58RNqcg58e8R3fb3HwPCOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+3GQRK4RJ5iT7cZHM1X9N8XTle/kipVRp0YvQlmEeFnvvpla
	yaTGWPpP+YpvLKBQbgTDdlaojClIFZ71FL+1ecC/SpI4CI0Jtj8O9xSR8LGUcMxYsQZnBQBN5tZ
	4fQNmq3UNtWBojI7gFEUXRdv/CY78WRRnEJ3PC9YflQBjHFaSNWV1YiVnCqU8IeRcpKn5cSAEjQ
	==
X-Gm-Gg: AfdE7clBBbYUlpBLVhZbbIXQ7YcEcQKYLyW8e46Xhw7AiraNwo8lJ32Wm5jwWyyyrpx
	gM9LcEnM3d+PtKprgtxvaH4bHy0M14gAotvK9esQFvfx/XHB6oz6lKeXB0OY46hIQwmrVfQ498n
	56ysafOly9ryBlrCCMxkvDoxXp4URz+oPDCVKoUeUU9Xh0OQBMGqff/Dq6cRHSJmHOObfm6sW24
	l8uhKUFFtp2jymybHNInrHeYdjXVDtc2F328+tJuMqvfO7gVJy7rWhufgV5+8xbHBrFBNa0KBH6
	/++29np5/zQcmM1dj4wNkWHmJMCFXGiF4OWBftt1puhbSFgbzWkb0+GnjDT4/4cWOjqu1HZ2Baz
	CFT+73bjaJz24X3s7UrQ8PXM/lzA4vogs5CLP7cEHdxbomUPmpaay3YEIIleSHTjBURhtMEqcSU
	UGxCku
X-Received: by 2002:a05:600c:34d4:b0:493:bd2f:c5fc with SMTP id 5b1f17b1804b1-493c2b3d569mr88773615e9.15.1783001119984;
        Thu, 02 Jul 2026 07:05:19 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:493:bd2f:c5fc with SMTP id 5b1f17b1804b1-493c2b3d569mr88773065e9.15.1783001119554;
        Thu, 02 Jul 2026 07:05:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm10696573f8f.32.2026.07.02.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:05:17 -0700 (PDT)
Message-ID: <3a288e8df5e253fd2a9707ad08a47fe34106d648.camel@redhat.com>
Subject: Re: [PATCH v3 17/17] selftests/verification: Add selftests for
 deadline and stall monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, Thomas Weissschuh	
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Date: Thu, 02 Jul 2026 16:05:14 +0200
In-Reply-To: <5ca104ab-cffb-4090-9af6-06d173e8069f@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-18-gmonaco@redhat.com>
	 <5ca104ab-cffb-4090-9af6-06d173e8069f@linux.dev>
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
X-Mimecast-MFC-PROC-ID: NJLvjPHBZNf9W96ElCBYKaNoH7RBHgO8fkADVoWmeZU_1783001120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-29 at 00:58 +0800, Wen Yang wrote:
> > +echo nop > monitors/stall/reactors
> > +echo 0 > monitors/stall/enable
> > +
> > +echo 1000 > $THRESHOLD
>=20
> A little worried:
> If the system had a different value configured before the test ran,
> this silently changes system state for anything running after it.

Yeah that's a valid concern, I could restore the initial value, but to make=
 it
absolutely safe I should also trap and restore it even if the test exits
prematurely (e.g. on failure or signal).

It shouldn't add too much complexity.

Thanks,
Gabriele

