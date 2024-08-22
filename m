Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229323749
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298888; cv=none; b=kFZx+B/0LBaB60vUazeFKTAWOspRHQZZC3xtjPNUWYyeQFP/vOKdGvo70U3hbgg225n6OPrzkFyGFNNbCYAGKK9Gmrb5QfBswoMBGyAToLFk0F/oZ8u3wEeXjJsYK+24hpd0Bxtt0MMzxPB2nj2xcMYKnyxoOeeE71VzmF7goWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298888; c=relaxed/simple;
	bh=T/F5YWbBsHJ/z0Iuh2yAc4urVrY6y59yzaKigq0sOvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtIohYMOxCfCYw8aTO9Zt35D8sBH2Y2/EQCKk/bRylmijMrXHXBRAntHFsHNludDaBaXmJrg/kqXgwbe+jEsPqwDHliTB0x6qxMg0sqw2TYrtuAdlc8kp1gxmmZXjX1L/3KeOjiKsYI/i7/c8SSseDPx/liI1UK+0kKb0VljnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHpwZIFk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHpwZIFk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-714302e7285so300972b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724298886; x=1724903686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+51o8YiuRVZF11J4eUjPb8uV0dcc874YeCBbU5SJ2E=;
        b=CHpwZIFk7PKPPrusbDFktlICkdUajUnnYEPKiqgT33nxNZbcY6Unn32lxf1eaHfrB7
         s5XjLAPLVXtdVXq5t5SwKqEfmHD2W59cqNgIl50Hj3IvQxWp7kZ6ip9T5F0QbQnDfaJO
         VUUapfPMZ+VebD8eHQ1twkw13Eh2t86zUkx9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724298886; x=1724903686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+51o8YiuRVZF11J4eUjPb8uV0dcc874YeCBbU5SJ2E=;
        b=KZILT5EXJc3LkJJZJaOitcuHPC5xjfa1uomzMIGnFabnrwVDhk1Ys93b/7ES68ax/M
         4L1vqNtWM9Ylfp7II0dfVmhvoKgyd+exuGf2rvzacEeFYXLtJPVtiumsP0ct7acHTU5f
         kQYmeEpE2+5cmM6ppW46D++ElprFPxearBQ77fvcgqJapuwh2ffsGox59IifP2S0iYOF
         oavECWy7pj8HcFS4eRZbJbftKXmiGi50dsT4SKzWlApIZ14mc4e+bI8x+undKvyGoH9c
         jDBCw5KS9e27blnW5rPT+H/1SGqloHN1kOwTR3Usl5bYiD6x37GRcEcYSZ5WKghdBA0p
         AsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAIo4T6mackkZyppoaSCR30UZaCGSxcCkOV8KksGbNQKB17U/f76mhTPLEFqVaMYsq6XUbaSnDVMe/e15GC9G0a88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqsxjHN4OF2s/GPNcAqeUEivnBTFzmCbQ/d/eV1MCU6q1GNdw
	FJgJtlj/8OKkCM07JFIAKih0wrMmi4rUuraWpebplG5NNbTotZnlvlhZnQHkV5g=
X-Google-Smtp-Source: AGHT+IEF5mjPTWIL5LkSLOikrrXvOOmbWUvTcH0b28Ep5CS8oSuo0W0v93DNqIuCxV5/NJGwDW5vvg==
X-Received: by 2002:a05:6a21:920b:b0:1c6:fbc8:670d with SMTP id adf61e73a8af0-1cada148a32mr5136891637.43.1724298885562;
        Wed, 21 Aug 2024 20:54:45 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdc5e0sm3324215ad.271.2024.08.21.20.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 20:54:44 -0700 (PDT)
Message-ID: <3901c521-be69-4824-a571-9182b9af02b6@linuxfoundation.org>
Date: Wed, 21 Aug 2024 21:54:42 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240821150903.05c6cf96@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240821150903.05c6cf96@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 13:09, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami reported a bug when running function graph tracing then the
> function profiler. The following commands would cause a kernel crash:
> 
>    # cd /sys/kernel/tracing/
>    # echo function_graph > current_tracer
>    # echo 1 > function_profile_enabled
> 
> In that order. Create a test to test this two to make sure this does not
> come back as a regression.
> 
> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> new file mode 100644
> index 000000000000..62d44a1395da
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function profiler with function graph tracing
> +# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
> +
> +# The function graph tracer can now be run along side of the function
> +# profiler. But there was a bug that caused the combination of the two
> +# to crash. It also required the function graph tracer to be started
> +# first.
> +#
> +# This test triggers that bug
> +#
> +# We need function_graph and profiling to to run this test
> +
> +fail() { # mesg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo "Enabling function graph tracer:"
> +echo function_graph > current_tracer
> +echo "enable profiler"
> +
> +# Older kernels do not allow function_profile to be enabled with
> +# function graph tracer. If the below fails, mark it as unsupported
> +echo 1 > function_profile_enabled || exit_unsupported
> +
> +sleep 1

Any specific reason for this sleep 1 - can you add a comment on top?
> +
> +exit 0

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Let me know if you would like v2 for this to be taken through my tree.

thanks,
-- Shuah
