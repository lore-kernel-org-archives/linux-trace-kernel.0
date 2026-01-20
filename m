Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C653A1E6E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895084; cv=none; b=m/xA6xXZQ0mIQrLCcUoBDgm68DBKqlzRIlcurX45hDUN5DZ5Gj5yqF2s13UTVfKLBVuwpljahkUmLijcE7ZKyYyHd67DCfx5a3FZIsnn1uT+yIFCIJpW2/YRcAR1ceP07ICuI/v+Z7x5+uVgttKl5nQH7U15vUO9Y3yO8tfShsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895084; c=relaxed/simple;
	bh=ipg+mSoJEdk5zjE+os8QYlY0SM6gJ7gF/I8SjyIouwA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6EO93Ms3lEESh9AScoqoYIiOeYG1LEL49cdpfOBWvzFhVmytbcz0SbMtGc7lClfSvdY9KrItoSXiCcQHQmHuRyp6y7S/0WLUGLQy65IO9s0AJPUP8Fhkr5WIHCCYh9HFhN3ENcm0KHlPHY0/1JgBxpYLbmv0pE7v8hctp8chOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfnYIqzw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfnYIqzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768895076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ipg+mSoJEdk5zjE+os8QYlY0SM6gJ7gF/I8SjyIouwA=;
	b=BfnYIqzwsA4sm2sHvuJ+7HdgRnbqvsLrj5OHXYN2iq1fqDSbta+lwXmRajlyfgx1sM382R
	N6EuPQqr7bfTs05xmGDrfkQ7JtzqY7fcDbR8uKPRb3ULO+9dXBqfM9l/dsrWsot8BHgYzp
	50VCvAgf4HBzH29golAQM3zHLJfBlPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-euGWMxmqP_6rDrkE8sAqSQ-1; Tue, 20 Jan 2026 02:44:35 -0500
X-MC-Unique: euGWMxmqP_6rDrkE8sAqSQ-1
X-Mimecast-MFC-AGG-ID: euGWMxmqP_6rDrkE8sAqSQ_1768895074
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso52545865e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895074; x=1769499874;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipg+mSoJEdk5zjE+os8QYlY0SM6gJ7gF/I8SjyIouwA=;
        b=YnHPoCHSfCZ7mamAy7Wx3OgshTEKDDJj2PLQAPEgu/DYV6V/hW31DA+G4gUhOsysuW
         n+wMarJSfKt7/XBz/YoETBgcAgWb8TnwF4Zz/OIm0Xh/0z64NJF+s8CRykn2MTNcNcSh
         tw6qp9rDdxF6y0JjyUSNWgoHrDLzVLWVaB5HCcchBUwu4Kk/synyPckNMfuKoq5eShRR
         8/AkzpJWifOLv6yK101UFn4shlBZTlHaIQAxLmgllA5eAcuaV+YypG0g9RFPCusyv6mE
         80VnUKSyznsQsZGzdyeHj7P1tEAp2JpqyNfIclND1jcazhC+4nNfmwVnoOq9X8vVDAfB
         b3FA==
X-Forwarded-Encrypted: i=1; AJvYcCVVnwCTwweZWEvoxlNQ2qfCk6g9YACuXG6eqX9pD6DOrkhRxPclYvIEOMvwle6dI1i6tGQYardJ2B1+JJ/hrzOHVMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkBojS8VZLOFNg6dqaqGtddgzWQwy9jNWceRxmqvJ17CmZzfT
	jfcuoDJpFA2cg9ac1Kc/nId0NK5VzaVa3evFo5BBhBSbqppiyHgbPoKtPiRFDTh5DklQyv9gtVk
	Ihb6+qLR9zr9NmTS+sNs+Bvj6YDsBreUkHwOxiQ6HA4GbLrbU4lesFajTshoPfT5FUUullvu9VQ
	==
