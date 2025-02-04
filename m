Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BA2153DC;
	Tue,  4 Feb 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687188; cv=none; b=Ps8cT9WnRsCBeYFpe8sq9WgkczKnJHOLu9u0GS3/PQf9ZgAoGt9vPcNBujpFAvJPp/FcoJfeCY0Lv9X1nuujusYP3MqB+X19eUX4p+bOv9T0jh5MqYw10z51/7F79sRRnXbwOpxSP4qbAfdtWRGnsy7ZeKUtMFWL3xvWUiidEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687188; c=relaxed/simple;
	bh=caW8wTACoY9BYs6UH3BCkKRgIIdsZxq/nCW07mg3juQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUBesWq/9RxZZz/xz3O45WLVCMycNfcRWnZMmrgXoZuRsE0cI2WvtiW1L9A3DrMqDtsJFu0BdIvGBbrdDzuBb5TZfHwjIJr6RXBywBfG6odqT5HUOsX+rHXImB5mRTff7zHCe82+G4UzSvHzVL++btuKZ5mk0Savz6go5N1YHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=P9hnbnDz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="P9hnbnDz"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 190AC404FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738687186; bh=+CIuFtBX5H1+MKatEsxzMEnDXri22F1yyzdj4L6ekdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P9hnbnDzd4NQ/dwwAMuHLH13KpoWmW+VmY2onJSECHGp3W+hOLM76Ce2puOMBdTDW
	 6LgdMRbbwh+dogbYqxfeLQVZATwTAIc14Ik4R3WjRPG0NP0PI48rUSDXNMgFSki+Us
	 gxR0z1tL07RiIEiScWPvshNA4dlFCtygu5EmRDQHktEHh3nvEvlwB4LzwxLWR/1OJd
	 hdzdvzOTtynBBmENIO9mVDOCyhwVScf7WHUXPorjURLVtWBf13SrgxOu1t841xLzPX
	 v5A5wB77UhUTkE9lQP36XRcIDGoa+4ycsn59iL6fio+lrKeo6bTSeJrKYqH99O8eeO
	 7fDI44nl/2NAg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 190AC404FA;
	Tue,  4 Feb 2025 16:39:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: skhan@linuxfoundation.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Purva Yeshi <purvayeshi550@gmail.com>
Subject: Re: [PATCH] docs: Move "debugging" section to the top in index.rst
In-Reply-To: <20250204133616.27694-1-purvayeshi550@gmail.com>
References: <20250204133616.27694-1-purvayeshi550@gmail.com>
Date: Tue, 04 Feb 2025 09:39:45 -0700
Message-ID: <87bjvhhdf2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Purva Yeshi <purvayeshi550@gmail.com> writes:

> Move the "debugging" entry to the top in Documentation/trace/index.rst.
> Turn index.rst into a good starting point for people wanting to learn 
> about tracing. Make it the first document users see, as it serves as a
> tracing tutorial
>
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  Documentation/trace/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 2c991dc96ace..f3d235c8438b 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -5,6 +5,7 @@ Linux Tracing Technologies
>  .. toctree::
>     :maxdepth: 2
>  
> +   debugging
>     ftrace-design
>     tracepoint-analysis
>     ftrace
> @@ -24,7 +25,6 @@ Linux Tracing Technologies
>     histogram
>     histogram-design
>     boottime-trace
> -   debugging
>     hwlat_detector
>     osnoise-tracer

So I totally approve of improving our index.rst files.  Without some
occasional maintenance, they become unorganized dumping grounds, and
Documentation/trace appears to be no exception.

This small change does not really help, though.  Could I please
encourage you to consider bringing some real order to this page?  As an
example, you could look at commit 270beb5b2aae from 6.13.

Thanks,

jon
