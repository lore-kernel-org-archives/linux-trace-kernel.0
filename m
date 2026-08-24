Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C63B42CE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566112; cv=none; b=n2hMuq4x4jzpa5rkgeOoAusthQD5FuxbQbgBYXftYUZR9neAs6Q6z6rMzhqeiYuPkqGIdV+WDTWK62aiEfVAFq4CV4Bn5c2JL1Nu50A6PkDWfzSZ01W44wETd8pemszTvoLWsodGi6KLmksrkk8wBCAsKfdCd99y/NP4QnBlM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566112; c=relaxed/simple;
	bh=QA3NnOYpbUT4HJtn2TrtO+2Ug+lASks9+L9s89KbLJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEue4L7UTpU4qlM+OG7KdeZu4ReVS7DlVgdvnPPtxnhiXMiXKugKRXLxX/d9rA0JMFQmnfkK8+QH8Z97zYHY2bcyf157cPx6/pOjlypHBDhQk4h/RUsMPLuJ5M3mTf6JIasRCReUJMkfyCYvN+ZpU7OWCTunQ7apGCBK3i7tueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG0PqOj+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG0PqOj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787566109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QA3NnOYpbUT4HJtn2TrtO+2Ug+lASks9+L9s89KbLJk=;
	b=OG0PqOj+F0AZTGcgRNwQmPQ9kDMG+OiFJC8iukqBeQnrw7k3iMl94mRqycOk6FBsjwUuhI
	kYljRwjDNXvJwqLoDW9h62zm8/gwkZ5NLBFgrp3am52pv2hvGXgWP1CPwtcKa7/9O+XCO5
	61JY5b6H5D+ULI4F7Guunr/NBFC/SFE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-eNtRQhDPM4ykf-12WK88LA-1; Mon, 24 Aug 2026 06:08:28 -0400
X-MC-Unique: eNtRQhDPM4ykf-12WK88LA-1
X-Mimecast-MFC-AGG-ID: eNtRQhDPM4ykf-12WK88LA_1787566107
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c16740eb587so243728966b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 03:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566107; x=1788170907;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QA3NnOYpbUT4HJtn2TrtO+2Ug+lASks9+L9s89KbLJk=;
        b=VUbOGlSz7xrv0lXif8MUcLfAQDgyc4+vMgUOHw4r7+UfDrohrIXuKFLwkgRaKprURh
         8MJQzxEdorrTpBJCusZuD1yvDOiu8Xclvg94qvWWvTVM124QHJl+5jJMgF95lVBA0HIj
         TjN9FVzuzG5m4SApeQI/PvYS/yIhI2uHw5VBqkJTzAQt+bo/R5V2nQ26rxNuN1mjBLlc
         E+cNSVBUxxF/uWSK/dbBbwxyQ04R9P0A5zbeaKA+DlshegEwN+h33MXHNRnKGWyspYPG
         Q92HdBu3rsx3+AIMg6sUMZLT1glfWPKwDoIF7LpI0wtkR4/z25mQVrWIc2BROIeNOPD/
         g/pw==
X-Gm-Message-State: AFuF++nFdB6CvYkJtNV2a6MYrtoq1ejk21Jq5xidYETdSX+K+qntxyrV
	PNLgWx1w/tpIVLem3AW4WYzdGZQ2pA7SQ08Mqo4B9ze54mGoX3bOlLBi3B3zDeG9J9lVA6iN/5M
	uGqVIbObr97MzLWSQGedHKrXiG37stVxnsyJcTKAmWJY31TB8zPbH+mUq5aBbJtkhYDTt8QzGcM
	L5ezuodVO5
X-Gm-Gg: AR+sD13PQLaSwdqVQewGqMH31Q5LokAHCdJxEP4hvKxzStO/TX3Mp7FZfk3KWiI/fkP
	S96hP61hVDOWs1wOWo05RkxK2OHGmrJj3J+d/gRHiGb1BcWpw0Lwe5heh8pVNSprAAQjlJ4s/PN
	hhGre6Rs1H8qHS+qNMTSxG+y9PFRiXQSmApLMBZg4mFLqmsgmPox4WeB2XinYuq2+wRdHJ48/Yn
	kcZhPhwOL4qZ4ECKStKSYLHVQu87YxBfGuTEfYB/KB5rMFxwek75XwhBP6hgZ6oiLzmcgNcCyTe
	FAFPm1ZQSOMT0i5xrks+Viz4LOV0xB6Tc5t2XtR8tYkvqiDjfniIiom0EqWtuMGVd1ILjBCjjvy
	VUdfy+U4SibOCcGw8lCBl7hivY4ucQQFWUDp+wF2vFa7Ct0Kw3HqXJGPEL9kKVXmazBWlWw==
