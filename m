Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEF13AA31;
	Tue, 15 Apr 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725886; cv=none; b=gjVBuDMMaoFFe9fpUXNNaWxypkbMe9VovXKlAu3uJfM2lheyD8vSeHrsFuqWwc9AoQYx4n0GNEi7FKXyf5PeCbEh+KHTXG3nJVC/iLVom5zX0JVfQJzs6BZLCGUk8l//L3PswZQzomQ1xhJK5LzCkaJP5uBSz7SLVqrt5q6PO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725886; c=relaxed/simple;
	bh=w/KuN1+/jkmXSCmG+Tl62jjuPvibvKiLVxTIWZQPbEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUE+dRezUaYy3FYmke9MrGRGYQLAIvEaZnn/cmNgvQBNufVdOk37LhcGs0bpXWVdJ1tMAmcr+QYBZ2y8p5Be5RejpwxxJpRAsjrmHgPLHXJhor8OU4tRwJ1OnC5AGf5lKtQ7K3G9sSydShVxT1i5pliofwsNN8OeV72W8JGz9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7128C4CEDD;
	Tue, 15 Apr 2025 14:04:43 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:06:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kernel
 Tracing <linux-trace-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Purva Yeshi <purvayeshi550@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: trace: Refactor toctree
Message-ID: <20250415100617.08ab9e08@gandalf.local.home>
In-Reply-To: <20250415034613.21305-3-bagasdotme@gmail.com>
References: <20250415034613.21305-1-bagasdotme@gmail.com>
	<20250415034613.21305-3-bagasdotme@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 10:46:13 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> Hi Steven,
> 
> I remove your Acked-by: since I massage the patch description. Would you mind
> to re-add yours?

Sure, I do have one comment below.

> 
> Thanks.
> 
>  Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index fecc4adf70a830..5ddd47ee781211 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -1,39 +1,103 @@
> -==========================
> -Linux Tracing Technologies
> -==========================
> +================================
> +Linux Tracing Technologies Guide
> +================================
> +
> +Tracing in the Linux kernel is a powerful mechanism that allows
> +developers and system administrators to analyze and debug system
> +behavior. This guide provides documentation on various tracing
> +frameworks and tools available in the Linux kernel.
> +
> +Introduction to Tracing
> +-----------------------
> +
> +This section provides an overview of Linux tracing mechanisms
> +and debugging approaches.
>  
>  .. toctree::
>     :maxdepth: 1
>  
> -   ftrace-design
> +   debugging
> +   tracepoints
>     tracepoint-analysis
> +   ring-buffer-map
> +
> +Core Tracing Frameworks
> +-----------------------
> +
> +The following are the primary tracing frameworks integrated into
> +the Linux kernel.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     ftrace
> +   ftrace-design
>     ftrace-uses
> -   fprobe
>     kprobes
>     kprobetrace
>     uprobetracer

I think the uprobetracer can go into the user space tracing below.
As uprobes attaches to user space programs.

>     fprobetrace
> -   tracepoints
> +   fprobe
> +   ring-buffer-design
> +

[..]

> +
> +User-Space Tracing
> +------------------
> +
> +These tools allow tracing user-space applications and
> +interactions.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   user_events

      uprobetracer

-- Steve


> +
> +Additional Resources
> +--------------------
> +
> +For more details, refer to the respective documentation of each
> +tracing tool and framework.
> +
> +.. only:: subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> \ No newline at end of file

