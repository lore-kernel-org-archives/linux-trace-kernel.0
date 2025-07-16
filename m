Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5D28C2CA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668316; cv=none; b=g29W0mg2+IBCZ7KDdmpbLGQSY//NNt7Rws6ynOeQahIhxb6JPlbhVJjZDlzk/fPtPBUb7RJW5tdj8KWn1tIKnYmRgZTetZqqxZbmm6KN9XkuRI56MI6dyNaAFFt+g/Tqi9zCiDS+J8HjNBJmghx8iz+BDvwyQGscRTk1XV4V+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668316; c=relaxed/simple;
	bh=gmcDXzDSBmQyN7GMc9XjdMT1i5uhdsRnCz911zq21Hg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stYnZaCPNuuzv8fSeueNv2KWIeLJfvRrKLd+lzsy1f00ZG14zyetFacpcdtftwwUI3+tcQWNfbMaq9tiJQxCOb0G0hq8cbN8ISveuKo3eTloud4hvWSbrT+aLbzY74qNEqf9MGS4NeKTVk1h4bKxRuLa0NSzuI+yfuIJKN9QqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDzmwxYO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDzmwxYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752668313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gmcDXzDSBmQyN7GMc9XjdMT1i5uhdsRnCz911zq21Hg=;
	b=XDzmwxYOInMu1IJiMqSHgF9SiBxnxVVSSyPWewdjJuQDCQNpq8/r0m7ILvLRDxtr+4+5UA
	R9200JL/YY/qCP2EUbiP5EEfPLNxe5CHNsf2eZEktDH/kzs6a8Zfkzev/InDVow5aGISBD
	GISziKQKrcAx0oga9VpcY9JOOQFzicI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-kkY83d8MP5yMZ2BDZetrqA-1; Wed, 16 Jul 2025 08:18:32 -0400
X-MC-Unique: kkY83d8MP5yMZ2BDZetrqA-1
X-Mimecast-MFC-AGG-ID: kkY83d8MP5yMZ2BDZetrqA_1752668311
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so38348425e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668311; x=1753273111;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmdc0S+s7zNUMo0B5ddaCw3YpY22llIhLIpvf6wHzbg=;
        b=eIygw785d1uKZa98GyT9hRNGOEUE/j5gLZz+gnuu+t6eS9G3sN6O0SVpH/dNq8bC4V
         kUOuyaGdZE+NWy+z8rR3+fhbuKgILNplOs3p+3AIWlRJi3EkyVVK9j37sb2dkqGVfATh
         HR1bLkBVJX33UR5xPdtjqvjUlp9SgcTRqzNAOHMcGSscc4GbScWC0eHDBRHiofeykchW
         jwrNUpmAMGEBNs7+WAgXCk3cIjgPvcPLcFmetnlN/RkbwW8pbuGOe9kUie+Jd1x6PbuO
         paOQWif2bflXIHoD1a14Al9B+L8Ci+tlEaAvonIuEKYbeP64kOasM4SrTv1qYqzE55IR
         zJyA==
X-Forwarded-Encrypted: i=1; AJvYcCX4/RP5heip5A0t0a8CfrFxAJSP6FuKkd7lkX3nLFD/zZ3ZrbMtMW4snmaC7QPYdgGW13ikBDkgv5RVyCEgPsdIT84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9UKCQEb2SVYCQ3JwQoYC/c0LxWS06BKAQ7x1O2MCQ6Qv2yhv
	xt57X+inZgZioqk5eBu1vGjlTXdOtFwSAyIOeKBJlULBSx5VkN2VbTQOXS9wT/XWFQRH93WM2z9
	XMzDogJ48kbJrbGy689+2S/CxZigVVHxwMFAhoq+c0D03UBY42yRyY3RQYSUVedK4xjFA1IbKlQ
	==
X-Gm-Gg: ASbGncsOVOFInJAZgjfjeXOpLA2bC0QfN52OPhsX/+EBgJvavKJM2xCxFsJZxN6dwlv
	lUZdF7wEWAWQEtKa4I/omgi2HJHPPfTvyfpyduDupUxeC3iljQS/gW5rSJ2kEToHTeYfOll0YpJ
	Yqix/E1g2hVpAITTuUqJwqnZPtRKKaF9v+Hrf4Gy0WXOibk3osjUijl5bDI0qCK2mF1byDAgwNz
	vOihJGpQnCZ7H9XvJQYsFRAmdKEcZmLhzSii+dGLYnCprkh5hms4Bs9h0g0a1B16Ex+UMcNA1rz
	iQhRAu7UVKPldlLzk1sUY0doV72R6wplFsDZ3+jvXEb0LkUffTKVrsSrEfTP1RUkRQ==
X-Received: by 2002:a05:600c:45d1:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4562e02c62fmr29010855e9.19.1752668311007;
        Wed, 16 Jul 2025 05:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEizuNZ7KMS3nV1ER+gRuwQX33CLZiIoP4lhqjrhroW2amy9gQOh+ZyUTRgeqViJuRyQZ7swg==
X-Received: by 2002:a05:600c:45d1:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4562e02c62fmr29010415e9.19.1752668310548;
        Wed, 16 Jul 2025 05:18:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm19193835e9.8.2025.07.16.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:18:30 -0700 (PDT)
Message-ID: <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 14:18:28 +0200
In-Reply-To: <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: 55nzv1HEjSbsa47I29HDzv_u3pl4Ad92h8Zqlaz8qqg_1752668311
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > Currently, the userspace RV tool skips trace events triggered by
> > the RV
> > tool itself, this can be changed by passing the parameter -s, which
> > sets
> > the variable config_my_pid to 0 (instead of the tool's PID).
> > The current condition for per-task monitors (config_has_id) does
> > not
> > check that config_my_pid isn't 0 to skip. In case we pass -s, we
> > show
> > events triggered by RV but don't show those triggered by idle (PID
> > 0).
> >=20
> > Fix the condition to account this scenario.
>=20
> The distinction between !my_pid and has_id is that you can in fact
> trace
> pid-0 if you want?
>=20

Yes pretty much, no flag is meant to skip events from pid-0.


has_id is used to distinguish between per-cpu/global monitors (they
don't have id) and per-task monitors (the id is the pid).

The case with !has_id is correctly checking for both my_pid !=3D 0 while
skipping events associated to my_pid (rv thread's PID).

In the other case we end up with:
* -s skipping events generated by the tool (correct)
* omitting -s skips events generated by pid-0 (undesired)


> > Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0tools/verification/rv/src/in_kernel.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/verification/rv/src/in_kernel.c
> > b/tools/verification/rv/src/in_kernel.c
> > index c0dcee795c0de..72b03bae021cd 100644
> > --- a/tools/verification/rv/src/in_kernel.c
> > +++ b/tools/verification/rv/src/in_kernel.c
> > @@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct
> > tep_record *record,
> > =C2=A0
> > =C2=A0=09tep_get_common_field_val(s, trace_event, "common_pid",
> > record, &pid, 1);
> > =C2=A0
> > -=09if (config_has_id && (config_my_pid =3D=3D id))
> > +=09if (config_my_pid && config_has_id && (config_my_pid =3D=3D
> > id))
> > =C2=A0=09=09return 0;
> > =C2=A0=09else if (config_my_pid && (config_my_pid =3D=3D pid))
> > =C2=A0=09=09return 0;
> > --=20
> > 2.50.1
> >=20

