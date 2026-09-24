Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5B3E7145
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236034; cv=none; b=U3nsGX9UUwE6Fj+u0ozNOuPC3yY4kB4ToUVvrDo9mLTiIPUgJ2aTpFuG7KOCul8en56EBeJ5G0saN7kTRE5fA0/MJAPi3ZqlgJTd387IFol4uCs8NztTaUsbuwCpTu+em746v1j0n1Gorh9RoB2ct8Eupm6gNQRjMvit1/KwcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236034; c=relaxed/simple;
	bh=OXZK+cY6zncUNK9MCaFFn9ybmDVKl+7xjPp+Szl1kMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV7GOCiv49My0PZOlC9HByq10cnDAx8KrZpr6qwST3U/dOGKxrbA+VG/uInXWC2X37v9CvFVVaZQnIpNIglsK+apdWNZ5DaQj/qpZ7DhwVUZ5BdwCvF+9zLnomiKB5FgSX2aPe2Ih9jJuVRF1MGtzSgDKK1OD9MYUkQXY5Oerto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOPcNt/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOPcNt/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790236032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OXZK+cY6zncUNK9MCaFFn9ybmDVKl+7xjPp+Szl1kMc=;
	b=FOPcNt/Bnzyp7ZGDkDPzAokXwzU+i3eQMO6S5ln5LgX9iOqC0VafUOpunMRh7W99YgZVUF
	Dp6io+RaONep6Vu0vbPlGBEYkyX1ym81jz4UDg4v1oa0LRS2GbftKKuh65Ewcc2lIzWyYy
	4ro8byN9mKz4n4X95vlt/n7gLXoM4K0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-btZ7L2aRP52C7mveEh2FwA-1; Thu, 24 Sep 2026 03:47:10 -0400
X-MC-Unique: btZ7L2aRP52C7mveEh2FwA-1
X-Mimecast-MFC-AGG-ID: btZ7L2aRP52C7mveEh2FwA_1790236029
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d156c917cso3579535e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 00:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236029; x=1790840829;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=agiy+hW/o2gOf7mZzT9kupJMq+eEEiW/AQJ0CIw0nXM=;
        b=yD23TM84Q4tPSO0Ph9aBQS69WPee1CRPvz73g6BlBthjREWSNrIR96JUjU8hiUe6lk
         OXbe5Z4DNj9f9ZBKtkcDAAxMVN4mJBnbMmNeJVCwvuC62e/qhXZdZAaaf6GEjx1Wmdfq
         vjHOEkfA/KzaMnuwzwb//fS0RnCwJgFr7mwCyWzUTUAhzrIzabtP6i4JWh1DAUw6cH+m
         aqCBCw29Yrze15dZxPysojS0AcUNxmho4T+DPVJ+hGU1FHg05hj9yiRoMIomOVqWe7Ef
         oIrqR5xFcVQBzExW8pAXSWV9UuHEhG30x/LHhQx2+DYkro3JCi+6c9XPxSfc+8idFtue
         U9jQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdQTsRs8cQodiW7EP+oCQS+SGVs1/pQzoGplCiT36ijevP5l7TG3RxsAU8yPdLdEGZODESlFCj/ZHfqwE57F9RWSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYW72Ju9YLh/3/Jp9SxaoDsDBGPb2NkhekSBpzP9CFtRNlF8Mx
	e1DrFShru5nDYzdnp2QSY3ycqnWFEgcovvZhtF53T9NLtSE1A/Fv8U/bnBb7x69h5C8/Pnw4ZmA
	U8W0CCRfOqM2svcVtielz/uDlG9dhsn+rk3V1czaPSlXIXzWg+92u719/Q4yuNdCMtpG4/x2VaQ
	==
X-Gm-Gg: AYBFou16Y9e1NhJZRZ7QAnY7HP7oZVawnF/1rfUGpca9iWAfHhgLTcWTUky18pNKy0I
	ZHns52WqXQ915A9m17SPZ5TFSXjTw9GHcWdJ6cly39vuRydGL0aq/gwxFL6nf8tdTyuok7TXqcN
	M5FdNueE53Aj2jvSbIHtBaUGeOylBkXstHAvvWSI2/Aa21xMzsX5vqPv5uYof1/zBDh4banKMqw
	VQXRbUbe9K+/qh1nqfHPv0Wrva7AFYRfaZ7mliKCxzNFQ+bEgFdrQgNgFY9bgzsGxGLgJ52qb8p
	QO18PNiHTphgroZr7opYX8l6x72dRfrGo7DPCJZ8EK12Hg73PLA/DBBakjzWwatONhzdYYMbeeA
	6zurPoIhBW7RSxUf6F8bRDKE/Dq7u
X-Received: by 2002:a05:600c:1d04:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49fe66d0606mr23324475e9.6.1790236029364;
        Thu, 24 Sep 2026 00:47:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d04:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49fe66d0606mr23324145e9.6.1790236028968;
        Thu, 24 Sep 2026 00:47:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd134sm49784545e9.9.2026.09.24.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:47:08 -0700 (PDT)
Message-ID: <78b8930b8de0ccbf8279637efd9c148395a8a4cc.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rv: add per-monitor edge-stat facility and stats
 file
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Thu, 24 Sep 2026 09:47:06 +0200
In-Reply-To: <20260911123439.463052-3-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <20260911123439.463052-3-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: 0V5yo5D7AnFKfniqc6Mm2PuIopm9ykVxGVEetoz-AWI_1790236029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
> +static int rv_edge_stats_create(struct dentry *parent)
> +{
> +=09rv_edge_stats_reset();
> +=09/* RV_MODE_READ is private to kernel/trace/rv/. */
> +=09rv_this_stats_file =3D tracefs_create_file("stats", 0440, parent,
> +=09=09=09=09=09=09 NULL, &rv_edge_stats_fops);
> +=09return rv_this_stats_file ? 0 : -ENOMEM;
> +}
> +
> +static void rv_edge_stats_remove(void)
> +{
> +=09tracefs_remove(rv_this_stats_file);
> +=09rv_this_stats_file =3D NULL;
> +}

Very minor nit, just for consistency you may want to use the macros
rv_create_file() / rv_remove(). You also probably don't need to include
tracefs.
You can also just include "rv.h" instead of <linux/rv.h> and
<linux/tracefs.h>.

> +
> +/* A zero timestamp marks resets, which can run on a different CPU. */
> +#define da_state_entered(s)=09da_state_pack((s), local_clock() &
> RV_TS_MASK)

Isn't this masking already happening in da_state_pack() ?

Thanks,
Gabriele

