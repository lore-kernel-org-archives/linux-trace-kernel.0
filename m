Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6B3859C4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738863; cv=none; b=P8LnJNA+efkW1gx42FrnZ7sXVBRDiOZnh0C0OvDsHpwGx5nOJNZ6h5xrzf0G6uMk2pH4rTNmcCrjljvtvBvHX0wvwsNAtzEch2/Fx8lHIhTxiDfo87lCEMuahYAv2bvlUYXNr+TAmAGXXQdXpyFjZhxHHKqG+JdXUg8UIozQ/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738863; c=relaxed/simple;
	bh=ST2OYSUr/9BOxuSHmo6m8vzlEriASf+JxzHewy/ojBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEJgus44t60uV33No0ZOZnIteQ1JkxDEJ8hbgkO+BuCK4Ig7uMFK3qkBh5xtoifi/hAQeuujR6ZZEqYRitM3MZ6UjT989B/sQMuyZ3aDlGU17w1cki1ttvgtelGDNBpMCX5H4euvcG7t4uk6fIy7PRsu2FsVZ38l2rPgKfsYBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plwfd2eA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plwfd2eA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso57610745e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770738860; x=1771343660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXRC/tAwqGKh/o1ifn7jOx1oKAbcp0FPsYzrynQiNbU=;
        b=plwfd2eAVC0V9X+tF+xaq4ZPgKfVzc/1WZXoln9uzlB7IripnJA/vsNhyAsG10mI0O
         8aw/MCu2W6SCfsJdczcb2xT9RlZ0fuZmYsn+KV9jmAKX4tZma4VuxMCBBLP1PcVJeD4x
         A4asbbz5hWhImnIcbcUQZiBE5TL6mQb2pQVCktPUAs95CdTCKzsrTsouu26dlMOb1ZLq
         AvJOgZVUlCB6Zf7vREGfuAVp63D19mrE6tm/qVZSOiw0ov9leaVVwUo5MGDUTk+eIbU3
         Se84MvL3UYgvsPsMp+O2ekGfBewuCalfmRRxwMiWj1PSxuA8tuhuMYvEsQgMWfc20Gu3
         3aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738860; x=1771343660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXRC/tAwqGKh/o1ifn7jOx1oKAbcp0FPsYzrynQiNbU=;
        b=k9daq8iCr+Q/IhFjNn266FAyS5haoAzkpNnVIrf8uS/h6LVRiBmNbMTzHneq1axHme
         NJtb3DJqigZeqUSK/YHQm2XZ9silgczjX0QPPMTbZu95kGG3HMBTYxoeronxGbgc1nuW
         Y+6ItUHhAL/0qslXwTViwzSQ8SAeHZrSUn52GbGbMPrk553AF5U/UrzOhfep3qYXPJ5d
         xiBCKnOVRMZwAgA/KPWCxRsbrLaEeQcF5/2JNYM/3nDAZMZm/1nN7NgbTnZq5dLPcQcm
         ofjNu1bIjgSL0WXMrRh7nSyx4+lAc0K4oi9tVMB4Hq05gXJmwyadiB7SXzAyYyoTqaIC
         e26Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1CtVx4XIEOJeCmGqV0ZwQ+wroRLycM+LKKPwas+sKxkXoXiirPFLqf/TMnWD4OkP2R7iiiqV9Te7k66CuYB4Q8K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kZ9PPw5Q70v+rVm1YC/fpuR2vy/ys9PHfOOZOs73zAe3rEUj
	IIDKfG2bYMoFEYKifajs/8VvVZ4TBxnW+tDwrKDTIs9rAkCEVwUaEOvcFi7S6dkJqQ==
