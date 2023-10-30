Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCF171B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ACFC433C8;
	Mon, 30 Oct 2023 13:59:20 +0000 (UTC)
Date: Mon, 30 Oct 2023 09:59:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check
 when module loads
Message-ID: <20231030095918.4ec74c88@gandalf.local.home>
In-Reply-To: <169854904604.132316.12500381416261460174.stgit@devnote2>
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Oct 2023 12:10:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check the number of probe target symbols in the target module when
> the module is loaded. If the probe is not on the unique name symbols
> in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |  112 ++++++++++++++++++++++++++-----------------
>  1 file changed, 68 insertions(+), 44 deletions(-)

Reviewed-by: Steven Rosted (Google) <rostedt@goodmis.org>

-- Steve
