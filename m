Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687663B52EB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291541; cv=none; b=N/CaM03F7w1BALt734TbqspVKTRs7NzMybrS/NejBt+O/Yg4mNPUHNuDpwxR0TYClVnNECfY5uFV/dDD5JSnwpGUpB3z2akDWtCdzI0pZOFJXXexd83Xki1jD6H0f/C9A+iasgEi5JgjhS8CVAtkerGvBBvR9YZ2jNOm15ZkIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291541; c=relaxed/simple;
	bh=gXe3eaTM27lII25U1x8HB7oqFXGFlijd/rIF3nCm5Yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpTOBjsZ2SksAhd/Wv4LoKCWIEaMvJqcenkHjrbC0z94C0huF/1vSiD4fhD48jehbgWtyotWhu8CZwAMWJKxPigcyp0QkfMk/IeakTqqeyJBj6nbxDmNlJgMgLhwYY3Fsr+5fxzM1kI9OpMC8nzVvtlO0o3cpoHBJ3Bk9GRJJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtzSMipb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtzSMipb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770291540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gXe3eaTM27lII25U1x8HB7oqFXGFlijd/rIF3nCm5Yk=;
	b=RtzSMipbHMI+DhXpVXM6nUPPl8sHG+wTINDK20BnGdU18tQVBq1vgutdMDCxlViFdjGPrS
	KAWuG0rbGUHcsIaDZv2OIFCB+dD1G1ekUblyD4930G+cr6RLerh3QTMJl5DtwEMNuKh/yJ
	Aa9NH6tdBmFzK2HQkqBPs49gAwTv2Vg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-BtqsnyqTPxCEUDe-RxgC-Q-1; Thu, 05 Feb 2026 06:38:57 -0500
X-MC-Unique: BtqsnyqTPxCEUDe-RxgC-Q-1
X-Mimecast-MFC-AGG-ID: BtqsnyqTPxCEUDe-RxgC-Q_1770291536
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso738287f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 03:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291536; x=1770896336;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXe3eaTM27lII25U1x8HB7oqFXGFlijd/rIF3nCm5Yk=;
        b=Elh3Vz3TeLe0JKuiGFurCKKJaTUkF9zbDMIoAmdNDC6MqJoTHqB1l80J5/l/HQA9qA
         pzPCcs+VVPrcbfmdeUeatQLlR9M9es+R7M7nI08mLrjEtVph5lgeMqOFo3y2a4LYSD7R
         wX/HFiDjn7g8mc03jEfBCWM1oYyS1G149gyofbLBpRMdNBa1K8x37UcNatcZ007ltZo+
         YWsAlWHzUf4AVxHgcjy+FObJKawfCjIAjyFJs74GS4GfiJf7Q0NkuGolUjTrxklmG0BY
         CCGP78vwh0nF+WliVwXCjAYIZgVo7f5EAHxPdKs0f7pGtdtwz+JcciWn/hpalFaK0Yk3
         kyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwmjKZBhsveC8rZc0NvLkTSxuh4TzBvVaHkMWc/k0cTv9Y/B761CoEJoEuWLlgJ0Ta/wvOvPbgu+IhBN9v7sFl6DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tGp97yFo1t5rCAfLPlrfJl4QrWhAPGVokRFeafuN+sLDdLg3
	pm0FbHyQuzsPkQ5YzfdDKG+/MZ6J3+ILZ9mqElMnRMrvXiqp0cByqu6cCyrLlCWG06lUunMIwfA
	ZNMtqZWhMMbyJV5AIqrNDl5Jj6WDp0uUkeFU5Kk8jimOcuoFdGgLfHyHND/bZZ/L4jZakdMpA3Q
	==
X-Gm-Gg: AZuq6aJjvVAQDF6HmgNy9aCuGg3znXMAGM2GT10RQ9CZ8256QWBQaLgKYoPlx42Qp0d
	alnipaSknfYl5WDQ3EibrrlbrvArb198KvevwKBVDAvA6DJJZsg5K0s7A1cORrNBmVsqQONR8iQ
	7dKBRNN8wckC903sRJPxref7ISg76wqlws7UuzBEIbetP8avpyuaHAN5yXIbzB2EFDOKQsnNKak
	C1JoszR1MMOlXNbenDsSnwYhvUFKCJTdBLATeUB4z3m1BNCf4hDpBKVl4rsy+eQM1l5nj4YZ/MN
	7/rQfjWLaqOPfJjHL09MX6ZNsz5da7/Grri+x7+itEaB91OB/yP4PZc1EBId5fB9lnfDEmpeb7V
	CIjLNMw2fACH55V4pnLmNYmFH9Stkx6k9PDkvS68uTQNXL9Z7dUpMGlYV+mkin9WaHtFNy9kSQ+
	saO3R9EpN3
X-Received: by 2002:a05:6000:2505:b0:435:8f1b:bb32 with SMTP id ffacd0b85a97d-43618052866mr8883269f8f.32.1770291535939;
        Thu, 05 Feb 2026 03:38:55 -0800 (PST)
X-Received: by 2002:a05:6000:2505:b0:435:8f1b:bb32 with SMTP id ffacd0b85a97d-43618052866mr8883213f8f.32.1770291535457;
        Thu, 05 Feb 2026 03:38:55 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e37e78sm14247335f8f.10.2026.02.05.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:38:55 -0800 (PST)
Message-ID: <495e8eaa248302b09e5049d9ec90b12f2c159016.camel@redhat.com>
Subject: Re: [PATCH v2 18/20] rv/rvgen: fix unbound loop variable warning
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 12:38:54 +0100
In-Reply-To: <20260204144914.104028-19-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-19-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: b5_CNLcWbbPAFSBN54-uPCsxzbclFzTfY5VilofHTJo_1770291536
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> Pyright static analysis reports a "possibly unbound variable" warning
> for the loop variable `i` in the `abbreviate_atoms` function. The
> variable is accessed after the inner loop terminates to slice the atom
> string. While the loop logic currently ensures execution, the analyzer
> flags the reliance on the loop variable persisting outside its scope.
>=20
> Refactor the prefix length calculation into a nested `find_share_length`
> helper function. This encapsulates the search logic and uses explicit
> return statements, ensuring the length value is strictly defined. This
> satisfies the type checker and improves code readability without
> altering the runtime behavior.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Looks good, that's probably the pythonic way then!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 14 +++++++++-----
> =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> b/tools/verification/rvgen/rvgen/ltl2k.py
> index fa9ea6d597095..2c564cc937235 100644
> --- a/tools/verification/rvgen/rvgen/ltl2k.py
> +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> @@ -43,13 +43,17 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skip =3D ["is", "by", "o=
r", "and"]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return '_'.join([x[:2] f=
or x in s.lower().split('_') if x not in
> skip])
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 abbrs =3D []
> -=C2=A0=C2=A0=C2=A0 for atom in atoms:
> +=C2=A0=C2=A0=C2=A0 def find_share_length(atom: str) -> int:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in range(len(atom)=
, -1, -1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if sum(a.startswith(atom[:i]) for a in atoms) > 1:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 share =3D atom[:i]
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unique =3D atom[i:]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return i
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> +
> +=C2=A0=C2=A0=C2=A0 abbrs =3D []
> +=C2=A0=C2=A0=C2=A0 for atom in atoms:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 share_len =3D find_share_leng=
th(atom)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 share =3D atom[:share_len]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unique =3D atom[share_len:]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abbrs.append((shorten(sh=
are) + shorten(unique)))
> =C2=A0=C2=A0=C2=A0=C2=A0 return abbrs
> =C2=A0

