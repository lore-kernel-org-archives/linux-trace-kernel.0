Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qNhzJPTY"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B610F1;
	Thu,  7 Dec 2023 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1701987565;
	bh=86p3ylrkbz2hpcmZExuM50REXyynwKwbcr5XPixsGws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qNhzJPTYRkdipYePc/C6vS7fT5ohZ8VF4yqLBsoiWKJ3QpmsJa1zgc6AEATOzt7yh
	 VgjauIWncZhzOhve0lJbPCv/ls4qL30vMlIQ9MXyPuPQlvyRIIz9PmzvmPDbIf8elc
	 UkzCxVx2Y7NtbSw/4tVIinVsaOg4hYSvnUuWF3sOII/1mz8spT9b3h7Li5adn7Do7x
	 ceWpIs8a/JwvnjzEGd8bzFXiZHNE1rhfxsc36nDaIIpMFZozelByoNKoXDl9ZhXgJY
	 +9LrsZbpDjTc1IAWJODbTqcXl/cytdiGIVBwMhOahh3DzbiPAhDDeodzOpzeYwyP8r
	 CKppzR//kmkPw==
Received: from [192.168.104.112] (Sansfil-Eduroam-Externe-212-2.polymtl.ca [132.207.212.2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SmTG55KTRzFpv;
	Thu,  7 Dec 2023 17:19:25 -0500 (EST)
Message-ID: <866d40a8-4e0c-465c-ab8c-b5d864c1a668@efficios.com>
Date: Thu, 7 Dec 2023 17:19:24 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Add offset of events in dump on mismatch
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20231207171613.0592087d@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231207171613.0592087d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-07 17:16, Steven Rostedt wrote:

[...]

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8d2a4f00eca9..b10deb8a5647 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3424,23 +3424,27 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
>   		case RINGBUF_TYPE_TIME_EXTEND:
>   			delta = rb_event_time_stamp(event);
>   			ts += delta;
> -			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
> +			pr_warn(" %x: [%lld] delta:%lld TIME EXTEND\n",

Please prefix hex values with "0x", as in:

pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n"

Otherwise it can be confusing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

