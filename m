Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F4145B2D;
	Mon, 29 Jul 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263889; cv=none; b=TVeICM168O4jccrDB21kP5Ftshax3LEy9Pmvr9WAt3GEEw7JEbW9oC8oCjdw2ZeZzKX/wGHRi2qIGufVmFPRiPR30LgGsKZ6E8mLPdellM7dw/eMrodmLbZC/T/doCWU/5rFaSsby6FZvhOVSikY18smn+FLuTl62rclK+GGxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263889; c=relaxed/simple;
	bh=Xt999VbQVFPQj1/vPa5Kbg8ykz964fWuNLVeDQhc16g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ivM9CZ+VPPFyw416aD7qhVY+3zR/wOjrTrXon0i78InbFBvqhRHbZ+ZzrUWvMQDx/j3q1Kpyy0jnRUWVHFLW3I80dMgWwlpkhmQsPxaJAbIopcMNKfu7UUAnXbVUPlAidqceRbSON2n1DCGU9Spbzkfisgiewgc1bK7TFaLFItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWVZm9di; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWVZm9di"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26CC4AF0A;
	Mon, 29 Jul 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722263889;
	bh=Xt999VbQVFPQj1/vPa5Kbg8ykz964fWuNLVeDQhc16g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWVZm9diILZsCsoyKTettxPwqcr7DTAAL+ZffekcdZR+fE31VvnORiXYIVcESQ/+z
	 6d2Sr3d1cdJrDjRBzTYZep5gEOX9CO4mzG4pGclacjClKUmjpVHa5GaQhZ8Cq3jBEQ
	 JO/BdMBBkU+u/m6X8y2cYGKfSYsLW25B25QM8mCbRkLzZgEguxDb5Z8eSM/xQ0k3CM
	 zwrIFVDXJR1CLL1uPHenkOQhSJt6cM6+s6kx7UFlg4ayOGOz7BBdyrQNTnmQjdjzQj
	 ykyPe1mQFzVdULelOHjXgEpEgQ+b8lGmDrm0tFL6jJiU7pRco0M7AvhKX12X1EN/3/
	 lgiJhuV+855jA==
Date: Mon, 29 Jul 2024 23:38:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Mathias Krause
 <minipli@grsecurity.net>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-Id: <20240729233803.2b8cf1881e79fe883e1603a9@kernel.org>
In-Reply-To: <20240725201517.3c52e4b0@gandalf.local.home>
References: <20240725201517.3c52e4b0@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 20:15:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When eventfs was introduced, special care had to be done to coordinate the
> freeing of the file meta data with the files that are exposed to user
> space. The file meta data would have a ref count that is set when the file
> is created and would be decremented and freed after the last user that
> opened the file closed it. When the file meta data was to be freed, it
> would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
> and any new references made (like new opens or reads) would fail as it is
> marked freed. This allowed other meta data to be freed after this flag was
> set (under the event_mutex).
> 
> All the files that were dynamically created in the events directory had a
> pointer to the file meta data and would call event_release() when the last
> reference to the user space file was closed. This would be the time that it
> is safe to free the file meta data.
> 
> A short cut was made for the "format" file. It's i_private would point to
> the "call" entry directly and not point to the file's meta data. This is
> because all format files are the same for the same "call", so it was
> thought there was no reason to differentiate them.  The other files
> maintain state (like the "enable", "trigger", etc). But this meant if the
> file were to disappear, the "format" file would be unaware of it.
> 
> This fixes two bugs in the same code. One is a race that could be trigger
> via the user_events test (that would create dynamic events and free them),
> and running a loop that would read the user_events format files:
> 
> In one console run:
> 
>  # cd tools/testing/selftests/user_events
>  # while true; do ./ftrace_test; done
> 
> And in another console run:
> 
>  # cd /sys/kernel/tracing/
>  # while true; do cat events/user_events/__test_event/format; done 2>/dev/null
> 
> With KASAN memory checking, it would trigger a use-after-free bug. This was
> because the format file was not checking the file's meta data flag
> "EVENT_FILE_FL_FREED", so it would access the event that the file meta data
> pointed to after it was freed.
> 
> The second bug is that the dynamic "format" file also registered a callback
> to decrement the meta data, but the "data" pointer passed to the callback
> was the event itself. Not the meta data to free. This would either cause a
> memory leak (the meta data never was freed) or a crash as it could have
> incorrectly freed the event itself.
> 
> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me. It introduces a chance of checking EVENT_FILE_FL_FREED
as same as other files.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace_events.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..852643d957de 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1540,7 +1540,8 @@ enum {
>  
>  static void *f_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -	struct trace_event_call *call = event_file_data(m->private);
> +	struct trace_event_file *file = event_file_data(m->private);
> +	struct trace_event_call *call = file->event_call;
>  	struct list_head *common_head = &ftrace_common_fields;
>  	struct list_head *head = trace_get_fields(call);
>  	struct list_head *node = v;
> @@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
>  
>  static int f_show(struct seq_file *m, void *v)
>  {
> -	struct trace_event_call *call = event_file_data(m->private);
> +	struct trace_event_file *file = event_file_data(m->private);
> +	struct trace_event_call *call = file->event_call;
>  	struct ftrace_event_field *field;
>  	const char *array_descriptor;
>  
> @@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
>  
>  static void *f_start(struct seq_file *m, loff_t *pos)
>  {
> +	struct trace_event_file *file;
>  	void *p = (void *)FORMAT_HEADER;
>  	loff_t l = 0;
>  
>  	/* ->stop() is called even if ->start() fails */
>  	mutex_lock(&event_mutex);
> -	if (!event_file_data(m->private))
> +	file = event_file_data(m->private);
> +	if (!file || (file->flags & EVENT_FILE_FL_FREED))
>  		return ERR_PTR(-ENODEV);
>  
>  	while (l < *pos && p)
> @@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
>  	if (strcmp(name, "format") == 0) {
>  		*mode = TRACE_MODE_READ;
>  		*fops = &ftrace_event_format_fops;
> -		*data = call;
>  		return 1;
>  	}
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
