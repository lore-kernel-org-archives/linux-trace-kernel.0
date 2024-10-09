Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BE1362;
	Wed,  9 Oct 2024 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436381; cv=none; b=b8aAsWIgc7ynfV0iAcqt0SYDE6ZNCq8J8Zb/nRnozJ80oU/zBOZvxrZx301F3BnIaCZ4QHqSYdvmnOQaYVxZLhS7BN7mIneQXsutbcErI8sPvm0qc0yspMnFdvVDm4d8t8Vd9QpYRVd0BbKsdpd5M9lKzou2RIYcWj1f4svLQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436381; c=relaxed/simple;
	bh=XqYIw9ZcG3ewoGXFKf4LopgaOJar4Q/9yePITHPI7Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOKccXdQacRjrDsg7ju5qlFU3lhMjzs7/o7Zv2PDRjM6Mt2MtFU9CNG90bH4OIJ9jFst5vBYP3cbymy4exoPWgt5RiT6mjJJ0ksAQPk20j79/rv2jfAko6BWVVsMxnRAm1qSps4LiG0ZsTe804VRGLjcUYRWISckA3YPofQQu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B703C4CEC7;
	Wed,  9 Oct 2024 01:12:58 +0000 (UTC)
Date: Tue, 8 Oct 2024 21:12:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees
 Cook <kees@kernel.org>
Subject: Re: [PATCH] tracing: replace multiple deprecated strncpy with
 strscpy
Message-ID: <20241008211257.6c9c9f88@rorschach.local.home>
In-Reply-To: <20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com>
References: <20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 17:03:45 -0700
Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings [1] and
> as such we should prefer more robust and less ambiguous string interfaces.
> 
> We expect the @pattern and @num_buf strings to be NUL-terminated, as
> evidenced by their manual NUL-byte assignments immediately following
> each copy.
> 
> Switch to using strscpy which guarantees NUL-termination for the
> destination buffer -- eschewing manual NUL-byte assignments. strscpy
> does not NUL-pad so to keep this behavior zero-allocate @num_buf. @pred
> is already zero-allocated before the copies.
> 	pred = kzalloc(sizeof(*pred), GFP_KERNEL);
> 
> This should result in no behavioral changes whilst helping towards the
> goal of [2] -- with the ultimate goal of removing strncpy in favor of
> less ambiguous and more robust alternatives.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

So this breaks my tests. This is why I have trouble with taking changes
like this :-(

Before this patch, his worked:

 # echo 'common_pid != 0 && common_pid != 120 && common_pid != 1253 && common_pid != 17 && common_pid != 394 && common_pid != 81 && common_pid != 87' > /sys/kernel/tracing/events/sched/sched_switch/filter

But now it gives an error of:

 -bash: echo: write error: Invalid argument

I have to drop this.

-- Steve