X-Gm-Gg: AZuq6aJwcOU8eN6hAJHEsIipYHRIkExRVadziFP/T4RE4GpsPN9Lc8OchYzxeZvT/1v
	R50+zOQ6W9Glqy3Xv/p/X4dx+Te8JYidtRN1Cn/G7r25t2rMi7iNKhStVOt3apCY9VpmR5oM88B
	5Kc5ANIB0A2tnYKEmlOxdVcksO5E8o3A9m0IM4Po334mGF/Ex6XJw3ssZg+J282ki00ET5T8RFN
	1GJIqcmF4EkA6LEE3VpZUPlY8hQHTLAz+5f9BY+MKJyAzN8uTY0P+AKiKE0YSpFaTWfBnne2yhM
	DQO84m0iUkeK5V8+jKNCxO4pFv0SBWAXplvemZ8jwSGvW1DelxmeaKWjIpG0GH3mG8Dgoxlt5XG
	xylfNYvNnwUNAcsn6GX0KVrRMBv87JRRRCEIVZ9XV+EkIVh2uHShF+Qqm3zxidQJk1ho7zBoATj
	V4a6Junmu4a267EOAvQiyMTYHDbL4ORzMxu/XHaEwFjat1GkdCBCW6Ok+qKqIv+EMLKug=
X-Received: by 2002:a05:600c:3b8b:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-48350511771mr44119235e9.5.1770738860235;
        Tue, 10 Feb 2026 07:54:20 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm71526575e9.7.2026.02.10.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:54:19 -0800 (PST)
Date: Tue, 10 Feb 2026 15:54:16 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 15/30] tracing: selftests: Add trace remote tests
Message-ID: <aYtUqOw8SdX7gqZT@google.com>
References: <20260131132848.254084-1-vdonnefort@google.com>
 <20260131132848.254084-16-vdonnefort@google.com>
 <20260205124208.2ed7cff8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205124208.2ed7cff8@gandalf.local.home>

On Thu, Feb 05, 2026 at 12:42:08PM -0500, Steven Rostedt wrote:
> On Sat, 31 Jan 2026 13:28:33 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Exercise the tracefs interface for trace remote with a set of tests to
> > check:
> > 
> >   * loading/unloading (unloading.tc)
> >   * reset (reset.tc)
> >   * size changes (buffer_size.tc)
> >   * consuming read (trace_pipe.tc)
> >   * non-consuming read (trace.tc)
> > 
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> This still fails:
> 
> === Ftrace unit tests ===
> [1] Test trace remote buffer size	[PASS]
> [2] Test hypervisor trace buffer size	[UNSUPPORTED]
> [3] Test hypervisor trace buffer reset	[UNSUPPORTED]
> [4] Test hypervisor consuming trace read	[UNSUPPORTED]
> [5] Test hypervisor non-consuming trace read	[UNSUPPORTED]
> [6] Test hypervisor trace buffer unloading	[UNSUPPORTED]
> [7] Test trace remote reset	[PASS]
> [8] Test trace remote consuming read	[FAIL]
> [9] Test trace remote non-consuming read	[FAIL]
> [10] Test trace remote unloading	[PASS]
> 
> I added this patch and the two failed tests now pass:
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
> index 081133ec45ff..dfc954a6a380 100644
> --- a/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
> @@ -106,8 +106,10 @@ test_trace()
>      echo 0 > trace
>  
>      for cpu in $(get_cpu_ids); do
> -        echo 0 > /sys/devices/system/cpu/cpu$cpu/online
> -        break
> +        if [ -f /sys/devices/system/cpu/cpu$cpu/online ]; then
> +            echo 0 > /sys/devices/system/cpu/cpu$cpu/online
> +            break
> +        fi

Hum weird, I have changed it in v11 to 

echo 0 > /sys/devices/system/cpu/cpu$cpu/online || return 0

That doesn't work? Because I would simply stop the test there if we can't
offline the CPU.


>      done
>  
>      for i in $(seq 1 8); do
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
> index d28eaee10c7c..146f0a9fe311 100644
> --- a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
> @@ -102,8 +102,10 @@ test_trace_pipe()
>      echo 0 > trace
>  
>      for cpu in $(get_cpu_ids); do
> -        echo 0 > /sys/devices/system/cpu/cpu$cpu/online
> -        break
> +        if [ -f /sys/devices/system/cpu/cpu$cpu/online ]; then
> +            echo 0 > /sys/devices/system/cpu/cpu$cpu/online
> +            break
> +        fi
>      done
>  
>      for i in $(seq 1 8); do
> 
> -- Steve
