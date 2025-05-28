Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9613AF2;
	Wed, 28 May 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442398; cv=none; b=mpQFCnMe0rtMUN7e3Zkjh2w2wy4RrezvHWfg8dGtceQY+J8kgwmE6oGJT5u7UweFQtodu5JVAaCvK5QRxq4fbRRDoqxpdCocJxixRImZ7I51SrSAW10VPvQMyurCUUq7YlBgXKjutX8kpI8U9zZcoecVRh9mFGu9RWQ4zg9bbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442398; c=relaxed/simple;
	bh=g8gTRASmmvSsfuZwzuPFcSFC+02zA9q+IRn3Y7AYods=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XigXvJERqZ4GbXB12thWcACM22nzM4kMVhYFxgnme9sdHhIo+vyiGMiaFLOHe77IWDApyjJrvX2T7i0s89lrcbfto/NBWzIGlM/3VG5Mnbb60SUN9xgWoxD82zeNoxFpBZ5eDmxZ9tekXz3vW8Fb7bXLdTnWgAlMoDSsjtn/ER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=IDo7N+g2; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="IDo7N+g2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g8gTRASmmvSsfuZwzuPFcSFC+02zA9q+IRn3Y7AYods=; b=IDo7N+g2tDs+yPTInSf/SucK5j
	qXu8UivasSaNrRDtcv6nLuxf4VEwNySE17EcHfu3nNBhkZ0AY6fOkrGBz31fThJXI7nUSy9GGtJ6e
	DsT3LpdecwvvRjxt8RnV4D3QNmQliSDt+qg5t47i/i+PTEEo98YM/FWYdxHm3UtxEnkhNEb9o3zU9
	t4OqiA6ARR37gu9RYwGWCEX5aTd2YSpr9xjAF3Pwkxospgs404TLxdY65KGAhsVPMa1SEXi020KR/
	5wY86pEBCOY3ZFjmju3CnwKSAN7QZVnvMlZ01IyIFiJbkA8r42V+eqfPh0WEjmSCBv426xuXJ8GZo
	T+BtA8eg==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uKHiz-000000000so-1SBT;
	Wed, 28 May 2025 10:25:45 -0400
Message-ID: <43ae7b3bf94b67611069572b7e3e909a922c964f.camel@surriel.com>
Subject: Re: [PATCH 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
From: Rik van Riel <riel@surriel.com>
To: Tal Zussman <tz2294@columbia.edu>, Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar	 <mingo@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"	
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport	
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko	
 <mhocko@suse.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Date: Wed, 28 May 2025 10:25:45 -0400
In-Reply-To: <20250528-tlb-trace-fix-v1-1-2e94c58f450d@columbia.edu>
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
	 <20250528-tlb-trace-fix-v1-1-2e94c58f450d@columbia.edu>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-28 at 01:35 -0400, Tal Zussman wrote:
> When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
> tracepoint, the enum was not exported to userspace. Add it to the
> appropriate macro definition to enable parsing by userspace tools, as
> per [0].
>=20
> [0] Link:
> https://lore.kernel.org/all/20150403013802.220157513@goodmis.org
>=20
> Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to
> stale CPU")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Good catch. Thank you!

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
