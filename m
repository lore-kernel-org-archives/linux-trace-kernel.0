Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6A2853E5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207084; cv=none; b=kXQFhTT2oxy5ZlTqDGtzKg+jHHVXbkcnY4go6KjbsZeQIIjUHKKvPUs/JmKdj20rtV2HaDZ7SYXyuIYO3LVTqGVFLiiNTP51ND7R1R3ZD2lRjvp7fTmktbYyOr9XsFhuZAjyRmS8qxBLZ521L2nPNLcnxaY02tHBqrepxGKo+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207084; c=relaxed/simple;
	bh=8TBhkX4KH7hSZZfeaQktRo9B48uLCn+Wne3y4art6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhBAfcuR83xCGeko6bf0y7I8HbC78Qj/OEvWCohZE+Dn8/62wJ0/8e7PqwIQQLex+ckuXQ0PZA/d9YBRmqhALq5Lk5WWqlUTVFGm1DG+OLGZz7IqL+R9JLllDrqhplpHuslmop7ycBcEER09isfuIP4vkXNRqOfZeFWOHcPddp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A2B901A127D;
	Fri,  6 Jun 2025 10:50:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id AE01320027;
	Fri,  6 Jun 2025 10:50:06 +0000 (UTC)
Date: Fri, 6 Jun 2025 06:51:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org,
 syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: fix error handling in
 ring_buffer_subbuf_order_set()
Message-ID: <20250606065124.07857968@gandalf.local.home>
In-Reply-To: <20250606091217.1506673-1-dmantipov@yandex.ru>
References: <20250606091217.1506673-1-dmantipov@yandex.ru>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AE01320027
X-Stat-Signature: 59nbzwbhiiijkwarc1yr5dfk5nwyryk3
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19MKX8aT5W+UZqfeNk8S55GpcrvBcGIZRA=
X-HE-Tag: 1749207006-931591
X-HE-Meta: U2FsdGVkX19gKHa58tQZeZLklgOEsMqUCHvVIgBSIjJIGck1GeVia4xE41q3p6N4f9PD1N1Ny93luSLJmvw5rWMGBPxXH9aZZiSY/K2WMCW3v7l8vjjIHEeNjl0dvgpOgXGJAT4dDgtpstjo5om7Jj2yaHaKJHIyT3gw0INuUy92O/A3J5FcMGkxPUf+rzuylZxqnSTSvPRPBU6iQgoD9ZP7nmqVGcvTajX74c1MFwNC0LHIAT1fzz05UJ+fBEW9GaYKGHk6+WZd1l87bWN6dxqiq+N7IwP7DBq/ZZL5tMYi0d8tpK74bNLlaLkz28VBwovsCL4aVIFyaS8QIlTvqdsCD8w+UVGkPueGAHzNyUGXDvyoewVwJkPvugmKUeDUnGR+LKzCNzNmAPrlze7oxAqy+s0UBkMNq/xng6JwRT1zziowIGH73BAbpYlfEJYVRRqOgJN6xiNpiemyAzKnDQ==

On Fri,  6 Jun 2025 12:12:17 +0300
Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'ring_buffer_subbuf_order_set()', enlarge critical section to
> ensure that error handling takes place with per-buffer mutex hold,
> thus preventing list corruption and other concurrency-related issues.
> 
> Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
> Fixes: f9b94daa542a8 ("ring-buffer: Set new size of the ring buffer sub page")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  kernel/trace/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e24509bd0af5..2028a24d6418 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6908,9 +6908,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	buffer->subbuf_order = old_order;
>  	buffer->subbuf_size = old_size;
>  
> -	atomic_dec(&buffer->record_disabled);

There's no reason to move the record_disable. Enabling recording here is
fine, as the pages being freed have not been added to the ring buffer.

> -	mutex_unlock(&buffer->mutex);
> -
>  	for_each_buffer_cpu(buffer, cpu) {
>  		cpu_buffer = buffer->buffers[cpu];
>  
> @@ -6923,6 +6920,9 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  		}
>  	}
>  
> +	atomic_dec(&buffer->record_disabled);
> +	mutex_unlock(&buffer->mutex);

As this moves the mutex to the end, we can instead just remove the
mutex_unlock()s and replace the mutex() with:

	guard(mutex)(&buffer->mutex);

Care to send a v2?

-- Steve


> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);

