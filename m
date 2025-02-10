Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C7254AE5;
	Mon, 10 Feb 2025 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227554; cv=none; b=HJlNh+mb82aK3hihRxMt8WjXJb1xkgpcBq3sMf8Xp9FFpiXuciNPRT/Op39HxYNHN1Mg/rbAiU0TsbD5g0exCL7SM6dk2h6GGD0qEP/V40hwAV60l5BtqLvX/9cWZLPQVmf7MjI6fVhJL2DxJwdeaFy5M5bT5d1wbNuTiKOWoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227554; c=relaxed/simple;
	bh=2QvQuvjtWE2UoAZsXwkMffIgHlLcQCVPXK+vM2BoV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eclykzfUZZdn600UFIZKmL2CZtxLsLreqjGhdxLrE8aFxEonEz3ZIgZlv5iqjwpbCvGlII3K0HxQoMRu6bHc1ydHrsI9DeeDlep9qD48jJS1nB/w/zYFhieogwqCu1fT8ueXlfxES4O5Zulzj1iDEJF7VS/07PMdcJzz2aXL+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77522C4CED1;
	Mon, 10 Feb 2025 22:45:53 +0000 (UTC)
Date: Mon, 10 Feb 2025 17:45:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
Message-ID: <20250210174556.70fc53b7@gandalf.local.home>
In-Reply-To: <20250206141453.139613-1-purvayeshi550@gmail.com>
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 19:44:53 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

Note, subject should start with: "docs: tracing: ..." as "tracing" is the
subsystem and not "trace". Even though the directory is "trace" the
subsystem is "tracing".

> Refactored Documentation/trace/index.rst to improve clarity, structure, 
> and organization. Reformatted sections, added appropriate headings.
> 
> Background of Patch:
> This patch is inspired by the maintainer's suggestion on the v1 patch to

Usually it's bad form to have a patch reference itself as "Patch". The
above could be written as:

   Background:
   These changes were inspired by...

> bring the documentation into real order, similar to commit '270beb5b2aae'
> from Linux 6.13, improving clarity, structure, and usability.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
> V2 - Refined formatting and improved section organization.
> 
>  Documentation/trace/index.rst | 86 ++++++++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 2c991dc96..c4ff7e7de 100644
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
> -   :maxdepth: 2
> +   :maxdepth: 1

I don't really know what the maxdepth gives here, but there was no mention
in the change log why it had to be converted from 2 to 1.

>  
> -   ftrace-design
> +   debugging
> +   tracepoints
>     tracepoint-analysis
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
>     fprobetrace
> -   tracepoints
> +   fprobe
> +
> +Event Tracing and Analysis
> +--------------------------
> +
> +A detailed explanation of event tracing mechanisms and their
> +applications.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     events
>     events-kmem
>     events-power
>     events-nmi
>     events-msr
> -   mmiotrace
> +   boottime-trace
>     histogram
>     histogram-design
> -   boottime-trace
> -   debugging


>     hwlat_detector
>     osnoise-tracer
>     timerlat-tracer

The above 3 probably should be in the hardware interactions section below.

> +
> +Hardware and Performance Tracing
> +--------------------------------
> +
> +This section covers tracing features that monitor hardware
> +interactions and system performance.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     intel_th

>     ring-buffer-design

The ring-buffer-design should be in "Core Tracing Frameworks".

>     ring-buffer-map

This describes how to map the ring buffer in user space. Maybe it should go
at the "Introduction" section?


>     stm
>     sys-t
>     coresight/index
> -   user_events
>     rv/index
>     hisi-ptt
> +
> +User-space Tracing
> +------------------
> +
> +These tools allow tracing user-space applications and
> +interactions.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   user_events

> +   mmiotrace

mmiotrace traces events between hardware and the drivers. Perhaps this
should go up into the Hardware and Performance tracing.

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


Thanks,

-- Steve
