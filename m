Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8F3AA1A1;
	Sun,  6 Sep 2026 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661367; cv=none; b=KeqYc53aDSenqfXrpQ8fp3vHzmcgFlkNBzEhismBbKLITYR8djkSNonf7dEcvF+vtqrtuDK9sMYeXXpAt/eKbgrFKbtlijZ7xHdRZr1fIWlHH8Me2/Kw00KUCIgJ2Tqj7xcfPFhTwHOKJi/ck8pumGnSGYH86jI+36IojRV8zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661367; c=relaxed/simple;
	bh=yA99m+ioFZL+/EQRz4C00yL1Xoh2Iur0JizJeH0uA9A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KuChgOtTbb3ZDnLMMjwsIS9EnQiXI3E1+Omu8/DlmKH8FDHyVVA8gpLGinFRn1J8tec8RrxFnBoXjLqkN+ESSy/K3mSFCdxKI1kvHHJMsUHRrFqevDXGyo9j7/06qHTezzSyqu7GdDLw9ckegM+A4f88xRTbbWET2OmH08JeEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK7EOywy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK7EOywy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD7F1F00A3A;
	Sun,  6 Sep 2026 02:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788661366;
	bh=AO9jKIPl7jEJ4O1JIazaUT9SzGKHtmAv5n3R3KZwskw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PK7EOywytyV0lXiuJPdG4mn6FG5ro4HVM4ev3A+9iIFJW7n8iy7JKikTAUNICTV+g
	 mQ0kzTtpPOo4RmnvJ5SYfidj9Y9gCdgflM6+Vnp7DZwr3fQtC913UiYWFQavVkzGq8
	 2HcL/lo4dE+rvj2I7G1jwYoGYObcE/wMd9itqGA6fAfkhOvABIE7NQITVdim/j1tyq
	 mcg+cUdznrzN3zd6bh+zBaqtmCpZxvfmwuF+SnGJz9hvTiY5aLi6amzz+ZqjdbqSyP
	 Uw5iB3qszjFc1HXGpHUS4HQqYJQGzs2mRwcI9kfofRjk1pqJxJdvhGFd+MlY11kZzf
	 bFwEMt6cOgrqA==
Date: Sun, 6 Sep 2026 11:22:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fgraph: Remove unused FGRAPH_MAX_INDEX
Message-Id: <20260906112242.421681769499f9f590d8c61d@kernel.org>
In-Reply-To: <20260905211922.1196366-1-donggeunyoo.kernel@gmail.com>
References: <20260905211922.1196366-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 06:19:22 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> FGRAPH_MAX_INDEX has no user, and it expands to FGRAPH_INDEX_SIZE and
> FGRAPH_RET_INDEX, neither of which is defined anywhere in the tree. It
> was added in that form by commit 91c46b0aa917 ("function_graph:
> Implement fgraph_reserve_data() and fgraph_retrieve_data()"), which
> introduced the current data word layout under new names, so anything
> referencing it would have failed to build ever since.
> 
> Remove it.
>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!
 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Found while reading the shadow stack word layout. The macro is dead in
> both senses: nothing references it, and it could not be used as it is.
> 
> Compile-tested only, with CONFIG_FUNCTION_GRAPH_TRACER=y and
> CONFIG_DYNAMIC_FTRACE=y. Removing an unreferenced macro cannot change
> generated code, so there is nothing to test at run time.
> 
>  kernel/trace/fgraph.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b..ed455b53513b 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -143,9 +143,6 @@ enum {
>  #define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
>  #define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
>  
> -#define FGRAPH_MAX_INDEX	\
> -	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_BITS) + FGRAPH_RET_INDEX)
> -
>  #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS
>  
>  /*
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
