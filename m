Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC911B4F09
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665550; cv=none; b=UWClwrlnCaYczHPrnkF3FEujYv4wZsxxTSJV4Rg/LBhsxShaGOuvtUM4J3e7jJKZUcQilw1cPGCHqketvsvxayWSbig8KBLtleyXRzv5t9VqxXrk7pkYS6SBCHOd74AzHowLst4T9CPn1ijn4Gj88/dWFDvsXW4KTlA9+gyJCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665550; c=relaxed/simple;
	bh=JAbpiyI+BslwJ7B/Qzrqv5zuR8SU6ac0TFKrufawJ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKj2cGD0MNIL9GIUR/Dawp32i8Bq79IfpZzae00/F6PyC+jNEqKuc3rV/FnMqfWsNeEg09VJoeHF8X8ZGMOsiTpLBoTb4FnwdJ4c4bibKkOtaMzIDzAFwEQs2TbCoyHfMm2F1f7GT7XX7Z655ZwM3pOyelgWW6ebTSOOI8Btrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC63C4CEE4;
	Mon, 19 May 2025 14:39:09 +0000 (UTC)
Date: Mon, 19 May 2025 10:39:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: trace-cmd No such device Errors
Message-ID: <20250519103914.5d3a1074@batman.local.home>
In-Reply-To: <aCUCQW98EpmQg3zr@linux.ibm.com>
References: <aCUCQW98EpmQg3zr@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 02:21:13 +0530
Vishal Chourasia <vishalc@linux.ibm.com> wrote:

> When running trace-cmd record, I encounter multiple "No such device"
> errors due to the splice syscall failing with ENODEV for
> /sys/kernel/tracing/per_cpu/cpuX/trace_pipe_raw files corresponding to
> CPUs that are possible but not present.
> 
> Environment:
> - Operating System: Red Hat Enterprise Linux 9.5 (Plow)
> - Kernel: Linux 6.12.0-55.9.1.el10_0.ppc64le
> - Architecture: ppc64le
> - Command Executed: trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
> - System CPU Configuration:
>   - /sys/devices/system/cpu/possible: 0-223
>   - /sys/devices/system/cpu/present: 0-63
>   - /sys/kernel/tracing/per_cpu/: Contains directories cpu0 to cpu223

Thanks for the report. Could you also submit a bug report here:

  https://bugzilla.kernel.org/buglist.cgi?component=Trace-cmd%2FKernelshark&list_id=1152443&product=Tools&resolution=---


> 
> Steps to Reproduce: 
> 1. On a system with a mismatch between possible and present CPUs (e.g.,
>    possible: 0-223, present: 0-63). 
> 2. Ensure /sys/kernel/tracing/per_cpu/ contains directories for all possible 
>    CPUs (e.g., cpu0 to cpu223). 
> 3. Run the command:
> strace --decode-fds -kk -o strace/trace-cmd -ff -- trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
> 4. Observe the output and strace logs.
> 
> Expected Behavior: trace-cmd should only attempt to access
> trace_pipe_raw files for CPUs that are present (e.g., cpu0 to cpu63),
> completing the recording without errors.

Can you show me what you see in /sys/kernel/tracing/tracing_cpumask

Thanks,

-- Steve
