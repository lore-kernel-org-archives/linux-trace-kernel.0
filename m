Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CB1F5858
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473020; cv=none; b=Vv75B+6gyUw051bFGnJSTnhbvvUpcXvwOBxLOdEwlKJ+UZY1k3dzfKtz2NvDPTr2zgIgKyh3fo2JaphgVrEqWqUcDvC946aBfYw1C/8YE3xfqFD3hZzolMyW1sZGPVSpu7OWJfvkrsqYBkCtBoTyz/HhcH0IDrxqRkVjTNjlS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473020; c=relaxed/simple;
	bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2M0SNwuaFB4pLf7IPBKlDQ0hjX+sweMGw3DpT+ZdO/EtiRpZkCkOynW8nD/n/eSttSsv8PO2KXSVkweTFwuEQ2/aiNMTD/JcLCtl2XKAIg3BEoMBk88jKIC9WFm0iiDmO1gUEvQmofvjcWLNy6BJhZLv3bCa0bsD9//TQZA6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2xhv1zi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2xhv1zi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759473017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
	b=V2xhv1ziFWnvdB08mNe2VHnkYZGUgk7EqbpZKqvsCpis7dIjU2n3l43z/MOVUGi5Z9hQch
	F+BWfZszRtNaPxnkdaoe2A0KSQEuBQSWqZEWc4sjKu2/x5zgbrNw8UlwvPpdMG3TsU37u8
	+lgCteXQXWH8F7BJ58F5H2pd1papFEk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-iCaT4xC-OayiARCdQ9GT3w-1; Fri, 03 Oct 2025 02:30:14 -0400
X-MC-Unique: iCaT4xC-OayiARCdQ9GT3w-1
X-Mimecast-MFC-AGG-ID: iCaT4xC-OayiARCdQ9GT3w_1759473013
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1448522f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473013; x=1760077813;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMBSmpZnqrRnkDKn+p2xZ6jv4I9lQldCRuwyBBKDowg=;
        b=amnGPVXfxIfmH/WrvDS26Ioyy9syK1VKfusB5EPtDyXipGP3c+v8HlXo39I1xCjuTa
         syUyXmWPZrgQ/wH22Ru5kKKp4g+hYFFw+ZLI/RCRs95q5fY7f7sRehX7dRL6AeXdtoLc
         /f5Eb0dtT2UgPTWBpn3J96uiE4bK4n5nwv+Yhidi+jy5WvPJePJeDT14EngtnMFA/Glv
         0tJi3rIlP/K455c2TTgJjSjc0slZ9JlS38ebqvwWrP3sGKo/N8zNgyf4j8g5uMxyr8Ux
         UyNgfDKmLv3P4FYNz/Zc+DcYeiqoAj+yEF+8HNTLTUvD5feOAarlEwzMEbvntM4tklOq
         glrw==
X-Forwarded-Encrypted: i=1; AJvYcCXAuqiRVMIZhrQwCYmc5cBPwAqMxIbhXbajqXL9MdiX601bVRbJQL0Az6jn7QOri3b/RFwDxuyCPg2l9H+Dj3+h+J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18mKhQXplnig71tDQzT5/jG/XMKG2P+FkRr64Ocovss3089F3
	jpzwrmQZZ8wKGBOyfet6TSktRysfWkCRpg81kBFRgg2gGFQZ4+hULdIKmHuADP0CRbf6Oh5sj03
	k1UBq/CjiyKodUbwGInD2KXGmRpAFyZzPYtoxsg1zgsPeRkmkWzUlvEMhkw0LcH33rzlKUwsi3A
	==
X-Gm-Gg: ASbGncvC8vKcc3UIuVOyLaZ5TorZh6qt23+G/VjEBki0N51uXotw+GSgbTjXjRFOkJy
	tDajtlqJ7iGc8sW4PdVw+VdQCwElnAXApyMc6UaCgBA/bgd4Cqqo40TcPuNWTTyk0R2uvcJwYp7
	7Am1QT852h8tkn6uOopbclUNpEWayeW6hd7gBnBU1dd0zn5ax7bAcR8IBIO2PwunruY3Yv9CNwW
	MPulH2NMCgENDC6+9wplWtgff9LkEKbhgjHAjB+wBzMbZzYPBerOqaSAE3IMRJkTjMMhRoq8nNi
	3xw1hQPErY3x89ejVU0Z3rqqGL4v3TZAIdDs2bhGILwvJ6fpeH2fUS/VAps16aMBMBKnqCE=
X-Received: by 2002:a05:6000:40dc:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42566c5354dmr1300947f8f.25.1759473012853;
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELR1JYmclf4EKUfrFyht98SyMCf4qSX9xmzaypmk8A7lQqrolOq939RWKtbUXsUaroq0t3UA==
X-Received: by 2002:a05:6000:40dc:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42566c5354dmr1300929f8f.25.1759473012477;
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm6443426f8f.2.2025.10.02.23.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:30:12 -0700 (PDT)
Message-ID: <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 03 Oct 2025 08:30:10 +0200
In-Reply-To: <87ikgxqrna.fsf@yellow.woof>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 62A7MQ0JIk9i-66V8fFx3t1Xg0u6p5D-KJtEr6qIt2A_1759473013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025-10-02T14:56:23Z Nam Cao <namcao@linutronix.de>:

> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
>> I am wondering if it would make sense to add a new tracepoint that
>> fires in addition of the reactors. That would allow multiple
>> simultaneous consumers and also bespoke handlers in userspace.
>
> We do have tracepoints for each monitor in: kernel/trace/rv/rv_trace.h
>
> And yeah, I think it is a nice idea for all the consumers to use these
> tracepoints intead (that includes rtapp testing, and also the existing
> reactors). It would simplify things, as the monitors do not have to
> worry about the reactors, they only need to invoke tracepoints.
>
> But this also makes me think about the necessity of the existing
> reactors. What do they offer that tracepoints do not? Myself I almost
> never use the reactors, so I'm thinking about removing them. But maybe
> @Gabriele has objections?

Well, many use cases might be better off with tracepoints, but reactors do
things tracepoints cannot really do.
Printk is much faster (and perhaps more reliable) than the trace buffer for
printing, panic can be used to gather a kernel dump.
One may just attach to tracepoints via libtracefs/BPF and do most of the th=
ings
you'd want to do with a new reactor, but I see reactors much easier to use =
from
scripts, for instance.

LTLs don't benefit as much as they don't print any additional information v=
ia
reactors, but DA/HA give hints on what's wrong.

I wouldn't get rid of reactors until they become a huge maintenance burden,=
 but
probably we could think about it twice before extending or making them more
complex.

For instance, what's the exact use case of the signal reactor? Isn't it sim=
pler
to do everything in BPF? Is the signal needed at all or something else (e.g=
.
perf) would do the job?

Thoughts?

Gabriele

