Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555563B7A8;
	Mon, 15 Jul 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070635; cv=none; b=OjdF5JFWnLm2UQj5Ku1wzqjd+Tyo0BSqkYGzEUYgAUECTDObhOPbUpskCr+pxBiNeVHbn97CP/A1X6cx9qw3XDP7JQ6Ly/+ENQWiHT2ZEfQtresGHF3NgMkwjIpAQOwxEXBmqn6/kPuPj9FGeCObXccS6bbdgYFc+HkqnDoSgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070635; c=relaxed/simple;
	bh=B9nv/IC8IEC5b9GU3Az0zPNtKYTfU1qOhzR3/DJuXRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/0m7kj/eEHdaI5Xdbx/3f0h7IS0e9M/2qAsnwUWuv7OwdpXjy+82EOnCvin8FH/50QoTamOmHfZZ93EQKscfCbjLDxLPBryqQMnqq2jBB5NFVoSEhe+Tx9rPAoGd8zVkPykBkofAEEw6OTxmtBXSgJb8Mbuc3oudtzDiiCKs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LbM19lsG; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LbM19lsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721070624;
	bh=B9nv/IC8IEC5b9GU3Az0zPNtKYTfU1qOhzR3/DJuXRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LbM19lsG7weG2wB2HCFWQ2z0//1j8fYiZ3NMzy1m+FN39WRGisafIoPWQPEMOvh7C
	 OHigHWA6ev3CTjxTAkg63sndChPbG5BymtBER6h1Avb65yzmEJJjrIBkrSwl2VvCnS
	 a6IQJvUoe+J4kSgaJ+WSb7SqshVDNx+silUFjIbwb/KHmmHwI0f+PTYYXZkMek8gNQ
	 RdrAbiZTeKIO+oljpJuHY9eiY5vXXTvSE3PyaEwUfDHPteX1E7o49tU+bygjkZEKQj
	 LgSheAymFxiU47uNREB7EqYWLgtsJiEpuzRQpAtznsw3ndFaWUNqgmPZ3qSILmu8Nf
	 BQ4DKFyDe8Xdw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WNBc052Wkz1B5l;
	Mon, 15 Jul 2024 15:10:24 -0400 (EDT)
Message-ID: <11fe922b-ffd4-4173-b1ff-d49745431fb0@efficios.com>
Date: Mon, 15 Jul 2024 15:10:17 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Update MAINTAINERS file
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
 John Kacur <jkacur@redhat.com>
References: <20240715144745.51d887a9@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240715144745.51d887a9@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-15 14:47, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Gone but never forgotten.
> 
> [ Also moved Daniel's name to be consistent with the alphabetical order ]

Hi Steven,

You appear to have missed this entry from SCHEDULER:

R:      Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)

Should it be done in a separate commit or folded in this one ?

Thanks,

Mathieu

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   CREDITS     | 10 +++++++---
>   MAINTAINERS |  3 ---
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 88c4c08cb613..d7798910e99f 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -271,9 +271,6 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
>   D: Various bugfixes and changes to sound drivers
>   S: USA
>   
> -N: Daniel Bristot de Oliveira
> -D: Scheduler contributions, notably: SCHED_DEADLINE
> -
>   N: Carlos Henrique Bauer
>   E: chbauer@acm.org
>   E: bauer@atlas.unisinos.br
> @@ -534,6 +531,13 @@ S: Kopmansg 2
>   S: 411 13  Goteborg
>   S: Sweden
>   
> +N: Daniel Bristot de Oliveira
> +D: Scheduler contributions, notably: SCHED_DEADLINE
> +D: Real-time Linux Analysis
> +D: Runtime Verification
> +D: OS Noise and Latency Tracers
> +S: Brazil and Italy
> +
>   N: Paul Bristow
>   E: paul@paulbristow.net
>   W: https://paulbristow.net/linux/idefloppy.html
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e1b8bbacb5e..0b7e4cd4ffd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18895,7 +18895,6 @@ F:	include/uapi/linux/rtc.h
>   F:	tools/testing/selftests/rtc/
>   
>   Real-time Linux Analysis (RTLA) tools
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>   M:	Steven Rostedt <rostedt@goodmis.org>
>   L:	linux-trace-kernel@vger.kernel.org
>   S:	Maintained
> @@ -19529,7 +19528,6 @@ S:	Maintained
>   F:	drivers/infiniband/ulp/rtrs/
>   
>   RUNTIME VERIFICATION (RV)
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>   M:	Steven Rostedt <rostedt@goodmis.org>
>   L:	linux-trace-kernel@vger.kernel.org
>   S:	Maintained
> @@ -22806,7 +22804,6 @@ F:	kernel/trace/trace_mmiotrace.c
>   
>   TRACING OS NOISE / LATENCY TRACERS
>   M:	Steven Rostedt <rostedt@goodmis.org>
> -M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>   S:	Maintained
>   F:	Documentation/trace/hwlat_detector.rst
>   F:	Documentation/trace/osnoise-tracer.rst

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

