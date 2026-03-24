Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8737B023;
	Tue, 24 Mar 2026 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317096; cv=none; b=DxcFaqNO0eZCb1moSTlmcr1OJ482iadbDwJg5dU1yO9aIuijAZeCOc+bF2s1dzl8ht1OVS4U3D0jIs7h2d1tdS00LaZiER939gpZRLUGpMqUbzbRrXqI8gMT1UnsNcztPwlljpMRnZf9kPAlw+ZpzV/FN5V9n3z0MU0Z7OJ9vTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317096; c=relaxed/simple;
	bh=QS7PQqz8sdka0ELrhHAzQZCbJF2Fe9++4y8m3ItLYNg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tOFBWY/bKbU3QJpid9Ukl2Zx+Hdfc3PuXin3ob1z2wQvCVqRt022/yEFZcq0AosLEOJ2/EWacNfAAIlE6sjaHkrAVe/R9R52Mq1fO1U5R5eZhYQaIuRUH2o0qtX0yEvPlsGxj1qpZHJmZpeEVycoDEup2XguMEx3ZkHIoU6IonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+Sc4MHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+Sc4MHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B20C4CEF7;
	Tue, 24 Mar 2026 01:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317096;
	bh=QS7PQqz8sdka0ELrhHAzQZCbJF2Fe9++4y8m3ItLYNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+Sc4MHQXPHtHkoP20K7GUGZIzTmZFKOn9S+OJ15bRSiWPusDD0XSPNmJhoyyTlyi
	 FYI/HiFy3nMYm88LF5ywnz/qrzppO4rJXziE3/Uwrb2HAFF/2V413AYFbBlxR1oEbZ
	 HnQmmv8sJCuw+zwPIy1lVoc1janNlLgka7Y2arLMioLKGYuPoyCEKZ8R9m95I+0gm3
	 TZM8mhfrEwrb9UXn2CQzSzzsJoQR8l3gw/LkE/QFMM6GrY4bJVId+A4STLPoCLEr0G
	 /qR3S3cy5OciOuZjwFJj/jVc1MR3IymLG+yPc9bgg9zz5CPZ4fKQgxsRXV0NGqsStu
	 fWJn2oA2CW1DA==
Date: Tue, 24 Mar 2026 10:51:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/4] tracing/fprobe: Support comma-separated symbol
 lists and :entry/:exit suffixes
Message-Id: <20260324105133.aeddf1a049afead53f92cc2c@kernel.org>
In-Reply-To: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sorry, I completely missed this series. Let me review it.

Thank you,

On Thu,  5 Feb 2026 08:58:38 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

> Extend the fprobe event interface to accept comma-separated symbol lists
> with ! exclusion prefix, and :entry/:exit suffixes as an alternative to
> %return.  Single-symbol probes retain full backward compatibility with
> %return.
> 
> Example usage:
>   f:mygroup/myevent vfs_read,!vfs_write,vfs_open:entry
>   f:mygroup/myexit  vfs_read,vfs_open:exit
> 
> Changes since v5:
>   - Fix missing closing brace in the empty-token check that caused a
>     build error.
>   - Remove redundant strchr/strstr checks for tracepoint validation;
>     the character validation loop already rejects ',', ':', and '%'.
>   - Add trace_probe_log_err() to the tracepoint character validation
>     loop so users see what went wrong in tracefs/error_log (reviewer
>     feedback from Masami Hiramatsu).
>   - Remove unnecessary braces around single-statement if per kernel
>     coding style (reviewer feedback).
>   - Extract list parsing into parse_fprobe_list() to keep
>     parse_fprobe_spec() focused (reviewer feedback).
>   - New patch 2/4: add glob_match_comma_list() in kernel/trace/fprobe.c
>     so register_fprobe() correctly handles comma-separated filter
>     strings.  Without this, enabling a list-mode fprobe event failed
>     with "Could not enable event" because glob_match() does not
>     understand commas.
>   - Reorder: documentation patch now comes after all code changes.
>   - Updated selftest commit message to note that existing tests
>     (add_remove_fprobe.tc, fprobe_syntax_errors.tc,
>     add_remove_fprobe_repeat.tc) report UNSUPPORTED because their
>     "requires" lines still check for the old %return syntax in README.
>     Their requires lines need updating in a follow-up patch.
> 
> Tested in QEMU/KVM but I am not too confident if I configured correctly and
> would like to ask for further testing. 
> 
> Seokwoo Chung (Ryan) (4):
>   tracing/fprobe: Support comma-separated symbols and :entry/:exit
>   fprobe: Support comma-separated filters in register_fprobe()
>   docs: tracing/fprobe: Document list filters and :entry/:exit
>   selftests/ftrace: Add accept cases for fprobe list syntax
> 
>  Documentation/trace/fprobetrace.rst           |  17 +-
>  kernel/trace/fprobe.c                         |  30 ++-
>  kernel/trace/trace.c                          |   3 +-
>  kernel/trace/trace_fprobe.c                   | 219 ++++++++++++++----
>  .../ftrace/test.d/dynevent/fprobe_list.tc     |  92 ++++++++
>  5 files changed, 308 insertions(+), 53 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> 
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
