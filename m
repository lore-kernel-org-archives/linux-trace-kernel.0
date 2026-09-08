Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E31A680C;
	Tue,  8 Sep 2026 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831321; cv=none; b=KS5olrGCWFaUtTaQqgRCTR0kII5TPv1lk14evh2IOzN8615wergC5GhLN7uNnfCjXe8UapzZ55gSCiIN29uWOF4rj/kIDRUIHmSM/M4THfWClrOmOtR3VFh5deRYtakGzSf0+qRs69bAgq5H7A8v6Qhy2S1nnIhITUwuskdQH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831321; c=relaxed/simple;
	bh=HcRShxzvk71BSA6oMKwUhJ3MkEJ8V1MqsW2aKf+Xxos=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B61y1MgbkMXlMe9NgSDEP8PzRZ8Qvf0DXQAL4f9ZLbI85zgdMZyv8VNUiCQqPIZ06CcFWKXqgLm9QZn/kJ8otbTr1Lae0BXhLh7wcd4/pAit/BcDIOlmaiAJomezfGrGnsYr80+7SluKR1G2NQLwiDcYFMiC9/Rw5GiMHPrel5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKQyyJhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKQyyJhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFF1F00A3A;
	Tue,  8 Sep 2026 01:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788831319;
	bh=jgByKFB/1L+upVT7rUj+pfkyRwkhlSdVhbrR4RRvcu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fKQyyJhbZqca+VSht7hwIMTjP0FjW607X040OvzuWYn26H8ppy3D1Or8DB+hNR275
	 f3SIDJecAajvgXwOOTIJRIpeEson+6ob9M86luy7ooyPmkKM264a3nQCMmUpvCwf+h
	 D8sP15V8ddysd0kAak/h26GFxCwX94KTNxAwnYWuunxXMC9G8wqVarD/FeXAwT0O9P
	 StR3FQb5wFrpS05cA7ckSxs4ruZVk65gyTL9H4nDRdsJAM3HI7yp722YzHhHAYCFMQ
	 sgn5ORsxyck+TDtNDyHkweS0ODgxKf4h90xwHfIQazllPxq1loud8cCoIylj5Eg8E9
	 DDI/Mlk1E7TWA==
Date: Tue, 8 Sep 2026 10:35:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengfei Li <ljdlns1987@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel test robot <lkp@intel.com>, Bo Zhang <zhangbo56@xiaomi.com>, Pengfei
 Li <lipengfei28@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/3] trace: add documentation, selftest and
 tooling for stackmap
Message-Id: <20260908103514.a1c61f51b84b8d67d6f0f511@kernel.org>
In-Reply-To: <20260903132409.270195-4-lipengfei28@xiaomi.com>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com>
	<20260903132409.270195-4-lipengfei28@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 21:24:09 +0800
Pengfei Li <ljdlns1987@gmail.com> wrote:

> Add supporting files for the ftrace stackmap feature:
> 

Could you decouple tools/docs/tests in independent patches?

> Documentation/trace/ftrace-stackmap.rst:
>   Documentation covering design, usage, tracefs interface, binary
>   format, and performance characteristics. Added to the 'Core Tracing
>   Frameworks' toctree in Documentation/trace/index.rst. Documents:
>   - Reset clears the map and nothing else: the trace buffer is left
>     untouched and tracing does not have to be stopped, so <stack_id N>
>     records in an already-collected trace can stop resolving after a
>     reset. Read the trace out first if the ids need to stay meaningful
>   - Boot-time activation via trace_options=stackmap: events use the
>     full-stack fallback until the map and required resolver are created
>     and the map is published to global_trace.stackmap
>   - bits parameter range [10, 18] and worst-case memory usage
>   - tracefs file modes (0640 / 0440), with stack_map required and
>     stack_map_stat / stack_map_bin treated as auxiliary observability
>     nodes whose creation failure does not disable deduplication
>   - Best-effort snapshot semantics for stack_map_bin, serialized
>     against reset via the reader_sem
>   - Counter definitions and stable output: successes counts map operations
>     that return a stack ID; drops counts capacity or probe-limit
>     failures; success_rate excludes bypasses that never call the map
>     and remains present as 0% when both counters are zero
>   - Gravestone amplification when the pool is exhausted
> 
> tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
>   Functional selftest verifying:
>   - required stackmap tracefs nodes exist; tests that consume auxiliary
>     nodes declare them in '# requires:' and skip if unavailable
>   - enabling stackmap + stacktrace produces stack_id events
>   - stack_map_stat shows non-zero successes; a nonzero drops count is
>     a legitimate by-design fallback and is not treated as failure
>   - reset succeeds while tracing is active, since it clears the map
>     only and leaves the ring buffer alone
>   - reset also clears the map when tracing is stopped
>   The test starts and exits with a map reset so a failed run cannot
>   leak entries or counters into the next case. It reads trace contents
>   BEFORE switching back to the nop tracer (tracer_init()
>   unconditionally resets the ring buffer). The function:tracer
>   dependency is declared in '# requires:' so ftracetest skips on
>   kernels without CONFIG_FUNCTION_TRACER instead of failing spuriously.

If each test has this volume description, it is enough to split those
tests in independent patches.

[...]

> +def main():
> +    parser = argparse.ArgumentParser(description='Parse ftrace stack_map_bin')
> +    parser.add_argument('file', help='Path to stack_map_bin file')
> +    parser.add_argument('--vmlinux', help='Path to vmlinux for symbol resolution')
> +    parser.add_argument('--json', action='store_true', help='JSON output')
> +    parser.add_argument('--top', type=int, default=0,
> +                        help='Show only top N stacks by ref_count')
> +    args = parser.parse_args()
> +
> +    with open(args.file, 'rb') as f:
> +        data = f.read()

nit: Can this support input from stdin? If we use this on android,
user may want to do:

adb shell cat /sys/.../stack_map_bin | python3 stackmap_dump.py 

instead of pulling the file.

Thanks,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
