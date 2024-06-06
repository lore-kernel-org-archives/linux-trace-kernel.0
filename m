Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1A195993;
	Thu,  6 Jun 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678388; cv=none; b=ff18qvkW4qLwQL4gepqvkNO1xNeOv97FHyVDf1I2K2UW88g+P+ft+T40RaQff2HnnWOZ2kmtJhx5Tqw7tc2aNfFUCVHNS4q/je5REo9L39oLDF/2QqfcOMRTMBcMk0+6nxLrQG52O4iPeSZqBMNLDw9+I7auHoylfY8WUhuUFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678388; c=relaxed/simple;
	bh=fRpk2JACrLGpV1chwSwx047Nj1SvEiyU9gcoq9W3hSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahmy8niRWojrLFPlPO7ZlPtU8/1fkH+1IoeULec579HavQxJr7RWEeg7YMw4WTjwb/J60hVAnd2iFRpERJqiGbCSNgvlVWJ7mmllD5idSIBGK1QOqXM6q6a8MPi31yXb7fNHOO8Mqqwlz+iRTgBWjrmVOukvO+gvlXm9YKTo1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2222F4;
	Thu,  6 Jun 2024 05:53:30 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5983F762;
	Thu,  6 Jun 2024 05:53:05 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:53:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/5] ftrace: Rename dup_hash() and comment it
Message-ID: <ZmGxLprlQohC3tJ3@J2N7QTR9R3.cambridge.arm.com>
References: <20240605180334.090848865@goodmis.org>
 <20240605180408.537723591@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605180408.537723591@goodmis.org>

On Wed, Jun 05, 2024 at 02:03:35PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The name "dup_hash()" is a misnomer as it does not duplicate the hash that
> is passed in, but instead moves its entities from that hash to a newly
> allocated one. Rename it to "__move_hash()" (using starting underscores as
> it is an internal function), and add some comments about what it does.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

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
