Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CF1D0E10;
	Thu, 10 Oct 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589929; cv=none; b=I9SfAs0W94RsGwv74xxdvXvsc5oVOpk6rvdaoN12Mas9dtcJ405+V9n0534wlVmLf+VfVKxUfuCBCYzpOUnK/RxoMTv5fq9TNgxm5A83gCuVlNqVU1yY1NHfP+/yp5xZ4egiy6Yx/WjhhzqAS+DjXtcIGhn0x57xSpsyumaqmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589929; c=relaxed/simple;
	bh=qcw6j0ZeUrCc7n9ZciGlFMxJdT8988R8ntWHIog88Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6aiOzS2OvE3ey9GtfOt5sXNzJh3X/ynnEOp6XFwb1yfwFTRMXNSKB9VlD2nL1Vu2IG8R+Auy4SnUgI7xQo6XsSH2HXxX3moNwoCSs5zquxkH+FfnfabnDMFYNHBJL/aiHq2JlR9RWA2IagLBA1CWSw3AbU9Gu6nyxJkdghJ/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G5a9H1SV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G5a9H1SV"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D259242C00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728589921; bh=g/gqbhjttoQMvUxgUOCqWQJ3rN+RGvjKpCYXLspiUSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G5a9H1SViQHuvk3GfgRHnlBWW/amvewQgCVgyRaNquaNEXlAfSI+eJsvoj17InQ5c
	 jPv4NiR8jzFWe+jxgIA6KdvA7sBCOSKhT6PRwDK5CnoFtssD8etgc2+gISua1jyANs
	 k32YoozCSGHxCx2siZ6zW7VPJzOpL6vx/JzE1JJwfLnleK1JA2kNeTgRwjL/yo6mLa
	 JWYfK/NNUY1T9Bvy/NiE+7k3EHGXXAWl4q3B27989WJXgrXIimQ1CAiJVqzCeifZ7t
	 IF0x8Q7yVNhWReSiqrXKaQTOZsuqT310HUZgFfNE0UC+ZxS7XaaSFrO4qwwcqOaTaJ
	 82ohLVF9s9pLg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D259242C00;
	Thu, 10 Oct 2024 19:52:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, SurajSonawane2415
 <surajsonawane0215@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
In-Reply-To: <20241010154708.0bf658a3@gandalf.local.home>
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
 <20241010154708.0bf658a3@gandalf.local.home>
Date: Thu, 10 Oct 2024 13:51:59 -0600
Message-ID: <87y12vzqg0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu,  3 Oct 2024 01:28:17 +0530
> SurajSonawane2415 <surajsonawane0215@gmail.com> wrote:
>
>> Add debugging.rst to the relevant toctree to fix warning
>> about missing documentation inclusion in toctree.
>> 
>> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
>> ---
>>  Documentation/trace/index.rst | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>> index 0b300901f..2c991dc96 100644
>> --- a/Documentation/trace/index.rst
>> +++ b/Documentation/trace/index.rst
>> @@ -24,6 +24,7 @@ Linux Tracing Technologies
>>     histogram
>>     histogram-design
>>     boottime-trace
>> +   debugging
>
> If order matters here, I'd like the debugging to be at the top. As I plan
> on it being more of a tutorial for using tracing, and should be the first
> document people see.
>
> I need to take some time out and start filling it up!

That's the order that the links will show up in the rendered page, so
yes, it matters.

jon
