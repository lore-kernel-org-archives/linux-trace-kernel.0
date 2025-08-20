Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4972231826;
	Wed, 20 Aug 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678618; cv=none; b=fP8x5VCEK8F/1J9EDdw1GQc3w4Wjngsa6fjW3h1q2MixtH7EffaWHa84XXHCj8CbokC2R3kaC1Y5h5Kjgtl3Mm2ghj0eDkp7gwj4lcxw1PRnsj3Yva3OQe6phDIIcqhDy9s326/wg29OAOr/59qhRWWf7tj1L7TG9di+IwI4urE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678618; c=relaxed/simple;
	bh=FNwDWm77mENGZsF5oiL+jLkr8I6XjKMJkanIdlVb2vs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RcwOu5UswPyZ5c3bFmXrIhqe+do8rb9zxUzxQvf35rlg0/D69Kbs7rz76wlaUTILEr3GhxNVDEpyHDOZOAo+9+lf14bVsqtM+n2/spnrpZxBdayBNl4likDjKN94SGQ8tPjFfN4N9THSVy/W25vCfjt6y3aqZv6Jd/Ro1NOBmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A24502CE348;
	Wed, 20 Aug 2025 10:30:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ASXCLEDPmnkd; Wed, 20 Aug 2025 10:30:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2A0C42CE374;
	Wed, 20 Aug 2025 10:30:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id STTOJMYm45J3; Wed, 20 Aug 2025 10:30:13 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EEAD82CE348;
	Wed, 20 Aug 2025 10:30:12 +0200 (CEST)
Date: Wed, 20 Aug 2025 10:30:12 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	mhiramat <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	ardb <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, dave <dave@vasilevsky.ca>, 
	ruanjinjie <ruanjinjie@huawei.com>, 
	liuyuntao12 <liuyuntao12@huawei.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Donglin Peng <pengdonglin@sangfor.com.cn>
Message-ID: <1362230792.146894.1755678612763.JavaMail.zimbra@nod.at>
In-Reply-To: <1672011332.146872.1755677514318.JavaMail.zimbra@nod.at>
References: <20250818103931.1100084-1-richard@nod.at> <CACRpkdYYTe0YArbheo3msd6r+CNrt9oSZWNjkiwb=ZNWfJ1dkQ@mail.gmail.com> <1672011332.146872.1755677514318.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
Thread-Index: CVXhU17DidlkWtQ6Ka0vacHBgIlQ2GnRE7g7

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
>> Can you put this patch into Russell's patch tracker?
>> https://www.armlinux.org.uk/developer/patches/
>=20
> So far I had no success doing so.
> Whenever I add the patch, I get back to the patch add form without
> an error message or such.

Worked. :-)
It took just some time until patchd's mail arrived.

Thanks,
//richard
