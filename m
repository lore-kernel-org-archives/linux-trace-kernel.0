Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323475;
	b=O//95dV/ei89KKWMjGdCQM+GGX+MNfGdA0R3EOASF/mfvWCt3Y8mffWw9yV5Bp696wRU
	 GjV6u8TMQHiP/ZzhOGb6xAtS8vAuRuIjt2781k7L05AXdjF+LOMLVmAoq69faGD9drTna
	 Ae0d71ob09b5pbyTDYgQtT1884Cxb8/+Q+1kHCrDZr3+OdP4Wh4REMZT9LCzKhNFp1ulY
	 3yKpU+vT8avxDncWlKxbTwhnfFlvhUmUXOBfN/oFS6cGm80/TAZOHVo149iwHmlxiemc3
	 lpvJw1sS8b+em0X80Jqv8Ih3zBAOOnWAdu4Ye8Wncz7iC/B58EaF2Yvz96gMOeLMKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GXUnUDqAE3TwAby2cgqzBzwzeC+7tHAKVjAfWPCfQk4=;
	b=c9HWUiXscfdfGawt0ok8/kj8j2fKIasNsOLcMaU3PXuGut2oOfuUa+8R4G5JqC+wSQNc
	 fZb3B9Iic9Htz8cK+WOTj/9pEFlMHoUtoLagIfXA5bx0Qgx1AEYl9o/7NvIaGKWW23ntz
	 xOY1oalZdUjWXhsK+i/Qd7KK/Jm5kkYwYoEvwmNBMsDgw674m+5CgAZn4E3jwTr48ZQ8j
	 Ro2ArlulsYLS/pugaYnQv3hUNCsxWM84IPs9sdgayl3pAD+w8UDN6RqHKTvGoPzg3jFrD
	 uN6J+LuLi4+JGMfV2tnVG7yKpa64Pv6uH9OTHcVTEczsp+ng+gkmd5RR1cfJYJU7a+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zgyp0qgx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E10606A31A;
	Fri, 30 Oct 2026 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zgyp0qgx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF0C1F000C1;
	Fri, 30 Oct 2026 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793323474;
	bh=GXUnUDqAE3TwAby2cgqzBzwzeC+7tHAKVjAfWPCfQk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zgyp0qgx3KR2XvdoypO4/34CNSz4J4up8EmDFaHWO6CHgAafGiHRU5DKWJ+2qbgYB
	 Jve3IPiM7mKOGURhXfgyi9CISYKvB+PY7Y2Jrw/pPkn3SAmtUrz48ZA+Fu+vUcZFDx
	 1UNe4wV+xp0EefYKhWJmFyWY5XUMUQ1LS1YHGaMp73jsA6MbAj4n0AlivVGdlpUnLn
	 N0XJYKGAY8R/8c5cldPjBRDdd9GWSPuQk+UKzuOKzWAPdXdGn7qf5yl4TV19c9ajdg
	 AiP0/wY9sgw/iCsvmlvjpeoKWbxbfVdhBTJZEqmjhDGGxPfLghbD6a17HjXTW4MYEr
	 Y4YISSjyMaRWg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tracing/selftests: Add reading all instance files to instance test
Date: Fri, 30 Oct 2026 10:24:31 +0900
Message-ID: <undine-1793323471122886728-c7f7442e58341b3d@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261029203205.969033931@kernel.org>
References: <20261029202849.245864353@kernel.org> <20261029203205.969033931@kernel.org>
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

On Thu, 29 Oct 2026 16:28:51 -0400, Steven Rostedt <rostedt@kernel.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Commit f4a771cc684c7 ("tracing: Have show_event_filters/triggers files take
> trace array ref") fixed a bug where the show_event_filters and triggers
> did not take a trace array reference allowing an instance to be removed
> while active. This would have the reader of these files read data that was
> freed by the remove.
> 
> Update the instance test to read all the files in the instance,
> instance/events, instance/events/sched and
> instance/events/sched/sched_switch directories (with the exception of not
> reading trace or trace_pipe). This would hopefully catch issues with files
> not taking references.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> ---
>  .../ftrace/test.d/instances/instance-event.tc | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> index b0e9d3abbf2f..9374c20c6aaa 100644
> --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> @@ -44,6 +44,19 @@ instance_set() {
>          done 2> /dev/null
>  }
>  
> +instance_cat() {
> +        while :; do
> +		find instances/foo -maxdepth 1 -type f  ! \( -name trace -o -name trace_pipe \) -exec head {} \;
> +		sleep 0.1
> +		find instances/foo/events -maxdepth 1 -type f  -exec cat {} \;
> +		sleep 0.1
> +		find instances/foo/events/sched -maxdepth 1 -type f  -exec cat {} \;
> +		sleep 0.1
> +		find instances/foo/events/sched/sched_waking -maxdepth 1 -type f  -exec cat {} \;
> +		sleep 0.1
> +        done 2> /dev/null
> +}
> +
>  instance_set &
>  p1=$!
>  echo $p1
> @@ -52,15 +65,20 @@ instance_read &
>  p2=$!
>  echo $p2
>  
> +instance_cat &
> +p3=$!
> +echo $p3
> +
>  for i in `seq 10`; do
>  	instance_slam
>  done
>  
> +kill -1 $p3
>  kill -1 $p2
>  kill -1 $p1
>  
>  echo "Wait for processes to finish"
> -wait $p1 $p2
> +wait $p1 $p2 $p3
>  echo "all processes finished, wait for cleanup"
>  sleep 1
>  
> -- 
> 2.53.0
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
