Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8B284B42
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778823; cv=none; b=ZStJPL/zmW6Z2KfEcpZfRQodN3y5G6Q5+LrB0sfp51s5rSLUVutPmU6C9m1qWExyDGViiiyCEDHiWHsp3fWWhFKJKqbmyHbhVZSlygqeYpXj2+lIS8i0EZX9E4ckuGa+AqxyhTmCD5iGX4nNiciDkS/QgrVVwXgDqnSs8F38eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778823; c=relaxed/simple;
	bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/7cxkGjHQpUHPxilcOq5mVoo8i3lT6KiQcIRrLq23eHaWVfpj1Eg+RZ6iqoInfrw6w1KeefJoJFd6QBna8+WPbnZaFZVb/J5t/UFq63Ore79rhyRIgebZWp0IpFkViYz/wICiSRebi/iL2ivsXO/TG447mQR+VMaSVXs/hA1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+UhqLXb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+UhqLXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753778819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
	b=c+UhqLXbo9/EwYeLSVZvdmizQK1WUnWy5ldLBD2uA6dQYvOxXWPUfVuM0eMyr6C2+SyQ9i
	7wE1M1FiFD/OdE8f4WgbNRfWQtoYgiJ4d6/o6VpEwtc68OuNa1Ovng+xvJesXFUWeT2Zkk
	7Dq0K5Z+K53tazh8QUCEC3zyll2G8UE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ToU2PewdOVOx2VGG8F3rtA-1; Tue, 29 Jul 2025 04:46:56 -0400
X-MC-Unique: ToU2PewdOVOx2VGG8F3rtA-1
X-Mimecast-MFC-AGG-ID: ToU2PewdOVOx2VGG8F3rtA_1753778815
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso26754425e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778815; x=1754383615;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
        b=DX7jWjLcfa2R9xNEq0Ddd8dQEkPRea8dA6Am3x0m/J5BN2umzBESMfekkL0vO798wY
         zqZT5kMeVf0ieT0o/Uuw7/7IK0kcCTZfegiR14mrFzs8V2H3YVhG6z4x2KOK4Ve2d/fa
         q0+OoaLTOIhDzIPaGSj5yR/lxB1QcI0e67DQEIu93sa4lFoOkDBujP715rpCcFNvcRvy
         PX2NNfJlhSIO/CfXQkiw0TEGSFFBCd8OU0NR8+IvNINSFA3U7H7Al5eKC5w2wtceBGHw
         mgOsNn3t1XdNoakzZAJTpZRtDTZ4r7ixNfgZ0+6UbsYz1nax5NXmXNVG+KMKymc44L66
         GPxg==
X-Forwarded-Encrypted: i=1; AJvYcCXuP023czZZVu5jRQZoHy/RVUwEm5Pcgz/RcD5ZSe6rZ+sJ+DSkGGXX+euPsfkqX2mhjJIs+EuIRvJDZgDlgf15s5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LRTM7XNc7c2fXWau2NqJj0Ug5vhyEQ8V2quXwdU9EC0+oGke
	+cpdds+HcbaxmtvzYcceao6ZvV1Vkday4vahdDLTB591CIGuK6/+2NEekKiyPvjfDIVTYnTQboa
	7/IH0Mch/vdSOdl6YepB+TY1ZhvUmpy/NSzRBgV+jEHNLv7EumvBfjvNosHgM0A93c2UfIuUMtw
	==
X-Gm-Gg: ASbGnct8Yd4s1Ec2vmZAUXH4/42pjyLjMX2q9ODBo6pX0TZ3Yn1vw2mbw6QBOjKsLlF
	VukTcCNfA2o9navVidxFkP2ihFcl789afmwcOPL3LM8pzjsfrEzkRJzA2Zsqm9BIYO7r/6XG0ig
	PAd2yqw1hJ1UXp6cPJE7uTpPe/fVVtYiRiy4jZcXq8Fi1EKVWiMmjHxzohANw3qOzEOHQqs9vPw
	5P3aeszX9DsAyR7uw/eKNzV19NTNm/qHOE91cWY/XuviyYCGRcqYLmsDRLin1YDvD1KuGPI8SnV
	IjxFXfBJI53CqlH64mVaPQSeV2pPqC8Ra8T4Sa29qVu47ax6m/HUlXTEgK4D6NUF0A==
X-Received: by 2002:a05:600c:a088:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4588adc3677mr39809885e9.26.1753778814855;
        Tue, 29 Jul 2025 01:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENm4rGB9QH5ZR2b+CQxX8IopxI/UqZi4w2Zrp9xW5q/tHuwjGtN0qFNHlnuI29FnnDzuK6cw==
X-Received: by 2002:a05:600c:a088:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4588adc3677mr39809655e9.26.1753778814422;
        Tue, 29 Jul 2025 01:46:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78dd6cb0fsm2299807f8f.29.2025.07.29.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:46:53 -0700 (PDT)
Message-ID: <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 29 Jul 2025 10:46:51 +0200
In-Reply-To: <20250728155332.sbkepHj7@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
	 <20250728135022.255578-8-gmonaco@redhat.com>
	 <20250728155332.sbkepHj7@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Y8z_NMbGVhBrpgN_PAl4eUHloOy6TxdZMCBJnrlAMQ_1753778815
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-28 at 17:53 +0200, Nam Cao wrote:
> I gave this a try on riscv64 and observed some errors:
>=20
> [=C2=A0 620.696055] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
> [=C2=A0 621.047705] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
> [=C2=A0 642.440209] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
>=20
> I tested with two user programs:
>=20
> =C2=A0=C2=A0=C2=A0 int main() { asm ("unimp"); }
> =C2=A0=C2=A0=C2=A0 int main() { asm ("ebreak"); }
>=20
> The two programs are repeatedly executed:
>=20
> =C2=A0=C2=A0=C2=A0 #!/bin/bash
> =C2=A0=C2=A0=C2=A0 ./test1 &
> =C2=A0=C2=A0=C2=A0 ./test2 &
> =C2=A0=C2=A0=C2=A0 # ... repeat lots of time
>=20
> Any idea?

Mmh I see what you're doing here..
Those instructions are supposed to raise some sort of exception in the
CPU which apparently disables and enables interrupts without raising an
interrupt handler tracepoint (the discriminator for this monitor).
This lets the monitor believe we passed the time a switch is possible
and complain when it actually sees one.

I still couldn't reproduce it on my VM, yet I find the timing a bit
strange: it's alright we handle the illegal instruction like this, but
do we really end up doing that while scheduling although it doesn't
look like an interrupt?!

Could you share a bit more about your riscv setup? It might some
configuration/hardware specific thing.

Thanks for finding this,
Gabriele

