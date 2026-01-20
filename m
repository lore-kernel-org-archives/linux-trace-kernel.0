Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323663793C2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900138; cv=none; b=YqQOQ7cKnw/Bu2N4wW12TnkIUoWRBWnl/7bHaNUhbKZyUIY1aoVGHd/1BWYa71e5nG0pd204T8UVaNNqwZqH6qKUR6Auj59zCaIKjgGnjx8yDvpzwsicChmBxzFXl6xWqM5CHFpEjXN1gkZOQ+lwM8bB2nE5Qyst4SIinFbhsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900138; c=relaxed/simple;
	bh=k+acc+Blsz7PjSI0EXgf2vzztKO1vh4z8hxzeh31Vv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RodqBAMSdZ+vzpAdaG6MLDkAXT+XePQb99gsNEeE06yfLO2wJW3/xPndujeQ5Do5XKaf/Hup0ZG32+nw2yg3qz/jGqKk/HbE9S92gxfDvuQ3Wu8HC2fWZQsdT3TdLYLVlg1iT4kE73yfpczd96wXER9iw5xLrEbNxJZBZqy8xSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6zndvWj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6zndvWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768900136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k+acc+Blsz7PjSI0EXgf2vzztKO1vh4z8hxzeh31Vv0=;
	b=Z6zndvWjAWD2VN5k41uE1WUH3gd1YZrWuL7rNHlfDsf9VB9UKOQ1Kz9ZRW9ZcCogjZXoCN
	pMMYfLB3xQuNnP+QzwxwxQTfjE2Ry6FxZbrYceFBprI8inN9+R0XFy+Ez9rnBO9zei7niE
	U4bDqmo3a7Gb29MDQuUsuTSTg/S467g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-PkzAzUOpPO2nSydsj3OdfQ-1; Tue, 20 Jan 2026 04:08:54 -0500
X-MC-Unique: PkzAzUOpPO2nSydsj3OdfQ-1
X-Mimecast-MFC-AGG-ID: PkzAzUOpPO2nSydsj3OdfQ_1768900134
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-434302283dcso3858841f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 01:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900134; x=1769504934;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+acc+Blsz7PjSI0EXgf2vzztKO1vh4z8hxzeh31Vv0=;
        b=mU+tNrFQZd1alU9VbpMY/rHAPnuGBPmwXSpKdREN+7KA3NH1E2sYsNK7p/CRV4LmBf
         qaVBWSQo9+ponvgLCMzrJgqJCe//VN52ObJm+rgPaM3tSwjnb2P87XLtqRHYzM+A73ph
         1slV1Dc3ta6MRYfT8XHdJmnlYH1x7vMinCXatWhz7ij/YiUOcqp7ewxBJDn0n9Tgewqd
         Jfw9Z5yoHA4C6qF2VmQEDpaw9dGGnEwlDKR/XNLy2ULQv8MFcHDcFGNWAp6erJ/hUX8d
         QPvtTXH57Ee1PHjPMemEIHjs1N6moE7NLUSoXV/V1EafRIqY/fQftgz73CgSwN9/6chA
         A4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH7oyebk7c5sxvZh8peJgEJJ6PSRSDBWCFvA1RWryAzj7fpaSgw93MaOBTRJvEoEYilNfBY7KdkFfMxD2YpQNB4B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer0rEeFLpF9t48d8sk4gZpjXyKJnvFaMRldO/sp4f2eiBIzIP
	EadPfRaWf3akc8IIHWjVSqdfGTSQpJZ1OEe4mcDfuUlkYS2I/saIwCls/aZ+vMLqygNzM8u2kel
	G7Bw1ngRpe3ZoqP7hg0YChf4sRsGz1qwWdQ1fQWPZnDCbnQ6PfYjmXN7uvibOxUK/jmBmsU5IBA
	==
X-Gm-Gg: AZuq6aKTaw59dmK6kHv7mz5V3AswIbSYjLfuB7N0c+wHl++MeerkxgGzxr3VHR/NBJi
	cszZ750dYp4M6j1paJKJ0CAH2HQ0seCCEAyQIE8pPhsBogMBtOr/1pFTnOmFvE+3HRZxirRaHnm
	KEnK0+WS/TpUvtimeTSk4zqAuVvcQit7r/jBWphvJVGrNRe2AnNovmXBsMG/GMaPuuaL1FB2+i+
	OccBmxnMF/mjhaAj112zkuOTq9p1EHbZx62II3snM7lJxhir/jCVN4btNXV4Pfr4ypvAZ5PoQM6
	Z2yg/c7iawQh0bVBpt1RyNnPYyEFZoRoEQloYtCRMIgTKBzxt1NbJVf0oOZvPjMoEUBYYifRcu2
	4/W9Sof3dOTYQiFxGT6w9D/9FU1+zWCGua3mbgotESvbn9MCjcf5DE9A37qZfxPfrgQ3QOcKRBR
	HUb5K5qsSm
X-Received: by 2002:a05:6000:208a:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-4358fed868dmr2010164f8f.26.1768900133719;
        Tue, 20 Jan 2026 01:08:53 -0800 (PST)
X-Received: by 2002:a05:6000:208a:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-4358fed868dmr2010121f8f.26.1768900133287;
        Tue, 20 Jan 2026 01:08:53 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm29032387f8f.2.2026.01.20.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:08:53 -0800 (PST)
Message-ID: <fa8dc8a894db0d78115ee366af79db196f56c0ff.camel@redhat.com>
Subject: Re: [PATCH 22/26] rv/rvgen: remove unused __get_main_name method
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 10:08:51 +0100
In-Reply-To: <20260119205601.105821-23-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-23-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: p3VPMKI47NX5K7BZQkFbmLvgSsnAm2ZjFE0_7uwAPIQ_1768900134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> The __get_main_name() method in the generator module is never called
> from anywhere in the codebase. Remove this dead code to improve
> maintainability.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Good catch, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 6 ------
> =C2=A01 file changed, 6 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index 0491f8c9cb0b9..d99a980850d64 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -206,12 +206,6 @@ obj-$(CONFIG_RV_MON_{name_up}) +=3D
> monitors/{name}/{name}.o
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
path =3D os.path.join(self.rv_dir, "monitors", path)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__write_file(path, =
content)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def __get_main_name(self):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D f"{self.name}/main.c=
"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not os.path.exists(path):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n "main.c"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "__main.c"
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 def print_files(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 main_c =3D self.fill_mai=
n_c()
> =C2=A0

