Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9931ED7C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876376; cv=none; b=os/03qs90xbJCBRllFisfh/+f2wEF5azR1Y1VbZ+noi4GpCjPX8yPKsYGobgcFgHyBVjs6QcPyDm9brqdqYl1BVtXKmieIRh2H33g4xtheCezb4MvjGNMp8H/l5M9k80fRnwV59YY/0K4R8LDtCMprOYut6Be5TtQiXR5rFDFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876376; c=relaxed/simple;
	bh=ewrmg3I1S4qLQZ3a1imZbYrlzGASU5GuB3jWVBat8jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaSS+3TlAt6DMrenOvVlHT4n/PujfQPjfO2H/LtDgvZ10ORP4Fa1x+CQo10VdlKoV25GB1Zc+is/eDjeVMnWoMwUUcfBOmTqDnfbMs6re6+/+yktEavz9g+Lev5L4e10LakuUySowyRWZUZ3Jxq6NbJReTAu6G8imqvuEGw4OGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDL0Di4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDL0Di4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791876374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ewrmg3I1S4qLQZ3a1imZbYrlzGASU5GuB3jWVBat8jo=;
	b=IDL0Di4X7mKDL0lQ9YqqEN0k/ZKmsRpyDUNoLgPlopz+YOeoakmqZPdxZ0f/2B4RPyYk9F
	DwkY58d9NOOHFko3wn12nqIzsDiEkBTaIj0oCjSsltAJRd2fM9exwhDItlVCo9/JKcSw+/
	Vc8qUkMBQi2Z8wlSSlgMqrRLKRRv8qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-GEeAWlclPVus8Sah4qGGHg-1; Tue, 13 Oct 2026 07:26:12 +0000
X-MC-Unique: GEeAWlclPVus8Sah4qGGHg-1
X-Mimecast-MFC-AGG-ID: GEeAWlclPVus8Sah4qGGHg_1791876372
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso17595285e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 00:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876371; x=1792481171;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ewrmg3I1S4qLQZ3a1imZbYrlzGASU5GuB3jWVBat8jo=;
        b=bn8VtJYizx1+oA4PFR22lyqNYP72Ye4BgQuUpO1gtsjOkTdzyioF4aOyF2JQ6YkMu2
         HhfA2cQts/6bslz8xTRO+hH3yiuWfallWvp8KNsnc1CWCy/s4BdWt88mmOPVitvUOZfI
         t5tiDMl6/AfTCXNZS0WtORLuAeOLb/ua8G94nz4lrLz2NRs5zDAyzcAbaFVota1vvBPK
         P6ChTqU/A1RBHKn8gfGgGc46HcytNThAOUaqBBCh//WZ9vb7am3BLPvyaG6dl+NS1Csk
         X5TbZK5rl97QD4DwPs9q8C+NPrwm+Y53TZf6vJ8k1/vpIGX1bg7OiYX6mmwoCHVm6SCF
         gj8g==
X-Forwarded-Encrypted: i=1; AKwUvBzvGYeiyIS91i8StF+VplbWXuqHHflqqilDYK9D6COI2fVtM/QrEFDyCPxLT5g2aRMoUGEyr3waqZiSIJ0ZYv2Ux2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCoSWDFZSb0qGEbDwJdX0MRzReBp/MrOey3yYQT0l7R9Ctc94Z
	XxbT/ofDt9F0g3knWQoKn+MXzosnLSuy0wfE6tHNS0mECtzZBoe/8xNNPxv7s7rIGv766nMCxIp
	IqPoD7Ryj81aJTg8itSu+2GHxwlhpHaxstsPI7/hm0in/b4kmX2U/YCSB9gida9Tbuh7tGzXDWA
	==
X-Gm-Gg: AYBFou1ULMJr0S8QUxcLoEjPGtZWq4npUDpLbbajNzDRnk3Ey/zqJ8TDtoqr9sFGuq5
	wFA+jUekptsiaptAvVCejwzajgHlSN+fWQwKi25Z3uZljj+2m/+wR+IwAUfXDMKg48Bsg9vG6uk
	EY4gYSES/usqLzX8YPV8hz3Tq091ThxyiizNgkbuOjd8Pb0uI8+JHR8589NZtM1HP+k9Hkvta1X
	MFfFLt7iHDd91zFraDAOz/rIJ1Hutn1poiE0FY6senbzzmcmFp3h9o8MkfwJ8fxawoDiRRksMLp
	8sL22GlmpYuRHDqeeUpYe443dGzBi8U0R4cd5whAolmYTn5HCydy2PWy1t0qhlSNDCW2YT1/gOE
	zCpu9dCIguuT2i58NfFvHm/Fz5Z7j
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a18e4dce0cmr221459805e9.33.1791876371641;
        Tue, 13 Oct 2026 00:26:11 -0700 (PDT)
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a18e4dce0cmr221459285e9.33.1791876371161;
        Tue, 13 Oct 2026 00:26:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd733fsm3581160f8f.58.2026.10.13.00.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:26:09 -0700 (PDT)
