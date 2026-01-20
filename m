Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7F3ACEF5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895131; cv=none; b=e7mSk65ptdN5me8BiEYoCbY2iNQky/YQYmWnEahuHdFu1B8C/GJ1PFCQ/jdudcrUp4AQt4ltC7NzrfcXYmko82WFTyIwPRlzTzMrLiPqEC3UX2CG7bIKbM7eNxpRpSDHQyHgue528NRJRTVxjHOVLX2o+a366ZsFcW3pWwfppfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895131; c=relaxed/simple;
	bh=A7WdKEUEVYfv9u/e3wJ6l1j/cN1T/RbeqRHBVjqH3m0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeTuiH+uPAnKZxmwJRBPiZvsw2s/tLAD4d+S3Hv4afmkHZKpCY2qVc/MZIQzKjATSHvlUdS5OsixZCf1W0tOqGnS8LPdgFXcxksFBHV0Dyc1hWpPN/fDFMyA/j+ZXCL/xc7fhzLMS6LeTNFI6OMioTQ8H0lJHkcX4DUOtJIfODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZs6cNiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZs6cNiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768895128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A7WdKEUEVYfv9u/e3wJ6l1j/cN1T/RbeqRHBVjqH3m0=;
	b=gZs6cNiRLI36l0Zb7ztBievVUPCmu4iNSLCy7lgKKTNd59JVtWCYWev/iDjToJbhiF0dTQ
	gVjn7Tku5cexy0iPqI7s0a1VdUWOEYii+iYMuw5GhLJyfdFNlzyn6FfQdnTYPhmRARDKT3
	bDSt1Ko+ekfKBnJjcFrw4/ES95zMNxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-LsdenhBYPhul1MPSyUOwkw-1; Tue, 20 Jan 2026 02:45:27 -0500
X-MC-Unique: LsdenhBYPhul1MPSyUOwkw-1
X-Mimecast-MFC-AGG-ID: LsdenhBYPhul1MPSyUOwkw_1768895126
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4803a72daaeso8795005e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895126; x=1769499926;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7WdKEUEVYfv9u/e3wJ6l1j/cN1T/RbeqRHBVjqH3m0=;
        b=Rwg307QgPldR0yI5Np3MO4DajumW0LfbIQHFbeVm5Yavv5hUiRNoOwISZm6v3hLK01
         y/1h4y5Xw6SPSKbMAsRr14987Yrt5sQE/iZDhGNBUgO/N+LN4ZJzsjL87LPqRN+4OERG
         cL4WLJpVPGBhYZVCWpQ5NZHNwfBIcF+QYGPN6vVK3u/n3iwtsUBGWsILhtnjvypIowjt
         K7XtWkXoFK/C9VxTaieh463PZrp+2Cd+y6xfEYfA3psQjFAlBo06EqCUMLKcHGnbsV4J
         IOjl35Znyt1vAawd3QoQ4j3hVC41jf4o1zpyMC7PE+Ad93yb2TpOOeE39qI3t78Eb9AM
         +ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCURFSGzZU+MV1ZZnBRY+Ae8HRoxJRSkAcSD5hNs/UmTUHgQRzkKjr5Uly7gxdFuNAg35YJm9TkZ3Zbg+Y0mnBkVCI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uX8d/PAWIIsoAhoKDNpx9qeSyx9dQMXjLrxGQ6sDN7+c0/k8
	M8uvBdxeVqGGTa2I5y3k2M7a+7IaUTNNxood/yybL/0qmQVL+WelH2LYkMCM8xrpFJT1ltJzIZ9
	J5P9eE2hXU4rmxdFOhp4548UvGIdSvps5ULf8+sdLfQxCBKas92rjAX1xuOpwc76H1HgmkKMs1w
	==
X-Gm-Gg: AY/fxX63rR+XlSV/XW5ajTZsKx6/hWOg8T1Fq7nn8ysuhJGmgC5Cz1QHDy2fDLeE++l
	YS1lDUSQLviI5YeeKWfPQM51Q3mabZxMU20RocXumRh/5ewwV3tUo20D7YL0jIK3FcrfH5a049v
	qz01RmYvS5aW7NAdjmfQoS984CYml3fheKC7ef+I0dNuilVvaqpjfoEHnW2btkqxuOxkL3hfXCL
	MDGhaiUfEJ8jJETeat6Y50oxUWDFX8d3XojgFUw7lXUxzvMAtVj9ppa7T8qIp0kg1e7dFQxB/kZ
	W76GbqK+rkzVwWOL+GoV/FJkmcDvEGbMzGDbp4X1GCyqg9AuC2/TRcezq9RKaJ225g8tB9mTQkL
	PaUK3CN5VusqYBy6pb+oanBg85jfVAsG65zyU8t8MvMMyyFnzla0bnotaW+qnvIlfLb+IYf15Zy
	xylJ8LJQC7
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-47f44d4ca19mr130183545e9.16.1768895126169;
        Mon, 19 Jan 2026 23:45:26 -0800 (PST)
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-47f44d4ca19mr130183295e9.16.1768895125704;
        Mon, 19 Jan 2026 23:45:25 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428acae8sm289964525e9.4.2026.01.19.23.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:45:25 -0800 (PST)
Message-ID: <ab5e7777a3eea74e5df9b24d8ab2ba1bed94a1a4.camel@redhat.com>
Subject: Re: [PATCH 07/26] rv/rvgen: replace __contains__() with in operator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:45:24 +0100
In-Reply-To: <20260119205601.105821-8-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-8-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XAdM_REo_e76gl8_ZWAshczMimKZOrgrDXGhAp9NOSM_1768895126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace the direct call to the __contains__() dunder method with the
> idiomatic in operator in the dot2c module. The previous implementation
> explicitly called the __contains__() method to check for membership in
> the final_states collection, which is not the recommended Python
> style.
>=20
> Python provides the in operator as the proper way to test membership,
> which internally calls the __contains__() method. Directly calling
> dunder methods bypasses Python's abstraction layer and reduces code
> readability. Using the in operator makes the code more natural and
> familiar to Python developers while maintaining identical functionality.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Neat, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/dot2c.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> b/tools/verification/rvgen/rvgen/dot2c.py
> index b9a2c009a9246..c97bb9466af6d 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -207,7 +207,7 @@ class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 first =3D False
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if se=
lf.final_states.__contains__(state):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if st=
ate in self.final_states:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 line =3D line + '1'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 line =3D line + '0'

