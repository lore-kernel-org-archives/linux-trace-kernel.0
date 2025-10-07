Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB4129A78;
	Tue,  7 Oct 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802945; cv=none; b=VxZtUqNwgNbCEx5wntpAn01KCs/OQz/orjkBS3M0soGoPnsu+3kHV1Z6OqPdkaIswUxXjs6KAzF+pkqKVGpLsjMzU40EruiGIzpiPXttJyUyxYfvaH2IMd5xbJ2ypUofGmwwyw3w4cCkqTSp+qoBLykkfykL+ZFCCkLS/bDokCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802945; c=relaxed/simple;
	bh=nMpMItrL2HG0TDPtJtqYXUdrta3yzI7x+lHsxH9Llz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt+l8Zs20N4H7LZqjgpIRdoBzDBX7NlUN84U7blMT3JA7cKTSE5QdhcYeBjCrpU1uHkNuBkSLl6oHjvrwBfdt7t9rWRvJAoUkfzd6YylEZ3FJDaFhHvyPtsXxRcKZF+t6Is1MdubrcDo/Baw3z2IezMbg+sH7xIeOeNbBQoAjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6DDD811ACE1;
	Tue,  7 Oct 2025 02:08:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 591D120026;
	Tue,  7 Oct 2025 02:08:53 +0000 (UTC)
Date: Mon, 6 Oct 2025 22:10:43 -0400
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
Message-ID: <20251006221043.07cdb0fd@gandalf.local.home>
In-Reply-To: <20251007003417.3470979-2-runpinglai@google.com>
References: <20251007003417.3470979-2-runpinglai@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 591D120026
X-Stat-Signature: 5eawuzhhe4dgb5fok9g1c5rjcfifjcty
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19EGSY3o9iEDPH61isLQbRV4JTw4rtuOBY=
X-HE-Tag: 1759802933-462618
X-HE-Meta: U2FsdGVkX1+HNYfHciqVADBX6vACzPb9mv/l2DqON9sskKVeQTYE+MKv9DnV/ba3Who3kXjFtdVnX+3vanW1a6P/6gzbUhLwJVIZKj9AcCVviMfHAVwpRmoGOV3eu1+ehbOyWzqm0ABtGTti/3J4F/vM7vXhcxUvBXlmssPm0lPZqLCQ01zyZBHZDN9dsKAAzWAHXT7pvrGM6CP2uTEyYzVx9Db12FWxeYnW6Z0sqIAyibj7W6SsG75zIj2eP+OWTzuZl+96L1kZW+kpgcyilQTAEEnMBjTBk/nlGC+CIMGX/zhUkqXRS6qqIiTlEgp3jxfZjxhtKqIdnI9d6vE3oaYzgy3DPs7dMSxzNZVBD7Cpc39TapA0ad4jKvkInanG

On Tue,  7 Oct 2025 00:34:17 +0000
Runping Lai <runpinglai@google.com> wrote:

> This reverts commit 3d62ab32df065e4a7797204a918f6489ddb8a237.
> 
> It's observed on Pixel 6 that this commit causes a severe functional
> regression: all user-space writes to trace_marker now fail. The write
> does not goes through at all. The error is observed in the shell as
> 'printf: write: Bad address'. This breaks a primary ftrace interface
> for user-space debugging and profiling. In kernel trace file, it's
> logged as 'tracing_mark_write: <faulted>'. After reverting this commit,
> functionality is restored.

This is very interesting. The copy is being done in an atomic context. If
the fault had to do anything other than update a page table, it is likely
not to do anything and return a fault.

What preemption model is Pixel 6 running in? CONFIG_PREEMPT_NONE?

The original code is buggy, but if this is causing a regression, then we
likely need to do something else, like copy in a pre-allocated buffer?

-- Steve


> 
> Signed-off-by: Runping Lai <runpinglai@google.com>
> Reported-by: Wattson CI <wattson-external@google.com>
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 156e7e0bf559..bb9a6284a629 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7213,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
>  	entry = ring_buffer_event_data(event);
>  	entry->ip = ip;
>  
> -	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
> +	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
>  	if (len) {
>  		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
>  		cnt = FAULTED_SIZE;
> @@ -7310,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
>  
>  	entry = ring_buffer_event_data(event);
>  
> -	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
> +	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
>  	if (len) {
>  		entry->id = -1;
>  		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);

