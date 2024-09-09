Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD51B29A7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890939; cv=none; b=afmP1yaPgzceqdQSGJ5EmjXEPMb46kdpXEwfbtsE0zl/vD2NrsntbmI96q3+O942mt6chpIEmOzT3XFs+pWnt2eeZxv6RLIzlVIUxoZHU4+Ipd9ss7YIrLdYzz+dMHYKDyYM8g1k4XCxjIWRmZb+a0TuyT4iPpKnTjah8hwcc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890939; c=relaxed/simple;
	bh=kNKLzLej1M52xasYwRCbta6kTESdQ3T1zXZ3FCfCyQ8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nGOlMOEfhvmi3DjOksEDf15rAb2A+tsrc7J3A0KRdfeRznwwUomabtb8a1PG2ZUFsNdHEwryRDpkzHuwZZ+21bLKy/6piNc1oGe6cXOe08ITICtSjLxgZhbdsifhsWBkgo/pkF/mAW10wTGAp54/ZQ7Ad496oedBTEOt1dOBB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrRFD3KR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrRFD3KR"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725890934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYkNBLTca3KsAkKQJXGOqbSrftPUBMvrE3h7ViDLv6A=;
	b=vrRFD3KRtPJtB7X1PyhHMq3TjoNr1e5UuEtJklKk4AucNb1IGuCjimVQpuz/7FaHFy2LiU
	9NwJ9ICh0Za3GQU5xYNgXceELcGMZSBdE4RmaEfPgDhV91VsF7UKTRFNTBwzjppR186RdV
	HtyLAMHQBLV9+Dndv401rX3gpbo8iEA=
Date: Mon, 09 Sep 2024 14:08:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <e97c610987667ae158f877ca2a4b9c0cbbc972e2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] ftrace: Get the true parent ip for function tracer
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiehuan09@gmail.com
In-Reply-To: <20240821233021.2785584-1-jeff.xie@linux.dev>
References: <20240821233021.2785584-1-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT

August 22, 2024 at 7:30 AM, "Jeff Xie" <jeff.xie@linux.dev> wrote:


Kindly ping, any comments here? Thanks.


>=20
>=20Currently, when using both function tracer and function graph simulta=
neously,
>=20
>=20it is found that function tracer sometimes captures a fake parent ip(=
return_to_handler)
>=20
>=20instead of the true parent ip.
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
>=20Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
>=20
>=20---
>=20
>=20v2:
>=20
>=20- Adding __always_inline to function_get_true_parent_ip suggested by =
Steve
>=20
>=20 kernel/trace/trace_functions.c | 18 ++++++++++++++++++
>=20
>=20 1 file changed, 18 insertions(+)
>=20
>=20diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_func=
tions.c
>=20
>=20index 3b0cea37e029..d989e927c898 100644
>=20
>=20--- a/kernel/trace/trace_functions.c
>=20
>=20+++ b/kernel/trace/trace_functions.c
>=20
>=20@@ -176,6 +176,19 @@ static void function_trace_start(struct trace_ar=
ray *tr)
>=20
>=20 tracing_reset_online_cpus(&tr->array_buffer);
>=20
>=20 }
>=20
>=20=20
>=20
> +static __always_inline unsigned long
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
>=20+ if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler))
>=20
>=20+ true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip,
>=20
>=20+ (unsigned long *)fregs->regs.sp);
>=20
>=20+ return true_parent_ip;
>=20
>=20+}
>=20
>=20+
>=20
>=20 static void
>=20
>=20 function_trace_call(unsigned long ip, unsigned long parent_ip,
>=20
>=20 struct ftrace_ops *op, struct ftrace_regs *fregs)
>=20
>=20@@ -193,6 +206,8 @@ function_trace_call(unsigned long ip, unsigned lo=
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
>=20@@ -241,6 +256,7 @@ function_stack_trace_call(unsigned long ip, unsig=
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
>=20@@ -309,6 +325,7 @@ function_no_repeats_trace_call(unsigned long ip, =
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
>=20 cpu =3D smp_processor_id();
>=20
>=20 data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
>=20
>  if (atomic_read(&data->disabled))
>=20
>=20@@ -356,6 +373,7 @@ function_stack_no_repeats_trace_call(unsigned lon=
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
> 2.34.1
>