X-Gm-Gg: AY/fxX6jQh+b6kKfGkidEmnjXw9onGM8vSavooRqU+Uk5nurLAGJSUqVt8gzE48xkzf
	dQXoH2tpHJtm9AOBkB4phehg8N9ewDUP7MRNPNcEn5CxC6RShX5YNid6yC1OnvMoOEwi63oYYot
	b5airF5yBmGP68QBKuU7doF3VY8f/tu8QpIt6/qeM3ClENXB0D0vOoi70ROe2unX6MaLw+5iece
	4l10/IiY8RA8ZFcYXERhDfabHcR3isNEHVLDTwTgRvvk5wBxSJmJD3cVWeLI8HG/KjmDCffRvv0
	wygaomlDvAWydkdE4ATWATjH/s9/OFWTiq2D5Du2ccaIqOcAOZM0xP+cgSH4jeqwiapGmlrOZ0H
	eqGA/tx87gYtNieEXmMqpAbInYWUsny6mTNry6Bm97F18RrYrHScYzCLxPE0qhHSRNVGV7GWZxv
	+ylUaRA7ZP
X-Received: by 2002:a05:600c:474a:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4801eb14b36mr181412435e9.35.1768895074073;
        Mon, 19 Jan 2026 23:44:34 -0800 (PST)
X-Received: by 2002:a05:600c:474a:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4801eb14b36mr181412165e9.35.1768895073650;
        Mon, 19 Jan 2026 23:44:33 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b789sm291325845e9.1.2026.01.19.23.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:44:33 -0800 (PST)
Message-ID: <9ed5639ec750349acfd243a7f8358acd1d13c2de.camel@redhat.com>
Subject: Re: [PATCH 06/26] rv/rvgen: use context managers for file operations
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:44:32 +0100
In-Reply-To: <20260119205601.105821-7-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-7-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DNwRvmpshlt-9awelfTD_TZAL4UHXbBMaH9lp4lROVI_1768895074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace manual file open and close operations with context managers
> throughout the rvgen codebase. The previous implementation used
> explicit open() and close() calls, which could lead to resource leaks
> if exceptions occurred between opening and closing the file handles.
>=20
> This change affects three file operations: reading DOT specification
> files in the automata parser, reading template files in the generator
> base class, and writing generated monitor files. All now use the with
> statement to ensure proper resource cleanup even in error conditions.
>=20
> Context managers provide automatic cleanup through the with statement,
> which guarantees that file handles are closed when the with block
> exits regardless of whether an exception occurred. This follows PEP
> 343 recommendations and is the standard Python idiom for resource
> management. The change also reduces code verbosity while improving
> safety and maintainability.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Looks reasonable, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py=C2=A0 |=C2=A0 6 ++----
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 12 ++++--------
> =C2=A02 files changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index ed02d0c69b410..70ff98abea751 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -51,13 +51,11 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor =3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_f=
ile =3D open(self.__dot_path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with =
open(self.__dot_path) as dot_file:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dot_lines =3D dot_file.read().splitlines()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError as exc:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
raise AutomataError(f"Cannot open the file: {self.__dot_path}")
> from exc
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D dot_file.read()=
.splitlines()
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_file.close()
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # checking the first lin=
e:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D dot_lines[curso=
r].split()
> =C2=A0
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index 6d16fb68798a7..ee75e111feef1 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -51,11 +51,8 @@ class RVGenerator:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise FileNotFoundError(=
"Could not find the rv directory, do you have
> the kernel source installed?")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _read_file(self, path):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(path, 'r')
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D fd.read()
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd.close()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(path, 'r') as fd:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conte=
nt =3D fd.read()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return content
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _read_template_file(self, file):
> @@ -199,9 +196,8 @@ obj-$(CONFIG_RV_MON_{name_up}) +=3D monitors/{name}/{=
name}.o
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def __write_file(self, file_name, content):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file =3D open(file_name, 'w')
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file.write(content)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file.close()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(file_name, 'w') as =
file:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file.=
write(content)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _create_file(self, file_name, content):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D f"{self.name}/{=
file_name}"

