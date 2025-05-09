Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A138239090;
	Fri,  9 May 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746830700; cv=none; b=WLDPbh5ZHfAGRlyunNM9JVXxqs/PYMGji37Hw7guazYadnNOM+BSjsrz6uSHMFJXkYLnDIpe/amEAMlZ14IQrHWpxzqjugbtP9qe3nJzxOn44j8efp1041ytqfFB11D3SMHaN1ZMUhUpXL5UkGApRCLSv9vxoYn3N6lvqxsyDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746830700; c=relaxed/simple;
	bh=fKb7TEYqvMInxNM7qaKgpKCnmwEqHPcz0am/QG6Bsic=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C4WsfGihJX3EOFVrq+XYqlznC4E4hwthr7lDNTpuh5cybCfB9HUSCaF7MBnzSBFiY4ZKXTYfgh5/uoOLZ1OPahPR5fEH1Hg1MLScHYqClEaQslk7xnMi3PUy5wBdNcB6RXcLw5m+gxRcpH8KRQI2NqSLu6/T68BZzuUDsvnF+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxqLM7Z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxqLM7Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC45C4CEE4;
	Fri,  9 May 2025 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746830700;
	bh=fKb7TEYqvMInxNM7qaKgpKCnmwEqHPcz0am/QG6Bsic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxqLM7Z9QVe8pKqcQAgbsEEJVL3uTjgtX2hVbBN+oizwN56KIGZDSHUdaBx6spayi
	 5va8N6fgcWUJf7hAGJHy6e5fIpwCrW3HoUUZskt55ZctIR/IqQwtCuJ0/CGvk6V31H
	 U2qqG/ntfqBtpDOtHh2q+dmy63ELV2ZtiHQULBQ+8oR3cEabT5L6wcddVBQB0nVhWb
	 oDarmUDrdsCT9qBUL7znk9NAEC0xqDDFsb6yQ2NwaVsbVhsL5Nz5HcfqclPjIhqMFh
	 bajlrQbXQLHL8w623ovgvQgaY8TM7B+r76gZftJnPt1BKV8TPVPM/Dj/bUA848nJPL
	 RR4TD1T+ssdjQ==
Date: Sat, 10 May 2025 07:44:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulcacheux@gmail.com
Cc: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing: protect trace_probe_log with mutex
Message-Id: <20250510074456.805a16872b591e2971a4d221@kernel.org>
In-Reply-To: <20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
	<20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 15:15:53 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>
> 
> The shared trace_probe_log variable can be accessed and modified
> by multiple processes using tracefs at the same time, this new
> mutex will guarantee it's always in a coherent state.

Actually that's not happen. For the create part (and currently the
event_log is used only in the creation), `dyn_event_ops_mutex` is already
held in create_dyn_event(). Thus, it is already serialized.

And even if there are multiple events are done in parallel, this
is not enough because trace_probe_log::argc/argv can be changed
before other user finishs to use the log.

Thank you,

> 
> There is no guarantee that multiple errors happening at the same
> time will each have the correct error message, but at least this
> won't crash.
> 
> Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
> 
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..14a7a0b59cd20a8bc43e3e7c653e986081f924c8 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -154,9 +154,11 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
>  }
>  
>  static struct trace_probe_log trace_probe_log;
> +static DEFINE_MUTEX(trace_probe_log_lock);
>  
>  void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	trace_probe_log.subsystem = subsystem;
>  	trace_probe_log.argc = argc;
>  	trace_probe_log.argv = argv;
> @@ -165,11 +167,13 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
>  
>  void trace_probe_log_clear(void)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
>  }
>  
>  void trace_probe_log_set_index(int index)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	trace_probe_log.index = index;
>  }
>  
> @@ -178,6 +182,8 @@ void __trace_probe_log_err(int offset, int err_type)
>  	char *command, *p;
>  	int i, len = 0, pos = 0;
>  
> +	guard(mutex)(&trace_probe_log_lock);
> +
>  	if (!trace_probe_log.argv)
>  		return;
>  
> 
> -- 
> 2.49.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
