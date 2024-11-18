Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756CB19D8A4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946518; cv=none; b=niGQNrUzG+e8/vym3OSnl1w1iUaCcmUzHtpOh8bAiCFFtMNhmbCE1PsfvV3Qjx+NA6bVbnb56MsYqtj03e4I4twKEAxLQHc/TKmGYhXpmMIZIwj3WLZCWguh9vlhIcgfzr8K3dDzdNbTpREWaZk5P+oG/JKwzz7ugBF6xQ+nnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946518; c=relaxed/simple;
	bh=PKVUoUUaO8R1rCwR7AWixHIRWM/rIktvLTj7G2SXVFM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BieXFfBCK4m0E7FCFebqKlD/PpeSAeQbe6P4+oGE28B0DeIZWPUs4InCzZNZTX11K8mYsKPbH8rV6wKA1pgWnstBzI1mEBgnKjM/+G51Amplv8PmMKdZnrU2UdfKWYfi0TYzAonm6a8UD8QDP2hctDbTeTloZhrhDw/SQrI07qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxJbC3Xs; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxJbC3Xs"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731946510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkiG9y2ehFnJbFL3/n23U9ZBpM4DCYOB9PkT+Tb9pS0=;
	b=kxJbC3Xs6EhETaX6UCb/ofFUsRJlE3xksNe1gr2/PggMojh1IO3BrLqrbJISwSvpRB/h+u
	xef5YjyRa8tQvdHZHcYExmig4ujzK4nTuBNmvYSNLg67tF32Afe9aLd3TpdGPh9a5fWeJr
	T2eLd27ABN/K/p1LOaNhrvH8op5w1x0=
Date: Mon, 18 Nov 2024 16:15:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <991260353fbe141ffef8db7a08ed8fb2473e4ca0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v5] ftrace: Get the true parent ip for function tracer
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiehuan09@gmail.com,
 dolinux.peng@gmail.com, chensong_2000@189.cn
In-Reply-To: <20241008033159.22459-1-jeff.xie@linux.dev>
References: <20241008033159.22459-1-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT

October 8, 2024 at 11:31 AM, "Jeff Xie" <jeff.xie@linux.dev> wrote:

I'd like to know if this patch can be merged into 6.13?

>=20
>=20When using both function tracer and function graph simultaneously,
>=20
>=20it is found that function tracer sometimes captures a fake parent ip
>=20
>=20(return_to_handler) instead of the true parent ip.
>=20
>=20This issue is easy to reproduce. Below are my reproduction steps:
>=20
>=20jeff-labs:~/bin # ./trace-net.sh
>=20
>=20jeff-labs:~/bin # cat /sys/kernel/debug/tracing/instances/foo/trace |=
 grep return_to_handler
