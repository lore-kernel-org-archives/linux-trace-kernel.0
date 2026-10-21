Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598117;
	b=h8ra0B97A9ga0eK3tdcW8KLW/eGsYDcGVGil6Dny/7jHZrl+J9/8rMYm/u8z8RzGl+7N
	 7Xs7nN6DiQDGeM0TEwWPgiZq4paXGK6c5/yn0QsVHbX1dAJb0bqoODuDh3DGo5+f5jyym
	 tI7o6Z2/zzS272/Qhv9LBzu0fvkIlw2hbVDCentpwhWyWrXLGQkPmAB3GQDfw5bvj3X5y
	 TRByqOmGcX9OR39/r6S2N20jRI9kX0Zhcvj+SObDOfv9xtIDJoX2yuUkzIpZoL5B7sW9S
	 e3wB3qXpsImvDLfkoQqrGhy6D6S6boEm9dHBk4ObhuCuR0BM/mhyZJfkbV+lV/0yvHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598117;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
	b=ZV2aY0yjIvRIqiWxpbX4HU9P3XdQyPwueLBqHcI8eyo96+BuFchGzkpAD7fSaqn/8PQ1
	 /6PG46C5xYW+0hnxeR5JdfouVIOCG1xVJbNLuACDMP2OplQ/D0uet5tPUfcxPvKb05u6F
	 UtYCA/p+3FZNxmIVS5fevzlom0wzm7PaQwAds8kk+0KutW7AAVPTVm1DukEIhaNj7EX6Y
	 xkjafNtaoraQulAU3iK+CBd+ao19TLitwB4PwVvukET7zPysKdKhxcxfILMKeiDJXPTy0
	 Ll0CBVklJtIXjtCnOP5VMpBxWJeIBdrxi1rSTYHcfoGlcVP9D8W/yP1+57HjiY5evow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BdUQHiQP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 15:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF44A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BdUQHiQP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
	b=BdUQHiQPvSWQXXZk04o9XzJzncCmNZdhOcorN9jD/+M8pPz8Iff/bLYHWogUESqDlcpu0A
	UO+SO/clShAoRv44CK/FNnWAXxmimjxYVipz5C834DNbAy5MCpdV4kP7nqxMKJbXP47mRX
	m175iOLc8FR+IMuKWwZwJRml2EwnLTg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-bi2ukILCODGnb2GDBykibA-1; Wed, 21 Oct 2026 11:55:08 -0400
X-MC-Unique: bi2ukILCODGnb2GDBykibA-1
X-Mimecast-MFC-AGG-ID: bi2ukILCODGnb2GDBykibA_1792598107
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1dec05668so7148455e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 08:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598107; x=1793202907;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
        b=hpUsLpf4JbOiGXJomduUfG+vpzpbwpEk5JFkWGdo4I1Ax3cmfLmQ2wBlQkMxnCe2eu
         0ZMVdww/SIcCBjn+EiaPlQ5cs70f5qYCiiN8jIvA1ivRbjqN0ao58b7Y7vYgvBv+2RcD
         2V0uwuMrD7QATG53IcQXl11qqrOzhtWf93Zt9CK7fEoggvth5DORoCFskN4Z45jJY9TB
         hSu/0S/MAQvOGA5117rep+chFmuO89zPgonIzQm5z/7HTmwg112I0t0GNmKnTH6Tr1A8
         EXMbaCWE6uOfk2bfljRTphwjvlgk80ZLBIcKQCzUK2ncU1dnRbkTIno8EgQt8mS0TwLW
         JOuw==
X-Forwarded-Encrypted: i=1; AKwUvByZT+zbyyPIH/wYZfalBiiyy7Q8ovLFFLoVrQstdJQQA0U1Xerbzan3fJAnrq3q91I3Y/SejdENqjoRiMCIspHOHp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkjgSRWVUOr4ThlgM07rEaVJqbJ6ayFkXbtD21wKOMVsPuMRj0
	QzEkG2vpBU2OcGFDv4362myWyvgjVAKUo02odZ9CwRkjUOo0X/mok+glutwqnspGpkWObLOoAOM
	8a4GVhdJj8G8PISqouybkUEYiuEgADUH5YFyiTLhe+m36h+VIbAL3zE8PG4AUiLGK6xvTwaCerg
	==
X-Gm-Gg: AYBFou3o1pMvkCu0DlcR3VPumyAEzsBsdxBYBMxzTZUEPR7wUEg0t0zLg2jUncVQUhY
	VOC/xMBr9JuaviEmr6utcnOmkuN5lWg/XqTEKKfT3BuhpnqzgDPXfKligBG4FOM901gdbDhcquZ
	o+p8OEyxz3NHAA0JHt57vj205QPqPkzSH5I7N6W9NZ0j7HcV85BaxwmTd62+VTqo0W4i1KcoHQn
	YXcelix2+Cp5jNcfjiNL46twaBYIhtp6ngrHGvOxuENqUl9qOhVszBGR3ePZgGJhPt0YLpux1px
	/5TJB7DBiDjdO/hGbxzEx0RIpo2aTrrJRFCmKjpnpe2CQ+/TAmweTJfZ8NKck1vSt+8FDUwIBeD
	FwLmy/7y4vL79fdH4vdOSOQOcS6I=
X-Received: by 2002:a05:600d:8051:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a1fdd6b9b4mr47597815e9.34.1792598106985;
        Wed, 21 Oct 2026 08:55:06 -0700 (PDT)
X-Received: by 2002:a05:600d:8051:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a1fdd6b9b4mr47597365e9.34.1792598106628;
        Wed, 21 Oct 2026 08:55:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a20398f37csm1981285e9.8.2026.10.21.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:55:05 -0700 (PDT)
Message-ID: <ffbb1908cb2a45afbd97814f09f11401a38c179b.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 17:55:03 +0200
In-Reply-To: <878q3rqpcy.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
	 <871p9mqcn2.fsf@jogness.linutronix.de> <87ld7trgzg.fsf@yellow.woof>
	 <87mrs9q1d3.fsf@jogness.linutronix.de> <87ecdjqxnr.fsf@yellow.woof>
	 <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
	 <878q3rqpcy.fsf@yellow.woof>
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
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cHHpmiNMvz1rvA1380rL4OeUSSpIAhk-0mHQBnuS3J8_1792598107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 13:12 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Wed, 2026-10-21 at 10:13 +0200, Nam Cao wrote:
> > > I wouldn't enable those by default though, it's way too much noises. =
As
> > > it's for debugging the model, we can have some sort of compile-time
> > > switch to turn it on.
> >=20
> > That's almost what's happening already, in-kernel use tracepoints, gate=
d by
> > static branches. Those are the closest thing you can get to a dynamic
> > compile-
> > time switch (assuming such a thing can exist), it's patching the code.
>=20
> I was talking about how people are going to enable transition events,
> not how kernel enables them. Do we expose some user API for people to
> enable at run-time (and kernel can use run-time patching or whatever),
> or people enable them while compiling their BPF programs. I think the
> latter should suffice.

Everything BPF-related will need to go through the userspace tool. From loa=
ding
monitors to enabling things, but it shouldn't require any recompilation.

Right now I use only the -t flag (enable tracing and print to stdout), we'd=
 need
some flag to only enable tracing.
After that you should be able to use ftrace as normal.

Gabriele

