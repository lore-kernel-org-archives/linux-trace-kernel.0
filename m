Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F30319616;
	Wed, 17 Sep 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116195; cv=none; b=Cxw/Rmex0uoMTeKaGOcQi63s96cRqlbSRoasLAZ/dccnOK28lOqlzRuSUnQeU7JC94ihCzGHhmfQLuPSuVGzIJC0eACRv4s94PQrVbwRsMVxbU6+mqkVvQbUWnLZ7fTpGu+B7+CaDJhR35G0CCWL55AphOVznv6Xv5ac2G2qOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116195; c=relaxed/simple;
	bh=S9mXumzYte5Pst5IA96k4rhntC25b69jTUmGsPuAoM8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pXoZICkeVsrQQb048n/pSMvifpYamog7tl7Wbrxi9UGVqJtjey7K652TeyWADsegXnbgLf539ji9zlrGx/lv0WQ96wqFq1RQ04fovaWbtHJ/PIdX3QW/X/L+Nq8mhR/2rjxzXtlIx17cLwq7DcnSE2WpgCNxbVf+r10HNh7Gaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XifFkS6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XifFkS6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2913BC4CEF7;
	Wed, 17 Sep 2025 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758116195;
	bh=S9mXumzYte5Pst5IA96k4rhntC25b69jTUmGsPuAoM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XifFkS6VVp607mqDbRvGRnDvsQIP4JYdMEn9cO0EJjIaJ8n5haZHK7wRbbTCxTJmD
	 QXgkxYUV6l6W7XjplQu/+sOZbI8FwQRA8BOvA/ivvr5I9oIJhasMaQDuRLm3eSCLB7
	 1ueydVAwr6FMjxirmjGsJH5tZmQSJUsy3sKjVWyYHuXG881Y0kBXEj4Zv5WF4+3O/9
	 IltlruCSmUWdR8lnjfVh6bUCMVZJHIXyzDK+4raVr+h0JfjQirgLT9qscBfx1X/8Lh
	 ndiVfRcY/ajSkTw+Z1hkvNEgkGVJjJ5uZyxEm47HLfojwU/JLYY1TpxdIbsSsLsCQX
	 dgJlwcUFGUfOQ==
Date: Wed, 17 Sep 2025 22:36:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: kprobe-event: Fix null-ptr-deref in
 trace_kprobe_create_internal()
Message-Id: <20250917223630.f936f6e71964037f07a33838@kernel.org>
In-Reply-To: <20250916075816.3181175-1-wangliang74@huawei.com>
References: <20250916075816.3181175-1-wangliang74@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 15:58:16 +0800
Wang Liang <wangliang74@huawei.com> wrote:

> A crash was observed with the following output:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 2899 Comm: syz.2.399 Not tainted 6.17.0-rc5+ #5 PREEMPT(none)
> RIP: 0010:trace_kprobe_create_internal+0x3fc/0x1440 kernel/trace/trace_kprobe.c:911
> Call Trace:
>  <TASK>
>  trace_kprobe_create_cb+0xa2/0xf0 kernel/trace/trace_kprobe.c:1089
>  trace_probe_create+0xf1/0x110 kernel/trace/trace_probe.c:2246
>  dyn_event_create+0x45/0x70 kernel/trace/trace_dynevent.c:128
>  create_or_delete_trace_kprobe+0x5e/0xc0 kernel/trace/trace_kprobe.c:1107
>  trace_parse_run_command+0x1a5/0x330 kernel/trace/trace.c:10785
>  vfs_write+0x2b6/0xd00 fs/read_write.c:684
>  ksys_write+0x129/0x240 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x5d/0x2d0 arch/x86/entry/syscall_64.c:94
>  </TASK>
> 
> Function kmemdup() may return NULL in trace_kprobe_create_internal(), add
> check for it's return value.

Oops, thanks for fixing!
Let me pick this!

> 
> Fixes: 33b4e38baa03 ("tracing: kprobe-event: Allocate string buffers from heap")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  kernel/trace/trace_kprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index ccae62d4fb91..fa60362a3f31 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -908,6 +908,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  			return -EINVAL;
>  		}
>  		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
>  		buf[len] = '\0';
>  		ret = kstrtouint(buf, 0, &maxactive);
>  		if (ret || !maxactive) {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
