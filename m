Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80EDDA8;
	Thu,  3 Oct 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969222; cv=none; b=f8j9SkgQ1X+tXYjoqDHy/KDnXYy5kktW+XV8LU6pB/PHd4UDHJ5/aPw6ZRzmXuJQ318pHGEsNeBufnbqNBFBzC2fXmEpViGerKSqDHvJxXKrMsmD5/VotItQf3+Ut3NyjvjRWgNQoRhcWRdWWtrjom7KKCtNkSRLQ3lquqnj5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969222; c=relaxed/simple;
	bh=RJWtPH/d+fY3ScW0SysxW4UYHxYKo0H2iwDu/3Nz9z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfjiW90rdsAZDwr5s8GXtMa15qQboJn7gNSreKLc0oSSC8zGVL3qugdxGyMYEqwWIudK8dRJwEsaovMD+XxU2mRvIkVJO5qMiyfU1g/EBKPlLW6UtkL9/1WAXzZEf/4kVkoe2LLswbp3PorNyqW8yTv/NohuvHekL3POcziGoOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B0C4CEC5;
	Thu,  3 Oct 2024 15:27:01 +0000 (UTC)
Date: Thu, 3 Oct 2024 11:27:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: doc: Fix typo in ftrace histogram
Message-ID: <20241003112755.62b88e33@gandalf.local.home>
In-Reply-To: <20241003122334.44682-2-gmonaco@redhat.com>
References: <20241003122334.44682-2-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 14:23:35 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> The Tracing > Histogram page contains a typo in the field display
> modifiers table.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  Documentation/trace/histogram.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 3c9b263de9c2..0aada18c38c6 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -81,7 +81,7 @@ Documentation written by Tom Zanussi
>  	.usecs         display a common_timestamp in microseconds
>          .percent       display a number of percentage value
>          .graph         display a bar-graph of a value
> -	.stacktrace    display as a stacktrace (must by a long[] type)

 "Pat, I would like to b(u)y a long[] type"


> +	.stacktrace    display as a stacktrace (must be a long[] type)
>  	=============  =================================================
>  
>    Note that in general the semantics of a given field aren't
> 
> base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
