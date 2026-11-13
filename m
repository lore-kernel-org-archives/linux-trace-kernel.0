Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535897;
	b=M26rnBdLLg73pVuPmA0Js645JpKWkDckDXsXAQCzOBtbKJrTQCRT0B/7LXR8jNjLC8Z4
	 6KBolmSxgeAZ7DCvEWXOgoVVPXthjfdCeN7Mw85dmsDfxP6YNS6bc5ul31dJlx3HVhZuT
	 8fYHuxUKNaVXhEOPDRzNcn7MiiAzuSFsheQIFv0jjJrIrBqQQ6HLFVFwtzqeiwzzFuEDm
	 f8c9w4Va+063BP0gjEkv6XgE3FMDJHPPFCHZmtpjiFUur4d2uq+b7GVCrXdbdBCnxVwsk
	 s7hbqz8Jmlrg3mDu3/5spbJ/9Pex1U5KSJmQ9kTsIA9T2gfLiOZ3oTYmoFVr50AaKow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jkHQBq5gRQDHu+wxTZ/fIcabmGhG1mmG2RhVjrNHPYs=;
	b=3l/n7xMZXYWRdIDDINiUAm0ahNOlSz4qdE41ViZWx1CkBUJhYPqWXH57orDML1BODlMS
	 VN5e52bj4TgT/tfCXPL9ccGFtRiipVrkVfXig9/zpwc0W7F1vlphAtDPEz7V3zGzfJxBP
	 zt+4JyETP0n856XmKLnS/DYLiTGwPb74h1CCwsSXAAuZEf0F9g8vivBoNW1HKzSs2P2mh
	 MRP3JhKFsG2Ul/M+UlgKRq2ghR7sYMptao9HMKKA6+SnTm2YLXdXfE3fdvh9sicviqiQ7
	 GridTFcCtzRKC6Vl111BXFoQ9cAN+o0FG3t4sg0cKhJRcx2RS5wlxbsVM0H0k5VJd8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEcXxZ7u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39F606A321;
	Fri, 13 Nov 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEcXxZ7u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E7B1F000C4;
	Fri, 13 Nov 2026 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794535896;
	bh=jkHQBq5gRQDHu+wxTZ/fIcabmGhG1mmG2RhVjrNHPYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEcXxZ7ux+0IAh2zdQppHphMmgIJfQdjEx57j8DfqLdDMsNOR0WMS79p+sNPR1RrT
	 ExbC5OzzD1uTYrSNxyP1N3fDed89yhyMyozkT54v1sF2IuR61GDXFi/ryHtyFwFzgy
	 l6d1Gs1Sad/gYehrXO34AS+wcF+EJtcTSxxnvsa/KSNjVZO6yBPCocnxWvD9/83W1L
	 9HeeDEjqb9lY5o4XbOb4PkVpqQFx87nJL8hDRCONPLm7npljKO35LTflxMY52zDwKd
	 BT0RTR3hQslIrTcAHsWFgN3Uai91fLdOYNGbb6HAYaJcLUDKRUB/IGE8DWtbWD0SY3
	 Uak9CHbE9BWrw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Wenwen Fu <wenwfu@qti.qualcomm.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: skip boot kprobe setup when no events were requested
Date: Fri, 13 Nov 2026 11:11:33 +0900
Message-ID: <undine-1794535893601698549-753ef018e21da197@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261106021457.2648231-1-wenwfu@qti.qualcomm.com>
References: <20261106021457.2648231-1-wenwfu@qti.qualcomm.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri,  6 Nov 2026 10:14:57 +0800, Wenwen Fu <wenwfu@qti.qualcomm.com> wrote:
> setup_boot_kprobe_events() calls enable_boot_kprobe_events() even when
> the kprobe_event= boot parameter was not supplied. That call takes
> event_mutex without any command-line probes to enable.
> 
> Asynchronous eval-map updates also hold event_mutex. A normal boot can
> therefore wait in init_kprobe_trace() for this background work despite
> having no boot probes to set up.
> 
> Return early when the boot-event buffer is empty. Keep the mutex
> protection in trace_event_update_all() and retain setup for explicit
> kprobe_event= parameters. Bootconfig handles its own probe enablement,
> and the existing trace_eval_sync() still waits for background work
> before init memory is freed.

Nice catch! This looks good to me. Let me pick it with below tag.

Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")

Thanks,

> 
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
>  kernel/trace/trace_kprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index ee8171b19bee..52ec16d8d838 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1995,6 +1995,9 @@ static __init void setup_boot_kprobe_events(void)
>  	char *p, *cmd = kprobe_boot_events_buf;
>  	int ret;
>  
> +	if (!kprobe_boot_events_buf[0])
> +		return;
> +
>  	strreplace(kprobe_boot_events_buf, ',', ' ');
>  
>  	while (cmd && *cmd != '\0') {
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

