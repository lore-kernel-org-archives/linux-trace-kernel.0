Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99621CFF6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840129; cv=none; b=ruJMddx0ZvsKvn0x6ZyZc9V7/MG6VQNC031fH2onXHPc6bstirok9CaNu+ALjIE8vIIZy/tMl4FucYSdcDDNOw7K0qd39KUZAabVJjAGdhXC2SxmNRqdsVT8l1iLjmhwasjUay5DtO6ES1lD5BW3h0mH+bo0L30H+8FSaqjBxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840129; c=relaxed/simple;
	bh=3GE5rtRZ9PQWrAojCWZLDYzMg+pfD2MSH7ld5Y0NuQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUfDFmu80lLn1Qb91pmBKfqKRvmow3eY1dNbTDAEwW4C81aPVBW6jVqDMNdL9LwT+BCBHzO/CEN6JfhESgM2Xl3VWdaWK1soCXj9TSxZJWnYlaWd+k4i8a+FvC7mSbZL6/CRP5XzND+MM9jLDp57kR9QpAHjJmfjYrYCS+DvW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAmHmqIQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAmHmqIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756840127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU6L3U/q2UU0R8EKwqE+/gNDiUaXUqZNmeER3/Sq02c=;
	b=fAmHmqIQpP6wJuuiavxlxUe6V0w2F5lF5u9JqVsx+E7wlw899jqmRYloOwSG0sNXLRTifu
	5V5pNZaE3fQn0VFQvH2pHcDHdD32ydDaemScZC7/1o4tYN29PVT1oVYv5+NIozJGAmX+Ex
	VhPE4QUkV2H4fpljA/UIBDePO0uTI+A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-2Z4HnzvPNKmxD5RbRVMwCA-1; Tue, 02 Sep 2025 15:08:46 -0400
X-MC-Unique: 2Z4HnzvPNKmxD5RbRVMwCA-1
X-Mimecast-MFC-AGG-ID: 2Z4HnzvPNKmxD5RbRVMwCA_1756840125
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dfcc58904so88324076d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840125; x=1757444925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU6L3U/q2UU0R8EKwqE+/gNDiUaXUqZNmeER3/Sq02c=;
        b=CrPaAQAG+GPsVqLfmCWFjy4puWZcwPPWBv41qPbPSaWWM62oP0oSS/ig7DK+iVZdjT
         BhwN2hkguncvc1rLRD0uHhSRPEWI4d0YyHDd+9UcHruPl/5hsoPnGMwjOwOTpg4BE+bD
         KzUoEyUghPTFo4NnUbWsyTLzsnDhCOWKHwaGP18JRjfewWiia86GRKs1QOfpb0lFtpSJ
         vMTA6mDxzgjsgfopzZfznEEiaBKyAzboQmEqXj2TFPpp/UEj11/30giRosWM2CfCH5vD
         xG6xK5vxDVkDd0SgIwHytLFcC6NOQ+hT4alr2++7+MuRX9IOrUG+nmUSilSPdZKt4O1k
         VJgA==
X-Forwarded-Encrypted: i=1; AJvYcCUoGvJ5HUvIZfXDctCxi80EKeo0MZHmf0iobehXL4EFOyL6DcWz1mzEwiARWxm7WDKtfGTmQihfs4ljMxr6RKNd6t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W78eCKHq/i+PRvU+pi5RN832AWUsxVmjvDtPk6hCtOgyzU8T
	77+qcqDLDCYL8W9ZQClijOACDPuhOONGOC7rw3gjtH8cDvR+lZ+7GMyKCAmz5EoduJ2GL5Qpi4d
	UVQbEeF76XTZATUTuXcSehIle0o5RQc3R04X7NZQGW4XXJQA56Ov/qsJOsjnprK8VQqP0ZQjUmg
	==
X-Gm-Gg: ASbGncsvEZp/geu7v4AEroSRicRCcgS3vBDqbc1eglj/zC1Lm7bwgHF0lHtqulBgTky
	RmQSnikKaiHQfCsv2b/T654jIZYzoHlGMKIXxa9OqNk7HtOz6sJRQmUUAj56vMf/LV6Q8z2KoO1
	zDS8QyGMXVq2agFgRBixwtdugQ6JDo4cIrVnDgj63bZohBEsAZWpIsTMoccHmQ8W2gOQVWrrfeS
	pLpLN701mrAzt1q8w70k02F7F5u7amv7oVJzjGL923JmTO+MpQIhdYCZwaiXwJ3VySwlu684aXD
	c3UJ0Xg6siBeg+MfvniI4vAf7PH5HC7VeMhDcneKdt7f3uDZg0N+LynnxOs2y0rhqyrO
