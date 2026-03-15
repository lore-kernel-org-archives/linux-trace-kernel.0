Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFB288AD;
	Sun, 15 Mar 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562789; cv=none; b=sD54rgHInQfrRImR7iQ8IgLwTWAvtro4tIYXtEQmOOx3Yjp1AEFuIaAKwEoHldFl+pmjdKV8RIvJfox4ezXz4Ybfj0vjAFTdkkSdX0Q9KQalDHjTkKMEavtyAgAfBc4fvmQF0Gf3ADL4KotP9zR2d1zoO2fFhh12ninyWS4U3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562789; c=relaxed/simple;
	bh=WER+MjFeBfiJ5tkt/IYGfCQrPBNKHuOxQFOyLNXlsEc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W3f+jY6m+lDr87cjV06rAAiPsBqVTFr6nLLXULti4Y3eWt21P+6Av/wqOJEkGIh4NUJ7iQlwlmeAOB33jGPThqt7ZGb1/WY8QCWNxruA9CIQesZquE+/Z+noSFrErlldSuCtyvg48xNpsdNcvVEyNerN1YXe1y/0HD8nXTFhwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTQz5BCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTQz5BCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E16FC4CEF7;
	Sun, 15 Mar 2026 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562789;
	bh=WER+MjFeBfiJ5tkt/IYGfCQrPBNKHuOxQFOyLNXlsEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZTQz5BCNh1r4u4t+onbaIwKD9Y5YlxaBOiCR0Ixuvx7BkolTKP0oojXV+u9gnJGd5
	 p8lfuOFot3ukPTEDsfUPuOB/q0w5aUcW3sw3svK5T/QsJ0RTGzVbl9nhWr86l9027y
	 1oL64ocfRlgCJVk0Uu3L+wp7aubgGDhURXntMxbOviYrv6sitXqbaP5chgGFKfwbNU
	 /oDS+OhZ0On2202o5UKSOGtyH/01NActf1c7t3Uo0YX2PNzB864CNgykDgzg7ag+6G
	 nw4oouvPa42GDK3aO5CA9Q+HKD17dl1dRt4w7LOzeh9gpX8HJLEKIOxTMsNGtBD/Q8
	 /M5c6EmPSPvog==
Date: Sun, 15 Mar 2026 17:19:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] lib/bootconfig: fix off-by-one in
 xbc_verify_tree() next node check
Message-Id: <20260315171946.2287bbb22689a52e7d996ca0@kernel.org>
In-Reply-To: <20260314230155.155777-9-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-9-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:46 +0000
Josh Law <objecting@objecting.org> wrote:

> Valid node indices are 0 to xbc_node_num-1, so a next value equal to
> xbc_node_num is out of bounds.  Use >= instead of > to catch this.
> 
> A malformed or corrupt bootconfig could pass tree verification with
> an out-of-bounds next index.  On subsequent tree traversal at boot
> time, xbc_node_get_next() would return a pointer past the allocated
> xbc_nodes array, causing an out-of-bounds read of kernel memory.
> 

Thanks, but How? Do you have any actual config example?
Unless that, I would like to treat this as a minor fix.

Thanks,

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 58d6ae297280..56fbedc9e725 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -816,7 +816,7 @@ static int __init xbc_verify_tree(void)
>  	}
>  
>  	for (i = 0; i < xbc_node_num; i++) {
> -		if (xbc_nodes[i].next > xbc_node_num) {
> +		if (xbc_nodes[i].next >= xbc_node_num) {
>  			return xbc_parse_error("No closing brace",
>  				xbc_node_get_data(xbc_nodes + i));
>  		}
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
