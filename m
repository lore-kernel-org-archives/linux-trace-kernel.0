Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADB3DBD7C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661163; cv=none; b=FFZBzvqTkBZ3NMRLwWtUIenBc4RkSfPzqlUfSi/Ll+8+jYG2dHxs4yiq4UaH2S1I0KMOYdH0fHrrYhmf2dgU3hzyhbocWa21HBD6mOCh1PDeboawo5iLkOO2pt5dFj7J/uzbSw1wA3qQvO+Ar260Q5bQyaIh1IPslyAsDwGvRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661163; c=relaxed/simple;
	bh=J/Dv0UWc5fFWPIOe7gZzQ5uITifiJBtRxJc1gZyIhEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqbu+6UbYXW2V/4XrhRZyyyamzsSu+cQPlam0oQRW42wJ9gxqjF7l9IurArTjQ+WMO1lQHyrGSEUK3iZQ3v6JSONHRO3lXeHDQGUonvH6lDK9toOthH/yhWY7uM8bYcqThpLItW6yGNlHNMql9xsd3zU2yLZePCM73PyaMvVIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIBSMCpX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIBSMCpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778661149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I/V6QNGxjpN2tsT3RkBCdiMepHJdTDp41wVfYJmBFyU=;
	b=AIBSMCpXRRTzVBzHdP1QI4V3wn7wQM25E1/o/bNbRGTWLANVdZZRR7HaUprQ1nTZ2dTF/R
	N3z4lipPmO/3kTOkMB1izG1EsiBUqnSypVZNnwsbBKNBiBTUv0Xx77zqRE6UefpXn2qkEZ
	I/b4FHEtfNB251Uxny4vVrUVBowdXGc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-BMUvHlwcPwmIWwgoArvVaw-1; Wed, 13 May 2026 04:32:26 -0400
X-MC-Unique: BMUvHlwcPwmIWwgoArvVaw-1
X-Mimecast-MFC-AGG-ID: BMUvHlwcPwmIWwgoArvVaw_1778661145
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-458e7004f63so2999011f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 01:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661145; x=1779265945;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/V6QNGxjpN2tsT3RkBCdiMepHJdTDp41wVfYJmBFyU=;
        b=dNXL+YIlCTKDVmWq+WQlkQG40j/FKxYJ+R5wOLlYTEjOzYNA1WBWN/d0XsjFBFex/R
         dH/po++Sx+69VGAoMikNkn1Tds/qGBG8Wp0Kbn1bE1f3Z6/zCtET/4jUmSPU3uFba898
         uf8Ud7B7Nwz4vQFHxMaQEZMzCx4ojHi50WlUmd8lAR9kTVB0KkwZ95+vKhxd+8c3n/kz
         4ITIbxWCX3V6N/jUbRzQRIG4pfy+Y35bwZuDyoePwT5lK06Zrmez8RjYHvpYctfI00uk
         xos+kxpcKcmldjWLXbLPRFmVb46PLTyG3ZxLAf41bZAwTD9nh0sTZcN47IaV+X/UA3Za
         5aWQ==
X-Gm-Message-State: AOJu0Yxk8KHvdsPF8qSpBIbJyFkY9yFuobHQkiA/MAfUnscFaDnKWcpH
	KEofOgLltYWvfA+kieahILcZvMVIRrxHJOeixZ1VR9HlSwTPzEgZYuL/JzlIdsu3LYljG74hrns
	ZtjYQjECiS4oX/YVgTlGUlWAmENLTKdxpB5k7Ve1gM1dTNEuJN9OutPkvSnpnqBI94Qp/sGP+Mg
	==
X-Gm-Gg: Acq92OFl+xqqNNuiUF9G7atOmG8HwLaSTiMnjLNgT7rm20ofewcx7m4MsdwbU/jepuU
	VQlYfcHoXMPMCm0k0PfCcveBSuCuctlEQQ9F+Y2nahoPrG1ySO42uZRnERQtTD58XeKTJW5O5bV
	1VfXNN/sTy9r7I6PPXGHh8Cp2T+3vnlqcDEhCjwP+h6r9RZbCNP128YGA0ANI2YiI8GLCYRiOB/
	IK7O9qGLGNdq4Glm0WdIPB3o+TeaDruhyXQWkzfV4DJ00EIlAK7GJ5nVMQdOhORQjb46OR1YIf2
	K2e8tfM5b3vt4v2kLvxx3ZHR0da53hwSptQMr7p25ElZy2E1rfXnPu32id0HlHoQbW9VQ+AjVcZ
	mWpgYQEnVXrQ9/OXJ0m1RiYIG/dBZ5M/5e5z3qAG2y8ym/sqtO7AWRfFr5PXJdgBAos00zeOuU3
	4qrCvvoMvxy47rwP4=
X-Received: by 2002:a05:600c:4e02:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48fcea064e2mr22693975e9.22.1778661145400;
        Wed, 13 May 2026 01:32:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4e02:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48fcea064e2mr22693375e9.22.1778661144870;
        Wed, 13 May 2026 01:32:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm37531142f8f.29.2026.05.13.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:32:24 -0700 (PDT)
Message-ID: <232713a9967e6ad20352f47e7220f6f6c334a97b.camel@redhat.com>
Subject: Re: [RFC PATCH v2 03/10] selftests/verification: fix
 verificationtest-ktap for out-of-tree execution
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 10:32:22 +0200
In-Reply-To: <7368ee25b1b45c92beb14c05be366b71da585ca4.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <7368ee25b1b45c92beb14c05be366b71da585ca4.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jwl6hfoh6mODMpdcrPzm4jum_lAiccF7-Z4pU067uhQ_1778661145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> verificationtest-ktap used a CWD-relative path (../ftrace/ftracetest)
> and a relative argument (../verification) for --rv.=C2=A0 This works when
> the shell changes into the verification directory first, but breaks
> when the script is invoked directly - e.g. by the kselftest runner or
> vng - because the working directory is the kernel source root, not the
> script's own directory.
>=20
> Fix this by computing the script's directory from $0 with cd/dirname/pwd
> and using absolute paths for both the ftracetest invocation and the --rv
> argument.=C2=A0 Also export the directory to PATH so that check_requires =
in
> the ftracetest framework can locate helper binaries.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Just out of curiosity, how do you run the selftests?
Are you calling the script directly just to run /some/ of them?

The officially supported way is through make [1]:

  make -C tools/testing/selftests TARGETS=3Dverification run_tests

(though I find it faster to omit TARGETS and just do make -C
tools/testing/selftests/verification).

Calling with make should set up all paths as needed.

> ---
> =C2=A0tools/testing/selftests/verification/verificationtest-ktap | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/verification/verificationtest-ktap
> b/tools/testing/selftests/verification/verificationtest-ktap
> index 18f7fe324e2f..456b8578a307 100755
> --- a/tools/testing/selftests/verification/verificationtest-ktap
> +++ b/tools/testing/selftests/verification/verificationtest-ktap
> @@ -5,4 +5,6 @@
> =C2=A0#
> =C2=A0# Copyright (C) Arm Ltd., 2023
> =C2=A0
> -../ftrace/ftracetest -K -v --rv ../verification
> +dir=3D$(cd "$(dirname "$0")" && pwd)
> +export PATH=3D"$dir:$PATH"

Then if you really really need to call it directly, do you need to override
PATH?

And isn't it clearer to do:

  dir=3D$(realpath "$(dirname "$0")")

Thanks,
Gabriele

[1] - https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

> +"$dir/../ftrace/ftracetest" -K -v --rv "$dir"

