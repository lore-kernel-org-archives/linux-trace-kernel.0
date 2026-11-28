Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858989;
	b=docST7GB88s6AxwPlW5d8nW6qn9MoR1J6d4qVpZS+u54o8a8p6nARdeDcSQbORBDJR4e
	 KZkVYj2ZV0g9zWF7/CPUjItU45nICx2GktD0NaSEAbHnHy8Op1enkgcRVAhIkC3pmGXRh
	 oxe0EgBjbcSN/KYw7QuwaiJoa5nc4agYYx3TdbKxN8bdzCNWn8LFFAV6wb4ST2eQBl/ss
	 zgeP8ROqKbJFtcmO1Lcxz87FdeEk0IhqyQSEJY6tOHrkfPfDHVggDuE80YS1o86fO7Bvc
	 3EBJo1vby7gbGYNvjVLMBpNIlEjwRQYdgV2WnGe3sUrkSeFK+jDPELGH56LY7fWzEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AiYWiEPipAizPditFs9I0FVLRHe2BWva7e+R9HSfuws=;
	b=Hj1+aWXg8HgSpUxLZNjwqPu3q9FI7rPRb4BYKesIlMh2oTsdaRaH1GAmkd9ZDDNqigV8
	 fY2x1bP5s03IkqEU5kUENM68plxPgtfTaMyzVL8LSi6vUo9SZrP/9MDLQqmUmGJz4wK0r
	 DJv6ITnU0hOjZpkZztCDuXm8lv+ZRGsD+KmBb2CBXNccPOqhRWfGOIf/Z2mT0HrwxLHqT
	 Jkyox2O/WERkzft944VMUB6qH7iMNltTlSTCYxXq0I3Pw3A99fjY0jy5JJXk45hwKZd3n
	 W0uiNW+B79GgDwl/7tDV6AS0u2T6TGQQgEFtdDiUHPdxPN94FvfoAsE6/EoqNOnKyoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuRCVlPc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE2606A31F;
	Sat, 28 Nov 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuRCVlPc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E2D1F000C1;
	Sat, 28 Nov 2026 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795858988;
	bh=AiYWiEPipAizPditFs9I0FVLRHe2BWva7e+R9HSfuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuRCVlPcfliE0k95i1R+mlP7/Ujg3IFBapE5Ittg4kApS+ZMm+sixsrmFnKppj+ZQ
	 K4KSYITfq2QoIeAzb7uMBFfbaFk1H7ihwrXfF7i3mSZDy8BaDRmY4fiUjSUzJnAemt
	 yWRZ8HvykuUV1WfrzRm8Eg6hqbXa73hPeo2hsaTjwTmDV2cChq434BxPDVCD0Vfqws
	 BHMyvbPfe4mijI0AYDocjZ3EXi4lqSa1XVb2Vul0CO0AFllppiuaK6afkx8vCJYzck
	 uksr/0OLYZRrAjBYJlZOoAuUsGT2n6L9JL2WrsMJlK/EoIagh7vSrWmoC3cBkcFHzZ
	 y6fY8/gpD4Clg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Sasha Levin <sashal@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Skip the sample module BTF probes without module BTF
Date: Sat, 28 Nov 2026 18:43:05 +0900
Message-ID: <undine-1795858985215003940-986d1001bb5ade62@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261124181038.2362595-1-sashal@kernel.org>
References: <20261124181038.2362595-1-sashal@kernel.org>
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

