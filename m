Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AA18027;
	Wed, 18 Jun 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214429; cv=none; b=uHBCi/lXk3jAShqpYNTowD55sH4baU8gqHWGX9vQSlM8cYMW/k+6WiiwB+jKNwynTOQ8kF2DGMyp7qtvVForjC7gxtwo2JbdaVhLAHvH50951vFQ3tPJxzi3ueSXu1Ib8WuKB8UsTfkecbnbKctpXiRNyeMJZeaiiY5UuRkRPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214429; c=relaxed/simple;
	bh=qsIA6mNPxnb7OXWg4kd4mkPdogx2qiMHk/5aIJp3TQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyO/QXlJ1BWCjc6VtVqtarmy3vMVFbJxpd51NvTBZUHzxI0kbfdmZ1JTwIPoVZmeqiYs+BPJITSiuuXbnogszg/n4TtM1Jok9y31rk16LmZ6jt/gVwxCgXote7NSs/AsoCF8LjKI6nmZbBI2r/M/ANs8Y+n0MdQAci4mipc0xDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bMSY91Ymnz2Cfbr;
	Wed, 18 Jun 2025 10:36:29 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B72C1800B2;
	Wed, 18 Jun 2025 10:40:23 +0800 (CST)
Received: from kwepemq500002.china.huawei.com (7.202.195.240) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 10:40:22 +0800
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 kwepemq500002.china.huawei.com (7.202.195.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 10:40:22 +0800
Received: from kwepemq200002.china.huawei.com ([7.202.195.90]) by
 kwepemq200002.china.huawei.com ([7.202.195.90]) with mapi id 15.02.1544.011;
 Wed, 18 Jun 2025 10:40:21 +0800
From: duchangbin <changbin.du@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
	<mark.rutland@arm.com>, duchangbin <changbin.du@huawei.com>
Subject: Re: [PATCH] fgraph: Do not enable function_graph tracer when setting
 funcgraph-args
Thread-Topic: [PATCH] fgraph: Do not enable function_graph tracer when setting
 funcgraph-args
Thread-Index: AQHb3/pWjfZBtRicskuT1WyP/TidDQ==
Date: Wed, 18 Jun 2025 02:40:21 +0000
Message-ID: <ad0745b53e5046b79378bdc12ddfdd51@huawei.com>
References: <20250617120830.24fbdd62@gandalf.local.home>
In-Reply-To: <20250617120830.24fbdd62@gandalf.local.home>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemq200002.china.huawei.com (15.02.1544.011)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98A46D4A86E7C845BBD920D113FB6E88@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Steven,
On Tue, Jun 17, 2025 at 12:08:30PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When setting the funcgraph-args option when function graph tracer is net
> enabled, it incorrectly enables it. Worse, it unregisters itself when it
> was never registered. Then when it gets enabled again, it will register
> itself a second time causing a WARNing.
>=20
>  ~# echo 1 > /sys/kernel/tracing/options/funcgraph-args
>  ~# head -20 /sys/kernel/tracing/trace
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 813/26317372   #P:8
>  #
>  #                                _-----=3D> irqs-off/BH-disabled
>  #                               / _----=3D> need-resched
>  #                              | / _---=3D> hardirq/softirq
>  #                              || / _--=3D> preempt-depth
>  #                              ||| / _-=3D> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>            <idle>-0       [007] d..4.   358.966010:  7)   1.692 us    |  =
        fetch_next_timer_interrupt(basej=3D4294981640, basem=3D357956000000=
, base_local=3D0xffff88823c3ae040, base_global=3D0xffff88823c3af300, tevt=
=3D0xffff888100e47cb8);
>            <idle>-0       [007] d..4.   358.966012:  7)               |  =
        tmigr_cpu_deactivate(nextexp=3D357988000000) {
>            <idle>-0       [007] d..4.   358.966013:  7)               |  =
          _raw_spin_lock(lock=3D0xffff88823c3b2320) {
>            <idle>-0       [007] d..4.   358.966014:  7)   0.981 us    |  =
            preempt_count_add(val=3D1);
>            <idle>-0       [007] d..5.   358.966017:  7)   1.058 us    |  =
            do_raw_spin_lock(lock=3D0xffff88823c3b2320);
>            <idle>-0       [007] d..4.   358.966019:  7)   5.824 us    |  =
          }
