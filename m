Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8ED2BE047
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899559; cv=none; b=NYTMZosV5IUjztwUb+sNRcVsHkQW3788NssTO1za3Jgs9HA2mgyS+144mL0/rbWS2gkL4yk3YkldDxq3wX+5DNmdZwJxhRg50Jm+dXh3vchilGb1vToye9NbOEme18IrhebwJ6KR6IYPwdMGIjP7jS6utjXAcSjHoXqaJTr2CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899559; c=relaxed/simple;
	bh=sMdRSvoG+LSVpXw+Rc3meOm0dLuxbQwv4p4D05xn+yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlN3m1KGnNRKbv79hygfAxrGPVi0XWhoqSo9DeVhyLrt7CM78osI3QaWsQ26MUJxMw/lMXEpHLJzbnArlZCa8tgm4neWkixfSdyyrgYNZ9gpdpwYw+madwFgh0B60FSJz4iQpQ1PCTLxsuFqtff/I7reVGsbjYXTCi6FY+slHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjivNP15; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjivNP15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768899556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6iFMtHhoL3bOSCrpSbQA5IrtnTyZJVqCZfgJ4obY6M4=;
	b=fjivNP15pcpI3YPSlbIxwzMyCZGtOXV2pCsfXlqaqF18zLoaDpCxTLcA6xgRXsHJsSzw2v
	0c/GABqBnCCL1xtBPF9EOEx5rfAED6MmGcp1SSSI8u7x8fzJ6cq0edFAjz4MDB8RPyjGQt
	BRWChqlVaHqTdIIKwBD/qcW1YQROFTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-DtY1YVsTOyyonJZzBNmERg-1; Tue, 20 Jan 2026 03:59:15 -0500
X-MC-Unique: DtY1YVsTOyyonJZzBNmERg-1
X-Mimecast-MFC-AGG-ID: DtY1YVsTOyyonJZzBNmERg_1768899554
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso35293075e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 00:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899554; x=1769504354;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iFMtHhoL3bOSCrpSbQA5IrtnTyZJVqCZfgJ4obY6M4=;
        b=fH2RjA45kRM9w2MLw4RpQxskM5YDo9YX1uoqNmhrP09O9JUHX97w9OC3GynvAhMDrt
         30uyQIFH8ZPrbjaUyJmr3X4cfHi3jyezr7WZUYwqxLOsdwSzafrDWUKWX92AIAJ3i4Nx
         NqvIrGv+XI3YxRgPCUj2hihOFf3ESLvina3iAasIGibDyb2Knri+U/o0xyU1gQbkSoTw
         awB0vlrGrLpq4kZxFtdWecBpzJe56qORmwu7LHIaKS0fP/V3BLn7tiUdahNEzARy7bCz
         jXdndG54aPD/2KX+FSTGiKSmI3VIjJ7lVK73XYMMJOOTMjYyjvroV4EqnZl1Gs7YV8F/
         2SCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1D7HktFrnbtuJDbjyQsysgpzezGEnWZId9ZDCKu+/ayXx2K1QoQdcKPnCv2HU1G0V1fODeM5Blv/bewrMkLpRVJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6BTK4qwiRUd8KHR4jP3yTawt7aZBdcMnheKPooo3x946Vt+p
	TaR+UHgyY+4+BRs9JAYZZ46uGDku40LaIlWR+x/LLn9+fGtSCObIUq4BZaWDyJdfLEqQdB6U5e1
	ytBTJVyIWPD47dAGdOlzeK2pMOflkjxzPbm7iAM00MPa2Uojvnnt4fdGXTsfb3IOfj8MH9B8L0A
	==
X-Gm-Gg: AY/fxX66iVBsbtRq3DXpv5gGJZgEbQ7PGoqf1/Ud/7KefI0qjG2e0/t1RCkH7slzZ7E
	aYOv3AIyou7inXSp2gaM7AixbtA/0pYK7CLujAD9xnmNUAKrFVPG2U3Y1p3CJobrawfNz6FLo5V
	eu3iH3hC4PLKdmZkiXcZtTnVVqQ51zfrYqCwhAJPygdc2hDjXOEHT1UzTZTKkGENYBUwLerIZWs
	uVGJqW6ZCvlolqzvjD1+fh7BUhZBlPAl09MuADye5BQ9rDue3lbcjy0Voba/NC00gcVUoQutdP/
	ISZigNsCrfsEh1jwoNBmXH6JaTQ8SBCKK2r5Z5rYxzFu2acN6/K1qrlse1hxZDE7lCqdOHCia4O
	OwbtSaSALzc153a2P/oqxlIEtCNgFzYHZ0jRRiWYmGMFlOpyjC6wTBG1yVAVx1yWCjUezgueanq
	rFUhR1ERMC
X-Received: by 2002:a05:600c:528c:b0:47e:e61d:b8d2 with SMTP id 5b1f17b1804b1-4803e7f18d4mr13837395e9.27.1768899554034;
        Tue, 20 Jan 2026 00:59:14 -0800 (PST)
X-Received: by 2002:a05:600c:528c:b0:47e:e61d:b8d2 with SMTP id 5b1f17b1804b1-4803e7f18d4mr13837165e9.27.1768899553635;
        Tue, 20 Jan 2026 00:59:13 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm365703365e9.15.2026.01.20.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:59:13 -0800 (PST)
Message-ID: <b8a2b88e484cac27a82e1c27d0e27599515c4bc6.camel@redhat.com>
Subject: Re: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 09:59:11 +0100
In-Reply-To: <20260119205601.105821-18-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-18-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DWIPFpkzwzyFLsDdzf_ab6MbFevhzfo2jWF1p0B0V9I_1768899554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Initialize loop variable `i` before the for loop in abbreviate_atoms
> function to fix pyright static type checker error. The previous code
> left `i` potentially unbound in edge cases where the range could be
> empty, though this would not occur in practice since the loop always
> executes at least once with the given range parameters.
>=20
> The initialization to zero ensures that `i` has a defined value before
> entering the loop scope, satisfying static analysis requirements
> while preserving the existing logic. The for loop immediately assigns
> i to the first value from the range, so the initialization value is
> never actually used in normal execution paths.
>=20
> This change resolves the pyright reportPossiblyUnbound error without
> altering the function's behavior or performance characteristics.

So are we just pleasing the tool or is there a real implication of this?

Apparently code like

for i in range(len([]), -1, -1):
    pass
print(i)

works just fine since range() returns at least 0 (as you mentioned in the c=
ommit
message) and i is not used before assignation in the loop, so I don't reall=
y see
a problem.

Apparently pyright devs don't want ([1]) to implement a logic to sort out t=
he
/possibly/ unbound error here.

From what I understand, this code is already not pythonic, so rather than
silence the warning to please this tool I'd just refactor the code not to u=
se i
after the loop (or leave it as it is, since it works fine).

What do you think?

Thanks,
Gabriele

[1] - https://github.com/microsoft/pyright/issues/844

>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> b/tools/verification/rvgen/rvgen/ltl2k.py
> index fa9ea6d597095..94dc64af1716d 100644
> --- a/tools/verification/rvgen/rvgen/ltl2k.py
> +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> @@ -45,6 +45,7 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 abbrs =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0 for atom in atoms:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in range(len(atom)=
, -1, -1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if sum(a.startswith(atom[:i]) for a in atoms) > 1:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break

