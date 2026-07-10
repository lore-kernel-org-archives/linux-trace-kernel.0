Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDB3CAE7F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672311; cv=none; b=gbTjs/RiX9cJG/cyeJpP1QI7lMUivAZkBv45Z6pqSW4lwQI0vaDLgLaTCoKQYPUkSVbYM7b06JStU9H7E6FTBk1QsRikojxp7TrmgTdjKzhGExhPBa1QsWe0CxYcYHs9pGaFbmbcqogftHPXkghJGVE7xvwRNIwKCrgJcrTLwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672311; c=relaxed/simple;
	bh=JzwffsRWC/hHixOM/9qBiac82iKo8MeCmWEHCxmjwEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxWR3s8j5Icf1MOn1FeoKzXEqyGE851FNoLYOuISsKzrZy2TPbNNCx+wkHGo4Ahw68eZ6xc1Mw64Bqfdi+Cz2kPwwnD46G0qG1yY/+Bq/B2hWuNmolzyB8XZup7sr2FPPHXrmOb0FNl9Kl715PZieiKq2lj/hmbj7ISTRw8O1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i02RuJ9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i02RuJ9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783672306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JzwffsRWC/hHixOM/9qBiac82iKo8MeCmWEHCxmjwEs=;
	b=i02RuJ9uHQ2ERF0TTWHSy6Ifa1qGW6WfT9vnV7y0yG/p6WlEUvs2MS6bw+e90kgEOjz0f/
	TcL9l5o6lFP7QiFrgpBuiacXg84Ooeo6QFFZ8TpyZlWvVR6ZTL13HwDzFDiYBrjq7AXmuu
	kmD3jCfaaxqMdRAV3U2//FYwO1V360E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-0dT0KG2NNH2HVlKei1kODQ-1; Fri, 10 Jul 2026 04:31:44 -0400
X-MC-Unique: 0dT0KG2NNH2HVlKei1kODQ-1
X-Mimecast-MFC-AGG-ID: 0dT0KG2NNH2HVlKei1kODQ_1783672304
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493e3ecd385so7077095e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 01:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672303; x=1784277103;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4kQemOIUwz1M/CXyOgmbczAyLfNUg0B0dvAv2SyUZZs=;
        b=O50aS4roDEgeTi1xn4TbuOKgMroJ6Z+cf1YazPyQENev2qeVS+FMBl9av/nODktbDl
         ltxzRqBvgIh6G8aWdJCtcL5b/JnSnzerShV48CIx5AAiQ6tw9Zr/nT7N4PeG+hdoi8xq
         10vcpPaxi7jpwgdXvNBWLzESBhQPPanh48hMKjQQGAiqCAHkJ6aJuUYkJBA95oBNR+s5
         hBWoxq6vs1c+zGDNcUWN2kw/oKo/jOD84/tbrVuSy4kfzi1s7DJols3aahwJ1PoBE4eL
         tFeKhwl/vYj0H5yBdKobYZDiOyTsT2gM9XBeySloE3xQLFzHiVpWU+Bwjhoi+AZgbwl1
         JaAg==
X-Forwarded-Encrypted: i=1; AHgh+Ro255mBW2S7b+CpgCxjSNh8t2A6uMypLVb4R146XH7JarD5WMn2Ffe21QfYk+FYuyJcgyp5ZuPRIspQocu7Y4fxA9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgRUD6wV1JZiz2654ylUZ4iMYBhpnmjg2DOq7ESXOQ6NhdStT
	SjqPgu/SQtIdax0nOO1NXMB6UuTkoNdu+QYq1zgi0i+A58VVFd/B4d2KpLZt2LJscCikAcDdLL8
	rmAf6eq/jgbK6euo3RASZUrWMDGu3KRMGAht92ZIlsxo3jK+SGn4cWtzpbTfJLPOw2J9oQx6viq
	iBR5Krhouu
