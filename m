Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CBEEC3;
	Tue,  8 Jul 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984081; cv=none; b=a1Ya2wZQm48JUYcXZEY6OKhbp1Y7tJjJcXiZabRx5HttKFtQ1eSh69x5Hz/wN11Z5ZpO+UMmJHV0AySEwRHnUaPPAksZ8YzznG9fpOgsVPLAcM1gnvCWeFmiL2GhS2oDrq/o2XAHgTaoUtsqLG2eFulPrVUzYLj3stC4T+xoofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984081; c=relaxed/simple;
	bh=FsDNbo8SKNA8IQp/RjKi16+L2G7xR/1hLOFC3Hn3rGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8tofRAAR+z+qQm8ugGUgC/fhWyeQwxulMRkCaHObcCeYgjy+Isn/rr4ipqPrtAzD57A18BfWb5HgSV1y3OjlDt18eun0tSx38Rrvfu5I0RaQ/aM8XuYqjxJwr+XRSmk6edtk6NAOjAveKaRmYRNWhp+Pf5B0EAKWgX0mjhaMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LqyXc/Ga; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LqyXc/Ga"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00211406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751984079; bh=DSJWbXFtHo5/zCD3cnB4EtER01TweueSmrBH2UgT2aE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LqyXc/GaPT2G4IUBSZPnQpuOT4qrVsl8e5GH+sOdhPzvRGz3gJ//mpQgNZiqZ0oq/
	 4FwZJpSe6T5jk64jp06xChTC9P+XlaKn8VoQXUXnStaUxQ04oZCWe4fF+1tEtAY1OM
	 VgFh8RuZGI3ac2Vp1DofqIDNBlaQr6GeVl9xn9qW3rFznPtFEV+UNN9CJvkkzBJ7Vh
	 7iRrLljr0HcDaQZG99JnMc+Nc/UUA3kGo2Hm2ADyEQF1s2glnvzFmxPmF1uJp9l+Qx
	 4+uuEkS7ZxkZ++qK58rCcAbGgTtukW1FFbc+EndU3FQvZIzsGWv+RA5nsQq7LRmh9B
	 4QXrq1Xhrv3ew==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 00211406FC;
	Tue,  8 Jul 2025 14:14:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] tracing: doc: fix "for a while" typo
In-Reply-To: <xygdnynf7m55p7d27ovzqtdjaa7pua3bxuk5c22cnmoovaji5e@tarta.nabijaczleweli.xyz>
References: <xygdnynf7m55p7d27ovzqtdjaa7pua3bxuk5c22cnmoovaji5e@tarta.nabijaczleweli.xyz>
Date: Tue, 08 Jul 2025 08:14:38 -0600
Message-ID: <87ikk26a7l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:

> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cv=
nrufop6tch@tarta.nabijaczleweli.xyz/t/#u
>
>  Documentation/trace/histogram.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/hist=
ogram.rst
> index 0aada18c38c6..2b98c1720a54 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -249,7 +249,7 @@ Extended error information
>    table, it should keep a running total of the number of bytes
>    requested by that call_site.
>=20=20
> -  We'll let it run for awhile and then dump the contents of the 'hist'
> +  We'll let it run for a while and then dump the contents of the 'hist'
>    file in the kmalloc event's subdirectory (for readability, a number

Applied, thanks.

jon
