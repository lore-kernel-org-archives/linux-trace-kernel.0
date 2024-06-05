Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038D1946D2;
	Wed,  5 Jun 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582969; cv=none; b=pBsujgHsRFjDCVNHmzGGFnHlthGvOwjmgtgXduPdw7z8gD2oqHHWFB9M7yW+Hs9kOJCIarXQjkCNpzg7KyztD8E94WWsmckJOnUeBdU8aMsp3xaSXF/3APAJCJ2UA+nEGXNw6pSHfSCb3biDTzeUDhbltiuPyYVGSmim6nZYAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582969; c=relaxed/simple;
	bh=dFL1wIIssPf14bjH7g0WUoNEoezNOPiZY06hXBSjm/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm5GyfP2HQ5rz5liYpbfPw/4let42PtS7ChjGWDtuugF9ZHmWToS3nuE7w09uG2cRUoC1IEfQey4gCSntUka8Pu/HqwS4pNVu5kmTKkSXdF8xE7jR+lv5aEivnsJtaVB2gy06PYzOUZ4UTmZuiQOpVVHPu/AJM9guFzMm164aJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCAD6339;
	Wed,  5 Jun 2024 03:23:10 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED253F792;
	Wed,  5 Jun 2024 03:22:45 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:22:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in
 ftrace_hash_rec_update_modify()
Message-ID: <ZmA8cqXUxxSmHhQT@J2N7QTR9R3>
References: <20240604212817.384103202@goodmis.org>
 <20240604212855.046127611@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212855.046127611@goodmis.org>

On Tue, Jun 04, 2024 at 05:28:21PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The parameters "filter_hash" and "inc" in the function
> ftrace_hash_rec_update_modify() are boolean. Change them to be such.
> 
> Also add documentation to what the function does.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Aside from the issue with forward declarations that need to be updated,
this looks good to me, so with that fixed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/trace/ftrace.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index de652201c86c..021024164938 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1915,8 +1915,31 @@ static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
>  	return __ftrace_hash_rec_update(ops, true, 1);
>  }
>  
> +/*
> + * This function will update what functions @ops traces when its filter
> + * changes. @filter_hash is set to true when modifying the filter_hash
> + * and set to false when modifying the notrace_hash.
> + *
> + * For example, if the user does: echo schedule > set_ftrace_filter
> + * that would call: ftrace_hash_rec_update_modify(ops, true, true);
> + *
> + * For: echo schedule >> set_ftrace_notrace
> + * That would call: ftrace_hash_rec_enable(ops, false, true);
> + *
> + * The @inc states if the @ops callbacks are going to be added or removed.
> + * The dyn_ftrace records are update via:
> + *
> + * ftrace_hash_rec_disable_modify(ops, filter_hash);
> + * ops->hash = new_hash
> + * ftrace_hash_rec_enable_modify(ops, filter_hash);
> + *
> + * Where the @ops is removed from all the records it is tracing using
> + * its old hash. The @ops hash is updated to the new hash, and then
> + * the @ops is added back to the records so that it is tracing all
> + * the new functions.
> + */
>  static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
> -					  int filter_hash, int inc)
> +					  bool filter_hash, bool inc)
>  {
>  	struct ftrace_ops *op;
>  
> @@ -1939,15 +1962,15 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
>  }
>  
>  static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
> -					   int filter_hash)
> +					   bool filter_hash)
>  {
> -	ftrace_hash_rec_update_modify(ops, filter_hash, 0);
> +	ftrace_hash_rec_update_modify(ops, filter_hash, false);
>  }
>  
>  static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
> -					  int filter_hash)
> +					  bool filter_hash)
>  {
> -	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
> +	ftrace_hash_rec_update_modify(ops, filter_hash, true);
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 