Message-ID: <aa16855bc9ccc6b776ba4f513b86e3eadf889f74.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Tue, 13 Oct 2026 09:26:07 +0200
In-Reply-To: <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
	 <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
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
X-Mimecast-MFC-PROC-ID: vJxSLGQHGXeUzqJ3-kPzz3SasNfBPEWFVDpe4eoILTs_1791876372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 18:18 +0200, Tobias Schaffner wrote:
> > First of all, would dropping RV in-kernel support negatively affect you=
r
> > current workflow?
>=20
> I am afraid it would, but first mine is a niche use case, and
> second I am not very experienced with BPF, so please weigh that in.

Thanks for sharing, I'm asking this question precisely to find out all use
cases. RV is itself a niche tool, so I'd rather not squash use-cases away!

> > About this series, I believe we could implement the same using BPF maps
> > without too much effort, then the rv userspace tool could display them
> > nicely.
> >=20
> > What do you think?
>=20
> =C2=A0From an implementation perspective there may be a few pieces missin=
g,
> both in EVL and in BPF, to make this work. But I guess most of them can
> use the patterns the kernel already has for NMIs, so I expect we would
> find a way.

I'm curious to know how exactly you're tracing EVL right now. Are you havin=
g it
generate NMIs to linux and catch their tracepoints?

RV attaches to tracepoints and BPF would do exactly the same.

> I have two more fundamental concerns though. One about verification and
> one about recording dwell times.
>=20
> Regarding verification:
> The path I verify is deliberately kept short and simple. RV fits well
> because the probe is a plain function call and the state update is a
> try_cmpxchg that cannot fail, so it adds very little. A BPF program
> brings more machinery into the probe path doesn't it? I fear that adding
> this would force me to verify that the new RV system does not change the
> behavior of the system we are trying to verify, and I suspect that could
> be harder than verifying the system itself.

I had a few conversation with some Functional Safety folks over the past we=
eks
(the same people Daniel used to talk to), I now understand the problem bett=
er.

Their use-case was even stricter, that's why RV didn't take off for them,
essentially they're trying to prove some more isolation from interference R=
V
doesn't really have out of the box.

But back to the RV vs BPF case, I'm trying to reuse the exact same code in
handlers, so the verification step should be mostly equivalent.

Assuming you'd use tracepoints (BPF can have more probes but vanilla RV doe=
s
not), I guess you'd need to validate also the ftrace code that ends up call=
ing
your handler. BPF adds a bit more on top of that too, not much though.

Then obviously there's the data representation: we use BPF maps that can be
quite complex, though simple arrays (in per-cpu/global monitors) shouldn't =
be.
That would probably add more to the verification you need to make..

> Regarding dwell timings:
> The numbers you presented look very good. But wouldn't we lose
> determinism by using BPF? If I want to use this as a measurement tool, I
> need it either not to add latency or to add a constant amount. The mean
> wake-up latency of EVL on my system is around 10 us, so an observer does
> not have to be very variable before I can no longer tell its jitter from
> the timings I am trying to measure.

Ok that's a good point I'd like to investigate more. BPF shows great perfor=
mance
in the average case, though I fear it could have worst case spikes my quick
tests didn't show.

I'd need to run more numbers to be absolutely sure of that, I'm not aware o=
f any
internal locks in the simple maps we are using (though I only quickly check=
ed).
BPF maps are clearly heavier (memory indirection and/or function calls,
sometimes mitigated by the JIT). But if we properly set them up we shouldn'=
t
expect big determinism issues.
Nevertheless, this is definitely something I need to look into.

The whole JIT thing shouldn't bring big problems either, once handlers are
compiled, they should run almost natively, but again, I am not too familiar=
 with
everything that happens under the hood so take this with a grain of salt.

Thanks,
Gabriele

