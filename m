Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E62BE64B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916151; cv=none; b=oJ2BleJwNBz2s7eoLwkL2fLcEZoxHB/s0lUYGkJImscqT5GVD08uHMBQnkp0CB96lC73l/nCMGdueS4xqDvzkI0K3sjrj1P5ZF8e9sv9KVuJCf2OnzPI8nj+xokfy3Wzgo5/alXawxmBuMMeo4Cqn/3wvy8ezR8kQwzqNFZ31Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916151; c=relaxed/simple;
	bh=VrszH26Da9KBGj3NpywffKlQHcy36YjShzflVIEDmJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqBC9T6ZyjzBu0kAar1jdLfU6qfawT9Dr4+J0+w7NfO/wfki+2bI6kW0JTUdnSc1XOmxl5od3b4qhfQenClqdH2Z/hQbWnbV13Z9ITMO3yRz0bCrR8WWFDc6aRLDbvWpbD0cqI3rMaj2zzCuSFr61KvZlWS7fKDGgS2WnSwVjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVJak7OA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVJak7OA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756916148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FtZODyxB15Plh2qkNpxQ0mMtjGrkpbkprEjB/mqRmc=;
	b=PVJak7OAPFy8WIOUon7w1ckMOpbCK005auBvweIvEimaQJ/VImqnymlIC4lE2JAoSmjOAh
	zvb4N4zt2pHdfAaHirDpALANM5xEWPjV+rYy4ehYSS2XmtST6nIggBACeHAokDtK9jaRr4
	1tER0EVMrxe2VeW10dPhjhSs8U2LM3w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-efPIuYqOP1OiFidqOtpw7g-1; Wed, 03 Sep 2025 12:15:47 -0400
X-MC-Unique: efPIuYqOP1OiFidqOtpw7g-1
X-Mimecast-MFC-AGG-ID: efPIuYqOP1OiFidqOtpw7g_1756916146
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b042f5d3521so3260166b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916146; x=1757520946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FtZODyxB15Plh2qkNpxQ0mMtjGrkpbkprEjB/mqRmc=;
        b=T3OzbKdt1vcMC2Wu0AksgzqEq0ueoCsdNDxDAhg/xT2TUHleXycjOTCwuGkSj7PZzS
         wvuZSq6hSISxJzF5u0dkM19mfL47BMTBfxZnwE/jONjkxzun3wIlKlcg/sKym5NML6mQ
         JJS8IFcFsDxzaMJs1s1rVVjzCpX/JIms2/hSvXrgYhV7jBomswXarqZzUnayQ9S1xSrV
         UDSLGQsOV1eC6pKyzYm0pE2VvXp7cEgj/obA20Qp+wY61CATwuj9b/6uMcQwO64P4g5/
         JgLjU4G2AMyNAnaeimeru5AK3MWQ3ZaEDo2sN6xVYb6xMjLh3JABdUYvhXToI/Z7bG+w
         7AhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa8OLZyp2GRdLwOQByvQbQ0dE/aT3da4cmH+bH30So2/gSBtAENBffg9d48FAR6CUIrzetOlnfAS+4gePgI9wfW6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxftSX2jI9GisKGPLHlapP5m9WMXxrUYz47s+7pTFM4tyBj9WYp
	UcVwEg2nI4sW0UKGeOGh4nmvOZgOuWPSA+T1WDQnpD0w83kL4EjNh57i7XBaz5DykjALiL6MBxF
	kefq2wvpXr6HdtimHgJ6SgneTVOPIkckfPwH167YpBNLew5y/yNTi58hvOB8u+CcSpFtoONteA2
	LU9cOgK5yPwNR59h6SHUtdAhgUJ6OLrvIu7lv7D/TOc6z9ssuO
X-Gm-Gg: ASbGncv193ykXoPNq/cP6Z4c8G8Kd9ErZyVJC0FgSt44vx2P5itIDYq2xyYrpIOu8IZ
	AQOxbK21NSL78gFn/CIZCUgFuSND7WscTy8wa4GC7eU3rrTMzyMHD0Ddy5h+bt6M3Ujr7gaS5Ax
	19YpldobWjZ0AS2cghQRQidpz7r+5yms6zP3HHclCDmyVjuOtbuHA=
X-Received: by 2002:a17:907:749:b0:afe:8761:e77a with SMTP id a640c23a62f3a-b01d8a7311cmr1679288466b.19.1756916146046;
        Wed, 03 Sep 2025 09:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv9hUELU4tDZmBzb7bdTg2IDZUA63zp7wxvUPREkMSdmBgWXhGiQWsfNqxWUQ5KbzW+pIP+ZvI2qSc4hfBCnA=
X-Received: by 2002:a17:907:749:b0:afe:8761:e77a with SMTP id
 a640c23a62f3a-b01d8a7311cmr1679284366b.19.1756916145538; Wed, 03 Sep 2025
 09:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-7-crwood@redhat.com>
 <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com>
 <d11da952ca2ef28e3427fd09972cc02e727606f3.camel@redhat.com>
 <CAP4=nvTJNJhueJi1vCR4hh2q9Z1mib3GCGv7eCHbAKfEJL=A9Q@mail.gmail.com> <0671eb5af61503a2c790c9d7ae1dfe037e39b223.camel@redhat.com>
In-Reply-To: <0671eb5af61503a2c790c9d7ae1dfe037e39b223.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 3 Sep 2025 18:15:33 +0200
X-Gm-Features: Ac12FXy-bCuu69AmKb88Z1pcGI8ZShhF5BE7_ZvGOD0L0B9Iq1KxWzekQtNzbcM
Message-ID: <CAP4=nvQmyp_fA=yxcwRaDvgZLgUo+OiFpXgCRv2gWuxEHYQyng@mail.gmail.com>
Subject: Re: [PATCH 6/7] tools/rtla: Add test engine support for unexpected output
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dg0uHpeRZ0yHuJPbhy9OVAv6xbSUDRM3IgVwADA2A2c_1756916146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 2. 9. 2025 v 21:08 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> It would be nice to not depend on an out-of-tree test harness (does
> anything else in the kernel use this?), especially without a prominent
> comment mentioning it.
>
> I've just been doing "sudo sh tests/whatever.t".
>

Ah, I see, I should document the tests properly, I'll send a patch. To
clarify, "make check" uses Test::Harness on the RTLA tests. It's an
external tool but it seems it is usually installed on RHEL/Fedora so I
went with it.

>
> Ugh, "prove" looks like it's some sort of formal rv thing... misleading
> name for just running a test suite.
>

Yeah not exactly a good name, I always forget how it is named...

>
> It already does print the test name.  If it didn't I probably would have
> made more substantial changes to the test harness :-)
>

Test::Harness only displays it in verbose mode which is not enabled,
since I thought it doesn't look as nice, I was maybe wrong.

>> Yes, this is used by kselftests [2], which are written in C.
>>
> >[2] https://docs.kernel.org/dev-tools/kselftest.html
>
> Would it make sense for us to use that?
>
> Though the current docs linking to a wiki that's labelled "obsolete
> content" isn't encouraging...
>

I don't think we need it or it would help us. The RTLA test engine in
bash is good enough IMO and customizable.

Tomas