X-Gm-Gg: AfdE7cmIazPLIaqnW4vV4FhJhwzz2WVO5r1PYQjjyEbQyVBB2rX5oub89OJqRWTF5nW
	nOwRCTJI50ligJTgLvExKQB8jahjlCnVb7Pb29jV02TebHlmm6zkQcRiNvHLEr1sQb3+uTmWobf
	mbVP7xCq/0rgxha+xL1evwtKcW76mSmjx24JebRXyrRCKxmRXWDx4yHawqEW73GeRM+/GAu+zzg
	t0cdPl6Ft+WC3af2zZEJS2ou8uiAJ9+y+uuoJLdfpryniZPyxHit1w2bp2yY+vcqKW6oo22vOVV
	Yj8qypLy6yeNNeQPsBKw/PsUq/m30UYOKlAR255Kso/VXyVUdhGqg4O3nC3AdHAySkNFqvvJIJe
	QcaB1OYYCcWQ/LVsn3Xu4iV6fajxZhBNGhuyOMaJKg37qiVwLGSWtXPaShnDI/zbtdg9YoKYrKS
	q7XZKP
X-Received: by 2002:a05:600c:4e0d:b0:493:c14a:a1ca with SMTP id 5b1f17b1804b1-493f3a5de04mr20017225e9.3.1783672303653;
        Fri, 10 Jul 2026 01:31:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:493:c14a:a1ca with SMTP id 5b1f17b1804b1-493f3a5de04mr20016645e9.3.1783672303123;
        Fri, 10 Jul 2026 01:31:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm12792241f8f.16.2026.07.10.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:31:42 -0700 (PDT)
Message-ID: <b971748dea21a7a6eec3be8b95f4c18aec2d0552.camel@redhat.com>
Subject: Re: [PATCH v3 16/17] selftests/verification: Rearrange the
 wwnr_printk test
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Thomas Weissschuh	
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <shuah@kernel.org>, 	linux-kselftest@vger.kernel.org
Date: Fri, 10 Jul 2026 10:31:40 +0200
In-Reply-To: <cd0a678b-1eec-42d8-b027-0d27b9c804a3@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-17-gmonaco@redhat.com>
	 <cd0a678b-1eec-42d8-b027-0d27b9c804a3@linux.dev>
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
X-Mimecast-MFC-PROC-ID: Prx6yZOQhPwzYSSmd15z6tq3uZiDcQ_c_r-sD4o7Lz4_1783672304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-10 at 01:08 +0800, Wen Yang wrote:
> > =C2=A0 load() { # returns true if there was a reaction
> > -=09local lines_before num
> > +=09local lines_before num load_pid ret
> > =C2=A0=C2=A0=09num=3D$((($(nproc) + 1) / 2))
> > =C2=A0=C2=A0=09lines_before=3D$(dmesg | wc -l)
> > -=09stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
> > -=09dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr
> > does not allow event"
> > +=09stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q &
> > +=09load_pid=3D$!
> > +=09timeout 5 dmesg -w | tail -n +$((lines_before + 1)) | grep -m 1 -q
> > "rv: monitor wwnr does not allow event"
>=20
>=20
> Minor nit: could we add a small delay (e.g., sleep 0.1) before dmesg?

I don't get what the benefit would be.

The intent of that line is to run a continuous dmesg (-w) for up to 5s (tim=
eout)
but stopping if an occurrence is found (grep -m 1 would close the pipe).

Do you see a case in which this wouldn't happen?

>=20
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
>=20
> > +=09ret=3D$?
> > +=09kill "$load_pid"
> > +=09wait "$load_pid"
> > +=09return $ret
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 echo 1 > monitors/wwnr/enable
> > =C2=A0 echo printk > monitors/wwnr/reactors
> > =C2=A0=20
> > -load
> > -
> > =C2=A0 echo 0 > monitoring_on
> > =C2=A0 ! load || false
> > =C2=A0 echo 1 > monitoring_on
> > =C2=A0=20
> > -load
> > -
> > =C2=A0 echo 0 > reacting_on
> > =C2=A0 ! load || false
> > =C2=A0 echo 1 > reacting_on
> > =C2=A0=20
> > +load
> > +
> > =C2=A0 echo nop > monitors/wwnr/reactors
> > =C2=A0 echo 0 > monitors/wwnr/enable