On Tue, 24 Nov 2026 13:10:38 -0500, Sasha Levin <sashal@kernel.org> wrote:
> btf_probe_event.tc and btf_typecast_accepted.tc probe sample_timer_cb()
> in the trace-events-sample module and cast its argument to struct
> foo_timer_data, so they need the BTF of that module. Without
> CONFIG_DEBUG_INFO_BTF_MODULES the module has no BTF, the probe is
> rejected with "No BTF entry for this probe point" and both tests fail.
>
> A "make kselftest-merge" config can end up without module BTF. The net
> and drivers/net selftest configs set CONFIG_DEBUG_INFO_BTF_MODULES=n,
> and only CONFIG_DEBUG_INFO_BTF_INLINE from the bpf config turns it back
> on, which needs pahole 1.32. KernelCI builds its kselftest kernels this
> way with pahole 1.31, and both tests fail on all the boards that run
> them.
>
> Check for /sys/kernel/btf/trace_events_sample. Without it
> btf_probe_event.tc is unsupported and btf_typecast_accepted.tc skips
> only the sample_timer_cb() probes.
>
> Fixes: 7d8d6ad659c0 ("tracing/probes: Add a new testcase for BTF typecasts")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this to your fixes branch?

Thank you,

> ---
>  .../ftrace/test.d/dynevent/btf_probe_event.tc |  3 +++
>  .../test.d/dynevent/btf_typecast_accepted.tc  | 22 ++++++++++++++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
>
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
>
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
> index bf71368c31a4a..d832eca058de1 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
> @@ -8,6 +8,9 @@ if ! lsmod | grep -q trace_events_sample; then
>    modprobe trace-events-sample || exit_unresolved
>  fi
>  
> +# The typecast below needs the BTF of the module
> +[ -e /sys/kernel/btf/trace_events_sample ] || exit_unsupported
> +
>  echo 0 > events/enable
>  echo > dynamic_events
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
> index dd5552727054c..50d303f7acc9f 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
> @@ -25,6 +25,12 @@ if ! lsmod | grep -q trace_events_sample; then
>    modprobe trace-events-sample || exit_unresolved
>  fi
>  
> +# The sample_timer_cb() probes need the BTF of the module
> +SAMPLE_BTF=
> +if [ -e /sys/kernel/btf/trace_events_sample ] ; then
> +  SAMPLE_BTF=yes
> +fi
> +
>  if [ "$FPROBES" ] ; then
>    # 1. Test basic typecast on fprobe
>    echo 'f:fpevent1 vfs_read name=(file)file->f_path.dentry->d_name.name:string' >> dynamic_events
> @@ -42,8 +48,10 @@ if [ "$FPROBES" ] ; then
>    echo 'f:fpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
>  
>    # Test this_cpu_read and this_cpu_ptr on fprobe
> -  echo 'f:fpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
> -  echo 'f:fpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
> +  if [ "$SAMPLE_BTF" ] ; then
> +    echo 'f:fpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
> +    echo 'f:fpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
> +  fi
>  fi
>  
>  if [ "$KPROBES" ] ; then
> @@ -63,8 +71,10 @@ if [ "$KPROBES" ] ; then
>    echo 'p:kpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
>  
>    # Test this_cpu_read and this_cpu_ptr on kprobe
> -  echo 'p:kpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
> -  echo 'p:kpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
> +  if [ "$SAMPLE_BTF" ] ; then
> +    echo 'p:kpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
> +    echo 'p:kpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
> +  fi
>  fi
>  
>  # Verify the events exist in dynamic_events
> @@ -77,7 +87,7 @@ if [ "$FPROBES" ] ; then
>    grep -q "fpevent6 " dynamic_events
>    grep -q "fpevent7 " dynamic_events
>    grep -q "fpevent8 " dynamic_events
> -  if lsmod | grep -q trace_events_sample; then
> +  if [ "$SAMPLE_BTF" ] ; then
>      grep -q "fpevent9 " dynamic_events
>      grep -q "fpevent10 " dynamic_events
>    fi
> @@ -92,7 +102,7 @@ if [ "$KPROBES" ] ; then
>    grep -q "kpevent6 " dynamic_events
>    grep -q "kpevent7 " dynamic_events
>    grep -q "kpevent8 " dynamic_events
> -  if lsmod | grep -q trace_events_sample; then
> +  if [ "$SAMPLE_BTF" ] ; then
>      grep -q "kpevent9 " dynamic_events
>      grep -q "kpevent10 " dynamic_events
>    fi
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
