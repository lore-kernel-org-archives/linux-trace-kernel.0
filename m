Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22041A55D;
	Sun, 27 Sep 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527180; cv=none; b=uGS4VJYILNBk6cFvm/+zGsuWp8XTuLTs0IXb8xRiTPGWw7vYYbgSYRZC0ZhPv1hJHv9/r73giwD2o3hzqWcxwWgPleRSEOEAonYityminphIzIIt7KOfF3tDkeoQ2EZ2900BnLG8YU1JjPSUYYJDAs4One8RioRqurh/GMDs4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527180; c=relaxed/simple;
	bh=FhQzjK+6z6ZIUkFNOPKFSAT+3V/h1heXwjRcjUeTUH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5hnBnhTi4dalEeqedlCufrzO2S3cRHoVIb0arhtGYqGcCPQ0NuZRdKHtF7edKR0MPDI2Nh+qlgV7rFjh+8k249+Gn6BcLO8vQ5BZMMh/FS6Dafp3GVLj9pwuSjPhYn3GEJtuClFmuYtHP1Y7EU/R7suOJN7GRs1I08nrxIRinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DiskZ7hW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DiskZ7hW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SpN6W4lEFND+VB5enmbsYW3nADzfTCDefHGu6aNuhLI=; b=DiskZ7hWcTpUGtBR+tqkbK0ts1
	wJKx0tOjugHbL2qFHlP1MVHuvHstCvHwOnRSKgjaZn6h955HQ/gFjeZv59EHMfJjZXhdGoZW74NX5
	x0GVkbo+uHOfuo89K0DvDQKerl5RCEnij76Cp5t7u5lgPxYDm+uVlQsqmTMna6PaZQORd/UrqGEgG
	CSgPZeCMpfwb6mWFaFFmT13baDfzLZV3uXzeeKKA7yC6oIndMxgv4GorxglzHfpSeghhlY8nZd0yU
	ZbcVZOXxPg5NMTP+pdNnfkpYhtCVfSm0TlwPBSiVdf4yzuUGRvmrjLjX4FfPkd0gE6XKzaADONxHl
	fnCqNjxg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAruS-0000000GblG-3LYl;
	Sun, 27 Sep 2026 16:39:28 +0000
Message-ID: <ff6eb658-3930-47d5-9d5d-3e9460d7c0d3@infradead.org>
Date: Sun, 27 Sep 2026 09:39:22 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] docs: admin-guide: Handle TAINT_FORCED_BIND when
 parsing /proc/sys/kernel/tainted
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Bradley Morgan <brads@mainlining.org>, Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <4f89ceaf98172dbfb788832ad3204c8739653b31.1790495516.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4f89ceaf98172dbfb788832ad3204c8739653b31.1790495516.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/27/26 1:03 AM, Uwe Kleine-König wrote:
> tainted-kernels.rst contains a small script to check which taint bits
> are set in /proc/sys/kernel/tainted. Add one more loop iteration to also
> handle the newly added TAINT_FORCED_BIND bit.
> 
> Also simplify by starting the loop at 0 and save substracting 1 for each
> usage of the loop counter.
> 
> Fixes: fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when userspace manually messes with devices and drivers")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
> Hello,
> 
> feel free to squash this into fcbfaffee51a without author attribution if
> that is considered a good idea.
> 
> Best regards
> Uwe
> 
>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index abbf5e3dd749..a208811ad525 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
>  script, but if you need something quick you can use this shell command to check
>  which bits are set::
>  
> -	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> +	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
>  
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
~Randy
