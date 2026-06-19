Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DDBA34;
	Fri, 19 Jun 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857987; cv=none; b=maCq07Pje8uNvJwIJXqRJW1yLAg6QIk917t3IONNEJ5Hb5s/0sfA/LMWnVLz9OdhIDmPXmKSYylwiP/ahqUahSymMDeSrTWJwRoNDd12p5Ph3jgU2UiaklWyLzg9aFX+hvEIb3+qAbKQSUQ7h6r7DQhSmzmrIhx/kS8Yh7+8mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857987; c=relaxed/simple;
	bh=I+tQqGD0L4UBX5q0DnT9f2pN9Gx6XZaZ/9c6st6ziS8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rCTldKy4fiZ2IkG14G2PLn/Laooo6G/0UxZZ/YQottgc4KHUcv7QecvXdylGOB2pJTG8c7730TVmatTAujnq+Ih6OLLtZ2T8IdMDIrlAtTCh+5G9SN7RaJ5/LPgnlu3JruqO4aOupaAayv59RNkysozRdiq/+mTH0LFrdip975A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGHmM465; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGHmM465"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2152D1F000E9;
	Fri, 19 Jun 2026 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781857986;
	bh=ZEWWUQknWTX9e4FkWKGZzS31KK9gLz4SZbX4DfHXsl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oGHmM465IppHHaNyj2y7/2v3/cbfz4+o1v8YarcrIgKY8qEvHwC0XLGSM8R4Umhcg
	 TifN/eZrRPRlqtGdmjjFS/CoFquk3C8GnJU+gGW7AvBzYzPtvO1TYHkzUGWqqsRs0x
	 QdSHeXNZofrX8/uTtdXGrfS4GLvKA4FY9IvT/e6/S7eSRqaKDLDyQ2ViCVkzqYLWf4
	 FIeoo3pAnEOr03i/r7Df+3SWwiJE8qsFvoTov/HzlxU9nABRTU60qGXR6AtXRb9cRD
	 DsUAlNB1cKF36vjoTgxAVKEDEg8ki9HllgvjDjfFNroC3ffZenGY2IKExeMviQ8SXR
	 prLOJRqJ1CTvA==
Date: Fri, 19 Jun 2026 17:33:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/7] tracing/events: Fix to check the simple_tsk_fn
 creation
Message-Id: <20260619173301.624aba2869adad19e11bf59e@kernel.org>
In-Reply-To: <178165817322.269421.3992299509400184196.stgit@devnote2>
References: <178165816303.269421.7302603996990753309.stgit@devnote2>
	<178165817322.269421.3992299509400184196.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Let me pick this fix to probes/core.

Thanks,

On Wed, 17 Jun 2026 10:02:53 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Sashiko pointed that this sample code does not correctly handle the
> failure of thread creation because kthread_run() can return -errno.
> 
> Check the simple_tsk_fn is correctly initialized (created) or not.
> 
> Link: https://sashiko.dev/#/patchset/178092865666.163648.10457567771536160909.stgit%40devnote2
> 
> Fixes: 9cfe06f8cd5c ("tracing/events: add trace-events-sample")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>    - Fix to remove decrementing counter in error path, since foo_bar_reg() always returns 0.
>    - Add a newline to error message.
>  Changes in v3:
>    - Recover the usage counter.
> ---
>  samples/trace_events/trace-events-sample.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
> index ecc7db237f2e..0b7a6efdb247 100644
> --- a/samples/trace_events/trace-events-sample.c
> +++ b/samples/trace_events/trace-events-sample.c
> @@ -107,6 +107,10 @@ int foo_bar_reg(void)
>  	 * for consistency sake, we still take the thread_mutex.
>  	 */
>  	simple_tsk_fn = kthread_run(simple_thread_fn, NULL, "event-sample-fn");
> +	if (IS_ERR_OR_NULL(simple_tsk_fn)) {
> +		pr_err("Failed to create simple_thread_fn\n");
> +		simple_tsk_fn = NULL;
> +	}
>   out:
>  	mutex_unlock(&thread_mutex);
>  	return 0;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
