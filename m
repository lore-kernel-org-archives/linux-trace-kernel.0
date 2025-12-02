Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD4301701
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657824; cv=none; b=WOWe6xHMe+xcAovxycUNZr5/7aS4vu4XNNiFMkF9T8rF5oGqO4qeEE3b7y6uVIrimZMRnRLwJEUHgySwT/9JcjFmVoUytabvNQLTE1tLTf/b2jlybWhEkUP4dxXDC1D7zXZ3uoLs9zQLEJHNfU5JnO5kOF+oiISALfRHe31PAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657824; c=relaxed/simple;
	bh=Jf9gVgouUS6WA1WmAKl+iapmoVqz/JtN0fwXRs+b4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWG03LQ+jT3A9+gQY9w181NT+pux021DfQmJH3hEj09zWYM2Ib0HRgtDlvRQ6/KYZUSNzqiUWNSToIaf7gj2Q93Ikcbxg7Izejf+5YAENobpZfJmv3lUO+mKLjSQp1tXC5LX+UfiBohmuRbynUHVCrs5KE4zBKDHYkcNP84nmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cumvfgwy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cumvfgwy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555415c5fso61189455ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764657821; x=1765262621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=CumvfgwykknWCLlGYfxl+aWzXM+wsXYC464qBApiNydWyo/GCG1/7RTtXpXKc+dHrx
         991hAxia7u5AdoccVPsITEX81DXNJZiWLee1gga39SLmNdYh4wvcwVEe6YcYHtDNtmk/
         UhEl3Wa2dAa4we0KkOidLr8rkfrEcU/r/iLX3OS3+dXn4CjlZkw941vAi4dUsmagCMCC
         V3DpQQ/B5cYX8ef5Niy23jwcZGhwC+6mMHvo1IYQVKF8Rl7CqQpTtt5KZ+Ao0Nov0Pj/
         Z2Yd2aCcCtCkf3hZ7KuZbH8rzgvwo5tk8Q23Ip+T/rn6ftht8h1Qxp91cAuTVcu6RQJ8
         N6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657821; x=1765262621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=oqjbOylmsps4/o66W2fngii1vIp2d2Kv9w3xr5MqJyrSYTkgjHJaXbihse+AagGCsX
         Hy0NyND4IV7EH8h8Ko3b24h7TefhRQTvEtYYxbydKbdweZXq/cvWZ/aAH9EOAtI03s2H
         pn0RN+qIno3RW5OyZi2LkBaQ5lmcfcWVBsmRcNz1uVHl7KaSSzxQIYhneaKl1DqDh4Vp
         CoCWUBdADxxXUWk6aByUPyPV+8G5K1ib/iAG3EqnkOwJDRP4Q1fI5dSNv0W4z7Lrz3m5
         GquPoIthRDlZc8M7c/IE/Yj+9MfVOO1c+KqEIrP/RKa2IoJIiGaHKvhDNuAIFs0xxBUa
         APuw==
X-Forwarded-Encrypted: i=1; AJvYcCW3nZHG1K4W2bCD1QfP8wsklmax9Cb9vNJ1q3RgWQVuUzsYQoW3Ho3KFWRmNZtLVMxAx6aJiNMVEzb1KZhGPB+rkyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fVFSbYW2cASR9O7XfkgXgVruGp+ab0egSLkdZ12trZ9UYE2h
	IEafdEa5luvVq9BiYve9qvYpOmhr1Tj3qQWHuDwIL9Yrv1DuwwssfZpaUKHL08t+Lgg=
X-Gm-Gg: ASbGnctNqp20Pr1NMJNC1+5TRBGZL6s9STWua5aXlADALY+IgtTGrWlhgDi8cF9oqen
	M9z/6braa+VvEhwQEM2aW2iv8GjYUUXWSMh4ilTm+hHOi4d1/ixN8d03tXKdfCMqlVLscOAQjVo
	DL99MaLaL9XJ9Mt8YLJkJOErpkqn9EplS2JGSg/MXJ3UQWs0kzS4lpCsNW8VaNyNtOQSav4nPG0
	zv0PQgpsJZC6NTNrOSN2Fm4kiM/wf41Oyr+RSwj19TycLSMjiTMJQzppEC6SIcHfZZMbgv4XdKY
	qMXX2HYJ8FK0o5P58mwO4ItOQc8k0KVEeLNYRwFHoImuLa/eqyRimicjl1AuYHb8eezqYbenLyn
	VLMeiltiKPGsPUKoihLgRwRtpsD/RjDJ/nPA33qzZ27vhHisZ0eRth6jkiTMYk8wwaX+kPAty6X
	OPdlm/u56dilRyzgsbATxq2w==
X-Google-Smtp-Source: AGHT+IElB/55iOL3pFkt4jDnVftx8SMwzLAFev+IFE16AlTrASn4wJp/yshPqxy/pYWD5aWdbmoY1g==
X-Received: by 2002:a17:903:2b0f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29b6c6d0d46mr435400315ad.56.1764657821143;
        Mon, 01 Dec 2025 22:43:41 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4418c4sm139899275ad.24.2025.12.01.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:43:40 -0800 (PST)
Date: Tue, 2 Dec 2025 12:13:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, christian.loehle@arm.com, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <inifvm4pxifvdazsfyi2ppzfwum6ukzujx5sfiux4s2iv55z4p@otoaj35vr47c>
References: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>

On 01-12-25, 12:24, Samuel Wu wrote:
> This series replaces the cpu_frequency trace event with a new trace event,
> policy_frequency. Since by definition all CPUs in a policy are of the same
> frequency, we can emit a frequency change per policy instead of per CPU.
> This saves some compute and memory from the kernel side, while simplifying
> analysis from the post-processing of the trace log side.
> 
> Any process that relied on cpu_frequency trace event needs to switch to the
> new policy_frequency trace event in order to maintain functionality. The
> decision of replacing instead of adding the trace event is intentional. Since
> emitting once per policy instead of once per CPU is anyways a semantics change
> that would require a tooling update, the trace event was also appropriately
> renamed. The presence of the policy_frequency event in a trace log is a clear
> and obvious signal for tooling to determine kernel version and which trace
> event to parse.
> 
> 1/2: Replaces trace_cpu_frequency with trace_policy_frequency
> 2/2: Corresponding documentation patch that updates references to
>      cpu_frequency with policy_frequency
> 
> Changes in v3:
> - Resending v2 properly (accidentally ommited cover letter in v2)
> 
> Changes in v2:
> - Replaced trace_cpu_frequency with trace_policy_frequency (per Christian
>   and Viresh)
> - Updated references to cpu_frequency in documentation with
>   policy_frequency
> - v1 link: https://lore.kernel.org/all/20251112235154.2974902-1-wusamuel@google.com
> 
> Samuel Wu (2):
>   cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
>   cpufreq: Documentation update for trace_policy_frequency
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   | 10 ++++----
>  Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++------
>  Documentation/trace/events-power.rst          |  2 +-
>  drivers/cpufreq/cpufreq.c                     | 14 ++---------
>  drivers/cpufreq/intel_pstate.c                |  6 +++--
>  include/trace/events/power.h                  | 24 ++++++++++++++++---
>  kernel/trace/power-traces.c                   |  2 +-
>  samples/bpf/cpustat_kern.c                    |  8 +++----
>  samples/bpf/cpustat_user.c                    |  6 ++---
>  tools/perf/builtin-timechart.c                | 12 +++++-----
>  10 files changed, 54 insertions(+), 44 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
