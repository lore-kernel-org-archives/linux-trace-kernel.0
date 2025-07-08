Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981077E0FF;
	Tue,  8 Jul 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983901; cv=none; b=Lb0eCCK2M5vtyT64us0AP+1hntaPafovhMKLcqpy8IMlbQvvqL6h+r49U81U6tXKoWNTmTPT16E+RxCjBIzNC0II59PaAPD85z07OurTG89eepNhzD7id/n8eKTE+j2Q4kmcvCtS5rVPJ5sUWjBhqZhDQvrc5cK/XZQK4TgZtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983901; c=relaxed/simple;
	bh=ncJd4EDBBSL8qMQIUUUAcpGhgKhm7PcDr/e2HNmk7+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2u+QXRJ/wJ8ZHeX+9IhfQ6NJcLSkqBkZn35sH9Q5JnEmbXd5h0pycmctIFHXuGIqDjr0Cmur7xDR5cVPzQoZlrFaSWuitSJm7at9HBdixsfStOI0ESbIFNc74xMFZZwDlr4bs2e7G7HWZWcp4g3y2WxEyS9ErBKBV2kY33Vyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pAnsSXmm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pAnsSXmm"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CF2ED406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751983899; bh=WJXN44J7kYFvMhCD5DKoWk928JEbhJXb5fnHph51JeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pAnsSXmmugaxJJGP0eS4fDTGDP/7Lz4nITe05Qpnyr6zJL7uzrCbKfyHTxcKeltlQ
	 37dSxPv05+h/r57YHMlt/8hhbcgE1SsJlZ2ZJgdWzUKGKlW8PKkNI9YDcoECB7yaNn
	 fE6BtFTvnXPBxsinFH3/pfUjZsQIArfjdC5GeIxVZ0c8xnURHYke4lNRA81/X+Fg70
	 AJbRDWUt+Qv1wS+m3fGM2FFZ0GP3fYolctq1PnREAnF8OjDQDW84PGZ57RehKayag4
	 9MD4d5m78IeQdneZJcIG+fb4kxJHDBmf7yIrxXCp4fAx2A1HNHnd5kVSCx2ueGkhn6
	 K1cihwqGWNhbg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CF2ED406FC;
	Tue,  8 Jul 2025 14:11:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, mhiramat@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, sumeet4linux@gmail.com
Subject: Re: [PATCH] Documentation: Remove duplicate word size in bootconfig
In-Reply-To: <20250705151618.4806-1-sumeet4linux@gmail.com>
References: <20250705151618.4806-1-sumeet4linux@gmail.com>
Date: Tue, 08 Jul 2025 08:11:38 -0600
Message-ID: <87ms9e6acl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sumeet Pawnikar <sumeet4linux@gmail.com> writes:

> Remove duplicate word size in bootconfig.rst
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  Documentation/admin-guide/bootconfig.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 91339efdcb54..7a86042c9b6d 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -265,7 +265,7 @@ The final kernel cmdline will be the following::
>  Config File Limitation
>  ======================
>  
> -Currently the maximum config size size is 32KB and the total key-words (not
> +Currently the maximum config size is 32KB and the total key-words (not
>  key-value entries) must be under 1024 nodes.

Applied, thanks.

jon
