Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAA3F20EC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853476; cv=none; b=C5ic1/8S8iG1qoh+wMUk6a/qytOlQc/vSvgTR6E1n5uUdVgy81wQ6TmVWyFFPQD3br/RGIrE6BfRd1U19JyR/rkK4YU0yCVeWi+MQ59hY8f3F20D9sWok+SAL9hGknlX2X9X6kMsBG6/YyAHJYU+qfNjAhn9hhidXh/B8/JHHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853476; c=relaxed/simple;
	bh=ae5igY5oYt0+CCSz1LVYew22CfKjMoUlVayPcy6R8fM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT03JIafq3iOEVHvjgH1Z5AK6Z08fr3zAiktgUnI8FLrKrkXuhvGeQtew6vVMbn6pMN7RyBRdxcNgM8sVTxpxs2WO/fFGPf8uy8y9JK3OKzXaxda2fM2fVB8SpkwscBCuKoZaiVAXn+mqEmw3nAwet+O1LoLw+DMMaZFDUv97vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFuGLlds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFuGLlds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790853474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ae5igY5oYt0+CCSz1LVYew22CfKjMoUlVayPcy6R8fM=;
	b=KFuGLldsGG8dPMwtMvD/08Gfz6QtK6XxT8cMkO9eBTBAGcJaLTEKfqZzIRMQgoF32a/gpc
	onIsq6Km7f5RAHjipuGndh1wCJweSZbsEFmShZKBl6/1pHi9mQLmqfiZkFCeRHG2XbqLSV
	Ed+PlRxE8svzJrVDLHoXyLWvZAbgwTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-njz8BXhgOHi3NWhFYa2zAw-1; Thu, 01 Oct 2026 07:17:52 -0400
X-MC-Unique: njz8BXhgOHi3NWhFYa2zAw-1
X-Mimecast-MFC-AGG-ID: njz8BXhgOHi3NWhFYa2zAw_1790853472
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48af4046a3bso3003843f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 04:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853471; x=1791458271;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6XQ0LxDigeeaZqBMssbCnY6iBpDsmsz0VQ1JYSkHCwo=;
        b=hINDzL9+YNsNva6UdQ48MxjGsW4o1FW8ixpuKfweKGdIvbHSvN3y0oL9X+UCCdRvGW
         wLGOCUijKKnaJNsWsh8pcBzm+U2T5w/zf7Vl1ulUjF1RAXitbE/SJGeZyGA4PB7VLBcx
         230NfQd3EPuYYkWnHqR+//v4LZbhnJgku5mG5OHw1pquSRdMjujH/mapkZnwCywQdbfE
         zdRLm+TXhEuEzcJKihARmCaQEiPe7QQ2zHVyeVvNAlqCzDSF98vOFlixpagZkA0GlJFa
         RpoN1m1WbUy36AjwfWShsughLH23luH+Em8bJphPd4fvHfRwg8wcP9Q2CKHR6T0LmDsA
         OLwg==
X-Forwarded-Encrypted: i=1; AKwUvBzY88B51PfUxCYRz9of3zkE9UrqX6s53duhL7T8JbJ0RU9eW8rdEKw5+4cYrY9st5IAIeCV4mqkv6ieGoBXAXKAUgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaGM1v7g/QbrFqYWy38h0XA9SiVIcItRy7cZv/kZfgmwaieQIe
	S0cJyij00/PkpKJNtgZ8wvfchtzjf+jL9di2vPfBtLJHZcFdaVW5ENTvg3yaMAlZicdSnOsjYwE
	g5NL/YIC69K7Bs0IdZHNgj/MTsEhg5ETDmv8dn1XMLknAdlQtg9u4t9Dy+i/14kbu7pqSQiCq6V
	d3qBAlu0du
X-Gm-Gg: AYBFou0W78rAMsE17zA51HLZNabSOsds/UgY2ryTRXKddi3QLEYXEmtRSJQJwIVDllt
	HJ2Wd5RH9fJHURZ8iSqGHhmXcM2wGNigm3lO6HKcd3x1rEqvi35paBr5zNpqPHItwM7MDHSrMmp
	ytwhryxifYRxJa7xuCrOBuTSvAGYI42LnbhdkLfTNOh1KUeB+p0j8lJOs32OqA3bfa/Dkj5DBi+
	P4XUS/rO1RLo4k9Egi1EF1Qg9Zvw82XrbK+h8ytzFUqsa5c7mDfCLa1yjZy7o+f7CyPmPgbngG7
	SWU1iMBPx2gWBm+AZ/Jn5ynC2Am1/vWBEw2kZSBapiB4YOzLUFWvBUEOQTv5eK+pesm0V4tRPYX
	R7nag9QUiBid5415YZdksjJOn7bk=
