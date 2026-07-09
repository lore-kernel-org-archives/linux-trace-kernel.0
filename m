Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C43A7858;
	Thu,  9 Jul 2026 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575495; cv=none; b=rI+mfV38HCDEbsVpG0yGLICSsIiRqIZXKvldydnsbrY0fqRoUjwFhgxcJaIL1QtZtZ+3il7GTQb0AHkdwK+6B75asCkU2oFa1IoQo56ba71JHxgnKv1xjdD/c+1BRmcHlXrYPtjhPUbTrOBjfauQ91yEz8YuHXwzMpgIDqtIxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575495; c=relaxed/simple;
	bh=wnYQM2WU/yhdEKYNCd7dIsGHntNG5Z4GPQT+6DcdbjI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jeIgGk7+pTPRdUmHumOSyx/VbxtiEbLXcULrDypTIHa45dEyuGl7smIavWkmmtWXJ6vzZleSV0GksK44Wq5nwYujZVqEDa62MT4gJBShJpy6jyuaUnd2VSofCMi8E2U5y3C1gYgYFCZ3pa4mBMRK3UxUAyD6qjLckhdJ+THNTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEQk3q1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEQk3q1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E41F00A3A;
	Thu,  9 Jul 2026 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783575493;
	bh=wd+boNMSPRHnwfyREAFQg1w3f/YXBAsY9IGcciO5Tso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VEQk3q1t6z+EDYWgr9L5PXh2Zs0v9JE9hNY6iW/7uhQDkl5k6tKqeDnSnpMVTm1g6
	 HQz+kDrK23VAd2IdtS6wwTx28xcoOaEPc8Q+CYv/Ni0FqHtDjSyiw/yod97e3MA7Vq
	 Iv+Dx9humhpw0p9SxVZHQ3dekke7MFY06nxA548jOrTa3W96udn8itGU5XwaRJllcc
	 zW3PaKUeoBDvNBVWn9SDNQbybmFwqQdrZJzBVr5HPnbrNJIDBapbsdTHR0DTcMBbrT
	 9Cs/AkFrUZrAqKe0xqmcjI3eHVGV4hFh9IwbsyFRmCeia0krftif03d4NJbE6auzFU
	 EkanCaajobHFA==
Date: Thu, 9 Jul 2026 14:38:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Fix reading enabled_functions in
 add_remove_fprobe_module test
Message-Id: <20260709143811.37abee846223b8f7c7da02e8@kernel.org>
In-Reply-To: <20260708153239.055d56dd@gandalf.local.home>
References: <20260708153239.055d56dd@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 15:32:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The add_remove_fprobe_module test checks the number of functions added to
> the enabled_functions file to make sure that the functions added or
> removed is as expected. The issue is that it expects this file to be empty
> on start up.
> 
> Now that systemd uses BPF that attaches to functions via ftrace, this file
> is not empty in several systems:
> 
>  # cat /sys/kernel/tracing/enabled_functions
>  bpf_lsm_file_open (1) R   D   M 	tramp: ftrace_regs_caller+0x0/0x61 (call_direct_funcs+0x0/0x50)
> 	direct(jmp)-->bpf_trampoline_6442529439+0x0/0xe9
> 
> Change the test to read the number of lines in enabled_functions at the
> start of the test and subtract that from the value of the count for the
> checks within the test.

Oops, good catch! I need to make a test environment which uses
systemd...

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  .../dynevent/add_remove_fprobe_module.tc      | 27 ++++++++++++-------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> index 2915206777b6..89660a9adf44 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> @@ -16,23 +16,32 @@ echo > dynamic_events
>  FUNC1='foo_bar*'
>  FUNC2='vfs_read'
>  
> +:;: "Save enabled functions count" ;:
> +ecount=`cat enabled_functions | wc -l`
> +
> +count_enabled_functions() {
> +    count=`cat enabled_functions | wc -l`
> +    count=$(($count-$ecount))
> +    echo $count
> +}
> +
>  :;: "Add an event on the test module" ;:
>  echo "f:test1 $FUNC1" >> dynamic_events
>  echo 1 > events/fprobes/test1/enable
>  
>  :;: "Ensure it is enabled" ;:
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -ne 0
>  
>  :;: "Check the enabled_functions is cleared on unloading" ;:
>  rmmod trace-events-sample
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -eq 0
>  
>  :;: "Check it is kept clean" ;:
>  modprobe trace-events-sample
>  echo 1 > events/fprobes/test1/enable || echo "OK"
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -eq 0
>  
>  :;: "Add another event not on the test module" ;:
> @@ -40,19 +49,19 @@ echo "f:test2 $FUNC2" >> dynamic_events
>  echo 1 > events/fprobes/test2/enable
>  
>  :;: "Ensure it is enabled" ;:
> -ofuncs=`cat enabled_functions | wc -l`
> +ofuncs=`count_enabled_functions`
>  test $ofuncs -ne 0
>  
>  :;: "Disable and remove the first event"
>  echo 0 > events/fprobes/test1/enable
>  echo "-:fprobes/test1" >> dynamic_events
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $ofuncs -eq $funcs
>  
>  :;: "Disable and remove other events" ;:
>  echo 0 > events/fprobes/enable
>  echo > dynamic_events
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -eq 0
>  
>  rmmod trace-events-sample
> @@ -63,12 +72,12 @@ echo "f:test1 $FUNC1" >> dynamic_events
>  echo 1 > events/fprobes/test1/enable
>  echo "f:test2 $FUNC2" >> dynamic_events
>  echo 1 > events/fprobes/test2/enable
> -ofuncs=`cat enabled_functions | wc -l`
> +ofuncs=`count_enabled_functions`
>  test $ofuncs -ne 0
>  
>  :;: "Unload module (ftrace entry should be removed)" ;:
>  rmmod trace-events-sample
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -ne 0
>  test $ofuncs -ne $funcs
>  
> @@ -77,7 +86,7 @@ echo 0 > events/fprobes/test2/enable
>  echo "-:fprobes/test2" >> dynamic_events
>  
>  :;: "Ensure ftrace is disabled." ;:
> -funcs=`cat enabled_functions | wc -l`
> +funcs=`count_enabled_functions`
>  test $funcs -eq 0
>  
>  echo 0 > events/fprobes/enable
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
