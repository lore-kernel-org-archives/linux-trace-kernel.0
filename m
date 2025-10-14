Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3227732
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449546; cv=none; b=dD0f4dB6c20W8O3dQ4F0izW6JRRXevZJmD/ZSgMhD+/YZ9pml5K6s24qDnbPriFgHEypEmyuWChYV/zCvCGilnOrzSVFSVtp/WaZZvjTidYztCGaF7xalmiOuQlbvBfjXtOyz003tf3TF5+XaKveYEc442bZE+peMLe+ZawTYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449546; c=relaxed/simple;
	bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZ95i3fvrmGe9iB4mhVi2YFqosnWzqMOqyy4zPGkWu/PpWljGrxfwIC+flITxp7fAC/0rMSBxxC+zvYMmYz5E+Uc6AfX6EJBzyvm6S279V3awrKHVlOJfTqAZy2f22BgEIXeeFYXCmdDRLnTMevpAv4ITCpnb9I6suuSgQX+kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDe8mJ5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDe8mJ5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760449544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
	b=iDe8mJ5bNfBpc3PxXZL7rKM+7HZI9Pjv8dDRIXATqANq0gE2lQ+gJowqFkb1cbunatu/jK
	Anz9wf4WT6nlO/rT1e2qEkVENdr73A04AR2ju8tdaUmdTnNsEeNHrr9gU6KDOBkL2OMar8
	2gLZamDdZSHikiNEBM6dEQm75/FgaNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-xlLwTFcZPCysV5012ZZ6KQ-1; Tue, 14 Oct 2025 09:45:42 -0400
X-MC-Unique: xlLwTFcZPCysV5012ZZ6KQ-1
X-Mimecast-MFC-AGG-ID: xlLwTFcZPCysV5012ZZ6KQ_1760449542
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e45899798so36828795e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449542; x=1761054342;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIQXVCBJtfItmt5aAR7Q8u4Kp9Dxpe/5VAwat14nD5U=;
        b=baD6QsH2MkQbcqxlfoop7BmyhrAESLRID8tVZbYThQWHoWnm8uTRhAd1RsGLEmekBJ
         FcyuqvnUzqHYrAX/8HA9Yelc2aRtvQ+SQsh5BZnM/c+gOZOw2Ze4gQPdT6LqskBPD3nE
         ixKwZORCozWwOBA0R3e4iEqXbKTdd2OKMHrq/jHP7BwQn3gnp8ttGEfaW/Z+oco9V5Uh
         9b/pjv2aBoa0ghAz58N48xMGXkW3nO/Ea+nfWLUulWIpSdA7wZopO5V4H/1/K1zoU9kw
         7FH8roSWEguyW1z11X5SslsDkZIItJYPmMlsW8xYk9UISbe24MPYq1hf/NdYYLYEuhcF
         ObqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBkzVRjvG1L2C1CqyG8bQsD1BdzuzREMo6LVrr79y6ZRb8aYQL9cqXv751AIzBbgWgLK8PMLsYgQEm8DIxZf3tzeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxVnhwKq6koDSREBOlaen29laejYgwIUL8BfKWRKbXVcQW3Xl
	VOeRW0qmdI4HHAz/Mzr777WN88uoMlPtx+TyTvD2kVzf0/rc9gqtoVMOXTV0HgD+3oLS/0sKX7f
	m3LbLQTzZJeP+zy1usqyhKWQ3KtVU72dHa0F/Jbp99Vb53/uGykixOvMjQ6jUXnauMVyQRmEF8g
	==
X-Gm-Gg: ASbGncu2W4fy0hIrzAOsYNuGmDZNpwuD2Ej3SDzEMStRHWbTu6TpC49Yx5YJgFBqliy
	rG/Y/hf5e/CHHjCZXBSJ0fv68UfrlcJberKYUR8eH9DAl0j9+OII844hd8pzWH6J9RGHOM2WP5+
	nzhaBszPpTME9jwrUsv+bBlK0pmcBXDFpy6ySJagiUO12mAsOq0F/i3lq1a2RwrqaC6ST4Frnqv
	Ko7SP0tAKa2+mvHoW32yZfVNurMxNGNbdpDhZMWFw9G63yw5D18Q2PXKfkN5ugybJ8mdrXPyH8N
	Evkx5HZ6pzinUJolUwSFwEjSyigp+fF1fNKMKR3q/yxoOApOLKjy0XhIq1kdiOp4K3re
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46fa9b17e09mr165685225e9.36.1760449541643;
        Tue, 14 Oct 2025 06:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlL+rgRgxjvezQCbd2Wr8dlgkKQQptuXyUBRVm3hq6/tSPyP/tOF2+AloxycKsh8x1Jt44yQ==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46fa9b17e09mr165685065e9.36.1760449541210;
        Tue, 14 Oct 2025 06:45:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483c7e0sm243785855e9.7.2025.10.14.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:45:40 -0700 (PDT)
Message-ID: <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 15:45:39 +0200
In-Reply-To: <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
	 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
	 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: ehgTpv6iVC8z8QMu8FHn8BBvpq6FrxAB5xpIyyLfBR4_1760449542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 14:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> I can't follow here. lockdep can indicate problems, but it should not
> introduce
> problems on its own. So preventing the usage together with lockdep would =
be
> the
> proverbial head in the sand. If the tracepoints called by lockdep are an =
issue
> then we would just not call into lockdep in the first place. lockdep
> triggering
> these tracepoints should not be an issue in practice. I don't see a
> bulletproof
> way to prevent a tracepoint handler from calling another tracepoint, exce=
pt
> maybe extending lockdep to also track that.

Forget about it, you're right. This leads to not using lockdep inside react=
ors
in the first place. We could even have notrace versions of the lockdep call=
s
(I'm not sure lockdep itself needs them), but that's getting horrid.

Leaving for a moment concurrency quirks aside, a monitor that is reacting s=
hould
be done for a while and can be marked as not monitoring before reacting, in=
stead
of after.
Trace handlers triggered in the same tracepoints should, in principle, be a=
ble
to tell they are not supposed to run. This at least stands for DA monitors,=
 but
the same idea could work on LTL as well.

Of course this gets more complicated in practice, but perhaps suspending
monitors during reaction can be enough to allow these lockdep calls without
risking infinite loops.

Thoughts?

Gabriele

