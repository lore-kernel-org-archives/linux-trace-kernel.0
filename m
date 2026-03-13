Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF832A3FF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382074; cv=none; b=r7sAhZX/4S0VDzaveMfkYVccyGWNelM7P32RynMPxHfqPDm6bpLi9SeKk5PbRqzCLQdL4wuPC/QexZD89ms8VF8fVqcc7+kB1/fBIYFvNlB/EJ1UCJQcz9AA7qsl0wJwML0OCEkEGcuIbQ+8Lkk3/vRGerzZOZ2sqiRMRYniK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382074; c=relaxed/simple;
	bh=c6VYYooBuklbrFIdu6kM24pC5jve/wT/sSRJEvmlKTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REsijDHQmUzKpv3sVGxxb4qSc/PU2eq2v5niLsBofcDeT3NXgMUIj1qfdY5Wj1TC5U0SwWEN82b4xwBI+RX+l3z1zv3k6/6UXlv0g9tSZwkYlXEquJSsHOjpR0Im6/ihPej0q4z/nXjWX934WyE3VdBrW9I1g9HBdGl1/O5TEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdBV16/0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdBV16/0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so1126741a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773382073; x=1773986873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwCbFjCjgsNsO4YhMYDCjGLZ2umsTE3gLTKcHITMbH0=;
        b=qdBV16/0jhm2xFD8b/ly97jVH9XtwRaFOsqq410Y6WnpItqnFRRIhMD6QigxFIH/vd
         zfpNgCuJpyf9kDLLtQ0uDb5bf3MnJBB9CxrKqilk7UofkiUnGjCWpCtQZTDwUaa553ZD
         tNtVz4ryRR9PAtinSFY6KomdLemE8BPCe+0Q7rjSF3Tb+kgzrYl4PUK+DRpyG6JuzJ8U
         EOWHnuPY7Y3yKg40h725GpvqVarfry8OU3xDZ3VHC9xmxoJ6u2OD1hyaqtdSdZD5Lj/G
         TG5zO0R22FTqSwVB1tSBlUtn825BZ1k1GUU0hh/7lmRbd2McMKfodNqII9EpL5G/K2sR
         qXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382073; x=1773986873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwCbFjCjgsNsO4YhMYDCjGLZ2umsTE3gLTKcHITMbH0=;
        b=djUcGQDDkunaqH47q21Vw1HnPDoKauxgey0AQuBnJtMNY8OM0CSFMzKmcFu0TTRssm
         9ltRk3XyjPR7KAQFCmg1jWnytIJSD5ViUUYuGuNfT+5K0tnfx+D1z9Mdmpnr+HbmTRSp
         8OnmfJk4GCXyLdp+GHyufDyIdtYo8825ev8cW3AedRe57p528WvxtREDPxQ0XrDLvR65
         VWliaAVIw7LTHm9IWCIBbIUD6V0hK4Bxh2Z+8tZCFdAVn4drya4zEvrDgIRLS0NEYzK3
         a14PwIN1JIdK+73tTRqxhxlzhS/lnlMaGONnUhmxIwvJfdjjJoh2qQTGUGAIMdKoYYGq
         6RLA==
X-Forwarded-Encrypted: i=1; AJvYcCXTjw/fHV79/ait5zEgVymf3vaEY0dmjuMae7K2bikhnxy3dgKG63pm4SLtrfPUV8OSQfURUqKeZRNwDU1IyLyGEmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjKL7SVjiNdsMWCufAVXcz/pLoGEdBumGZ3n0ZSP13bVITHDm
	1o6wEHs9eUXHLhydxlieHeCDNvs+Wq01igKLrIlbmZjLIyp6YaEjh2VZu547MvcqrOE=
X-Gm-Gg: ATEYQzzZb3ZDXoJ31SktFqbPmpr6LnO75NbrbbzACDc6xZLlPksKQzqII+pBTfvjyCq
	crW6Ey9fmyx+yn8uUJ1qCZ2+R5y14fV3ztUXxnPvPA0URKamVdsN7+ez2Mxds3CqxSSsAy3LjFX
	Jg+X4i3AQ5LPJokv6xJmTYgav+Bygxa8dVB4oov+xh0itmWa2r3swOim75A6wrTrWZzgBvGB7et
	aXyIc7D5+Sk+7IFrqMNcE0KNWNwdaZHJJNVWZkTOeeoqjcBsutqISYbR0j6Gbpbv6D3nXvBMmWp
	X5GiUy4MACg5+EaIhpVT427ZevDhx0Oxe2EwZkVmcTgFdBGQEESaktBtcpGplecpBT3QAJ3G55Q
	owbm2qecGzjDquP8Kt1gZJl6BZ4GZRcEwvkdli3dza3lxA6TpXZinqxfptky8MH9wBtORv4LaIY
	skwGzgqhUpGIrsWgWZdv+soNnX
X-Received: by 2002:a17:902:ce11:b0:2ae:3dd5:c69c with SMTP id d9443c01a7336-2aecab1ed6bmr19020575ad.33.1773382072584;
        Thu, 12 Mar 2026 23:07:52 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed753sm12352835ad.45.2026.03.12.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:07:51 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:37:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] cpufreq: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <upto66dotvjmkd5zsdbmtumxccm53qgwmf3qlpfd36q56jqfcj@7ed5kdoq4q76>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-7-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312150523.2054552-7-vineeth@bitbyteword.org>

On 12-03-26, 11:05, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> ---
>  drivers/cpufreq/amd-pstate.c   | 10 +++++-----
>  drivers/cpufreq/cpufreq.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
