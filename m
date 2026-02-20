Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65482F6193;
	Fri, 20 Feb 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617417; cv=none; b=GLlTPpzLuBUaGeQXTj4bvsYmBw6ueGPiF9rlnsqd7PEjumGB0xAHVys1w8UWut2J4I5ZoriEEsRftM+xUW/mg3vwPxnILrclVrOMc+2/dovo2yjf5NU0f01/AWsiBbdTefCZqBf/5SPaqusRnzMclcyt9/5aYWdT4DNbl6kNmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617417; c=relaxed/simple;
	bh=Kns6tgVpRQtUtiaBvGtV9Oo0eJo7MZzULSXgEWXf3n0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mg0yBdVMKpJQWuX2TIXHwULvaNGiQmjDXa3HzvtzKYtU5x3qTdZPJ3SIiQM76TCBI3/d3ioGzXa5wV7kxGehzycrr0tpbvy73cfqK44c4aenWu5jW4UgQSTLtDnc4WW0Mpio4irhiEUlIEdaNGBhhpcOe8rh9fCY9by9ECaSG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6A29558359;
	Fri, 20 Feb 2026 19:56:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B99D920025;
	Fri, 20 Feb 2026 19:56:47 +0000 (UTC)
Date: Fri, 20 Feb 2026 14:56:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260220145656.7dd289f5@gandalf.local.home>
In-Reply-To: <177140967567.1537493.7265236420134382381.stgit@mhiramat.tok.corp.google.com>
References: <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
	<177140967567.1537493.7265236420134382381.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B99D920025
X-Stat-Signature: rjoyzi97uejbn9yr5tjrrdbwtmxkpakb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/4GAQ5NlptnJQ7XxRP/7v7dn2uthf7jMA=
X-HE-Tag: 1771617407-128448
X-HE-Meta: U2FsdGVkX18bYPfw0IPc8Lk6yPVp7OilUXa08RF08fYaj1kacPGTyghUtu0BTBu8gWEOWSYgC5lzKhRbvo9s9la+Jogb0Rnrg6oy9eOAyPz08yfprWTxum3+a53q/o9s/wblNJWqPkPhbtjq8CV+Sg4wuCuE1lWgo8BYrBRVsUfJSxhGNrXLgB48RFd6lJVrMfzKU9zss6TFNjocYxCwEhPxy4qahdfXvcPrn5TzC3tdUKm2nrxiNpmeuYm6/XudMd61fcWJuwiYTeqisz+ATT905vjFt6s4I8sNcasd8bs//9H5Xn7z1UgF1VoYcXHF+ij/f1PglOBy9uMs/W9a6uWEZqyzIeRX

On Wed, 18 Feb 2026 19:14:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Skip invalid sub-buffers when validating the persistent ring buffer
> instead of invalidate all ring buffers.

  instead of discarding the entire ring buffer.


> 
> If the cache data in memory fails to be synchronized during a reboot,
> the persistent ring buffer may become partially corrupted, but other
> sub-buffers may still contain readable event data, allowing usersto
> recover data from the corrupted ring buffer.

                  ... contain readable event data. Only discard the
                  subbuffers that are found to be corrupted.

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ring_buffer.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index d2b69221a94c..0ae2a5ad8c3e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2045,17 +2045,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  		if (ret < 0) {
>  			pr_info("Ring buffer meta [%d] invalid buffer page\n",
>  				cpu_buffer->cpu);
> -			goto invalid;
> -		}
> -
> -		/* If the buffer has content, update pages_touched */
> -		if (ret)
> -			local_inc(&cpu_buffer->pages_touched);
> -
> -		entries += ret;
> -		entry_bytes += local_read(&head_page->page->commit);
> -		local_set(&cpu_buffer->head_page->entries, ret);
> +			/* Instead of invalidate whole ring buffer, just clear this subbuffer. */
> +			local_set(&head_page->entries, 0);
> +			local_set(&head_page->page->commit, 0);
> +			/* TODO: commit an event to mark this is broken. */

Here's how to fix the TODO:

			local_set(&head_page->page->commit, RB_MISSED_EVENTS);

-- Steve


> +		} else {
> +			/* If the buffer has content, update pages_touched */
> +			if (ret)
> +				local_inc(&cpu_buffer->pages_touched);
>  
> +			entries += ret;
> +			entry_bytes += local_read(&head_page->page->commit);
> +			local_set(&cpu_buffer->head_page->entries, ret);
> +		}
>  		if (head_page == cpu_buffer->commit_page)
>  			break;
>  	}

