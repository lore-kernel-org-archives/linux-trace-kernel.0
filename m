Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE9433A4;
	Sat, 28 Dec 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735394905; cv=none; b=R/O2QT3BFMQ/e2cL2g5M0UgFdkDko8vyH4/b7PBFKDDLcEvUjvgFCVxMA40g8FEOrE5XSP7KjWJIS2tfwTyNRigumiTdBM7BBmv+qPH0RdP9lBP6a46BhGL4HJWH0lfGuVYgHO0zTJb1Bjj9x5meB974jLvybZrMaJsE56AIjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735394905; c=relaxed/simple;
	bh=KY+5ncopo0B9w/h2AXCBSG5Sj+88kby9x2TNQ/JWVwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IjDfJaIhEDgHdocaZharb4I4s2zBhl9Di3PNZ4Yml12K6deT44WwQWbtTSGbR2mPiSGztKavcgK711SZCUABUlzl/xyavNogxp99am6uK0CmDST7YXGe5/L9ZAWrGLmQrNUgsA4N+l+aAlYYaL5AuRUndtJWeB+86AtEbhM8Ecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h+iX4fOi; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h+iX4fOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735394901; x=1735999701; i=markus.elfring@web.de;
	bh=KY+5ncopo0B9w/h2AXCBSG5Sj+88kby9x2TNQ/JWVwg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h+iX4fOiidSsVuU4fLF9doaSmcOLlClBDrPpRdNuLZWZT7umWu+Z7EjIqiJNu0hB
	 wEGDPn1M/Vnqsz+yaLmuCPjg+ppw9d4DrKDjpQREq6EWQh2kGrNl/e5X1IA3G4kAZ
	 kDa6ykrtpw7UE3gUJoJql4xBgSVktl7jLds4v3lOKkQw/XNLWrypTVKyXLl72IcWH
	 uaxkWunYEAsosVUf/9Pg4lDc64/HQPqDZqvQ9R6W9E9Qsv56y/d2rJxryFrUI0VKF
	 FUtwrb3mKauVkGSixKqdI7SP+Kua2R1t1JkB4W9af/IfWm8LHaSFRd3I4GJUhiWjR
	 z6qIjn3vYxCKG8bW/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ISr-1tP4wZ3vcN-006KV1; Sat, 28
 Dec 2024 15:01:52 +0100
Message-ID: <9a0cb3d3-3592-40b4-a4c0-85ed10e8dd98@web.de>
Date: Sat, 28 Dec 2024 15:01:51 +0100
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
References: <20241226143936.513295476@goodmis.org>
Subject: Re: [for-next][PATCH 11/15] tracing: Switch trace_osnoise.c code over
 to use guard() and __free()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241226143936.513295476@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QUdli6sbzA9DxMcsCoZ7WuqL+w80svaGbndDhnhZqbuYbnAlXq+
 VyJV758lgHpFzM7xgYqKhmG2hThsL7npUNHHoaIyzJIlXeAspr61EbjTgOKnEJbR/GFPBf6
 aHjbWh12c6uij1U86nwjLSfCoJ/pgA4BTqUVN7tL5Nzb5SyODUG+YR6ZX0kHfMyRg14/cHa
 VZ2Ucg836h8yz3Z18Atpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kUfVazvgzXc=;gHXehkplLVye4Ar5EOOhFfPK91j
 E7B/EiXv1ZjURSpqblZtwhn+Buoh65nApWJn6NfMyJma+8g7Jy1nlKtypSSsC6JyuSzHyLmwG
 FENvlsHp9ToiyeGLbBJa2pqiYcNWAUCKAgM6DGUqy/NsYwwtw0JDrkwgU6kU1xjX0HU5jx1JL
 JTOzA0TwDd8V8wFrcAgq8T2TaaFUaIptgwnnSBIgeT+JEJsDjhdfFTEuUW1JdXnu+dWIbvCQM
 vzM9JRNUugLEhL6OPFj0vDMVpT+CaUIHTIj8MPSoED2gNYUoSwj0ZchNXX7IUZn5xWP331OBg
 hvin3QZYVhvdvbRjDLmUiyVOMGd52d25X+yxApnd57Tv8LIWPaVjFTph7urErsaFFxIPBnS1t
 QnC2frUWfGUl7Va11uyG5jSKhM0kh0YSArKS5T+uQb3f70L/NMOe23OnUR/uJC7tX2+QOdilT
 NE3FCV5BaOiMGHfMzcX+5MlT8JCWxCkYof6h0mPikwgTwnOuKKeVqqPO6VR6Er+QQFhXE1UPQ
 2ME4p5ZE4saOZot3ML4rzHiICYHFKFug3LWRICsegFxgkMR2NfGBLdZISoPGWNrQfivTUYZEJ
 HL4bwItRQqTSuEqOp5HzFsO68MnolDOnpg5lCXURTqZnufBSFJqYKuRiklZzlj9RnSsa89TTs
 By1hyfE3uuWXQmNdZvFt6PdZsEkVG1RPxqc6igTgAo2SIzbZvXIecGe4Br9TcOB55gztHx/mQ
 SIjKBW5xzqv5ObxbSc31w9gU25SrkInMN1tJoeQaUQl6NfrGLRC9mtY3IDsfwZEYW0VFCAxGi
 7N/ZYvocThlkcQ1/Wq7PBidTGMaiLXFf0gxNvdlsB/HoNisK15aloXGC1sfT044+On8qfIDcU
 RFBqSQktP9UzuR+qqq12eDGn1NH/xskohs+hehp4txomuhu+Jk2jgFjjZUDd4i9AvXkgGVl3M
 u8HLNy7+jW53iBEKQoUbfgg8iaUnl1SddTKx9jGw8TKYBhnem6wk8EFpxHxkjMj2SFCfywF4C
 YVuqPHjkTpBRbFTxlXOMl3ByY7a1X7BV+jgRrTCtlR2VvJ0G6Cnj5a6FyJ7mKhGufgXDg3Ag6
 hCxqOu/EE=

> The osnoise_hotplug_workfn() grabs two mutexes and cpu_read_lock(). It h=
as
> various gotos to handle unlocking them. Switch them over to guard() and
> let the compiler worry about it.
>
> The osnoise_cpus_read() has a temporary mask_str allocated and there's
> some gotos to make sure it gets freed on error paths. Switch that over t=
o
> __free() to let the compiler worry about it.

I would find it safer and cleaner to separate adjustments for these progra=
mming interfaces.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc4#n81

Will code transformation concerns be reconsidered any more?

Regards,
Markus
