Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534423C3BEE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114706; cv=none; b=ZB6j8Wou/gqwTrWdmwgJW/p9rSW+nthWK+38hXDJkfAbc6VcdkrNZ80enbrSMhxvsFRCwjMCv+PFocH6aR9OWL8DAGgWiV2GgRn6XgqYs3C1q3/l/KYoqBc2lCyVTkDwm+ZK+DMbxjRQKEkUzGsONqhEopcqfZQitpjXRJ9qkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114706; c=relaxed/simple;
	bh=G4HCU55+m5Y/1jOLBW+gK3m9fHgqz08eidyoQxg0iwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIMhvvXnblClitia9S4vx2W2HRd3CCuefct5p023b33zYSlqFvLR8Qe/t4KHzEjf0+sI0cduV9o4R1LP8rS5cXFfEY34DYAzYELtQZyHYsjZLA+l9EA/gHKvKSW4bg9iLjBF0Kz4moLeaW+zHqfFzeuyXG9jvGreGsq1uUK4L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REOHOeMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REOHOeMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o0UlIb8/NfA1VI46wOs7o91Aw/JM+w1UsLhU38YafsE=;
	b=REOHOeMYX3ACOx/NIKrFIxsDqkqszHMa5MsSvNz1YsEk57cNyql0u4c1Zv9tKHcFqBvWuy
	tTzqA8Hcc/V2orNHrVKNxaerD9GC6rq6Zxp3+F4R35iWaQ4gylD7naqCNtN1fEk+jKmjCt
	S9KonCgTkxfkogOH+tsOCbGaHCHTp3M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-RS90jyD1Mrm5WtCEMJfXPw-1; Wed, 15 Jul 2026 07:25:02 -0400
X-MC-Unique: RS90jyD1Mrm5WtCEMJfXPw-1
X-Mimecast-MFC-AGG-ID: RS90jyD1Mrm5WtCEMJfXPw_1784114702
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c160b9c0676so129961666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 04:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784114702; x=1784719502;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o0UlIb8/NfA1VI46wOs7o91Aw/JM+w1UsLhU38YafsE=;
        b=BkqNtMRiz3khKRfwbBHJPd+c4s5BSA5tctI1PMw6WqmudXdiLRHf8erzfHadapESwi
         22yxvC0pJ6q/u6jPH2hapFvtJE9+hNbZYyS+b0wC3EiPP8axQZJzorMwogW3uBNmiw3i
         e28Ftr/yPs9CfkbksZXeOyNbmdiEG5Is2vBztuerd4Xt6OhHx30IKXgDqVu6L1pkZdmq
         kxTV397oE/g+KsrQ22MpJDejkI0gkhm2WNuHSRn6i8hMwvCuQkGRjMKNpzQDyQu4rr6t
         TmvApkeewTMNHvfLnwgERsheQYATcto2JeKU5oQLkNlWyqOeusmCPVppyhqPkaKs8ioo
         0g0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrq7xW99qjn2eYHEzmEiPDzrTEBma12x9SYtIzIBWNQdoW+BJS2zoYhCMZo2uk9JSjhF2W/j6nf/loVFOad/oB9s4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9aOIQfFS8ugXljN4/n9faFuuTWK2WL5EMS37AdFKBzK9yqLP
	aRXv+OPXZ/lvj62KvQ0AhNUTzGyBDVSrabzXTATsIcROH3iAqLmpYmhM5d4Te813851773N02Ob
	SJcQYq3hGZr/FrmRmsSYyGXM8QPKJofMSg72maj/dtpIytdDThY+CmaNi/x8hcX6YUq4/0wXQZA
	==
X-Gm-Gg: AfdE7cnfHOE3UjY+46mSNdam+hfW7zjIj+vB0eT9sdwZZZ5uib9tnag7vYr7JA7Q5Dy
	Cp46oQstyyWiVI7LLo3wruXM8u/p1PTB3ODBfGgED3VQhPtAqYTd9lcjAG24n9q7gezyKhooONh
	uw5AUjZLoU/hRZCX5IeuB7ISJp+wIYnxaEoqrNY6M7X7WFZYNBOKi/Io9ODc72MUrbbqZJXmpIJ
	bnRArEvtXoug5Pn4jbnVUlMgnlWisiKMOAFTqfggcIYgXDORkK2jxeJ92x/Z2lKxPQdH3/Lkhl8
	5OQp5aYKdOpniePFzdetKiXAui/6fXrJ7Nd2bQ2Qlczjls9yGW0HkRwupSoKzZtw4Tyup6VT3D6
	GGKfEKv6HZr5eWZgnaYKtqlnpdr/UwEBKy/veKH3vJgmue0fgjxWNUSQSEsbVLAxBEgrxrKZogv
	XCljq7
