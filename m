Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1C747F;
	Wed,  5 Feb 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716464; cv=none; b=pcSrUIKM+mhQQRvrRVnobzurAxe8Q/4BbZkvg00tOHM6AQgzsGoBIvtxjAzYbJYnzZbHlxUhfBC0LMlF5lh4H2e4BHfU2sLXTqphSyBIxzfV3HrxcAFmL8d0TBUpnN03/SLm/cxKWNAZ5sWzcpiXhsP9WOVpFOzw0rNRVkpQsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716464; c=relaxed/simple;
	bh=pA5YSQT+PflJ99T3ntYsCMPYvL6cveLPcdY6XLlaojI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOxoqn07GLfWXYbaUxMQemd/OUHJrisqGmNLQbmX2odrkPCamgigSTLOfze1KaRnfFT/o7tFp3APQ/VC7gGAO1kX1C/esXWgLW/uLQARyKpbDEImJnI+a3tSyzYdUbBGCcf4KhjrMBa8M8e1HKdL5xsLLuVAdApZquCkcUm48fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BAAC4CEDF;
	Wed,  5 Feb 2025 00:47:43 +0000 (UTC)
Date: Tue, 4 Feb 2025 19:48:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang <wenyang@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in
 function_stat_show()
Message-ID: <20250204194820.7ef50d96@gandalf.local.home>
In-Reply-To: <20250204172045.3a5d8d01@gandalf.local.home>
References: <20250203100603.5c00df0f@gandalf.local.home>
	<20250204074301.1427497-1-kniv@yandex-team.ru>
	<20250204172045.3a5d8d01@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 17:20:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> x = rec->counter
> 
>   x * (x - 1) * 1000 = (2^32 - 1) // use minus 1 just to be sure
>   x * (x - 1) = (2^32 - 1) / 1000
>   x^2 - x = (2^32 - 1) / 1000
>   x^2 - x - (2^32 - 1) / 1000 = 0
> 
>  x = (-b +/- sqrt(b^2 - 4ac)) / 2a
> 
>  a = 1
>  b = -1
>  c = -(2^32 - 1) / 1000 = -4294967.295
> 
>  x = (-1 +/- sqrt((-1)^2 - 4 * -4294967.295)) / 2

And I did make a mistake, as b = -1, and the above should start with -(-1)
or 1 :-p

> 
>  x = 2071.930 for 32bit

This should be: 2072.930

> 
> For 64bit we have
> 
>  c = -(2^64 - 1) / 1000 = -18446744073709551.615
> 
> That makes
> 
>   x = 135818790.812

And this needs to be: 135818791.812

> +/*
> + * The calculation for stddev will overflow when the counter
> + * algorithm overflows the long size:
> + *
> + * rec->counter * (rec->counter - 1) * 1000 >= 2^BITS_PER_LONG
> + *
> + * Using the quadratic equation: x = (-b +/- sqrt(b^2 - 4ac)) / 2a
> + * we can figure out what the max rec->counter is before it
> + * overflows.
> + *
> + * x = rec->counter
> + * x * (x - 1) * 1000 = 2^BITS_PER_LONG - 1 // -1 for rounding
> + * x * (x - 1) = (2^BITS_PER_LONG - 1) / 1000
> + * x^2 - x = (2^BITS_PER_LONG - 1) / 1000
> + * x^2 - x - (2^BITS_PER_LONG - 1) / 1000 = 0
> + *
> + * a = 1
> + * b = -1
> + * c = -(2^BITS_PER_LONG - 1) / 1000
> + *
> + * x = (1 +/- sqrt(1 - 4 * -(2^BITS_PER_LONG - 1) / 1000)) / 2
> + *
> + * For 32bit that is: x = 2072.930 (or 2072)
> + * For 64bit that is: x = 135818791.812 (or 135818791)
> + */


But in the patch, I redid the numbers and did not copy from the above, and
here I did it correctly.

-- Steve
