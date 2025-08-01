Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BCDF71;
	Fri,  1 Aug 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078875; cv=none; b=UPyoFzMJahB2cSqiFZr/cxcnDMK545YDUA52neVYqdaUYtIgFnJxDvLulv4E2E6IyDHhqiOH3U/Wkb3bneEWN0w7Z6lMQe+ZlrfCGV2QaPdlS3qZsMWPa4RV+2nkp7gEAOvAALNykqOasV79Ywp5ti95CzrzW38/ZShzqnG8zBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078875; c=relaxed/simple;
	bh=WCFqIN5IfkAoMew21HtVQNAsVVFH1PrcnYcR5a62H8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRHFmiKl699V54ZUGegqgzPkAf2+hwNJ2dSSfqLYlNNANe2dk1EEK00e+ZitIt7W/sONm/Cd/QiXgECUocnhEOJnJ2xU2iWBW3jJpymAl4uCH6uCA44m7Dp5IthomKAiwrfyS4vMRY8nN3wmCpUr6kHVXFJUgk0nW4D/xZx7LHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E41AF16031F;
	Fri,  1 Aug 2025 20:07:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 0B0D920024;
	Fri,  1 Aug 2025 20:07:49 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:08:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] tracing: Add guard() around locks and mutexes in
 trace.c
Message-ID: <20250801160811.1e3c63e1@gandalf.local.home>
In-Reply-To: <20250801142526.649674199@kernel.org>
References: <20250801142506.431659758@kernel.org>
	<20250801142526.649674199@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5fcsz7pqofjt1hmssnerkpsc8p8ixcmu
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0B0D920024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/PlKa+6n0hUur+ERP9UvEHU12ArJUYfa4=
X-HE-Tag: 1754078869-254513
X-HE-Meta: U2FsdGVkX19k9gLyBv6c0UD9NKfZ4t2/KeY1yKHH2Qmc41HOk2Kzti+DBexiDQg/0zx1c7PUSbxKJa7QQZjnqpVzOhkfbpcfPXMpgy9/0PtQyWDdrvUF9yij3GybaoS94S086V9tDTZigfArhOEvf5HMb0zphwHT8RsUsesi/jKgvQoolVQGR/OS549nlJQwDx/7w5ku2S41PJdtRRnIhaHgjRnk0wFJgJKAdAvGzWDcO2aklOgQ+YHKqDpONYWm/WlKb1jiruDvS/26OKmxvvObuyG3Er43JXeZp4wdxvSA7AoI7JyC5FIYA+lwhW38V2ubkXGLoKTt9d0j5p8KvwbSXYEjp8hh

On Fri, 01 Aug 2025 10:25:09 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> @@ -2760,7 +2734,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
>  
>  	if (!tr->no_filter_buffering_ref &&
>  	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
> -		preempt_disable_notrace();
> +		guard(preempt_notrace)();
>  		/*
>  		 * Filtering is on, so try to use the per cpu buffer first.
>  		 * This buffer will simulate a ring_buffer_event,
> @@ -2809,7 +2783,6 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
>  			this_cpu_dec(trace_buffered_event_cnt);
>  		}
>  		/* __trace_buffer_lock_reserve() disables preemption */
> -		preempt_enable_notrace();
>  	}
>  
>  	entry = __trace_buffer_lock_reserve(*current_rb, type, len,

Bah, this code is really this:

		preempt_disable_notrace();
		/*
		 * Filtering is on, so try to use the per cpu buffer first.
		 * This buffer will simulate a ring_buffer_event,
		 * where the type_len is zero and the array[0] will
		 * hold the full length.
		 * (see include/linux/ring-buffer.h for details on
		 *  how the ring_buffer_event is structured).
		 *
		 * Using a temp buffer during filtering and copying it
		 * on a matched filter is quicker than writing directly
		 * into the ring buffer and then discarding it when
		 * it doesn't match. That is because the discard
		 * requires several atomic operations to get right.
		 * Copying on match and doing nothing on a failed match
		 * is still quicker than no copy on match, but having
		 * to discard out of the ring buffer on a failed match.
		 */
		if ((entry = __this_cpu_read(trace_buffered_event))) {
			int max_len = PAGE_SIZE - struct_size(entry, array, 1);

			val = this_cpu_inc_return(trace_buffered_event_cnt);

			/*
			 * Preemption is disabled, but interrupts and NMIs
			 * can still come in now. If that happens after
			 * the above increment, then it will have to go
			 * back to the old method of allocating the event
			 * on the ring buffer, and if the filter fails, it
			 * will have to call ring_buffer_discard_commit()
			 * to remove it.
			 *
			 * Need to also check the unlikely case that the
			 * length is bigger than the temp buffer size.
			 * If that happens, then the reserve is pretty much
			 * guaranteed to fail, as the ring buffer currently
			 * only allows events less than a page. But that may
			 * change in the future, so let the ring buffer reserve
			 * handle the failure in that case.
			 */
			if (val == 1 && likely(len <= max_len)) {
				trace_event_setup(entry, type, trace_ctx);
				entry->array[0] = len;

				/* Return with preemption disabled */
				return entry;
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So it must not be converted to a guard().

Let me fix that.

-- Steve


			}
			this_cpu_dec(trace_buffered_event_cnt);
		}
		/* __trace_buffer_lock_reserve() disables preemption */
		preempt_enable_notrace();
