Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FD2571A0;
	Thu, 23 Jul 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822545; cv=none; b=SJPx1MWJWQge5NhxxEfFEm9+HfQVYK0dkyZOMZrc2wyn44uUbek6qEbLZeYMeh7I6nsi6QuuNx6A14KKyKaeXiccSgVFicPx8I1CQYinfGz4oNPg/+hy6f9AQNTdTCFUM/iGBk1H3ENN7MvuC+wMjanWZsE5C7wE7YDc3XS3dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822545; c=relaxed/simple;
	bh=v14QlQzxVxtOQXjyOGfUdwYKlKkXH0ECUwdzKMwXl2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCGSgxXObSLgX3X8H9HGey4aJhMId9uiD3+PZON/wXzwWCzeOnrso4FoQYXi+e1rWav3orNxVvfv9ucq6Wmmbm3p5j8IwVylIhCqM+uXdUOrs2/eELSNA+kotYRwFVoZe1yxALAMVw6upRL58BFp5edx+ZIBUmvYpZbIrhQfm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 51FF11A0593;
	Thu, 23 Jul 2026 16:02:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 66BCF18;
	Thu, 23 Jul 2026 16:02:20 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:02:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Defer trigger private data frees past the
 grace period
Message-ID: <20260723120242.5c21d818@gandalf.local.home>
In-Reply-To: <20260712161006.242797-1-devnexen@gmail.com>
References: <20260712161006.242797-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9zntudatcrag3bnkdthe9xsxokn8wd65
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 66BCF18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19s9oV5iPQ117zR0A0VCU0/aR3UIk/+nvg=
X-HE-Tag: 1784822540-464244
X-HE-Meta: U2FsdGVkX1+ZCpGdbPmTtf8tZR7GKXIzUsMbIetnH51z09pMV+mDUhb8QKRyjhDGVGu9bjHXlIRLjkJ94lKR6FGPKPe07lz9bQlNm9hIBa9Fk3Lfq0IeOTOY1gDvPMXBgSFTkomiaO+AZxzn/KcyxurHPsT9m2egiHNQeJMOtefzbhNrurNTJrb45uzNPXLrPZk4HF+22mp5+y5vne9Mn1HEy1d7exTjPG3TFRHTKO+EowPU6942jCAVPmRiIOq3NMR5AghqtfL6SvxHcYbmkCwZlRYKq6tfhbDAqNZbqVBx6B/iEtk1PX+2qYUAEoqoUPiVnxXXm9OGm4mq0gFO848FUY+lLVOEwGKz81PpD9wxHdSBheWUFWtZvtZeO/sR

On Sun, 12 Jul 2026 17:10:06 +0100
David Carlier <devnexen@gmail.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 82ce492ab268..bc696e4bd695 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6335,6 +6335,16 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
>  	}
>  }
>  
> +static void hist_trigger_free_private(struct event_trigger_data *data)
> +{
> +	destroy_hist_data(data->private_data);
> +}
> +
> +static void hist_trigger_named_free_private(struct event_trigger_data *data)
> +{
> +	kfree(data->cmd_ops);
> +}
> +

This triggered lockdep:

[  785.093618] ------------[ cut here ]------------
[  785.097043] WARNING: kernel/trace/trace_events_hist.c:3597 at action_data_des
troy+0x74/0x80, CPU#3: trigger_data_fr/10557
[  785.104157] Modules linked in: [last unloaded: trace_printk]
[  785.108151] CPU: 3 UID: 0 PID: 10557 Comm: trigger_data_fr Tainted: G        
W           7.2.0-rc4-ftest-00009-g22f7a9d07cb0 #174 PREEMPT(lazy) 
[  785.116393] Tainted: [W]=WARN
[  785.118863] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  785.127417] RIP: 0010:action_data_destroy+0x74/0x80
[  785.130947] Code: 8b bd 30 03 00 00 e8 bb f2 1d 00 48 89 ef 5b 5d e9 b1 f2 1d 00 be ff ff ff ff 48 c7 c7 60 75 7f 83 e8 d0 4d e9 00 85 c0 75 a0 <0f> 0b eb 9c 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[  785.142648] RSP: 0018:ffffc90002803e78 EFLAGS: 00010246
[  785.146271] RAX: 0000000000000000 RBX: ffff88811837e800 RCX: 0000000000000000
[  785.150595] RDX: 0000000000000000 RSI: ffffffff82d24bb2 RDI: ffffffff82d5aacb
[  785.156356] RBP: ffff88812bc8d400 R08: 0000000000000001 R09: 0000000000000000
[  785.160229] R10: 0000000000000003 R11: ffff88811e290f60 R12: ffff88812bc8d400
[  785.164090] R13: ffff88811e290000 R14: ffffffff815f1630 R15: 0000000000000000
[  785.167949] FS:  0000000000000000(0000) GS:ffff8882f9727000(0000) knlGS:0000000000000000
[  785.172381] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  785.175483] CR2: 00007f02ef65341c CR3: 000000000366a001 CR4: 0000000000172ef0
[  785.179019] Call Trace:
[  785.180523]  <TASK>
[  785.181881]  destroy_hist_data+0x24f/0x260
[  785.185686]  trigger_kthread_fn+0x87/0xc0
[  785.187762]  ? __pfx_trigger_kthread_fn+0x10/0x10
[  785.190099]  kthread+0xf5/0x130
[  785.191807]  ? __pfx_kthread+0x10/0x10
[  785.193752]  ret_from_fork+0x336/0x470
[  785.195716]  ? __pfx_kthread+0x10/0x10
[  785.197654]  ret_from_fork_asm+0x1a/0x30
[  785.199694]  </TASK>
[  785.201037] irq event stamp: 3815
[  785.202762] hardirqs last  enabled at (3827): [<ffffffff814be4ee>] __up_console_sem+0x5e/0x70
[  785.206442] hardirqs last disabled at (3838): [<ffffffff814be4d3>] __up_console_sem+0x43/0x70
[  785.209954] softirqs last  enabled at (3476): [<ffffffff8141115d>] handle_softirqs+0x35d/0x430
[  785.213524] softirqs last disabled at (3471): [<ffffffff81411346>] __irq_exit_rcu+0x106/0x1a0
[  785.218790] ---[ end trace 0000000000000000 ]---


Can you fold this into your patch:

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bc696e4bd695..1f438de90d09 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6337,6 +6337,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 
 static void hist_trigger_free_private(struct event_trigger_data *data)
 {
+	guard(mutex)(&event_mutex);
 	destroy_hist_data(data->private_data);
 }
 


-- Steve