>            <idle>-0       [007] d..5.   358.966021:  7)               |  =
          tmigr_inactive_up(group=3D0xffff888100cb9000, child=3D0x0, data=
=3D0xffff888100e47bc0) {
>            <idle>-0       [007] d..5.   358.966022:  7)               |  =
            tmigr_update_events(group=3D0xffff888100cb9000, child=3D0x0, da=
ta=3D0xffff888100e47bc0) {
>=20
> Notice the "tracer: nop" at the top there. The current tracer is the "nop=
"
> tracer, but the content is obviously the function graph tracer.
>=20
> Enabling function graph tracing will cause it to register again and
> trigger a warning in the accounting:
>=20
>  ~# echo function_graph > /sys/kernel/tracing/current_tracer
>  -bash: echo: write error: Device or resource busy
>=20
> With the dmesg of:
>=20
>  ------------[ cut here ]------------
>  WARNING: CPU: 7 PID: 1095 at kernel/trace/ftrace.c:3509 ftrace_startup_s=
ubops+0xc1e/0x1000
>  Modules linked in: kvm_intel kvm irqbypass
>  CPU: 7 UID: 0 PID: 1095 Comm: bash Not tainted 6.16.0-rc2-test-00006-gea=
03de4105d3 #24 PREEMPT
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1=
.16.3-2 04/01/2014
>  RIP: 0010:ftrace_startup_subops+0xc1e/0x1000
>  Code: 48 b8 22 01 00 00 00 00 ad de 49 89 84 24 88 01 00 00 8b 44 24 08 =
89 04 24 e9 c3 f7 ff ff c7 04 24 ed ff ff ff e9 b7 f7 ff ff <0f> 0b c7 04 2=
4 f0 ff ff ff e9 a9 f7 ff ff c7 04 24 f4 ff ff ff e9
>  RSP: 0018:ffff888133cff948 EFLAGS: 00010202
>  RAX: 0000000000000001 RBX: 1ffff1102679ff31 RCX: 0000000000000000
>  RDX: 1ffffffff0b27a60 RSI: ffffffff8593d2f0 RDI: ffffffff85941140
>  RBP: 00000000000c2041 R08: ffffffffffffffff R09: ffffed1020240221
>  R10: ffff88810120110f R11: ffffed1020240214 R12: ffffffff8593d2f0
>  R13: ffffffff8593d300 R14: ffffffff85941140 R15: ffffffff85631100
>  FS:  00007f7ec6f28740(0000) GS:ffff8882b5251000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f7ec6f181c0 CR3: 000000012f1d0005 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   ? __pfx_ftrace_startup_subops+0x10/0x10
>   ? find_held_lock+0x2b/0x80
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? trace_preempt_on+0xd0/0x110
>   ? __pfx_trace_graph_entry_args+0x10/0x10
>   register_ftrace_graph+0x4d2/0x1020
>   ? tracing_reset_online_cpus+0x14b/0x1e0
>   ? __pfx_register_ftrace_graph+0x10/0x10
>   ? ring_buffer_record_enable+0x16/0x20
>   ? tracing_reset_online_cpus+0x153/0x1e0
>   ? __pfx_tracing_reset_online_cpus+0x10/0x10
>   ? __pfx_trace_graph_return+0x10/0x10
>   graph_trace_init+0xfd/0x160
>   tracing_set_tracer+0x500/0xa80
>   ? __pfx_tracing_set_tracer+0x10/0x10
>   ? lock_release+0x181/0x2d0
>   ? _copy_from_user+0x26/0xa0
>   tracing_set_trace_write+0x132/0x1e0
>   ? __pfx_tracing_set_trace_write+0x10/0x10
>   ? ftrace_graph_func+0xcc/0x140
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   vfs_write+0x1d0/0xe90
>   ? __pfx_vfs_write+0x10/0x10
>=20
> Have the setting of the funcgraph-args check if function_graph tracer is
> the current tracer of the instance, and if not, do nothing, as there's
> nothing to do (the option is checked when function_graph tracing starts).
>=20
> Cc: stable@vger.kernel.org
> Fixes: c7a60a733c373 ("ftrace: Have funcgraph-args take affect during tra=
cing")
> Reported-by: duchangbin <changbin.du@huawei.com>
> Closes: https://lore.kernel.org/all/4ab1a7bdd0174ab09c7b0d68cdbff9a4@huaw=
ei.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_functions_graph.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 9234e2c39abf..b6211c304c7f 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -455,10 +455,16 @@ static int graph_trace_init(struct trace_array *tr)
>  	return 0;
>  }
> =20
> +static struct tracer graph_trace;
> +
>  static int ftrace_graph_trace_args(struct trace_array *tr, int set)
>  {
>  	trace_func_graph_ent_t entry;
> =20
> +	/* Do nothing if the current tracer is no this tracer */
typo: no -> not

> +	if (tr->current_trace !=3D &graph_trace)
> +		return 0;
> +
This can fix the issue. But how are tr->current_trace and &graph_trace link=
ed?
When are they equal?

>  	if (set)
>  		entry =3D trace_graph_entry_args;
>  	else
> --=20
> 2.47.2
>=20
>=20

--=20
Cheers,
Changbin Du
