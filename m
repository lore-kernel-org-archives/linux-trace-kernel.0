Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6113C679;
	Fri, 19 Jul 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397372; cv=none; b=d4z0d6azOlymj2bMqnrDhOJq3qA0T9xVysaEpbDxaYdBOL/k6KQmcnKkOMMTq3jQX2KrgctF+pUvwUtSN6Z6XIOVQId8A8Ysh/9RJeI9FMO21TFr1xdDr22CocoC6rwfraontiNN0h1zol/DrCDXzPE0BDZ8boDbFRnVl/oc0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397372; c=relaxed/simple;
	bh=KKhBgZBUTuQkO5A5vGVz2Ey1wmgXc0rIGGDKBtZU1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kv87BC4M1Fp1+6z5fVgB3+zHdT675+jJKtmRt3YLCYyaBrWYS+bEAkwOH6ix3H7cUmN0tvp2rVjFvVwMO2CHZGfwVjA4016QBq88kTKLM8DTnrFGoFtXS49TYlzLrlA5OeaNdNpFA4z7X/EweW5JT9apFAymEJ67xKJwVzO5+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D440C4AF0B;
	Fri, 19 Jul 2024 13:56:10 +0000 (UTC)
Date: Fri, 19 Jul 2024 09:56:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zheng Yejian
 <zhengyejian1@huawei.com>, Vincent Donnefort <vdonnefort@google.com>, Huang
 Yiwei <quic_hyiwei@quicinc.com>, "Tzvetomir Stoyanov (VMware)"
 <tz.stoyanov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/ring-buffer: hide unused last_boot_fops
Message-ID: <20240719095608.31e4c67f@rorschach.local.home>
In-Reply-To: <20240719102640.718554-1-arnd@kernel.org>
References: <20240719102640.718554-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 12:26:33 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This variable is used only in an #ifdef, which causes a W=1 warning
> with some compilers:
> 
> kernel/trace/trace.c:7570:37: error: 'last_boot_fops' defined but not used [-Werror=unused-const-variable=]
>  7570 | static const struct file_operations last_boot_fops = {
> 
> Guard this one with the same #ifdef.
> 
> Fixes: 7a1d1e4b9639 ("tracing/ring-buffer: Add last_boot_info file to boot instance")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually "last_boot_info" and snapshot should be mutually exclusive.
That is, an instance can have a snapshot or the "last_boot_info" but not
both. The real fix is:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5462fb10ff64..0d1841b3363e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9828,15 +9828,15 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
-#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->range_addr_start) {
 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
 				  tr, &last_boot_fops);
+#ifdef CONFIG_TRACER_SNAPSHOT
 	} else {
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
-	}
 #endif
+	}
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_err_log_fops);


I'll write up a patch and give you the "reported-by".

Thanks!

-- Steve
