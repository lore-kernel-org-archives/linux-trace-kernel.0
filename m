Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42013F0AB3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183117; cv=none; b=D94zLutYmf/MVKJBYO4t5gh6X18SHnosGOAPn4cD6bh8xGfAQTZcr/FxA6mBT/1ZjGdluGIAuaPVvoBpBVHC4ZZH6ywg9pVsUj1FvloKEPsC2G3J3oi0Y1JRmr68eHAfPq7UBv4Xf9Bv5VigsRxVcjCIEjFK62DAWnBFbVYVWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183117; c=relaxed/simple;
	bh=S3HA85/ZS9enSG1fSMODd211yT6512/EfWAqnSCymTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P21eKjcSbjHDqCqPX25zmUN+x38mbtyF69IYm63eVI5bK2Yl7LpCCBqyCkxPtxPJsdgfVTwcauBZIcDHfRBvH2YnZglC+gm5js+Ry5t/cQMij8d7wYgaucDFjzZO8jT3xsh2LCEHlc60rWvN4vDdx6geMm66CKMJhtyPOjH8MYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuq7wi0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuq7wi0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S3HA85/ZS9enSG1fSMODd211yT6512/EfWAqnSCymTw=;
	b=fuq7wi0NFmOsHHuO5lUKfXnaUQ2xq2tzgcQIHk5RDw6kCcOGm+SMC0smzEfDMSvSWwa2BI
	CXQ7EpgFrYkHHUeCMYV5DRmwBeMrLU/KJKgldHOd7HS/gvUNR+v6NPmH+7OfxIfNS8Xwkg
	W3FWQH8XFhR3Bth7b8TkSdl35reTr6A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-FBpzB619MiS4JbBKA-IsCQ-1; Tue, 19 May 2026 05:31:53 -0400
X-MC-Unique: FBpzB619MiS4JbBKA-IsCQ-1
X-Mimecast-MFC-AGG-ID: FBpzB619MiS4JbBKA-IsCQ_1779183112
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fdb2b0cb8so22393225e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 02:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183112; x=1779787912;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsG579UNRNkHYChdG7Vazcz8j5/rVsPW6WDElHcMIwQ=;
        b=R4yHNHB+laCUo01fNjqbPC9vJsW+rzJpp/kp8Ul0SaCuYbYQ4+5PUZpF2AOYKs6NSd
         PqzoM3djXlAH+LJXswr81yI4iYdOfhOTiwZ3JGCy5WvnYh5KxInQdN4TlyI/IpMPa17Q
         UkMwKR7OAXKnQoYFG6SvUvjaRo1g8tcThJnrIwXZVqC7LGkAUlLb//HTyAcEkGJz1nM7
         39S5ttHBPZ7CiGCntbecKRzVpQ3ds7cy5hmphlRf9vgmWUG+EvEoNYrVL8M1PRZpCcYh
         DFkYGVUkEjec3zkxjzhVK5wl6Nq16btuATJYFgicFn7KXM4iz4mMqxybNBjjIJ/sZg3v
         KzUg==
X-Forwarded-Encrypted: i=1; AFNElJ8ze75L7RpIyX7DnkwyI38snoCkWHqkI+vugfFHAh2htBUFHYB3OdujwYVmrW5CB4wVLWBAitiDMPHxDTUbpX0DXGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqeyCNu9kdzDewR8KKyRyKUmVvs31RMNYU2RPAUtF71DCsoT1
	bY27dIwqsAY16OGvrAvrkHDddxE1teKQQ4p6ViQqqUQdvXn6K+Sfn/Gg2Wuv8ES//tEWqHeMV6S
	Rsi6xvJKgLud7Fe1pYheIqvvI489vLe2kdVNcs2j4ZJJVDnm/amg3Suyftonm2cN1EuFojc5a4w
	==
X-Gm-Gg: Acq92OEg1kVLFNnJAn59HkGUtVeLMs2vE4pZtTQBW9r9Lw56fIqptwcHQ0FofkrC0YN
	tZ4TT6BQCy9s1Igl91q85cjeL9JofvaJhiU4xxrYrt1XvFRlCXP4tVAJb5BIS7VOzdD4FMWhVah
	ne9Gx9otz+JyolLvD8j9MeAHhNegg2wxRp5u8450nXbnkF15CWZEgjgNFHGGwlgpIadhbyy7//9
	wYg+L//knQY0h6qD0ABkNk9BGxjLvDmQb1NBLJQRROEo3TazOqpgSmAS/GzQKGj9b7DCDkHnKxf
	2OubVeSkQg+AtZnlw2Guv0L+Fc0tWetd8X1p0uX0yqJPpY6r/LouB0C//iQ98aoITBJmUOiSOM9
	T5hQHtxCs6T/xiczkZERWLJJ7Om+aRCcw1BBUx/UMMllE12WcUvmEEXVsUkb0g71QNJL8b+O6Ca
	n9Wy70RA1Ml6bjKNA=
X-Received: by 2002:a05:600c:8597:b0:48f:d5d7:df89 with SMTP id 5b1f17b1804b1-48fe630a2b6mr203499165e9.25.1779183112235;
        Tue, 19 May 2026 02:31:52 -0700 (PDT)
X-Received: by 2002:a05:600c:8597:b0:48f:d5d7:df89 with SMTP id 5b1f17b1804b1-48fe630a2b6mr203498845e9.25.1779183111781;
        Tue, 19 May 2026 02:31:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fea52a0bfsm156722615e9.0.2026.05.19.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:31:51 -0700 (PDT)
Message-ID: <02c522f2a09183c9e1a6ff5b0110d0d5cc5e35bd.camel@redhat.com>
Subject: Re: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
Date: Tue, 19 May 2026 11:31:49 +0200
In-Reply-To: <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
		 <20260512140250.262190-7-gmonaco@redhat.com>
		 <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
	 <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eo06pApb7-euBMnm-_fBzhJ2vjmvQT-6qqWBa48qm8g_1779183112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2026-05-18 at 13:54 +0200, Gabriele Monaco wrote:
> Something like:
>=20
> void __ha_monitor_timer_callback() {
> =09guard(rcu)(); //this is only for waiters, let them wait more
>=20
> =09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> =09=09return;
> =09smp_rmb();
> =09curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);
> =09...
> }
>=20
> void da_monitor_reset() {
> =09da_monitor_reset_hook(da_mon);
> =09WRITE_ONCE(da_mon->monitoring, 0);
> =09smp_wmb();
> =09WRITE_ONCE(da_mon->curr_state, model_get_initial_state());
> }

That's obviously not going to work unless I read curr_state earlier (and us=
e the
acquire/release helpers while at it):

void __ha_monitor_timer_callback() {
=09guard(rcu)(); //this is only for waiters, let them wait more

=09curr_state =3D smp_load_acquire(&ha_mon->da_mon.curr_state);
=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
=09=09return;
=09...
}

void da_monitor_reset() {
=09da_monitor_reset_hook(da_mon);
=09WRITE_ONCE(da_mon->monitoring, 0);
=09smp_store_release(&da_mon->curr_state, model_get_initial_state());
}

