Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA1306756
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331968; cv=none; b=lFaVFQb5gsaE3FsmTYNtgpRB0hIHH18HawThkIa2yvvATOK8VAI31md5/U6AczMb9MX+WkosuH98jBGLNO9fRr8I3xo+Yq7M/kErSWcCNqM20JqC5JQxN6t/1MlSU+WWtJkc7GhktAVvpUDBEZJbp3N6Zwv8BzkKdO/+dAgWBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331968; c=relaxed/simple;
	bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx2Op9tEN/+ofy/jvml+m9Drtwp6ZDgtNRcdhB4ylPJaIE5Zc7AmKPfqZagOMezGOKdHSp+U0SlucXxXxmUV0AGB4r6hDcZY+Ee7t/GqAab9PvQ+zO4Z/bjpR1oMs6qRiEsLLvWxz2yF1ufv7Uz/yI2wlHi6qYdIDNvpvtZ3KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSp1vqO/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSp1vqO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788331956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
	b=MSp1vqO/ZibK6ld1XBbb8ArbgUqz+TbkLcPvPYSRHtg/ocjYynHE5nOX0RvJCTLiezpzkU
	q0qtsUSA88RqKwQuKNh+jkAihf6ZPrmXeWlrG2xwErI+CX/+8IJnWcBVQzFvZ8T3AKZJVB
	wD//rJyXO+MD5NduFpHzRkGkVgQMVEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-XlPYD1-fPauLP1OK5_wjdA-1; Wed, 02 Sept 2026 02:52:35 -0400
X-MC-Unique: XlPYD1-fPauLP1OK5_wjdA-1
X-Mimecast-MFC-AGG-ID: XlPYD1-fPauLP1OK5_wjdA_1788331954
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49a1b4ea633so6885005e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331954; x=1788936754;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tdQPXAEy+8QdspuTOxqFKJnA9qsJ6Jve5TAJj3j51Gg=;
        b=q46EATGsZHwaV64mi/8FhH7moh+rlcgb46ZXBgR4ZxECQgjzDOFMy91Uy6NU5zAuIW
         n4YjYPiqzA05vs40oTVygcLiC2mN65WEwNCkdSFEVDKz//6waGYJQOoz8R8aurhO2wyj
         c1twXhWWMfvSEOhaDujZzY5TDmhr4+OuwHK/2sfGUk0D1KAW7glcg/HCQTfRfBKR9+7r
         4/oGOz/4kPJrrtrDP1/ZWt1psEqGOc/PRUMpTl7ohaOF1wDIs4xrrKij5RvcBlJ6SL17
         oTDplIlumaP+JCttPzj2rsrKBbobq1dNLU+OlUueFyku/5OQ2JiprO/wDD6fZN3Ecjx5
         5sUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRSvUbv00dD3VmCbtS/7jdgAJzD8owke9ixvzQRoFUMMyegOfmC4ualtQ7bKEP2n9znmNTUfpV9uhq4bETdLuf7YQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lHiyITLzGGN/6TkGFvpqSTRf1W4MqItLfSvmSP7jDHc10i5l3Q
	3UZIl8e4Mj7F1NXsSDVdZ40/5IXpFebJ5WH8dxIl/hyTDcrrn9dBlUHmJsZbifFw2bCTDphSaOH
	GEzmoyf78vrXx+BJmgbNHZqlJkaL/YodObPezkzALkSecrmHc1vnwJaO3kGSQpsHQ/rp80CnEEw
	==
X-Gm-Gg: AR+sD11YlfURbGdP0mT1ioIjb0Kw9S5AIXKqiAX4+oVBf7PF7KTOCTLMwlXzaJxl8gW
	k7RLD+njRose0voi4S3Q60LwlMJiKc6JIdbk5WwOTXM/MUUi4Sb+a1gMEG7fTOtbEg9KzJuLufR
	QZZX3gH/nazqZ0aAm1K3J1dlZXUrvw44zRmUXctgaCfUY0v2edmEVuWH7fiID4ly7reGSrkmNli
	12nZ/qxZEyVNQ8oHHLQKZU46bZzYPtoELwgcvsfpLxXt+KVvhEt8/NSKx9x5uy4aO9ahrCTIMET
	Q41ZQ3vN4LPBgBXIwqx+2oDzv6cGR7gGZGrIk7Q+s0TFekwTKza1+K42zLAb5+nkAdMiPbgj9lh
	NO8HeNVmXUFofQppUG0nMP3B8+NiaJA==
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr42599105e9.16.1788331953846;
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49ce584c93amr42598525e9.16.1788331953447;
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4642382sm47964965e9.3.2026.09.01.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:52:33 -0700 (PDT)
Message-ID: <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Wed, 02 Sep 2026 08:52:31 +0200
In-Reply-To: <87se3sakgi.fsf@yellow.woof>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zi68fAXloBGXXKHBtZ_i1zeMd3181_tcnz5p0VYTirI_1788331954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 20:35 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Extend the rv userspace tool to load BPF monitors, those can be found i=
n
> > specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
> > object files including BTF data.
> >=20
> > This type of BPF monitors can be generated from rvgen using the -b flag
> > just like in-kernel monitors and, after manual adaptation, can be built
> > and run transparently by the rv userspace tool.
>=20
> I am not familiar with BPF. What is the benefit of BPF monitors,
> compared to the existing DA monitors?

I should definitely have included it in the cover letter.. I'm writing it
everywhere (will present at LPC) but forgot it here.

Essentially BPF monitors can be pluggable, folks writing their own monitors
won't need to submit a patch or maintain a separate tree, which is useful f=
or
domain-specific models.
By being pluggable you also don't need to reboot to use a new/updated monit=
or.

Think of being able to distribute a more granular set of rules for RTapp, I
remember we had conversation along those lines, not all rules apply to all
contexts and what you send upstream has to be general, what you keep for
yourself doesn't.

Having monitors in BPF brings also other perks over kernel modules: a whole
bunch of readily available probe types (uprobes, fprobes, all unexported
tracepoints that are cumbersome for modules), the map infrastructure for
allocation is arguably easier and the code is verified when loaded against
common issues (NULL pointer access, unbound loops, etc.).

That said, I try to mimic as much as possible the in-kernel functionality, =
but
some things are not the same (event/error tracepoints).

These support DA only because BPF loading needs a userspace component and t=
he RV
tool doesn't support LTL and HA yet, there shouldn't be any technical reaso=
n not
to extend to those in the future.

Gabriele

