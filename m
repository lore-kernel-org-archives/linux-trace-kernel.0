Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584B2F28FC;
	Mon, 27 Apr 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308661; cv=none; b=FIPI60IAypEKLFQcVX+H1ms4zqAk6BWl8g0WZXmodPkr/sf/AeciC1VAVx9aU+pe0/bzhr0EFyLzPOAD+KDU4nHdnUgnhDsHYzCG0vHUMa4kaKryk0Hen82MO3xRL4Oh5Tramp33YDVWb0Z/ujzSmrc9tM8/YDgRo8eDQ3D0vGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308661; c=relaxed/simple;
	bh=6r3XAMpgYbyM2eyCP4NpvBlVyLsyGxzHZWs+M3qjJG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaKDsErU9WKbhKgDHSqvAG/PuqfKIEJgLHH5anLb8xydJm6Mdp5aVk9jea2srWywmq6D7W5GxMlIVDFWChXVTF7PkoqhYCdulbXhm3Jvf0AZ6YM27zbDCwt+CRq8RW7uX7bKSb94cKdNW5pH4GhAj3CdFuaM4I5Vsgyu0LJs0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TjE3dI91; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjE3dI91"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WEpbWAMzRMwdAe2pI34IchbmL7/zApzmHQrs2eWfTVs=; b=TjE3dI91e7viFgl/PYJ3axr6aq
	Faf9nVzEvJSwoPt2vbyUWngq03yJ/CouTv8UTPUxDXYXW45v4KUgiGV0P9AkNK87yB2kGzOHV9H67
	gWVrLhF0Bfc+3F+25ySR1cGx3h0D0Ks5TDW38QM0yrqOizkJxZOVUU3Olg7/57V6/6CreuC+35WtL
	ljlGgqGteIt1UXLV6oqyacipxWJoOblxTWa0WjSVutWPrhn2WZQYDibfskLSK+HZ+M1YBIttZ9OdU
	Ay3FX2ULxaNuwCgCwFlM/CYvEIIZIvibDhfaxdhAoOj6aX39CF/fhi+nUB3Gsbr7QEKKwFD02iD/q
	b03crZ5A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPAb-0000000HOA2-4Amg;
	Mon, 27 Apr 2026 16:50:54 +0000
Message-ID: <f841e9f6-9d0b-4e10-a930-fdd74a74b9b9@infradead.org>
Date: Mon, 27 Apr 2026 09:50:53 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
References: <20260427131709.170505-2-gmonaco@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260427131709.170505-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/27/26 6:17 AM, Gabriele Monaco wrote:
> The sched monitor page was linking to Daniel's website which is now
> down. The main purpose of the link was to point to a source for the
> models from the original author and that can be found also in his
> published paper.
> 
> Replace the link with a reference to Daniel's "A thread synchronization
> model for the PREEMPT_RT Linux kernel" which can be found online and
> includes the models definitions as well as the work behind them (not the
> original patches but since they're based on a 5.0 kernel and are mostly
> included upstream, there's little value in keeping them in the docs).
> 
> Fixes: 03abeaa63c08 ("Documentation/rv: Add docs for the sched monitors")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> V2: Add link to the PDF and fixed RST references
> 
>  Documentation/trace/rv/monitor_sched.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
> index 0b96d6e147c6..d3ba7edc202f 100644
> --- a/Documentation/trace/rv/monitor_sched.rst
> +++ b/Documentation/trace/rv/monitor_sched.rst
> @@ -36,7 +36,7 @@ Specifications
>  --------------
>  
>  The specifications included in sched are currently a work in progress, adapting the ones
> -defined in by Daniel Bristot in [1].
> +defined by Daniel Bristot in [1]_.
>  
>  Currently we included the following:
>  
> @@ -365,4 +365,7 @@ constraints when processing the events::
>  References
>  ----------
>  
> -[1] - https://bristot.me/linux-task-model
> +.. [1] Daniel Bristot de Oliveira et al.:
> +       `A thread synchronization model for the PREEMPT_RT Linux kernel
> +       <https://www.iris.sssup.it/bitstream/11382/533630/1/Elsevier-JSA-2020.pdf>`_,
> +       J. Syst. Archit., 2020.
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

although I don't care for the "J. Syst. Archit." abbreviation.
Does JSA use that? Not that I can see.

thanks.
-- 
~Randy
