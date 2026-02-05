Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455A125D0;
	Thu,  5 Feb 2026 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257852; cv=none; b=UsIXA14CaShlCvVi7gZ9V/Y+LQklP1RnrviVSlrtbrRGtJfjrZFLflwRSwVNCd9pd7muS1v02P+CgP/EXXrm5RSZPgEYF3Rlnnm5tNibun3kfaCNJJmWgVOi5q/+HwgtRzGcpLY4XG717VBA2XguwHZ7/drhU4SJkvNCNmU3bOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257852; c=relaxed/simple;
	bh=zeahERPlSxSgVl9SJ4NWyVkSn3rX+et8OGBtAY6iN8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5XCi3AHEy3Mwf/7B2itLDZ0ZpyTwxwaMDgjXtFgLPuZLllM6YZph8uI3KtyDNrpPkAeY1K7ey/VDleo6X5QME6c+lS4bpcp33q82mmJjTPSC7zkBxEjRwJItdWbo3duPICEZSxjI1VYxVqDt4a5Yd5o6Ls14hmZY79ngT11w2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 9B352140124;
	Thu,  5 Feb 2026 02:17:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id E19866000A;
	Thu,  5 Feb 2026 02:17:22 +0000 (UTC)
Date: Wed, 4 Feb 2026 21:17:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260204211721.74e501f0@robin>
In-Reply-To: <176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: y1hsu6t5eanye8djkn55a4dwho6uc4ux
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E19866000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18std86Jtd2B+/gy1VN3ZY7xSTzvgJHMXE=
X-HE-Tag: 1770257842-387631
X-HE-Meta: U2FsdGVkX1+wFD9tri8xeDxvSNOjam4BeCVP7nkeVCQp/NNMDqnx1Ktl9ZlXUfPNnjcuxbvmohLduwez+wi8pc8TMvI7NdF/AzfOVvJp4P8gV1wgdZxH2UNaDSYqtL6DampxIndT8Sn89wRuZt2wV/wtU4OHiwz5ViLmghiIF1VGvPatJauYQLc1zvmYEUV+XfU+y1VBns9qO3/i+1MmKmNT9vBhotDhcT6fgmoBmFi6oydv73EiZhzy9r4wIML2VMA+6yCR020nBEWMEvtCNWBExvbA31/9OqGp0mfymyg/XXZPM4g0L4sXQ4jcPvYU9wLP4LY6gU/xzl50AIwV5S7xIBqfMTCT

On Sun,  1 Feb 2026 12:29:15 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since there is no reason to reuse the backup instance, make it
> readonly (but erasable).
> Note that only backup instances are readonly, because
> other trace instances will be empty unless it is writable.
> Only backup instances have copy entries from the original.
> 
> With this change, most of the trace control files are removed
> from the backup instance, including eventfs enable/filter etc.
> 
>  # find /sys/kernel/tracing/instances/backup/events/ | wc -l
>  4093
>  # find /sys/kernel/tracing/instances/boot_map/events/ | wc -l
>  9573
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>    - Remove tracing_on file from readonly instances.
>    - Remove unused writable_mode from tracing_init_tracefs_percpu().
>    - Cleanup init_tracer_tracefs() and create_event_toplevel_files().
>    - Remove TRACE_MODE_WRITE_MASK.
>    - Add TRACE_ARRAY_FL_RDONLY.
>  Changes in v5:
>    - Rebased on the latest for-next (and hide show_event_filters/triggers
>      if the instance is readonly.
>  Changes in v4:
>   - Make trace data erasable. (not reusable)
>  Changes in v3:
>   - Resuse the beginning part of event_entries for readonly files.
>   - Remove readonly file_operations and checking readonly flag in
>     each write operation.
>  Changes in v2:
>   - Use readonly file_operations to prohibit writing instead of
>     checking flags in write() callbacks.
>   - Remove writable files from eventfs.
> ---
>  kernel/trace/trace.c        |   94 +++++++++++++++++++++++++++++--------------
>  kernel/trace/trace.h        |    7 +++
>  kernel/trace/trace_boot.c   |    5 +-
>  kernel/trace/trace_events.c |   76 ++++++++++++++++++++---------------
>  4 files changed, 117 insertions(+), 65 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5c3e4a554143..b0efcf1e0809 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5052,6 +5052,11 @@ static ssize_t
>  tracing_write_stub(struct file *filp, const char __user *ubuf,
>  		   size_t count, loff_t *ppos)
>  {
> +	struct trace_array *tr = file_inode(filp)->i_private;
> +
> +	if (trace_array_is_readonly(tr))
> +		return -EPERM;
> +
>  	return count;
>  }
>  
> @@ -5152,6 +5157,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
>  	cpumask_var_t tracing_cpumask_new;
>  	int err;
>  
> +	if (trace_array_is_readonly(tr))
> +		return -EPERM;
> +

Shouldn't these checks be done in the open function? Doing it now is
too late, as -EPERM on a write is confusing when the open for write
succeeds.

-- Steve

>  	if (count == 0 || count > KMALLOC_MAX_SIZE)
>  		return -EINVAL;
>  
