Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276D13A3ED;
	Tue, 15 Oct 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954507; cv=none; b=Nar7cVK7uFtVis7LTfhd3N2zeB3dDkgotvlO5bbDD1XSiEG+0HaHk0HhromwJ3aFwuk8yx16tPf0XrR6ne7KGPDnWtCBqDAAiPqtwytB01rItUKfnr8VHmBjBg3tKHznvL5sTNnDVAd2S7GmSkmJwZCFP7luKpp//uFmbY7Ne04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954507; c=relaxed/simple;
	bh=7fi11oqdsEvU7LXkhsaTVxgl7Dg+idIz/SLSOKSmIOw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PH3ALl9c8kMF03uVXAftXzobw5v3nFjE8kBE+EMQYACJwbPalxVBkE2osPoRwHL6AL7xjT4vLQIbgbWve8lgJoswITWl2LnzRM7gvEaHzTf3zvRNKxNu7Lbz2tX62yYAjM0bkIhWERHuHG8qQY7buVlqt3ErhfGYfPFkHA2qrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C32C4CEC3;
	Tue, 15 Oct 2024 01:08:23 +0000 (UTC)
Date: Mon, 14 Oct 2024 21:08:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jose E. Marchesi" <jemarch@gnu.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Nick Desaulniers <ndesaulniers@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Zheng Yejian <zhengyejian@huaweicloud.com>, Andrii
 Nakryiko <andrii.nakryiko@gmail.com>
Subject: Have compiler remove __fentry locations from overwritten weak
 functions
Message-ID: <20241014210841.5a4764de@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

There's a long standing issue with having fentry in weak functions that
were overwritten. This was first caught when a "notrace" function was
showing up in the /sys/kernel/tracing/available_filter_functions list.

   https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/

What was happening is that ftrace uses kallsyms (what is basically listed
by nm) to map the location of __fentry to the previous symbol ahead of it.
Then it says that function is the name of the function for that __fentry.
But when you have weak functions, you can have this:


  int notrace do_not_watch_me(void)
  {
	return whatever;
  }

  void __weak define_me_in_arch(void)
  {
	return;
  }

The define_me_in_arch() gets a __fentry, but because it is overwritten, it
becomes attached to the end of do_not_watch_me(). When ftrace asks kallsyms
for the symbol name of that __fentry location, it returns
do_not_watch_me(), and ftrace will simply list that.

I currently have a hack in the kernel that has:

	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
	/* Weak functions can cause invalid addresses */
	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
		snprintf(str, KSYM_SYMBOL_LEN, "%s_%ld",
			 FTRACE_INVALID_FUNCTION, offset);
		ret = NULL;
	}

Which checks if the __fentry is too far away from the start of the symbol
returned and if so, it uses the name: __ftrace_invalid_address__

Then when you cat /sys/kernel/tracing/available_filter_functions you get:

   [..]
   do_one_initcall
   __ftrace_invalid_address___884
   rootfs_init_fs_context
   wait_for_initramfs
   __ftrace_invalid_address___84
   calibration_delay_done
   calibrate_delay
   [..]


The order of available_filter_functions matter as you can enable the filter
via the index into that file.

   seq 50 100 > /sys/kernel/tracing/set_ftrace_filter

will enable all the functions in available_filter_functions from index of
50 through 100 (it does it in n*log(n) time, where as echoing the names in
takes n^2 time). It also allows you to differentiate between different
functions with the same name.

That means the weak functions found still need to be listed, otherwise it
will make the index lookup not match what is shown.

But I was thinking, since gcc (and perhaps clang?) now has:

  -mrecord-mcount

that creates the __mcount_loc section that ftrace uses to find where the
__fentry's are. Perhaps the compiler can simply remove any of those
__fentry's that happen to exist in a weak function that was overridden.

Would this be something that the compiler could do?

-- Steve
