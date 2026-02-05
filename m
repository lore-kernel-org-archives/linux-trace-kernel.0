Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5435CB6E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276259; cv=none; b=nIsDCL274CccGE5o04RhCyZx2VzwwBgZj2zMakX5q3HOCd2eCjJ+hs2zVH8py2DcbD9lIWAa6JtmuGDtBhazvPkDt1Vsdt1Zf71Vls8SvNE4cb57uL+qzc61cnYWynrpHxray2neXsfbBIlH1ElsVcRebz/Wq5s4HG+yL12CAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276259; c=relaxed/simple;
	bh=4f8mTigMIqXkFwFt839fQ3ocfQnHUH8K1Gu4Z//aYps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP5556FsA8W8+80rDNkzRPPR21rPxK63PIQveoT6bCVd78cYQekWQAwO0J7ARBtSEyM2NcIUWIC10LCeoECI50rbKRlO1vBcakiJynlyHMbDp/88US9fgb39fsDtuptb/u5WkBOXQfRTcbGa93gNEH4hVek1hXU5JnFY3cKSuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bkk3YEC8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bkk3YEC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770276258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4f8mTigMIqXkFwFt839fQ3ocfQnHUH8K1Gu4Z//aYps=;
	b=Bkk3YEC8a2XMlF+cro+Fiio61uTRWMLoWTL6OsE7PjMF9tXJYv/EHVfOdu89voeVzNUjkd
	5T3z73C5GKCFKQKz1OX60ioB62Ies66O6dgp5jm+UfuB0j5KnC6S7HHKjZGCYkliQdPJVz
	ftXvmCyaIDZKc0ZHcBuHgepL8GUmAU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-EThsHPc8P7C4qb-Rateh6g-1; Thu, 05 Feb 2026 02:24:15 -0500
X-MC-Unique: EThsHPc8P7C4qb-Rateh6g-1
X-Mimecast-MFC-AGG-ID: EThsHPc8P7C4qb-Rateh6g_1770276254
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so3791945e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 23:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770276254; x=1770881054;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4f8mTigMIqXkFwFt839fQ3ocfQnHUH8K1Gu4Z//aYps=;
        b=iCrUv0gCSaaJRHvUaFjdaryD+2QLQ4hpUadMXREViOVeevbyBkj1E4tSJZCA55MdUQ
         0tpuoJpPHsPyrrzvd8Nt49thTiYpou/LQb9un2LsLPaXRsykzW6tu+sqZsNN+LfsU8us
         PuNoDfyS6YedRe7mTYrQSQa5dppza4S6NdDSRz1RtmGkyJfSi0TBkLbV6XXDKS1z9DVS
         EjuUKTQNOrQhqbnTpJ6phN7QnNt+hDNyoeod4CT+a2tLuIifdFssZl5XIz+DoUm7D0LR
         8rKReCabUTSQt+bGh/tlFySbc9OrXRVXcrayyMaqXg9fjg+zcbx+TrBs19mPUN2uASa2
         rTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXVyeK09ZXNuM2SKvxv7ONYENlJHxWZXj43LQqNgnRF+qzXz7mNYMf6xIkX+38Gm34LZWXNRawkAwUdC5yXasFd0pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuzdLt8aICaRm27INqlGV61StW9HzLpRNgeNSHdDomB3eUEPpB
	zIbq0DCY2IdZQnuBCH1g1rkME3t9SkTvsJW95Acwv9XGp5dos4mcD48gBmK14j3OBguf3L8rClW
	/duxyKVC1uvZcePW7g2E3fEO/TpfWk9suY3DptRhKjjrflXgEBsx0NC1sdUYO+Taz22EE71F7Sw
	==
X-Gm-Gg: AZuq6aJhHjBYm83ErlrRG4GYwYgPsth+l08X5J18YEFtHKnBjM1Xoyh22riTIjXuPC+
	jf2fJgQ8IAW3CrMmNXyZBjGiiT7oma3ZG3BLFtwO2y/u8FUwtAHisA29O+eDoG+B9MKNTJJEJYD
	rYZROqlY8p92EpKtrxEf4RKMayKasNSuJaKLyEJnmls2Re/sPCnAaUMkhKri9L125q3J01snEEr
	c5gXt/v7MOuuyDbhhVszPaFIYk86Jxvw24Q+eyJyqYjEUwHC3rNe9+zvryMU+aUKln+fub6+ekC
	rZW6MxpqF/A4Rb+4/KYU95Sgtbi8i8S9WFyHb9dTBAkfLUCgIXUT0KahWBPTGhyLhVQc4UNWxaM
	zc6PyDfSYCKKB73umQEb/Ex63qqdJNmpqDtvdnFabNby6jDmL2EuIieQbbEPkWGTMBL3qi1J7er
	m7AWgNA3WL
X-Received: by 2002:a05:600c:19cd:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4830e950d34mr79235885e9.16.1770276253691;
        Wed, 04 Feb 2026 23:24:13 -0800 (PST)
X-Received: by 2002:a05:600c:19cd:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4830e950d34mr79235605e9.16.1770276253302;
        Wed, 04 Feb 2026 23:24:13 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm39046345e9.19.2026.02.04.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:24:13 -0800 (PST)
Message-ID: <7b35a21f1b85e6510b3653ab520920e459160679.camel@redhat.com>
Subject: Re: [PATCH v2 19/20] rv/rvgen: fix _fill_states() return type
 annotation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 08:24:11 +0100
In-Reply-To: <20260204144914.104028-20-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-20-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WJjJM0nBWErRHsERCESSy1ituG-4TeHHq6T_4GjENok_1770276254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> The _fill_states() method returns a list of strings, but the type
> annotation incorrectly specified str. Update the annotation to
> list[str] to match the actual return value.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---

Looks good, thanks. I would keep all annotation changes together (i.e. squa=
sh
with the next patch), but if you prefer this way, I'm fine too.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> b/tools/verification/rvgen/rvgen/ltl2k.py
> index 2c564cc937235..de765b8486bd1 100644
> --- a/tools/verification/rvgen/rvgen/ltl2k.py
> +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> @@ -71,7 +71,7 @@ class ltl2k(generator.Monitor):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not self.name:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.name =3D Path(file_path).stem
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def _fill_states(self) -> str:
> +=C2=A0=C2=A0=C2=A0 def _fill_states(self) -> list[str]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D [
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"enum ltl_buchi_state {",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]

