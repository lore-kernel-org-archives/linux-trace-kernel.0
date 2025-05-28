Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D8286D48;
	Wed, 28 May 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442411; cv=none; b=ui+p3AlqsNVFtGeiPlDWDbddEY3vRNibXvGHEOUZzcEas/rFnfn6tVJWRJq81PPqyAgqNo6jnhJkRzl5XyaNptA9Q1CHkllnMHM3dv+DqVb7af+q19IyCIymf0RqYJJ/ekAU3hLKbB0smMGDbTvC2QRgjgqGQe9EP++qByvW4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442411; c=relaxed/simple;
	bh=cS79qCw02W352C4o5afUgwhUGwcsuYgeRjXGbXZOI8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vn/W5ZzvVs5ZkJXMTYcyekfWBCie9Pn9TQHzKZqVDTAGpRGcPxmEa6fpe08UcqvUsduLRCFZb+fGR1K5I7gqhz8MRWCDWQzTgM0X7tJMeAISC4QlUKw8QroofdKvFDRNIE6upVnhyaZpYLchZP50fDnrXske7rj+pV37Kvhp8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=iiHSrwGb; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="iiHSrwGb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cS79qCw02W352C4o5afUgwhUGwcsuYgeRjXGbXZOI8U=; b=iiHSrwGbrwswQJmrXNS4YYn773
	kGLotIEZIyAPFV8+h+WqbAVM9Bl7VS9C6jzQMLjg0b/NaMXooV9/Hfu6ZHAo6k3V5K5yLGZOsa11/
	SseSd9Q9Ej0iFITTMbX/T6xAQZw8L4m+yel7ystwEK0ly9rnzKOO77DHCxkgVOSpT0CT04p9nOwWi
	YIbBTsQMz65FhF3aTl1bAnYIGaWo/vME4yph61afiuI2yeK50NqkLOHrB6kk2C/WvQftYkwJWu7+C
	oPtuNEymkRDfACZXLRPUBJFG4J2O3kIzsg2qPB6y8Ml/EL8g9K1UlWZGfcjGkktRVnV2UIM9PhLjj
	cGLZePeA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uKHjh-000000000tN-0jg8;
	Wed, 28 May 2025 10:26:29 -0400
Message-ID: <05b6280b2550011623a433017baa8f17bc83fe9d.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
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
Date: Wed, 28 May 2025 10:26:29 -0400
In-Reply-To: <20250528-tlb-trace-fix-v1-2-2e94c58f450d@columbia.edu>
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
	 <20250528-tlb-trace-fix-v1-2-2e94c58f450d@columbia.edu>
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
> This has been unused since it was added 11 years ago in commit
> d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").
>=20
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>=20
Reviewed-by: Rik van Riel <riel@surriel.com>


--=20
All Rights Reversed.
