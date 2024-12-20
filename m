Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA97210FB;
	Fri, 20 Dec 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712416; cv=none; b=uD8IAVPb/M6xUc3hfu+HE+sITTpGn2qsohiaM6GBJTUsDTCoKpbXyx0PmFTZWEZQhn6dWMrvwh0eneVjYLPyDzZ6z/nD2KS47ePFX6TyPWS8fxsIUFkFyezOubXjzytnC8rHodZfP4ymaCUwdmEIhKZs8lmd4CCFkcQLSG0Qo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712416; c=relaxed/simple;
	bh=7s1ukD1RAlamqbSAa0jAt8fFpg+XU6+ZoIYrfchNtsY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OIZBHT1e7Zwf5SPWxGeeoZkcUArl8ykjba9FS2DNog+fGDEyzk8rcFKmUgtkJ5UnxwazMs9aAWhhzghZoai8HgkRC33wMX7LYMkCxKrmE1Dva52g0Hje0ZRONaseF3IbtwqR7DZ+AF43yz91bZauHgU7GStG0M7thW6WRy9tQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DYOG4nd6; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DYOG4nd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734712395; x=1735317195; i=markus.elfring@web.de;
	bh=7s1ukD1RAlamqbSAa0jAt8fFpg+XU6+ZoIYrfchNtsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DYOG4nd6D8yoHO3K6EgtPg0sDpggEOSGaZkhyIkBWDvCD0xXTZcC3JmtFWpkatxg
	 ZRdCAr6WA4MuzQwWR/rK1gQqIEztiGQ1wGx/bJ4NXIkUiMGcNDiu4XWuNrIns2lgN
	 iQse/3iOhGewg4nD58ykOeQoaZUmN4SnMAZQVXWr59UypSnEGYENProHt5txpPQII
	 j70/rbqaNe8+1CW4CexhODyHtZpuYUzJDHr/5JeOnYO8iAhlfu1t5g9nqgDsG90tw
	 1Akv7ARnyibBZ4tdmSnWBAiAGv7TrZcIx0Ln2zRedOWlDtTdhDsW0LOyJa1OpKXhu
	 GX1FSbzToDVDLlOk3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1tmEAX29Nu-00rCNh; Fri, 20
 Dec 2024 17:33:15 +0100
Message-ID: <72d98029-6daa-4eeb-b1c9-10e8183adb74@web.de>
Date: Fri, 20 Dec 2024 17:33:12 +0100
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
References: <20241219201344.687105470@goodmis.org>
Subject: Re: [PATCH 01/14] tracing: Switch trace.c code over to use guard()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241219201344.687105470@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tm7eubnFtAb1P8r7g+9XsgYhqZha4SuO0rMWer19PiC0xBboh0F
 8fGj3WhD2HtqOfSRhrHWvoHGTPvQdVP3SGoGT5ewHv1XGguMONs8qAKhhEQCQKHBZgpXP4b
 +OQAYvkrtOrd2h/WDueHxqv4DHZYUeJPk/aLjvPe89ZZ13zU5lQ2iifWRrpbsQJMGozq1PU
 AcYD2u7GAQ20i28KSjsBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lBN4jY/YM9g=;nYoa/XE7hWhSr77bgN1SL/7vbeh
 RKa7fostCQyN0rmydMFu4yQg3++1pAedwPTNj+YVoQOln+6TQVpoFaUNoYEXIu7oA6qKRRNVu
 dxzjmSWpnb27XyIF9ObMeZwfsjfUfk4YgMFnaJpbnl6put++5U5/UvwxtUA2rWGVM76jfcTFB
 SpGYdUJICLtgmQmOnMrLoFWSTZ79NJXgWxgl4pmeOi+yYeeJxWnqxx0aeF8XGtIQ1iIozBBxs
 DOhwgiH83GijnAdfZlD8DZhbWfRfn7FPuwkb2EG3SaN7nRGwlYDg81CeKdGhL0Gq9K2TWxAiI
 v3zu/oPUugX5MEpfbraTlM1Z5+4cMkNDXDcUu7X90Ssrb+C3Ocn0Fbi7wp//8OrIuPCHhtSKT
 CIXqc4IDpRJBSNBFLl8+7f/Fu8bHrsb9Ha7X4SewRGCIfZ5XmQUg/xuvVhmuBGgK58SA6v0/a
 JJbLP0zZ7RAljsrB1l1RVme7BGv9pRSNx8GAkuRA2B6GNwDwLUfg62E67yUoLdJyPv/2lc5zq
 U56B2Y3WfGmSrGIxl5x/ayEwK/I0ltJZbWPZ0yaMZFHs2Xd/RRBKADY3Ifrhf8jQqqtMFFkmA
 IL9wZ0p3yAKhIOxm/4R9XEdJZvQpsyKsq0O/NO3gjw2UD0WJdn1HL3UPjxS3JcsyxToHGu8Oj
 ReiT8Tf14symxAckz19Y8yO89azzAurLOS+ToA+hwfzssyhxpDcx6rNqw8hp50FquX14fU/sx
 z2WfCAiZiHeWswvgTJBxWVSEVhkL5CYNTU4VqIW9wHNQxhqJ4AzrFCeoCEnxZ3lgDMvAwWVNM
 t/32739/vIkhoDUD0cp/ftfkkiRPTuJmlCiBT1SpNc1KwioJOGEDFP9tRSjQqkoCyBSDI7/aG
 r+qh7A9J3PgNAHNSW1Ksqf3gJnQxnAdIe1LWkUVfZoRxsj9G6PYLwTzRBFkvQM1STu7xl3KFi
 9SinroTLkPrqtgKsFfQpwyAImUZg7y9uuFNPe9x08uoBhc9WlhCmOKm0ZCWAyqUVUs8YhY7Rn
 YR9st6TjXbZSdBc0/UR5i8sLD8fRVWZ3yyJqKVCLeBDK2tuy12S8NCuVMGz/6jo7cUqew+TUa
 n/8h/Ducg=

=E2=80=A6
> Switch every location that ends with unlocking a mutex or freeing on err=
or
> over to using the guard(mutex)() and __free() infrastructure to let the
> compiler worry about releasing locks. =E2=80=A6

Can it be safer and cleaner to split adjustments for these programming int=
erfaces?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n81

Regards,
Markus
