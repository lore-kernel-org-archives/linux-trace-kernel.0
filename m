Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFAF2E62C4;
	Fri,  4 Apr 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774326; cv=none; b=JMQRpgig9ev/68x4S/grb6FXaLzEu6d8AF38gkZUTk5YuH598LoczXmvktZE8J0aBePzrBwnDiihYweOUNvStmCG+w/liZuacZRCUJH07xz2hivBHsn+9mJShmHefsM5mgbd6UP86OMPILAq5kI+NQ4q3m39d9ejoaKkt++BaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774326; c=relaxed/simple;
	bh=RIjCzkBYrZ3eOlnkjx1fOdd9XKjiKDANIJ4T3CaLGWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHmxZ5Qej8nLt1t5gNttuBuqCyZ9Xi61LNpnBoj61K474G/pVn17ZsylnSt26x5Ff0K2Tor78HHiAspSi02T0ALcZoZ2DFzXEJFdUpsRZzeuPOiJlDJxYifofheK+eYXpWmO9nv8sUNcocJMxINcREJ3AHBf2nvpRA+tI8ASdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01423C4CEDD;
	Fri,  4 Apr 2025 13:45:24 +0000 (UTC)
Date: Fri, 4 Apr 2025 09:46:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] tracing: Replace deprecated strncpy() with strscpy()
 for stack_trace_filter_buf
Message-ID: <20250404094632.26f5b7c0@gandalf.local.home>
In-Reply-To: <20250404133105.2660762-1-devaanshk840@gmail.com>
References: <20250404133105.2660762-1-devaanshk840@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Apr 2025 19:01:03 +0530
Devaansh Kumar <devaanshk840@gmail.com> wrote:

> strncpy() is deprecated for NUL-terminated destination buffers and must
> be replaced by strscpy().
> 
> See issue: https://github.com/KSPP/linux/issues/90
> 
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
> ---
>  kernel/trace/trace_stack.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5a48dba912ea..982b1c88fce2 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
>   *
>   */
> +#include <linux/string.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/stacktrace.h>
>  #include <linux/security.h>

Is string.h really needed here? And if so, please keep the upside-down
x-mas tree format:

#include <linux/sched/task_stack.h>
#include <linux/stacktrace.h>
#include <linux/security.h>
#include <linux/kallsyms.h>
#include <linux/seq_file.h>
#include <linux/spinlock.h>
#include <linux/uaccess.h>
#include <linux/ftrace.h>
#include <linux/module.h>
#include <linux/sysctl.h>
#include <linux/init.h>

The includes *are* ordered.

-- Steve
