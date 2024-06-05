Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150E1946CA;
	Wed,  5 Jun 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580760; cv=none; b=nQ9AJ5UDbo8uuPdi/AUZlAsdnckCKv3PrBvQCi5arwBgYOtVr+D1vjYsIukeqvr4UdZus8cVJO0iqAyV3WLaSIkg9GzGwPJJEY4q6YRMQeqrSC/tooXnh+P4HTGi5ScTKv6nx/fawyuLLxQ0jK6HtJsXvN14MFvh3giYzjtDmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580760; c=relaxed/simple;
	bh=HRhwsCwZJMDT/pJ0buxmvyRoZ6tgXbl42wDlzIPXQGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yosi5M8EFnHx+xZt+ATusVR8bEVeKjwxI9p5mcDPtwne9d58o9mAV5RSpbPebXDBZLGVWHnLwhQWX9vsMmRNIPhWXTHRvusmh4rlHTfmY/C6yTTimy6BWj/uyk1I6olnZ/Z7cRnLIbOFRt9v7P+SABZ5/qALwnSIkLStNVMGaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F951DA7;
	Wed,  5 Jun 2024 02:46:22 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426913F792;
	Wed,  5 Jun 2024 02:45:57 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:45:54 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace/selftests: Fix pid test with function graph not
 showing pids
Message-ID: <ZmAz0uEKV_9ijfSF@J2N7QTR9R3>
References: <20240604152550.0c01d7cd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604152550.0c01d7cd@gandalf.local.home>

On Tue, Jun 04, 2024 at 03:25:50PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The pid filtering test will set the pid filters and make sure that both
> function and function_graph tracing honors the filters. But the
> function_graph tracer test was failing because the PID was not being
> filtered properly. That's because the funcgraph-proc option wasn't getting
> set. Without that option the PID is not shown.
> 
> Instead we get:
> 
> 	+ cat trace
> 	# tracer: function_graph
> 	#
> 	# CPU  DURATION                  FUNCTION CALLS
> 	# |     |   |                     |   |   |   |
> 	 3) ! 143.685 us  |  kernel_clone();
> 	 3) ! 127.055 us  |  kernel_clone();
> 	 1) ! 127.170 us  |  kernel_clone();
> 	 3) ! 126.840 us  |  kernel_clone();
> 
> When we should be getting:
> 
> 	+ cat trace
> 	# tracer: function_graph
> 	#
> 	# CPU  TASK/PID         DURATION                  FUNCTION CALLS
> 	# |     |    |           |   |                     |   |   |   |
> 	 4)    bash-939    | # 1070.009 us |  kernel_clone();
> 	 4)    bash-939    | # 1116.903 us |  kernel_clone();
> 	 5)    bash-939    | ! 976.133 us  |  kernel_clone();
> 	 5)    bash-939    | ! 954.012 us  |  kernel_clone();
> 
> The test looks for the pids it is filtering and will fail if it can not
> find them. Without fungraph-proc option set, it will not be displayed and
> the test will fail.
> 
> Link: https://lore.kernel.org/all/Zl9JFnzKGuUM10X2@J2N7QTR9R3/
> 
> Fixes: 35b944a997e2 ("selftests/ftrace: Add function_graph tracer to func-filter-pid test")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Applying this makes the pid filter tests go from FAIL to PASS, so FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> index c6fc9d31a496..8dcce001881d 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> @@ -8,6 +8,7 @@
>  # Also test it on an instance directory
>  
>  do_function_fork=1
> +do_funcgraph_proc=1
>  
>  if [ ! -f options/function-fork ]; then
>      do_function_fork=0
> @@ -28,6 +29,7 @@ fi
>  
>  if [ $do_funcgraph_proc -eq 1 ]; then
>      orig_value2=`cat options/funcgraph-proc`
> +    echo 1 > options/funcgraph-proc
>  fi
>  
>  do_reset() {
> -- 
> 2.43.0
> 
