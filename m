Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06D1624DC;
	Thu, 17 Apr 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899387; cv=none; b=fVwx9HHvjQOwF0wZRBtJV1zNZm69P23w9eOPWxj/4K0upzzV7e+LpTZnKFLNuGL2ngYPMUc66D/QPmWm9j241W5nEpuj+D6rlZDo2AvbfmyCi5wVhi4/JAmtIzY9LQiaOVu72BTwnm2yJS4Xe+jk7jHpzUwR3Ro4E/fssHoKrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899387; c=relaxed/simple;
	bh=/tJ4Xj/O4Wbf0UOMsD/j71OpKvDSPJPVgxvid0SC6a8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9ovPFnkEuwoKg6dZpo9+sl1/R1HpsTGq3mptqiyWnxjYKGiGBuibkIrAWihJRGY3zxr0WHgomWEKFC0VCo3wGWxPx92EfYLGNfjtX6yI920s5+SMkQR8zY5271u4pkI+olFYL1H9T1V8fyg9yUp9j8nqr2M07Vzr6S80FvFu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E2C4CEE4;
	Thu, 17 Apr 2025 14:16:26 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:18:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Record trace_clock and recover when reboot
Message-ID: <20250417101804.3117e478@gandalf.local.home>
In-Reply-To: <174486704950.3973933.810283141514120282.stgit@mhiramat.tok.corp.google.com>
References: <174486704950.3973933.810283141514120282.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 14:17:29 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6004,6 +6004,7 @@ struct trace_mod_entry {
>  };
>  
>  struct trace_scratch {
> +	char			clock[TRACE_CLOCK_NAME_MAX];
>  	unsigned long		text_addr;
>  	unsigned long		nr_entries;
>  	struct trace_mod_entry	entries[];
> @@ -6114,6 +6115,8 @@ static void update_last_data(struct trace_array *tr)
>  	if (tr->scratch) {
>  		struct trace_scratch *tscratch = tr->scratch;
>  
> +		strscpy(tscratch->clock, trace_clocks[tr->clock_id].name,

Why copy the name and not the clock_id?

The clock ids should not change between kernels.

-- Steve

> +			TRACE_CLOCK_NAME_MAX);
>  		memset(tscratch->entries, 0,
>  		       flex_array_size(tscratch, entries, tscratch->nr_entries));
>  		tscratch->nr_entries = 0;
