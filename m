Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD038F9A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348899; cv=none; b=QZwQvzk6BFzXAT3l2QKh4LusmLtuQUvRJ8EVO+2Vo9eGqu/cZQTQKuvJldqR0aHqQEctLv7BUuehaz/rX62nAU1ZcO2grAlVtZdZo6aVJ/VrBLgshxTif63KhZtfJjb+3eYrSLixihYQOLPQBnG2zFbs3vmSg9x/RtUUat//xvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348899; c=relaxed/simple;
	bh=KFsFmZL5edHZTOMJdwx9E4BAJSITxRdaDVp0inbfcXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Web8yYTNA0PnWeEcRGb9bW78TdKq9/d6YqRPK1BY8OoaXwIdhr2gMuELLAdtex4oGVAD9M73LU2jVE2hfiy3kczvAiwULZoSRVCRmfoOABLCkz6mC0cYO01LaOjgdvyS0Xuj3CzJ9sNoiLjA60AAY5uh7YjG/CrOxQkmzHBO/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B8C32782;
	Thu, 22 Aug 2024 17:48:18 +0000 (UTC)
Date: Thu, 22 Aug 2024 13:48:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tianyi Liu <i.pear@outlook.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 flaniel@linux.microsoft.com, albancrequy@linux.microsoft.com,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/1] tracing/uprobe: Add missing filter for
 uretprobe
Message-ID: <20240822134849.185f868e@gandalf.local.home>
In-Reply-To: <ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
References: <ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 01:36:20 +0800
Tianyi Liu <i.pear@outlook.com> wrote:

> U(ret)probes are designed to be filterable using the PID, which is the
> second parameter in the perf_event_open syscall. Currently, uprobe works
> well with the filtering, but uretprobe is not affected by it. This often
> leads to users being disturbed by events from uninterested processes while
> using uretprobe.
> 
> We found that the filter function was not invoked when uretprobe was
> initially implemented, and this has been existing for ten years. We have
> tested the patch under our workload, binding eBPF programs to uretprobe
> tracepoints, and confirmed that it resolved our problem.
> 
> Following are the steps to reproduce the issue:
> 
> Step 1. Compile the following reproducer program:
> ```
> #include <stdlib.h>
> #include <unistd.h>
> #include <stdio.h>
> 
> int main() {
>     printf("pid: %d\n", getpid());
>     while (1) {
>         sleep(2);
>         void *ptr = malloc(1024);
>         free(ptr);
>     }
> }
> ```
> We will then use uretprobe to trace the `malloc` function.
> 
> Step 2. Run two instances of the reproducer program and record their PIDs.
> 
> Step 3. Use uretprobe to trace each of the two running reproducers
> separately. We use bpftrace to make it easier to reproduce. Please run two
> instances of bpftrace simultaneously: the first instance filters events
> from PID1, and the second instance filters events from PID2.
> 
> The expected behavior is that each bpftrace instance would only print
> events matching its respective PID filter. However, in practice, both
> bpftrace instances receive events from both processes, the PID filter is
> ineffective at this moment:
> ```
> PID1=55256
> bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=55256
> time=2 pid=55273
> time=2 pid=55256
> time=4 pid=55273
> time=4 pid=55256
> time=6 pid=55273
> time=6 pid=55256
> 
> PID2=55273
> bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=55273
> time=0 pid=55256
> time=2 pid=55273
> time=2 pid=55256
> time=4 pid=55273
> time=4 pid=55256
> time=6 pid=55273
> time=6 pid=55256
> ```
> 
> After applying this patch, both bpftrace instances will show the expected
> behavior, only printing events from the PID specified by their respective
> filters:
> ```
> PID1=1621
> bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=1621
> time=2 pid=1621
> time=4 pid=1621
> time=6 pid=1621
> 
> PID2=1633
> bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=1633
> time=2 pid=1633
> time=4 pid=1633
> time=6 pid=1633
> ```

This did not need a cover letter. The above could be added to the patch
itself.

Just don't say "After applying this patch", it should be:

    
  The expected behavior is that each bpftrace instance would only print
  events matching its respective PID filter. However, in practice, both
  bpftrace instances receive events from both processes, the PID filter is
  ineffective at this moment:

  Before:
  ```
  PID1=55256
  [..]
  time=6 pid=55256
  ```
 
  After: Both bpftrace instances will show the expected behavior, only
  printing events from the PID specified by their respective filters:
  ```
  PID1=1621


-- Steve
