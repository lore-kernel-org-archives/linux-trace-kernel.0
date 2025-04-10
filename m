Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D928F935;
	Thu, 10 Apr 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313181; cv=none; b=JDvG+YUflgEWh9BUjuJ3qG8gyMwNLFAtygP+N9m0+rZQ8RxTwqctjm8oSP7lzB6s3y/8k49OQHdtq24hVjcMR2NFEtICQK3vDZZhpGwu5lED7Y2JPawePfIKA6U06t7vNSCcxQJThmRqpkmDXQqpuv07BBQrYqxcycsDwJDvmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313181; c=relaxed/simple;
	bh=3FSnzZV8mVsa9Rp0JuzSiWmA+roxKhp3i01z/lq5iRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtIAS8NRiyKKP6xH5h+ExNbtXVEuPIu/ARzE+pFX5ergykx3bcGU7XyPULBlq/EIuHYehQLqyqO+nvNDR1mGFic4g7aEcMaYG6Gc8sqdbWBBuOKImo0DZxHlz0MbglWf5UYVIEUwR04fGtQdbLgiy6hQNrNCGqzN9hZ5+9+Qy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B252C4CEDD;
	Thu, 10 Apr 2025 19:26:19 +0000 (UTC)
Date: Thu, 10 Apr 2025 15:27:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Show subops in enabled_functions
Message-ID: <20250410152741.518fa2da@gandalf.local.home>
In-Reply-To: <202504102339.KxLwdUFJ-lkp@intel.com>
References: <20250409094226.23f75293@gandalf.local.home>
	<202504102339.KxLwdUFJ-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 23:45:45 +0800
kernel test robot <lkp@intel.com> wrote:

> >> kernel/trace/ftrace.c:4342:11: error: incomplete definition of type 'struct fgraph_ops'  
>     4342 |                         gops = container_of(subops, struct fgraph_ops, ops);
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks,

This code needs a "#ifdef CONFIG_FUNCTION_GRAPH_TRACER" wrapper.

-- Steve