X-Received: by 2002:a17:907:3c83:b0:c21:7584:fc58 with SMTP id a640c23a62f3a-c246a60cd41mr2821067766b.12.1787566107367;
        Mon, 24 Aug 2026 03:08:27 -0700 (PDT)
X-Received: by 2002:a17:907:3c83:b0:c21:7584:fc58 with SMTP id a640c23a62f3a-c246a60cd41mr2821060066b.12.1787566106658;
        Mon, 24 Aug 2026 03:08:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249686e37bsm1134441566b.55.2026.08.24.03.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:08:26 -0700 (PDT)
Message-ID: <f70d634ff65d6b1bd61c4ae517cf522881a23c61.camel@redhat.com>
Subject: Re: [PATCH v6 9/9] selftests/ftrace: Walk up to find
 test.d/functions when a subdirectory is passed
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 12:08:25 +0200
In-Reply-To: <20260820165819.5CCC71F00A3A@smtp.kernel.org>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <dc58717cc225389b041dc36c684df23e3253c473.1787243842.git.wen.yang@linux.dev>
	 <20260820165819.5CCC71F00A3A@smtp.kernel.org>
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
X-Mimecast-MFC-PROC-ID: HY_jJGtK2U0pSwStqY_-2uxf2--uN9MEPWKMsj9WExk_1787566107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-20 at 16:58 +0000, sashiko-bot@kernel.org wrote:
> > +=C2=A0 if [ -n "$OPT_TEST_DIR" ]; then
> > +=C2=A0=C2=A0=C2=A0 # Walk up from OPT_TEST_DIR to find the nearest anc=
estor that contains
> > +=C2=A0=C2=A0=C2=A0 # test.d/functions.=C2=A0 This allows a monitor sub=
directory (e.g.
> > +=C2=A0=C2=A0=C2=A0 # verification/test.d/tlob/) to be passed directly =
without placing a
> > +=C2=A0=C2=A0=C2=A0 # dummy functions shim in each new subdirectory.
> > +=C2=A0=C2=A0=C2=A0 # Security: only walk within directories owned by r=
oot or the current
> > user
> > +=C2=A0=C2=A0=C2=A0 # to prevent sourcing a functions file planted in a=
 world-writable
> > ancestor.
> > +=C2=A0=C2=A0=C2=A0 dir=3D$(realpath "$OPT_TEST_DIR" 2>/dev/null || ech=
o "$OPT_TEST_DIR")
> > +=C2=A0=C2=A0=C2=A0 while [ "$dir" !=3D "/" ] && [ "$dir" !=3D "//" ]; =
do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -f "$dir/test.d/functions" ]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Verify the directory is n=
ot world-writable to prevent LPE.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirperms=3D$(stat -c "%a" "=
$dir" 2>/dev/null || stat -f "%Lp" "$dir"
> > 2>/dev/null)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$dirperms" in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *2|*3|*6|*7) ;;=
 # world-writable: skip this candidate
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOP=
_DIR=3D$dir
>=20
> [Severity: High]
> Does this logic actually check directory ownership as mentioned in the
> comments?
>=20
> It appears the code only checks if the directory is world-writable, but o=
mits
> validating that it is owned by root or the current user. An attacker coul=
d
> potentially create a directory with standard 0755 permissions, plant a
> malicious test.d/functions script, and if a privileged user or automated =
test
> harness runs ftracetest against a subdirectory, the script would traverse=
 up
> and source the payload.

I'm wondering if this is a broad example of root can shoot themselves in th=
e
foot.
This is a selftest run by a root user, I believe they are responsible to
validate what's running isn't malicious.

I cannot picture a case where a path is commonly world writable here. I wou=
ld
keep things simple and perhaps walk up at a maximum of 4-5 levels
(tools/testing/selftests/verification/test.d), to kinda make sure we never =
go
out of the repository.

You cannot really rely on git (may run from a tarball) or other static meth=
ods,
but I believe 4-5 levels up will cover us just fine.

In my opinion all this stat/dirperms thing is rarely useful, you could just
write the concern in a *brief* comment, saying we trust 4-5 level ups are s=
till
in the repo and we trust the repo, just to make AIs happy.

What do you think?

Gabriele

> Additionally, if the stat command fails for any reason, dirperms will be
> empty.
> Would an empty string match the *) fallback case and cause the script to
> silently
> fail open, accepting even a world-writable directory?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TES=
T_DIR=3D$TOP_DIR/test.d
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dir=3D$(dirname "$dir")
> > +=C2=A0=C2=A0=C2=A0 done
> > =C2=A0=C2=A0 fi
> > =C2=A0}

