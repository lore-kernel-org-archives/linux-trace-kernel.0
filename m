Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A438E11D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089860; cv=none; b=pQYV6yPzj5gTf3q1DX2G6MvicdrLX/B3sC4UJVddhX7FZAo6ahV1gctSoqzx/1vIuCRD/jTm1YqM0oG3I32Nx1bWcHNEO3t6z+GaOndTQ4xa8ti55eHtp54PilXIZeK8j73e+K1YhoKE2AdrxRpUUagha275jeEDr3raJ27y/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089860; c=relaxed/simple;
	bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhUnzTkvIF6XdCjwH7mwZTqedfWlP/tuKCq3phmdk6TAvf+QryGQOgHZfsmINtPoErklT9ts6d3+cfc1YCxqZaOXP78xKUHGkR5nC4IFyZ8cFUx6iztSihk2sHcSmcLnRMGvUWXMy+CPBzZ1+l7n8zQ4UpV+kIuDUNrvc4705oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBsad0Qr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBsad0Qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772089858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
	b=LBsad0QrTlFY7HNwJe/aDUlsWTvIHItb+QeoJYXHpJRkr6DQ1NRZViGM7r8QLN8wckUMUj
	aLfwuaqrB21fhe8AAuEYlxmpYKYfPf6n3A1DXmTxw1J88bwOKdEv9eQcbWwAJqgTvCra3i
	nQU71ISWAGJdHKE15qNbeKmRwffsOw0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-NoavtoHyObqM-qs_65xvpg-1; Thu, 26 Feb 2026 02:10:57 -0500
X-MC-Unique: NoavtoHyObqM-qs_65xvpg-1
X-Mimecast-MFC-AGG-ID: NoavtoHyObqM-qs_65xvpg_1772089856
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836c819456so3734595e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 23:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089856; x=1772694656;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
        b=TBaC//765nhlUZTZeCGI+0D2956mJkKihahqnPKyCN2HH1cNLTX+kdcxpXQvvEskOK
         WH9E01mZOuM3Syiy7sTDnLrORwrhFfKzk/IcIjGf9skzsWm71208LtGRNI0uBhSwAiRf
         jytFk2DUgWDbap9mJ34X78eV+GnhDFcDmuSiAbvvHp1g/Ogx6vYvTLMKXUUxymKTrT8Y
         AtGdP2kVE0QYqb2vbwDhBMB1n9bKGZ+Xl0OgGBXm+NBSW/LQREz36eVGDrm2puOmEqpJ
         8wGeeg5QNZt96hKBa0KSx5f4lmq/07ivX+q16fBAtUNxIRmd8Yhww4o1rQKWaAxFNZBy
         CvLg==
X-Forwarded-Encrypted: i=1; AJvYcCW4nWsKRmmy4rcWLJB/seKDWc+GWuHWaOr3afQT6SkVFXfr7MAwZNWGhDdmOOgeIXuu17nqIgDtzPUlRI3NyiPlWpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTeA3xzeRYxBaF4XT1X9f/2xft+AeJcc0l32DwVnv7YsGwBJj
	iSItloHzzP/gpEP8lb/vahXBKvoBvPT+3zymttby/ZcWgoxZ7UjNJ6G2AZc86JUURSTyK72LTve
	DJmw3u1qSIIpwum8pX975LM+9BeV/m7VHz2pQ90qw87PN+UOK2/Q8OoUx8q0emqOHJBMGcR5TRg
	==
X-Gm-Gg: ATEYQzwVBT7XzFTs7r9IpExuZI3hthSGs2Fsv9QtNXY2x5ati6PAl+fM3zRFG3/ccs1
	8E1A1B3fwb1dSWmcZZV2HMZVSI2WMR1+mzBunCs/wX7Ha4da6rmFhizr2GtCUiIrYA6g5cgeVdv
	+3sPgahn3MorUQ6/LpP/pz77xDmAc+p0NSC9vqJcDhXdOl7ql7DDCbzB8Wjv4V8TWzCL6wXe3pc
	xqi9sqW1SerRzRfxKWFItMjxnpKfsxIxzHq7KYIImfeQjxn7aiC8DegCY5DCLYp+u1jQd1lPJ+2
	lqGXgWtvmfbrQWq7S2SwT6cpcvQeWjtTIHWTE/NnZpMKN0bnJrSmuOQXsTRUZSLlnXtMqJbHFg0
	U9K0tuFg4NlaynqbRuv/+4gZEV0AidVoN5LeESVZ9jHKV13xjIQ2xvuRu0RrXCgathaWiCT34sc
	pR16d/us0FotuGw4M=
X-Received: by 2002:a05:600c:1411:b0:483:acd9:bd18 with SMTP id 5b1f17b1804b1-483acd9be44mr200825515e9.1.1772089855783;
        Wed, 25 Feb 2026 23:10:55 -0800 (PST)
X-Received: by 2002:a05:600c:1411:b0:483:acd9:bd18 with SMTP id 5b1f17b1804b1-483acd9be44mr200825285e9.1.1772089855392;
        Wed, 25 Feb 2026 23:10:55 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770c2sm23532555e9.10.2026.02.25.23.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:10:54 -0800 (PST)
Message-ID: <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>,
 Nam Cao <namcao@linutronix.de>,  Juri Lelli <jlelli@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	sched-ext@lists.linux.dev, Tomas Glozar <tglozar@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 08:10:52 +0100
In-Reply-To: <aZ8snSHWw-U0lVz2@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-15-gmonaco@redhat.com>
	 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v1q-Cf236K_sVal9A-By4gAabLHwGmIoq2DirYJjdqQ_1772089856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-25 at 07:08 -1000, Tejun Heo wrote:
> On Wed, Feb 25, 2026 at 10:51:20AM +0100, Gabriele Monaco wrote:
> > When a sched_ext scheduler is loaded, depending on the configuration, i=
t
> > can handle also fair tasks, however it isn't trivial to understand if a
> > certain task is currently handled by fair or ext outside of scheduler
> > code. This can be a problem when writing verification or observability
> > tools like RV monitors.
> >=20
> > Export a task_is_scx_enabled() to allow quick classification by using
> > the scx state SCX_TASK_ENABLED.
>=20
> This test already exists - task_on_scx(). Please feel free to move that o=
ut
> to include/linux/sched/ext.h.

Mmh, right, thanks for the pointer!

I see task_on_scx() is used in what looks like some sched core hot paths (
pick_next_task() -> prio_less()), but I presume not inlining it isn't a big
issue.

Thanks,
Gabriele