X-Received: by 2002:a17:907:9622:b0:c12:da4a:97d5 with SMTP id a640c23a62f3a-c161f404f86mr842944666b.50.1784114701672;
        Wed, 15 Jul 2026 04:25:01 -0700 (PDT)
X-Received: by 2002:a17:907:9622:b0:c12:da4a:97d5 with SMTP id a640c23a62f3a-c161f404f86mr842941466b.50.1784114701065;
        Wed, 15 Jul 2026 04:25:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168716aa07sm8621966b.14.2026.07.15.04.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:25:00 -0700 (PDT)
Message-ID: <cae096bdcab7e3a6247c0591050d4a45d73bc5ba.camel@redhat.com>
Subject: Re: [PATCH v3 04/17] tools/rv: Add selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 15 Jul 2026 13:24:59 +0200
In-Reply-To: <6b232d66-703b-4fe6-bf0c-4f0eeff4b4a7@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-5-gmonaco@redhat.com>
	 <0c230c01-77c8-4c9e-9f49-ecb9555402cf@linux.dev>
	 <01b025c43dda6efe97646162e61002fdf5fff0e3.camel@redhat.com>
	 <6b232d66-703b-4fe6-bf0c-4f0eeff4b4a7@linux.dev>
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
X-Mimecast-MFC-PROC-ID: DAs2mF2C8gliTFR06o3zYZEigicorquRWW6s4FXw2lg_1784114702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 02:01 +0800, Wen Yang wrote:
> > Any better idea? We cannot really rely on the shell's $! because comman=
d
> > is using a combination of eval+timer and we'd get the wrong pid.
> >=20
>=20
> - Since $bgpid is the timeout process, its direct child is exactly the
> =C2=A0=C2=A0=C2=A0 command we want. Using pgrep -P $bgpid avoids the frag=
ile pattern
> =C2=A0=C2=A0=C2=A0 matching of pgrep -f and won't accidentally match unre=
lated
> =C2=A0=C2=A0=C2=A0 processes with a similar command string, eg:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in $(seq 10); do
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid=3D$(pgrep -P "=
$bgpid" | head -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ -n "$pid" ] && b=
reak
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 0.5
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done

That would be neat, but apparently eval cmd & spawns a new shell (I'd assum=
e to
keep control of the background task), so in practice we get something like:

  bash(88148)=E2=94=80=E2=94=80=E2=94=80timeout(88150)=E2=94=80=E2=94=80=E2=
=94=80rv mon(88151)

while getting the pid of bash in $!, we could probably do:

  pgrep -P "$(pgrep -P "$bgpid")"

but I'm not really sure how portable this is.

Now I tried all sorts of bash hacks but couldn't reliably avoid this subshe=
ll
(technically eval "cmd &" with quoted ampersand skips it, but breaks output
redirection or whatever else).

Unless you have a reliable way to get the pid that doesn't rely on some she=
ll-
specific dark magic, I'd keep pgrep -f .

> =C2=A0=C2=A0=C2=A0 Note: a bounded retry loop may be necessary; without a=
n upper limit=20
> the loop hangs indefinitely if the command fails to exec.
>=20
> - For the verbose test specifically ("my pid is $pid"), the pid already
> =C2=A0=C2=A0=C2=A0 appears in rv's own output. An alternative is to match=
 it with a
> =C2=A0=C2=A0=C2=A0 numeric pattern instead:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "my pid is [0-9]\+"
>=20
> =C2=A0=C2=A0=C2=A0 This sidesteps the race entirely for that test case.

Yeah an accurate pid isn't as important in that test, but since it seems to=
 work
fine I'd keep it.

Thanks,
Gabriele

