Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2113FD92;
	Wed,  5 Jun 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582545; cv=none; b=b5G0ijEHSsP16WXHwyQVmbjLRJlx7T+Vox5UEYBflm7ikr2KP3Oldqf4xmTaI85Q4FFOfZf45rzJ4KkeWVfgHQY0CzizhX8cpRNQbT+SHlHnQ+FNYIF/FTaT3L5Xdg9/s1qqv7Gz2JOSrhB93lT+0ceo6Bb8LE+9kw3JlRM3fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582545; c=relaxed/simple;
	bh=IUX6zIPyypIRUN0tk9hXbZutMUX1lSDUS76QuLJCPBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOcJtXYbYKBNCni1dMei+umEUK6rkMrCCyeDqR3TUExNxV0eZbyLT7REv+cfhEqwm7sg0QU+21mZaA6/0B3oP36SPgTtJ9seb1+sTV1NliAj1Dr/PwgWUY97XF5+jQaMcb/LeFt0k12yrKGAVIz3xUoBP++2YRa3JEaDR2GhTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E813339;
	Wed,  5 Jun 2024 03:16:07 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14A23F792;
	Wed,  5 Jun 2024 03:15:41 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:15:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] ftrace: Comment __ftrace_hash_rec_update() and make
 filter_hash bool
Message-ID: <ZmA6ygUWNPkq0PKV@J2N7QTR9R3>
References: <20240604212817.384103202@goodmis.org>
 <20240604212854.725383717@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212854.725383717@goodmis.org>

On Tue, Jun 04, 2024 at 05:28:19PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function __ftrace_hash_rec_update() parameter "filter_hash" is only
> used for true or false (boolean), but is of type int. It already has an
> "inc" parameter that is boolean. This is confusing, make "filter_hash"
> boolean as well.
> 
> While at it, add some documentation to that function especially since it
> holds the guts of the filtering logic of ftrace.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9dcdefe9d1aa..93c7c5fd4249 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1701,8 +1701,20 @@ static bool skip_record(struct dyn_ftrace *rec)
>  		!(rec->flags & FTRACE_FL_ENABLED);
>  }
>  
> +/*
> + * This is the main engine to the ftrace updates.
> + *
> + * It will iterate through all the available ftrace functions
> + * (the ones that ftrace can have callbacks to) and set the flags
> + * to the associated dyn_ftrace records.

I beleive s/to/in/ here, to make this one of:

	set the flags in the associated dyn_ftrace records.

... rather than:

	set the flags to the associated dyn_ftrace records.

> + *
> + * @filter_hash: True if for the filter hash is udpated, false for the
> + *               notrace hash

Typo: s/udpated/updated/

... though I couldn't parse this regardless; maybe:

	@filter_hash: true to update the filter hash, false to update
		      the notrace hash

Mark.

> + * @inc: True to add this hash, false to remove it (increment the
> + *       recorder counters or decrement them).
> + */
>  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> -				     int filter_hash,
> +				     bool filter_hash,
>  				     bool inc)
>  {
>  	struct ftrace_hash *hash;
> -- 
> 2.43.0
> 
> 
