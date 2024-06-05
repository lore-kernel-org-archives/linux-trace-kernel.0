Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986ABA38;
	Wed,  5 Jun 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628511; cv=none; b=GIMd7IwcUqY89iTJQVYwue+AGnFZleZCkPcjKS+WS3XSco5LTV8KEEE+RVNA41V991Oc5ZzT1QRr5WwL7+vFY3LlGUrBFOMxPT7ExVJnIcoWtOMqYo6XJIaLHII+83IWzIgfwNLxe4BcvkLcvPkaUIJxBtb32cCnRhtQZRHzfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628511; c=relaxed/simple;
	bh=Z3h4+PdKb5fP3a2f7pP8Dpq2lfsZWnsIkrMrgnK1Kh0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YEV+3yXUoH0UItul4GOhenc/21PtVhOjpInFUiUCrLwhhPx7ggL9Dnk9m+q0ty3GKBsKy1+BP3vmWKyx5kXy2dZovYOLTsCrpktLs5MfOMeBm7h6vrGaThDkFXK5Ew3f5iKhGdH1IwjvtZsR9fbec9sg/t1RZ0RohAPm2jrhAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4RsB/q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4RsB/q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B99C2BD11;
	Wed,  5 Jun 2024 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717628511;
	bh=Z3h4+PdKb5fP3a2f7pP8Dpq2lfsZWnsIkrMrgnK1Kh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4RsB/q3OYPNHyBjNwIrXJ5dhDMNo6c02n9hk6NVTKxJ0bSLyqmcUwHReqNUoRGfg
	 2nci0Plb0Fgme8sZon/sMkLNdX4EFxEcR+D7LaINo6uZlVg1J42M2X8N1tBN/pmsRw
	 roBMeBSGyPXybUABfd4eqGbl7u17n09UeMt46qvuM+4LV7BX/4jazpell3cSb2isPZ
	 A2poSOkc7g2OFiN28VbXSuG5DIg2W7D8vThNv2fWI8ED6FXhyt9AGYZyo/F0ZWf7xo
	 pIh6bCqiujZu0u5fgzW8uYJeBD6+HTjc93u6xM1MvZYD7UPvYQx9sn8WSIWcfuK6Ji
	 bycyargZHq88A==
Date: Thu, 6 Jun 2024 08:01:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/5] ftrace: Rename dup_hash() and comment it
Message-Id: <20240606080147.99c20cd5a638eda8307dc7a7@kernel.org>
In-Reply-To: <20240605180408.537723591@goodmis.org>
References: <20240605180334.090848865@goodmis.org>
	<20240605180408.537723591@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 14:03:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The name "dup_hash()" is a misnomer as it does not duplicate the hash that
> is passed in, but instead moves its entities from that hash to a newly
> allocated one. Rename it to "__move_hash()" (using starting underscores as
> it is an internal function), and add some comments about what it does.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index da7e6abf48b4..9dcdefe9d1aa 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1391,7 +1391,11 @@ ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
>  static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
>  				       struct ftrace_hash *new_hash);
>  
> -static struct ftrace_hash *dup_hash(struct ftrace_hash *src, int size)
> +/*
> + * Allocate a new hash and remove entries from @src and move them to the new hash.
> + * On success, the @src hash will be empty and should be freed.
> + */
> +static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
>  {
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *new_hash;
> @@ -1438,7 +1442,7 @@ __ftrace_hash_move(struct ftrace_hash *src)
>  	if (ftrace_hash_empty(src))
>  		return EMPTY_HASH;
>  
> -	return dup_hash(src, size);
> +	return __move_hash(src, size);
>  }
>  
>  static int
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
