Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF917D2;
	Fri, 12 Sep 2025 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638778; cv=none; b=YSZvsmczmbrv7DYz+vR48DLEy/5ARskyzA3WgzyEwskzsrArPFXeFzRwRJIPVyLCDGFtWFwNtndeKYTtwUxVpxhJNUDRvxzpOz13WTNOE2c/1JIRpgQCgP93Bd7WZ+vDkItBXTGl9h6Tk8sOtDXgb++kIqSRfmnwkek36RHkqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638778; c=relaxed/simple;
	bh=Y0hEhUFysEMi8sX74VGSpdf0sMJvMTy+m9KyRq0xdl4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s+zo1E2esT0nLVODkwu+jg1lhvO9RHJ2rjWaZhg8xgv6VR82kfsgjwd0eISerRt2iCd6PWve3GoBiI9gH0cYERpqnGaKEzYbw1OnSZ/5DqPhP5nAhpwiHAwpf01t+RrXheU+pmP5xY2a97I3ai5E0jg6SqzvsOGdUiu2sfArOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/LkZt//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/LkZt//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B999C4CEF0;
	Fri, 12 Sep 2025 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757638777;
	bh=Y0hEhUFysEMi8sX74VGSpdf0sMJvMTy+m9KyRq0xdl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/LkZt//Svr3B1k8Vx/cx+eR7v+6CSpXeVwDcn5UVCyF57DopReBZ2kNUwodSyfmf
	 4ZYYEQDGGUzeDuYWJbTjev2oqY6K0P2GEn072173p0iRHcBtY3ks/EeIv98kXB6yQO
	 q4j2oQ8QMTGKcxtwNfI0f4OhRJsOMrAwC6KOS8srexz9fQ9ZmqgcSEXT6Fpfz2GHnW
	 ysjgqNGPOeJxPaDnNO2VsWBDTkjx1SqBTExOJje3JzWXjRx27WHdTRof8XAmcTeCNv
	 r7ttAcl/dMZvB8EbyfjdTBFl3DDqeQO9c7Zjl9F0ET62nGRV7X55g8wyUwWD0nLbqJ
	 +uQ4h8PTcak2w==
Date: Fri, 12 Sep 2025 09:59:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 1/5] Documentation: trace: histogram: Fix histogram
 trigger subsection number order
Message-Id: <20250912095933.79a4d8b71031310b310de173@kernel.org>
In-Reply-To: <20250911042527.22573-2-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	<20250911042527.22573-2-bagasdotme@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:25:23 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Section numbering in subsections of "Histogram Trigger Command" sections
> is inconsistent in order. In particular, "'hist' trigger examples" is
> erroneously numbered as 6.2, which is a leftover from  b8df4a3634e08a
> ("tracing: Move hist trigger Documentation to histogram.txt").
> 
> Fix the order.

Thanks for fixing. This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram.rst | 34 +++++++++++++++----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index af6d2e15568ebd..d158dadaa42447 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -186,8 +186,8 @@ Documentation written by Tom Zanussi
>    The examples below provide a more concrete illustration of the
>    concepts and typical usage patterns discussed above.
>  
> -'special' event fields
> -------------------------
> +2.1. 'special' event fields
> +---------------------------
>  
>    There are a number of 'special event fields' available for use as
>    keys or values in a hist trigger.  These look like and behave as if
> @@ -204,16 +204,16 @@ Documentation written by Tom Zanussi
>      common_cpu             int  the cpu on which the event occurred.
>      ====================== ==== =======================================
>  
> -Extended error information
> ---------------------------
> +2.2. Extended error information
> +-------------------------------
>  
>    For some error conditions encountered when invoking a hist trigger
>    command, extended error information is available via the
>    tracing/error_log file.  See Error Conditions in
>    :file:`Documentation/trace/ftrace.rst` for details.
>  
> -6.2 'hist' trigger examples
> ----------------------------
> +2.3. 'hist' trigger examples
> +----------------------------
>  
>    The first set of examples creates aggregations using the kmalloc
>    event.  The fields that can be used for the hist trigger are listed
> @@ -1608,8 +1608,8 @@ Extended error information
>          Entries: 7
>          Dropped: 0
>  
> -2.2 Inter-event hist triggers
> ------------------------------
> +2.4. Inter-event hist triggers
> +------------------------------
>  
>  Inter-event hist triggers are hist triggers that combine values from
>  one or more other events and create a histogram using that data.  Data
> @@ -1685,8 +1685,8 @@ pseudo-file.
>  
>  These features are described in more detail in the following sections.
>  
> -2.2.1 Histogram Variables
> --------------------------
> +2.5. Histogram Variables
> +------------------------
>  
>  Variables are simply named locations used for saving and retrieving
>  values between matching events.  A 'matching' event is defined as an
> @@ -1789,8 +1789,8 @@ or assigned to a variable and referenced in a subsequent expression::
>  
>  Variables can even hold stacktraces, which are useful with synthetic events.
>  
> -2.2.2 Synthetic Events
> -----------------------
> +2.6. Synthetic Events
> +---------------------
>  
>  Synthetic events are user-defined events generated from hist trigger
>  variables or fields associated with one or more other events.  Their
> @@ -1846,7 +1846,7 @@ the command that defined it with a '!'::
>  At this point, there isn't yet an actual 'wakeup_latency' event
>  instantiated in the event subsystem - for this to happen, a 'hist
>  trigger action' needs to be instantiated and bound to actual fields
> -and variables defined on other events (see Section 2.2.3 below on
> +and variables defined on other events (see Section 2.7. below on
>  how that is done using hist trigger 'onmatch' action). Once that is
>  done, the 'wakeup_latency' synthetic event instance is created.
>  
> @@ -2094,8 +2094,8 @@ histogram::
>      Entries: 7
>      Dropped: 0
>  
> -2.2.3 Hist trigger 'handlers' and 'actions'
> --------------------------------------------
> +2.7. Hist trigger 'handlers' and 'actions'
> +------------------------------------------
>  
>  A hist trigger 'action' is a function that's executed (in most cases
>  conditionally) whenever a histogram entry is added or updated.
> @@ -2526,8 +2526,8 @@ The following commonly-used handler.action pairs are available:
>           kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
>                <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
>  
> -3. User space creating a trigger
> ---------------------------------
> +2.8. User space creating a trigger
> +----------------------------------
>  
>  Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
>  ring buffer. This can also act like an event, by writing into the trigger
> -- 
> An old man doll... just what I always wanted! - Clara
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
