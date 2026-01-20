Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7613D3338
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900575; cv=none; b=A/4+YPWabtKAjnRrF+q4zEOUvA2F1RDeT3KhzrhKHreYhlT0GfJLe3Z9VniV7hHL63MRkq6ATkaBtrBToEh1GDp+6VE5wD/Z2XnLbfRb1fZXS+TuAx3BkHE9lgeQsF+4/8lOb5nl+Fi3DOHH+B8R3RlemBXLaKUYnxPqaax0KCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900575; c=relaxed/simple;
	bh=t+Zb5w8MPwk4+YlwNUPh4k2TTU4mrhoDza6/coVQNRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPEzrprHPVC8xOt7LU0OIoCsIzhXJbJ9EGFjdKHHSKrQU1AmXmkJO9NPNJMfIDJfE6iGhNHUYefvxSOiOwnwEX5PUrJlOvhmrbhEGeAkICR7kC3BMP9mNdLXna0ksIiCJiaU7DeWEJTRJg9Cvu6plxtEc6Tok+rJbVOlrerVV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqYo0l8f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqYo0l8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768900572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t+Zb5w8MPwk4+YlwNUPh4k2TTU4mrhoDza6/coVQNRg=;
	b=OqYo0l8f7+CMHEdX9trMqSN1jSHahMsW88S5Sj9ubVfppTZOcftnU0brcKy8YBsM+DRhsT
	OsDoh6t+gVDazv7/l4a+ZFLbh8MvIdJV3Zqc1wbBTH9PIAUUU9ghb8FsDCZY8da2gqVYav
	Ul0NOh0r8OJgWRNG7v8XcNgGhOisK+k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qZuzhxGXOEiYUH6R1f0WmQ-1; Tue, 20 Jan 2026 04:16:11 -0500
X-MC-Unique: qZuzhxGXOEiYUH6R1f0WmQ-1
X-Mimecast-MFC-AGG-ID: qZuzhxGXOEiYUH6R1f0WmQ_1768900570
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-431054c09e3so4624842f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 01:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900570; x=1769505370;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Zb5w8MPwk4+YlwNUPh4k2TTU4mrhoDza6/coVQNRg=;
        b=C9WILg4jNhTnOCLfRf+LPvbACSNviVU3RQAeib5Vm7rc8tJky8hzAbSY/GAz2nYMQE
         XV9lYXskCmE6O2k17g0WE8NEOTFRnTdFfHSkvp/MKtT741sRULzOiRgb6xBS8l7TQLBP
         AeYlD0emqXBsVmbkZG6R6jn9Rp8Dh9jFv8yiYKdDKY3EZBGiPKvVQ+7CAZP+LeisH8OM
         gq/HeSC8WX4RAG6xSyIWMGT9Eux3aj4oKj4jWiTVmTfJQI5XGpMor0pYsgZPBx3eIHEA
         H2uoFCoBPe144z/Wn04naLKd72GE3C0SsRvkHn5TSg7zmMJ09nQnWDkXjYEClB3HVtUf
         CmLw==
X-Forwarded-Encrypted: i=1; AJvYcCXsGRN8fhKxgUdOByQZxjBob+KZN01vPjfI5z6abxfX16QkzTgkNu6xoH8xaOH2OPKu34+gipO4lMM38ucWqmOzZok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8szkschZPhbx7bIpnhrlwlMFCEVuM3cj/tcjPdpuUcQT36xT6
	VplsSWM9vSRbtj4+V6I6H+qUmAV5q2kRxZ2bipM54wQ1Sp4WEVl6V8iBGJFqeNqqh90ReLGXIE/
	k9ULIsqYY6UU8z6S7fEEGlEw7HKiibUwx9/eiDvHbf/RnMnGIyTyfRaW5qgJPmW94nejeXzf1tA
	==
X-Gm-Gg: AZuq6aJjtr1f9ctcYYA1HNcXrZBWzmHdOKCIOjvyQfpGyoPzzyuefmggxFPZxkyNhG3
	pkJkJeVzqTaVrkJtT9NOETKg7NVfiSOvweF2dIMiacYMs6jWFUw2m4v7XmSrVSWF+4YPovokYib
	+2fDgW5rsRHH40GHBvcFedHpAuGV2NOrjD0SfEpfMa8UZdfUqZSpVQjT1OTyG8TmiDY/WW8RLcY
	v7QmXokOjrMNvzfmkeOrbpxhg92Q5A3+gZvroz1GD0wsGx1CrVfhkmuy/Pz2C5GfZ2WdN4hNLgu
	fqabGqupBXcVFK6+NdRZfHm2VV/ioqX+GyfFstIa6TQFqRThUZWOFgLC6sBJx+1XNTB6mJsh7kg
	BszEdn7sI57J91Q+gMRnhoUu835dJYWVxR9js4ISZ5kJC1Sniykk6f9H1mk0A1d0oslRdIUF1Rw
	UElQ1NJaNy
X-Received: by 2002:a05:6000:40cd:b0:431:342:ad41 with SMTP id ffacd0b85a97d-43569bd30d6mr18220157f8f.61.1768900569575;
        Tue, 20 Jan 2026 01:16:09 -0800 (PST)
X-Received: by 2002:a05:6000:40cd:b0:431:342:ad41 with SMTP id ffacd0b85a97d-43569bd30d6mr18220117f8f.61.1768900569048;
        Tue, 20 Jan 2026 01:16:09 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a6fasm58581f8f.10.2026.01.20.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:16:08 -0800 (PST)
Message-ID: <071f940ebd428349862fcf233130d5f9774512a5.camel@redhat.com>
Subject: Re: [PATCH 21/26] rv/rvgen: remove unused sys import from dot2c
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 10:16:07 +0100
In-Reply-To: <20260119205601.105821-22-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-22-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Fj4G81rQ_Ij5BV4ETyCH8JDyyjgF6NerEp-gNvQV90_1768900570
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> The sys module was imported in the dot2c frontend script but never
> used. This import was likely left over from earlier development or
> copied from a template that required sys for exit handling.
>=20
> Remove the unused import to clean up the code and satisfy linters
> that flag unused imports as errors.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Good catch, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/dot2c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/dot2c b/tools/verification/rvgen/do=
t2c
> index bf0c67c5b66c8..1012becc7fab6 100644
> --- a/tools/verification/rvgen/dot2c
> +++ b/tools/verification/rvgen/dot2c
> @@ -16,7 +16,6 @@
> =C2=A0if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 from rvgen import dot2c
> =C2=A0=C2=A0=C2=A0=C2=A0 import argparse
> -=C2=A0=C2=A0=C2=A0 import sys
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 parser =3D argparse.ArgumentParser(description=
=3D'dot2c: converts a .dot file
> into a C structure')
> =C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument('dot_file',=C2=A0 help=3D'Th=
e dot file to be converted')

