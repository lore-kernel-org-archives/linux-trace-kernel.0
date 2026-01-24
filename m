Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E627456;
	Sat, 24 Jan 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769274166; cv=none; b=QV/hK5Xcn1R6pjOXDiHpDuTC4XXQumBqlfTpw9vk/rZuafPj8mb+qO+k/9HwwdQtB05txIaGBnJNCLAS+XxFZ9ZI3nUEf7s+ack4GNWavGWs0If3eYNTQ2n7AlftgJqsHElg4o9qinnFnffWh2/AgG3SRNPkceGBSODyYLyqhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769274166; c=relaxed/simple;
	bh=EA9UqL27ldsgBtLnYScmRK7cLe6GkbNk8UUf7+j4a3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQqPwvc/5miowkyQmpfhHIWYeNBV0LgbSkZLCnfU9QBssiOmJjVFH4hjHf3yFlXcoN2/Q2AB2N0656eFRvXYEVmNDwyvEOsHHZ1e8oBLaE7jRmCccbRs28cZXqXmp5YyF9j78Z5tg5L7Umc1L3FEQDF0jIpYzrfjG+1LDEhNsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 4A9A6C1849;
	Sat, 24 Jan 2026 17:02:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 5C9F020024;
	Sat, 24 Jan 2026 17:02:35 +0000 (UTC)
Date: Sat, 24 Jan 2026 12:02:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sunliming@linux.dev
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sunliming
 <sunliming@kylinos.cn>
Subject: Re: [PATCH] tracing: kprobe-event: Return directly when
 dyn_event_list is empty
Message-ID: <20260124120233.17926a82@robin>
In-Reply-To: <20260123013641.23066-1-sunliming@linux.dev>
References: <20260123013641.23066-1-sunliming@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5C9F020024
X-Stat-Signature: d6js13ttb7bxssud9if4gscynpbda8pp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1803SAYhiPfeNv/z3zjDyjgnYZl0dR5MQk=
X-HE-Tag: 1769274155-722471
X-HE-Meta: U2FsdGVkX18Bw9IqQXQD2PllezzkqVRqq972YO08bgr2uWWHkQllNIFSkizDIQOJs8jKcCtLi+YTfy2IG/06mC4D5sAa2Qf9dJiW3UGEI4t6+NhgATo5E/1IpDhCxGz2aNAMGkjAbmf18IKMH2taO5lfX2s5fIg8yIqn05BCgVdTYYALDCfjiWVtIdpnidNqY4l75+UXWODUbqJrZovPKgmyLLQBhGYR1adrsTa/4kI8pmd9ykOarYTFP2KE90LCp8bvo2jo0W9AKw1fete1Hfh/Aq/h58tVZSTqAJ1gBiBDp5HFdUpzXZFJ9z+j2hb3

On Fri, 23 Jan 2026 09:36:41 +0800
sunliming@linux.dev wrote:

> From: sunliming <sunliming@kylinos.cn>
> 
> In enable_boot_kprobe_events(), it returns directly when dyn_event_list is
> empty, thereby reducing the function's execution time. This function may
> otherwise wait for the event_mutex lock for tens of milliseconds on certain
> machines, which is unnecessary when dyn_event_list is empty.

Have you measured this?

I'm curious as to what may be holding the event_mutex at this time.
This is called by the initcall functions which are currently all
serialized. Any conflict would have to be caused by a worker or kthread
and not another initcall callback.

I'm not against the patch, I just want to understand more about it.

> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_kprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9953506370a5..d89a403c99d4 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1982,6 +1982,9 @@ static __init void enable_boot_kprobe_events(void)
>  	struct trace_kprobe *tk;
>  	struct dyn_event *pos;
>  
> +	if (list_empty(&dyn_event_list))
> +		return;

The above should definitely have a comment or we should wrap that with
another macro because the above is assuming that
for_each_trace_kprobe() uses dyn_event_list. If that ever changes in
the future, this will be broken.

Perhaps we should add a:

	if (trace_kprobe_list_empty())
		return;

?

-- Steve



> +
>  	guard(mutex)(&event_mutex);
>  	for_each_trace_kprobe(tk, pos) {
>  		list_for_each_entry(file, &tr->events, list)