X-Received: by 2002:a05:6214:488a:b0:70f:b1d8:5eb0 with SMTP id 6a1803df08f44-70fb1d86097mr115095826d6.7.1756840125396;
        Tue, 02 Sep 2025 12:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqJWOdirxLXynPocqeOy/VonaretmfNkc+PGIPCCsbbQQUyEdhyEXiNjl9rtyauCOb+lzIbg==
X-Received: by 2002:a05:6214:488a:b0:70f:b1d8:5eb0 with SMTP id 6a1803df08f44-70fb1d86097mr115095436d6.7.1756840124840;
        Tue, 02 Sep 2025 12:08:44 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac2659ccsm16560256d6.10.2025.09.02.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 12:08:44 -0700 (PDT)
Message-ID: <0671eb5af61503a2c790c9d7ae1dfe037e39b223.camel@redhat.com>
Subject: Re: [PATCH 6/7] tools/rtla: Add test engine support for unexpected
 output
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>
Date: Tue, 02 Sep 2025 14:08:43 -0500
In-Reply-To: <CAP4=nvTJNJhueJi1vCR4hh2q9Z1mib3GCGv7eCHbAKfEJL=A9Q@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
	 <20250821035719.137161-7-crwood@redhat.com>
	 <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com>
	 <d11da952ca2ef28e3427fd09972cc02e727606f3.camel@redhat.com>
	 <CAP4=nvTJNJhueJi1vCR4hh2q9Z1mib3GCGv7eCHbAKfEJL=A9Q@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b1Ay-dhEsY5g90dJEktcO9ygmbc-FypkSCatk7Szna8_1756840125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-09-01 at 14:50 +0200, Tomas Glozar wrote:
> p=C3=A1 29. 8. 2025 v 23:35 odes=C3=ADlatel Crystal Wood <crwood@redhat.c=
om> napsal:
> >=20
> > I'm not seeing the "tests/hwnoise.t ... 2/6" part.  What is printing
> > that?
> >=20
>=20
> Test::Harness (which is one implementation of what is called a "TAP
> harness") is printing that=C2=A0
>=20

It would be nice to not depend on an out-of-tree test harness (does
anything else in the kernel use this?), especially without a prominent
comment mentioning it.

I've just been doing "sudo sh tests/whatever.t".

> (the "prove" command which runs the tests),
> it runs the tests, consumes the output and formats it.

Ugh, "prove" looks like it's some sort of formal rv thing... misleading
name for just running a test suite.

>=20
> > > Furthermore, it's standard to first print "not ok" and then the
> > > comments, see the documentation to Test::More [1], so I think we
> > > should keep that.
> > >=20
> > > [1] https://metacpan.org/pod/Test::More#ok
> >=20
> > https://xkcd.com/927/ :-P
> >=20
> > I'm not a Perler, so I didn't recognize it as anything standardized.
> > Still seems backwards to me, both in terms of making it easier to see
> > which test failed, and in terms of being a pain to implement.  And we
> > don't even get the benefit of seeing the test name printed before it
> > runs, to make it easier to see what's taking a long time.
> >=20
>=20
> We can certainly modify the test system so that it works better for
> us. The TAP standard that is used by the harness to process the output
> of the RTLA test engine [1] does not specify where the additional
> output should go, it's just a convention. I just say this might be
> confusing to people who are used to the "not ok, then error" format,
> which is associated with this type of test.

I'm not suggesting that we break the convention; I just didn't realize
it was a widespread format.

>=20
> I'll have a look whether there is a way to easily print the test names
> besides the number.
>=20
> [1] https://testanything.org/tap-specification.html

It already does print the test name.  If it didn't I probably would have
made more substantial changes to the test harness :-)

>=20
> > Seems like Linux uses a variant of this, though:
> > Documentation/dev-tools/ktap.rst
> >=20
>=20
> Yes, this is used by kselftests [2], which are written in C.
>=20
> [2] https://docs.kernel.org/dev-tools/kselftest.html

Would it make sense for us to use that?

Though the current docs linking to a wiki that's labelled "obsolete
content" isn't encouraging...

> But bpftrace is licensed under Apache 2, so it cannot be in the GPLv2
> kernel source easily.

Sigh...

-Crystal