X-Received: by 2002:a05:6000:4024:b0:48a:f8dc:ae14 with SMTP id ffacd0b85a97d-48b0245a3b1mr9283428f8f.2.1790853471601;
        Thu, 01 Oct 2026 04:17:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4024:b0:48a:f8dc:ae14 with SMTP id ffacd0b85a97d-48b0245a3b1mr9283388f8f.2.1790853471205;
        Thu, 01 Oct 2026 04:17:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bd8c9sm5587597f8f.2.2026.10.01.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:17:50 -0700 (PDT)
Message-ID: <e91ee6fcd36a6ae4616fbd61121b2354594099f9.camel@redhat.com>
Subject: Re: [PATCH] rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Ogness	 <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org
Date: Thu, 01 Oct 2026 13:17:49 +0200
In-Reply-To: <e6f78faca93f92981130621d712ac05374d83b05.camel@redhat.com>
References: <20261001044218.3508990-1-namcao@linutronix.de>
	 <e6f78faca93f92981130621d712ac05374d83b05.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jY265btJOi6XNGM7bJOrgPKGy1RjYPceT8B5VhXr9ZI_1790853472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-01 at 08:31 +0200, Gabriele Monaco wrote:
> On Thu, 2026-10-01 at 06:42 +0200, Nam Cao wrote:
> > Commit d9e4c61a12dd ("rv: Use generic rv_this for the rv_monitor
> > variable in LTL") renamed the rv_monitor variable to rv_this. But
> > rtapp/wakeup monitor was late to the party and missed that.
> >=20
> > So for this monitor, rv_this is an empty struct. The reactor fails to
> > work, because rv_react() checks monitor->react and sees NULL.
> >=20
> > Correct to "rv_this" and make the reactor work again.
> >=20
> > Signed-off-by: Nam Cao <namcao@linutronix.de>

d9e4c61a12dd was introduced in the same pull request but after introducing =
the
wakeup monitor.
So for me that's the commit that is "broken" (should have accounted for wak=
eup):

Fixes: d9e4c61a12dd ("rv: Use generic rv_this for the rv_monitor variable i=
n
LTL")

>=20
> Damn.. Thanks for noticing!
>=20
> That's a weird one, I cannot think of a way to only declare the rv_this, =
so
> the
> compiler is perfectly happy to give you the empty one..
>=20
> I'm taking this, but I believe it deserves the Fixes tag. What do you thi=
nk?
>=20
> Thanks,
> Gabriele
>=20
> > ---
> > =C2=A0kernel/trace/rv/monitors/wakeup/wakeup.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.c
> > b/kernel/trace/rv/monitors/wakeup/wakeup.c
> > index 01b47416f24e..2e803e79181e 100644
> > --- a/kernel/trace/rv/monitors/wakeup/wakeup.c
> > +++ b/kernel/trace/rv/monitors/wakeup/wakeup.c
> > @@ -128,7 +128,7 @@ static void disable_wakeup(void)
> > =C2=A0=09ltl_monitor_destroy();
> > =C2=A0}
> > =C2=A0
> > -static struct rv_monitor rv_wakeup =3D {
> > +static struct rv_monitor rv_this =3D {
> > =C2=A0=09.name =3D "wakeup",
> > =C2=A0=09.description =3D "Monitor that real-time tasks are not woken b=
y
> > lower-
> > priority tasks",
> > =C2=A0=09.enable =3D enable_wakeup,
> > @@ -137,12 +137,12 @@ static struct rv_monitor rv_wakeup =3D {
> > =C2=A0
> > =C2=A0static int __init register_wakeup(void)
> > =C2=A0{
> > -=09return rv_register_monitor(&rv_wakeup, &rv_rtapp);
> > +=09return rv_register_monitor(&rv_this, &rv_rtapp);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void __exit unregister_wakeup(void)
> > =C2=A0{
> > -=09rv_unregister_monitor(&rv_wakeup);
> > +=09rv_unregister_monitor(&rv_this);
> > =C2=A0}
> > =C2=A0
> > =C2=A0module_init(register_wakeup);

