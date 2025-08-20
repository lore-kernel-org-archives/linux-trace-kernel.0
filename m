Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9B2D838A;
	Wed, 20 Aug 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677526; cv=none; b=ZoEs2Y5ugaNMNbh6H85YK0eEn7JgZiUDWAcVURmnEoJqQn3Zl9FniSNDZj1oeR/NL+lShBYg2OsGL5T6FJ+36bGVp3DlWWWpht46tn84qjn/2fe3EUwEU4ywpfdSMogjvEYIe4L7sErbJcqICZ0ZtjKV3Ao2OD5BZyPmE8t5mmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677526; c=relaxed/simple;
	bh=5ffBfXfkWnxBLysk65/GWI3ham98Fz2RAzunURzEpHM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=e1um4uDicAC9MhzQat0Z+p8IZxWng8+tCNHKjJ7Gs2hzD3m3SQXzgOpxM2kNofUqoeTboa96i6hqsy3MBu7MW76SzVtJqq+AwnJn3EqFcTQSMDCvmL4ZJPEWN+6z7E6sLLk1GGW57zzwqK8vqRqVO1Tm6kDaBdGAX/cLVafjeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 183792CE348;
	Wed, 20 Aug 2025 10:11:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XVIhD7bjm513; Wed, 20 Aug 2025 10:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A84F02CE374;
	Wed, 20 Aug 2025 10:11:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ObgVaPfNnbRa; Wed, 20 Aug 2025 10:11:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7C0032CE348;
	Wed, 20 Aug 2025 10:11:54 +0200 (CEST)
Date: Wed, 20 Aug 2025 10:11:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	mhiramat <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	ardb@kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, dave@vasilevsky.ca, 
	ruanjinjie@huawei.com, liuyuntao12@huawei.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@sangfor.com.cn>
Message-ID: <1672011332.146872.1755677514318.JavaMail.zimbra@nod.at>
In-Reply-To: <CACRpkdYYTe0YArbheo3msd6r+CNrt9oSZWNjkiwb=ZNWfJ1dkQ@mail.gmail.com>
References: <20250818103931.1100084-1-richard@nod.at> <CACRpkdYYTe0YArbheo3msd6r+CNrt9oSZWNjkiwb=ZNWfJ1dkQ@mail.gmail.com>
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
Thread-Index: CVXhU17DidlkWtQ6Ka0vacHBgIlQ2A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Linus Walleij" <linus.walleij@linaro.org>
> Can you put this patch into Russell's patch tracker?
> https://www.armlinux.org.uk/developer/patches/

So far I had no success doing so.
Whenever I add the patch, I get back to the patch add form without
an error message or such.

Thanks,
//richard
