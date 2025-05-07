Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AC221FDC;
	Wed,  7 May 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653587; cv=none; b=nIUuCan52bg/lMhKzyhYah+HnCNlrW1VxzvMdY+Y8PBEA4ScRUWygwxh1AfdQj8MBDThm6VKkU6vSWKGHLpSNNnVP8Sz/cKHkch40+hqHeNb8n61k5agl8BVvWNVrXOLhgo5kNhFC0sjJJoISY42Fe7SAvLRRbnOPhOE3r0IXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653587; c=relaxed/simple;
	bh=LfAQ4q3Mr0+WzoqKHhVWFq4Yyw/xGIIZaV47zVjAuHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8f7ZW7frE8Wo2hv/lZ90eGHJRDc6BxlxnCJCje+GC4EgubpFjdNA74blBOVs0BtowXcGy0nDYW3oQZwP9OxmBhBpcQfqUaCnG+k+ZlEZjDK+A3/3fQrLUK3T3UkeMe8hCv3gP+xxcMkebkZjAMchtYKo4H0k2CKEwokh9iAV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FEBC4CEE2;
	Wed,  7 May 2025 21:33:06 +0000 (UTC)
Date: Wed, 7 May 2025 17:33:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Cc: paulcacheux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Namhyung Kim
 <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tracing: fix race when creating trace probe log
 error message
Message-ID: <20250507173316.76451024@gandalf.local.home>
In-Reply-To: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
References: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Masami,

Do you want to take this?

-- Steve


On Sun, 04 May 2025 20:27:51 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> Hello,
> 
> As reported in [1] a race exists in the shared trace probe log
> used to build error messages. This can cause kernel crashes
> when building the actual error message, but the race happens
> even for non-error tracefs uses, it's just not visible.
> 
> Reproducer first reported that is still crashing:
> 
>   # 'p4' is invalid command which make kernel run into trace_probe_log_err()
>   cd /sys/kernel/debug/tracing
>   while true; do
>     echo 'p4:myprobe1 do_sys_openat2 dfd=%ax filename=%dx flags=%cx mode=+4($stack)' >> kprobe_events &
>     echo 'p4:myprobe2 do_sys_openat2' >> kprobe_events &
>     echo 'p4:myprobe3 do_sys_openat2 dfd=%ax filename=%dx' >> kprobe_events &
>   done;
> 
> The original email suggested to use a mutex or to allocate the
> trace_probe_log on the stack. This patch implements a simpler
> solution suggest during the review of the v1 where we only protect
> access to the shared trace_probe_log with a mutex. This will prevent
> any crash from happening.
> 
> [1] https://lore.kernel.org/all/20221121081103.3070449-1-zhengyejian1@huawei.com/T/
> 
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
> Changes in v3:
> - add some comment around the new mutex definition
> - Link to v2: https://lore.kernel.org/r/20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com
> 
> Changes in v2:
> - change approach, and use the mutex based solution suggested during
>   review
> - Link to v1: https://lore.kernel.org/r/20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com
> 
> ---
> Paul Cacheux (2):
>       tracing: add missing trace_probe_log_clear for eprobes
>       tracing: protect trace_probe_log with mutex
> 
>  kernel/trace/trace_eprobe.c |  3 +++
>  kernel/trace/trace_probe.c  | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> ---
> base-commit: 95d3481af6dc90fd7175a7643fd108cdcb808ce5
> change-id: 20250420-fix-trace-probe-log-race-cc89d8e5fb15
> 
> Best regards,

