Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A930C37D;
	Tue, 19 Aug 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625820; cv=none; b=fDQ+yWabYUjmvI9i9OzeTKIiXcxRu8WpNcN7SNpEMwpFqtFJg2RJc/Bdb0H49UXcbfTPf5TeSvi5JzEqU2MyosKEB+ZoLlVODZuBV+hL1V6wh34s/dtVXz4Yx1fEXB7RlhpxVeKdmjfeFMQ+ZG2iv7jHN6KH8oprC72e62C0sCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625820; c=relaxed/simple;
	bh=OhvM2c7vEcF7jWm0ycE4LKWrQFWuA4XQtHjMBwYvVro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdP9OKuLt0MEDajT58D4PlhjFZvjUAG20L7wEKmxeYGDum4cJY4ELmz0PA4oLpX/vtmUYvSMofI45ibHoio6dtO+d3OCOM1jLlmYofxbqc8/zv2IumKb6N6vfgP7SrV8c6n8dFS29wepqhMrZnqoca3MeoRK5aUEjSCw37RxygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D808B81E0F;
	Tue, 19 Aug 2025 17:50:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 1AC4120028;
	Tue, 19 Aug 2025 17:50:08 +0000 (UTC)
Date: Tue, 19 Aug 2025 13:50:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250819135008.5f1ba00e@gandalf.local.home>
In-Reply-To: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AC4120028
X-Stat-Signature: p8w9hboa5cfhpjby15feuu5fzpmreku7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WEKIKa+f8n9kXIveZU+urR907NvqVxVg=
X-HE-Tag: 1755625808-295650
X-HE-Meta: U2FsdGVkX18xwxqT8yDACISI+ww2K8vt7CJrfyYEbE9Cn0iPMCF2zzIr3mRABDlQWj+Hyob1lra91gAGYw2UPXqpF49FqkFclE1Rbvpb8uxh1YgR2Dvy2cXBZyKGZ+d1HOQA/SUU9JbMEIzNoZyxLDdzuGMr4kceqaw7axGmxnvVgvEjTQU7dv5zfHPl/9snGwjhr2pzsScNMoZr8wvQMO++miKZNJEjMpi8BSufxS0w6eCGdNWC9cImN7iyuHIBrx/oL22c+YABEJuBIASGiwkNZgw5ToHCS6rQAv0+67nBlkcUj2ntHG1tiNlcdbIIzddlnb/hPBc8sjQOLXMsQCNYYcriaL+p

On Tue, 19 Aug 2025 10:51:52 +0000
Luo Gengkun <luogengkun@huaweicloud.com> wrote:

> Both tracing_mark_write and tracing_mark_raw_write call
> __copy_from_user_inatomic during preempt_disable. But in some case,
> __copy_from_user_inatomic may trigger page fault, and will call schedule()
> subtly. And if a task is migrated to other cpu, the following warning will

Wait! What?

__copy_from_user_inatomic() is allowed to be called from in atomic context.
Hence the name it has. How the hell can it sleep? If it does, it's totally
broken!

Now, I'm not against using nofault() as it is better named, but I want to
know why you are suggesting this change. Did you actually trigger a bug here?

> be trigger:
>         if (RB_WARN_ON(cpu_buffer,
>                        !local_read(&cpu_buffer->committing)))
> 
> An example can illustrate this issue:
> 
> process flow						CPU
> ---------------------------------------------------------------------
> 
> tracing_mark_raw_write():				cpu:0
>    ...
>    ring_buffer_lock_reserve():				cpu:0
>       ...
>       cpu = raw_smp_processor_id()			cpu:0
>       cpu_buffer = buffer->buffers[cpu]			cpu:0
>       ...
>    ...
>    __copy_from_user_inatomic():				cpu:0
>       ...
>       # page fault
>       do_mem_abort():					cpu:0

Sounds to me that arm64 __copy_from_user_inatomic() may be broken.

>          ...
>          # Call schedule
>          schedule()					cpu:0
> 	 ...
>    # the task schedule to cpu1
>    __buffer_unlock_commit():				cpu:1
>       ...
>       ring_buffer_unlock_commit():			cpu:1
> 	 ...
> 	 cpu = raw_smp_processor_id()			cpu:1
> 	 cpu_buffer = buffer->buffers[cpu]		cpu:1
> 
> As shown above, the process will acquire cpuid twice and the return values
> are not the same.
> 
> To fix this problem using copy_from_user_nofault instead of
> __copy_from_user_inatomic, as the former performs 'access_ok' before
> copying.
> 
> Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")

The above commit was intorduced in 2016. copy_from_user_nofault() was
introduced in 2020. I don't think this would be the fix for that kernel.

So no, I'm not taking this patch. If you see __copy_from_user_inatomic()
sleeping, it's users are not the issue. That function is.

-- Steve



> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
