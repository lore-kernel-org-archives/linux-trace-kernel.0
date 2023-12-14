Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F0814
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5218AC433C8;
	Thu, 14 Dec 2023 02:48:45 +0000 (UTC)
Date: Wed, 13 Dec 2023 21:49:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231213214930.5a501584@gandalf.local.home>
In-Reply-To: <20231213211126.24f8c1dd@gandalf.local.home>
References: <20231213211126.24f8c1dd@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 21:11:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -3720,6 +3517,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>  	struct rb_event_info info;
>  	int nr_loops = 0;
>  	int add_ts_default;
> +	static int once;
>  
>  	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
>  	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&

Oops, some debug code got committed!

-- Steve
