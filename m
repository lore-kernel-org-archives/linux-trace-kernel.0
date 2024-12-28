Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4493594B;
	Sat, 28 Dec 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735382473; cv=none; b=GHOKoWUyK05Zu4w5HNcAyH6DykxnX3qZSBdCFpSygC6/XVN9bO31kYA7qxhLtApvGob/Zt3gb1U6zM79g657s+Hak8bPZyaWTYzVt6LFgBoqRSYhXYktPgTOCsGa+rdgFnKkJwoeNZFGbk45hvoVE6boG+OU/zOvR1lY+5909gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735382473; c=relaxed/simple;
	bh=3INcNYmP6edgGAm/+3hwBZjwkbUjpK32d3HL5slKMGc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TivtoxgV0X5KjGOzIdgtYjNTrzZVcsMNneFe7crPkS+AcGWh2p3aJev0RwAoFrZA/ZPrdMadZaInZ9jtzahOkr1fJ1wIAio2STF9Hjbnc4JxrbmKot4R2rCbAq7x121MAbbSyRx+CoZwyk07FsBDfBEKrQgGFSJiaVhK6HZgJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eFMHY8UV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eFMHY8UV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735382453; x=1735987253; i=markus.elfring@web.de;
	bh=GC2Gww9wD9CI4B03w0CRv60JCEdqAwVmIK6rJJa6uMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eFMHY8UVBcJ0fdih/qbdX6e1wnFrHkqRo7+AFLYjtxGh2UjlHWZ5cNS2eayXFHry
	 oR4qAH/6CqYMH+SdHBr4Vdungs2zUyp3v9FPqgIIbTnyhQSJt7jTMGHvXVhuUzXOi
	 hKIcDYQnQHR+iHutAGsMdReSpq458cDiNUqs32NazxuYPrbXVz0uFeno7TQAg2A4R
	 08yJo2iVidQZiDBoHoslGOK/hfBC1T1+AxPfFfdRixUBkkEgHdLH+aGBcFp+2iPp3
	 EMbDg89uETY6s9x+irap3YKhVB/LAxbTczl17d9yM277DuYLcfIzkgJgzZLeLn2ye
	 iNYwAbYAPXuc0EYUgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1tdfle1bgx-011tsT; Sat, 28
 Dec 2024 11:40:53 +0100
Message-ID: <d87cb12a-db58-4ff3-999e-c99839524e8e@web.de>
Date: Sat, 28 Dec 2024 11:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241226143934.814245543@goodmis.org>
Subject: Re: [for-next][PATCH 01/15] tracing: Switch trace.c code over to use
 guard()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241226143934.814245543@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l9NLeXfHX28bIzveKv2Acmo4PWYKfCGStf1OnVND7UBuOVMqbX0
 Hp1Xp3s8MJK9d3PdHRWCWR+gfJ8HRTKaLH0FmWXlkMyxzYxT1GGXY7ZqrfTwwXTe+9sDhFZ
 JbZ4BCAy71c+lIPHrTGin0ttEtPl6cemw6yrDtLS1mMSAPijhfpZrwTpOvwBYp2yqVjqaW4
 gj7tu8aCKQ0WWzfenNflw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WgztrJ/P9ek=;3FWwXova9ycPpTgOda3kL+RPlkV
 C34gsw1u7XtIAsYNL5jnCddFMppqkSxn9k1OggB7vegipwIc/GIbehf94dpJEPDvLtkYKOXkb
 uBt2EdX/NZ7UoYshyeTOY0dI7FggEGZChH37LV49wNEqnjE9zMe9fTxfUcqxnavPWqrfDyusR
 K0SfvS2TuKk1wfaUqlEyRHYMsp5WKXL9I3n1tvw56MaPaonXAtmPh/FiM+Ln+dq67NPcHNqxX
 5jPV8qHwDiYhfm2BfdJALqQaeY9X2vCOIzysorfyK0YVHSrsw2t+7ZKjs3ZSkIwTVjwvwcuZa
 2wes+6MK0Zz/sxes/f5TMi1+XUcrshT1BKKzr6hPmByo3Znr5sqPqEZJZO05vsZXCBQbthEw9
 Tyc57WeM9SxFqIKRQh3gGAi6rjMJanrrIjm2FqQZQou0zEZJr+st1SPq9Vi/2vWGcyFBvF8J5
 E+YUfBsAZjZG6ouKRjnPBjU5WOiWnU2CKUG1e/eiVExlQlZoUroSX1Zi/4v6Xmz/Gn5IA8GU1
 d9KnUZGQyAKaRVfUWklseL0s654eM8jDHd93bq49wxC91UJj2ciINYk290ZO1wDbR495o63Jv
 7ykG0dhEutSLM2/eLFRIascRrmEO+vDdxfrFy5z/J1l/LysmzLotbv5wqRDCuGlps0l868wyS
 BLmpMCaGreRQxBkMaK9nleHunrAqcWlWlBOyG0gfBUgJBumYf8omCpRvHLgOTGgQbOooyS9Cl
 I22l7jgYVl1qTNPQQJm2gI60Hroixrl0ZTz2PRaLJy2HSPUgD2nJmOq4Dg7OeUNmkAlOUja8M
 Kpj37noSK2Il64pdAu01JFePXPXoxu+7LTm2cJwzCuk6R5n5dnRac3Ixk5ML2eqVTffhN2YIP
 MtkJcf3FwfVj5LVf+S0c+FkcmoOCvQD3bDQkeLSVvAssfzYHSkwTRQYqxpq5maaYOgLF0D98a
 iTuETWesIHuLV3sm/6Fi3F+p7kV2M6eyCkZITZU/at71EYAqM1lPBc1oSeb352uviT6n5hxMN
 QekQoXDKu07CS0P+epAiqsCBc+l9PlPVRXGCdIxifvJbKFhFC5K35odHFEYNg2fyOFSinhMDh
 9IhfL9WxA=

=E2=80=A6
> Switch every location that ends with unlocking a mutex or freeing on err=
or
> over to using the guard(mutex)() and __free() infrastructure

Do any contributors find it safer and cleaner to separate adjustments for
these programming interfaces?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc4#n81


>                                                              to let the
> compiler worry about releasing locks. =E2=80=A6

May the compiler take care of further code transformation concerns?

Regards,
Markus
