Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A41E492;
	Wed, 19 Jun 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804615; cv=none; b=SYRnR2y4k+wEm588dAQ9yMkrpZ/WS4rB2NJS5/CF3sJ34DZQuUV8N5F72RFTXrj07f4yOMCa4SuN7kBtclIVPvJeTlFNPCsSFqW1gDGUCG9e6m0GvSitc2nXeIWIpPn6PD4skeQu0qHVNhIhj7xs1ICjdnQkvs7i5tsUvjwempk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804615; c=relaxed/simple;
	bh=5cXu+JHFL08f9J9rX0pT6j0NjNsjkr5HoSXnkbDpJB0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P23f3g//dDaYftAt9/KRQ8bNF0Gt0WRCnPTFtg9cjvNTAFdI9y9eyrzeHByWLx6RZhyjyz45u+z/aWTMmVrEmQ7Fg9cfw7vtP60a/d3EC0p9wm5/2L1dvHzn49mi8dXjI/qFc4aGxDUK1Yg3yyzE6YkzB1x9lVZok5aNDkS4M7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrVinK5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrVinK5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E69C2BBFC;
	Wed, 19 Jun 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718804614;
	bh=5cXu+JHFL08f9J9rX0pT6j0NjNsjkr5HoSXnkbDpJB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrVinK5NLi0QN/bFRVYH5asigrGLs+nbEbhk2hup4JiYhsbnsRwkqDnlaCq7ZMhqb
	 wwu+RuUUAc7C9oQkLr9JM2IkwT8IEfdn3qehanlZ3APJbaZsDAHIZJ8IvT3JatqyPV
	 ic0OmIW8uxnEElhOLuXJ6QR02ia3MkoUZpdxROj+kTwnWCbYQHfDBeg0QeH6zZMBhb
	 v1TI0dbWIQeRha0HTDlna01Cb2FKiTVw8RmfSeQKvT5EIflriaOg6ZDQTRwQPMLIIY
	 ud78XlC+zHqBpr/Tx3t9iSGEyssoXtI1rpRyoSYUubDAL2hp6qvwHdgq87ok+Zm2Pe
	 BeVI5zjZazHVQ==
Date: Wed, 19 Jun 2024 22:43:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fgraph: Use str_plural() in test_graph_storage_single()
Message-Id: <20240619224330.d54d6d1ef2f2dd7b02dfd739@kernel.org>
In-Reply-To: <20240618072014.20855-1-jiapeng.chong@linux.alibaba.com>
References: <20240618072014.20855-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 15:20:14 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Use existing str_plural() function rather than duplicating its
> implementation.
> 
> ./kernel/trace/trace_selftest.c:880:56-60: opportunity for str_plural(size).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9349
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> ---
>  kernel/trace/trace_selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index adf0f436d84b..97f1e4bc47dc 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -877,7 +877,7 @@ static int __init test_graph_storage_single(struct fgraph_fixture *fixture)
>  	int ret;
>  
>  	pr_cont("PASSED\n");
> -	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
> +	pr_info("Testing fgraph storage of %d byte%s: ", size, str_plural(size));
>  
>  	ret = init_fgraph_fixture(fixture);
>  	if (ret && ret != -ENODEV) {
> -- 
> 2.20.1.7.g153144c
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
