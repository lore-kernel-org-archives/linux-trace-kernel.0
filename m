Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B562247295;
	Tue,  7 Oct 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873223; cv=none; b=q8W2PgAB2fQSOpLqxWmOTqspBjZIo7qKUTGSPuoA4CwjaQtrCd4+Kk0kIJh4rJa42DP5MQ90vUolTXWYP1uIJpYQqDZBtkbRYy4izx8J2K+WlW9NcqT4EQOTMXYUyWKHoSZ7ZIiRjpmAd9odera4tcP9v45bf+HMWsfiDDhgFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873223; c=relaxed/simple;
	bh=CzucD7jQ8YWt4x3vL1rjjME2IB+shp9RtWxtDBoYYvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xt/zaiD28QNCPJNmlkuU3JbJiNPsROtIJFEvTc1pGJEaGJ7iWrEmVXxX5qqQ83GFYfhXzLQkRWvfoEDdatX4pUhLAeFk7+jtVeWbt/vjf67RLgYSKjBWtzEpFenVyqXMkDQbC5bEDFBLAZfaCHqaeaLjnptjLDsJttqFgEa/VlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DCB1AC02F5;
	Tue,  7 Oct 2025 21:40:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id B0AA02000E;
	Tue,  7 Oct 2025 21:40:16 +0000 (UTC)
Date: Tue, 7 Oct 2025 17:42:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runping Lai <runpinglai@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wattson CI <wattson-external@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Luo Gengkun
 <luogengkun@huaweicloud.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
Message-ID: <20251007174208.11fd02da@gandalf.local.home>
In-Reply-To: <20251007163141.1034b120@gandalf.local.home>
References: <20251007003417.3470979-2-runpinglai@google.com>
	<20251006221043.07cdb0fd@gandalf.local.home>
	<CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
	<20251007154308.5b158d04@gandalf.local.home>
	<20251007163141.1034b120@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fy8ymza4czow4bnymtr65w97txo45ky4
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B0AA02000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Fu5KlYDDHg/fNhQLS8qW+9kDPDsJw2ko=
X-HE-Tag: 1759873216-528941
X-HE-Meta: U2FsdGVkX1823vcATPkDRITYN0vsWbwiUJNgoRpB4Qu1WmZ/n1ec4gztb1oL9tnM5f++5R6QvgNTCkO5AfRhSjYff86PsYApboCBz0xvF+VIjJIAHEOm61Tm/pbgnJOX7J7DY23Ltj3HNbWBsmo/Ov29sqZnJAk2TKqAWec0qFzm3EnB1zF310I/K9OaJxnmwT1crwavydhPqOMFRYG8busuSkuBBxvMfUiahQIGCe2/1cCHqYWan4xCgP18BV/V7SECC7ymdcw9jHlTdgzTSDHHRduYwrIiyAqKAFAuersV2PA7+cJoIcodrYhY62q64bQStfAR2mqoyewt9agYse2t0rVr49pWHshqQ6eGeyFrx49vFLxOS6O4q5D7DP4J

On Tue, 7 Oct 2025 16:31:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static void trace_user_fault_buffer_free(struct trace_user_buf_info *tinfo)
> +{
> +	char *buf;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		buf = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> +		kfree(buf);
> +	}

Oops, missed:

	free_percpu(tinfo->tbuf);

here.

-- Steve

> +	kfree(tinfo);
> +}
