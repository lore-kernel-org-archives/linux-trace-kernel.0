Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91035A952;
	Tue, 28 Apr 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407698; cv=none; b=mLU9E7kE8Bq1KCBDSbnsACYCkELvqXducdMTAkxxedPc0Y1/SVqKX9uT3aBls/ZWJR8QRknZbO90hg47zTc4cUjD5GmopQ+2zIwjYr1s5E1medbxer0TlE583fwDUqAvFCEV+SuKAe5pAX7eYpwvfF8xIaztazXjhtK/RSvi1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407698; c=relaxed/simple;
	bh=lVOc/2QaoXtfEtfj92ril73lFfZ0p0Xh7oNlTs1uRtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT89Pg19IalGfvia+FHy3y4zCWoR+knq+a4gjxWnC7y1u7q8Qplewss74yfGkq/otl/2a4PYREyLgfrFBeW2UJxUzXkaR9HlBmEO7ZxcFETAqBP8jNiwGK/6Wc3LlSZ+k7JwTj+8UzywOQ8LwK90WNP+l9UF7GCwjn67XrEgFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E22CE140424;
	Tue, 28 Apr 2026 20:21:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id DB11A20032;
	Tue, 28 Apr 2026 20:21:31 +0000 (UTC)
Date: Tue, 28 Apr 2026 16:21:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 4/8] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-ID: <20260428162146.78e52988@gandalf.local.home>
In-Reply-To: <177701355481.2223789.8929563537404268817.stgit@mhiramat.tok.corp.google.com>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701355481.2223789.8929563537404268817.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB11A20032
X-Stat-Signature: uxqknnieyh6qocc33pm4dz7a11hriibh
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WQB/o4GfEx2nnNkMQzQazvHdAcoOUkS8=
X-HE-Tag: 1777407691-181976
X-HE-Meta: U2FsdGVkX1+x9wPUL3Mdg1isPM9pfvR1/hxbPT0fY0XZvtE0Hf2YH9Xd1aKCTwW1VRk5Nzd0AtjHg1RVcGOUNjxGS/QaOBSXB46Rq+uD6AEztUuQVj4UE0TCl5utRe+HA48HVFGRyUKUe2ZO9dLfoOsYirrMSuNqbLarWp1v+31u5nEivCDpiOWwEKlgIONYAGCw0cMS43zASy/EfwX/EFDl+S5VWyNpYs5u9Da9HKa280zLjqQeIDeCHtHlD8Yo/BUiGFydQj0YvUWLBNpiKafYnotbtTc6BoTWRk8kPlzDm9X6qPnmziZlmYv8W1f+Q/cvTtwgRp3Qm+sMcEI/a6SMyjbBQ0U9

On Fri, 24 Apr 2026 15:52:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -1892,9 +1895,19 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
>  	 * subbuf_size is considered invalid.
>  	 */
>  	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
> -	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> -		return -1;
> -	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> +	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> +		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> +

This code seriously needs comments.

-- Steve

> +	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
> +		local_set(&bpage->entries, 0);
> +		local_set(&bpage->page->commit, 0);
> +		bpage->page->time_stamp = prev_ts ? prev_ts : next_ts;
> +		ret = -1;
> +	} else {
> +		local_set(&bpage->entries, ret);
> +	}
> +
> +	return ret;
>  }
>  