>=20
>=20 trace-net.sh-405 [001] ...2. 31.859501: avc_has_perm+0x4/0x190 <-ret=
urn_to_handler+0x0/0x40
>=20
>=20 trace-net.sh-405 [001] ...2. 31.859503: simple_setattr+0x4/0x70 <-re=
turn_to_handler+0x0/0x40
>=20
>=20 trace-net.sh-405 [001] ...2. 31.859503: truncate_pagecache+0x4/0x60 =
<-return_to_handler+0x0/0x40
>=20
>=20 trace-net.sh-405 [001] ...2. 31.859505: unmap_mapping_range+0x4/0x14=
0 <-return_to_handler+0x0/0x40
>=20
>=20 trace-net.sh-405 [001] ...3. 31.859508: _raw_spin_unlock+0x4/0x30 <-=
return_to_handler+0x0/0x40
>=20
>=20 [...]
>=20
>=20The following is my simple trace script:
>=20
>=20<snip>
>=20
>=20jeff-labs:~/bin # cat ./trace-net.sh
>=20
>=20TRACE_PATH=3D"/sys/kernel/debug/tracing"
>=20
>=20set_events() {
>=20
>=20 echo 1 > $1/events/net/enable
>=20
>=20 echo 1 > $1/events/tcp/enable
>=20
>=20 echo 1 > $1/events/sock/enable
>=20
>=20 echo 1 > $1/events/napi/enable
>=20
>=20 echo 1 > $1/events/fib/enable
>=20
>=20 echo 1 > $1/events/neigh/enable
>=20
>=20}
>=20
>=20set_events ${TRACE_PATH}
>=20
>=20echo 1 > ${TRACE_PATH}/options/sym-offset
>=20
>=20echo 1 > ${TRACE_PATH}/options/funcgraph-tail
>=20
>=20echo 1 > ${TRACE_PATH}/options/funcgraph-proc
>=20
>=20echo 1 > ${TRACE_PATH}/options/funcgraph-abstime
>=20
>=20echo 'tcp_orphan*' > ${TRACE_PATH}/set_ftrace_notrace
>=20
>=20echo function_graph > ${TRACE_PATH}/current_tracer
>=20
>=20INSTANCE_FOO=3D${TRACE_PATH}/instances/foo
>=20
>=20if [ ! -e $INSTANCE_FOO ]; then
>=20
>=20 mkdir ${INSTANCE_FOO}
>=20
>=20fi
>=20
>=20set_events ${INSTANCE_FOO}
>=20
>=20echo 1 > ${INSTANCE_FOO}/options/sym-offset
>=20
>=20echo 'tcp_orphan*' > ${INSTANCE_FOO}/set_ftrace_notrace
>=20
>=20echo function > ${INSTANCE_FOO}/current_tracer
>=20
>=20echo 1 > ${TRACE_PATH}/tracing_on
>=20
>=20echo 1 > ${INSTANCE_FOO}/tracing_on
>=20
>=20echo > ${TRACE_PATH}/trace
>=20
>=20echo > ${INSTANCE_FOO}/trace
>=20
>=20</snip>
>=20
>=20Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
>=20
>=20---
>=20
>=20v5:
>=20
>=20 https://lore.kernel.org/linux-trace-kernel/5bc5b9b07d997e299b0480058=
26bc6d592265c67@linux.dev/T/#me683cf5ac3858711230e54e5d5924a82e85917e6
>=20
>=20- Using fregs helper function to get the stack pointer=20
>=20
>=20=20
>=20
> v4:
>=20
>=20 https://lore.kernel.org/linux-trace-kernel/20241005101320.766c1100@r=
orschach.local.home/
>=20
>=20- fixed the crash when accessing the "current" if the arch has not im=
plemented noinstr
>=20
>=20 thanks steve for the testing and the detailed explanation
>=20
>=20v3:
>=20
>=20 https://lore.kernel.org/linux-trace-kernel/20240910001326.87f27e6b31=
2f1d956cf352a2@kernel.org/
>=20
>=20- fixed build error when CONFIG_FUNCTION_GRAPH_TRACER=3Dn suggested b=
y Masami
>=20
>=20v2:
>=20
>=20 https://lore.kernel.org/linux-trace-kernel/20240821095910.1888d7fa@g=
andalf.local.home/
>=20
>=20- Adding __always_inline to function_get_true_parent_ip suggested by =
Steve
>=20
>=20 kernel/trace/trace_functions.c | 26 ++++++++++++++++++++++++++
>=20
>=20 1 file changed, 26 insertions(+)
>=20
>=20diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_func=
tions.c
>=20
>=20index 3b0cea37e029..46c79a349d8c 100644
>=20
>=20--- a/kernel/trace/trace_functions.c
>=20
>=20+++ b/kernel/trace/trace_functions.c
>=20
>=20@@ -176,6 +176,27 @@ static void function_trace_start(struct trace_ar=
ray *tr)
>=20
>=20 tracing_reset_online_cpus(&tr->array_buffer);
>=20
>=20 }
>=20
>=20=20
>=20
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>=20
>=20+static __always_inline unsigned long
>=20
>=20+function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_r=
egs *fregs)
>=20
>=20+{
>=20
>=20+ unsigned long true_parent_ip;
>=20
>=20+ int idx =3D 0;
>=20
>=20+
>=20
>=20+ true_parent_ip =3D parent_ip;
>=20
>=20+ if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler) &&=
 fregs)
>=20
>=20+ true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip,
>=20
>=20+ (unsigned long *)ftrace_regs_get_stack_pointer(fregs));
>=20
>=20+ return true_parent_ip;
>=20
>=20+}
>=20
>=20+#else
>=20
>=20+static __always_inline unsigned long
>=20
>=20+function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_r=
egs *fregs)
>=20
>=20+{
>=20
>=20+ return parent_ip;
>=20
>=20+}
>=20
>=20+#endif
>=20
>=20+
>=20
>=20 static void
>=20
>=20 function_trace_call(unsigned long ip, unsigned long parent_ip,
>=20
>=20 struct ftrace_ops *op, struct ftrace_regs *fregs)
>=20
>=20@@ -193,6 +214,8 @@ function_trace_call(unsigned long ip, unsigned lo=
ng parent_ip,
>=20
>=20 if (bit < 0)
>=20
>=20 return;
>=20
>=20=20
>=20
> + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
>=20
>=20+
>=20
>=20 trace_ctx =3D tracing_gen_ctx();
>=20
>=20=20
>=20
>  cpu =3D smp_processor_id();
>=20
>=20@@ -241,6 +264,7 @@ function_stack_trace_call(unsigned long ip, unsig=
ned long parent_ip,
>=20
>=20 * recursive protection is performed.
>=20
>=20 */
>=20
>=20 local_irq_save(flags);
>=20
>=20+ parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
>=20
>=20 cpu =3D raw_smp_processor_id();
>=20
>=20 data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
>=20
>=20 disabled =3D atomic_inc_return(&data->disabled);
>=20
>=20@@ -309,6 +333,7 @@ function_no_repeats_trace_call(unsigned long ip, =
unsigned long parent_ip,
>=20
>=20 if (bit < 0)
>=20
>=20 return;
>=20
>=20=20
>=20
> + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
>=20
>  cpu =3D smp_processor_id();
>=20
>=20 data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
>=20
>=20 if (atomic_read(&data->disabled))
>=20
>=20@@ -356,6 +381,7 @@ function_stack_no_repeats_trace_call(unsigned lon=
g ip, unsigned long parent_ip,
>=20
>=20 * recursive protection is performed.
>=20
>=20 */
>=20
>=20 local_irq_save(flags);
>=20
>=20+ parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
>=20
>=20 cpu =3D raw_smp_processor_id();
>=20
>=20 data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
>=20
>=20 disabled =3D atomic_inc_return(&data->disabled);
>=20
>=20--=20
>=20
> 2.43.0
>
