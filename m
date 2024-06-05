Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89584125D6;
	Wed,  5 Jun 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624015; cv=none; b=oLlwCevkwCoEH7JuGrcFl/d2Qnu+w7rgqbpWWmxkvQ86y70V3L5RWdcZffUlV0G6zBv895aLY1nhzcAa4AZpHmoi9ts/tpLhOye7IjSE1V99dnRge1Mf8hY9CJM/+L+xX6w1KQBKkNvmUlkz5DPHfgaXKLEetFvHGZPqVC11NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624015; c=relaxed/simple;
	bh=8IwSqABN3QUMo7Xt3msOWudlsQ/lqx8RLiIFZ+0j31g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M9oUwMZAIl0wBKVD7uX5bdo8u8zMYiFO4GALTbQ7GbcYrON5LjfX+0L1uWXel/0Znp0QM0ifqghQNG8cXQWo54teLXS6pxw45OzUjVeg1VC4VSgBH6qaF3Lp4RFcuKUv9FERxYkkL7CW4t9LqZQSdPT84AWFQkOhfpdIZ/EF+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3VcNcRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3VcNcRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB7C2BD11;
	Wed,  5 Jun 2024 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717624015;
	bh=8IwSqABN3QUMo7Xt3msOWudlsQ/lqx8RLiIFZ+0j31g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J3VcNcRAd5sterQjy8ufiNGoR9ycCDnEBBSeNq95rhHVOO7SA60FXX3/Xbt0wpwr/
	 XHHkBYpP5rz9l/1dW1/MlhXgYs05Y+bXJ6zfYbbMocPlRBnAz5Mk/BIu2Uiir4IPHt
	 p1iuAuTjCfY9JSGqU8Iqmt7whs5+POsThIg9U8AGeugdLeRBe0I/4U2/9lTLvWiFDH
	 Jsq/koTF2KtPSdKGW7vwiBdSNhu6nP/EOVvmFyPAnBNsVbSKa11WYYKbVFISiskX6L
	 N0sYIz3olSB0GQmZGpbf8U/Q6gFbvxlMXUw+eArKnUlKZhgUb8x6UlsCg3nUdRZVhN
	 g83pGVEYMqOoA==
Date: Thu, 6 Jun 2024 06:46:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] ftrace: Rename dup_hash() and comment it
Message-Id: <20240606064651.2de33dadaf241dda11fb70bc@kernel.org>
In-Reply-To: <20240604212854.564747474@goodmis.org>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.564747474@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Jun 2024 17:28:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The name "dup_hash()" is a misnomer as it does not duplicate the hash that
> is passed in, but instead moves its entities from that hash to a newly
> allocated one. Rename it to "__move_hash()" (using starting underscores as
> it is an internal function), and add some comments about what it does.

Good change.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
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
