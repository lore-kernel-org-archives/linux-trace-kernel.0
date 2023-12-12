Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D77A201
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7AC433C9;
	Tue, 12 Dec 2023 15:28:09 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:28:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-ID: <20231212102851.5e181e33@gandalf.local.home>
In-Reply-To: <148974c2-df17-4c71-a59a-6e056e10910e@efficios.com>
References: <20231212084444.4619b8ce@gandalf.local.home>
	<148974c2-df17-4c71-a59a-6e056e10910e@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 09:23:54 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-12 08:44, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If for some reason the trace_marker write does not have a nul byte for the
> > string, it will overflow the print:  
> 
> Does this result in leaking kernel memory to userspace ? If so, it
> should state "Fixes..." and CC stable.

No, it was triggered because of a bug elsewhere ;-)

  https://lore.kernel.org/linux-trace-kernel/20231212072558.61f76493@gandalf.local.home/

Which does have a Cc stable and Fixes tag.

The event truncated the trace_marker output and caused the buffer overflow
here. The trace_marker always adds a '\0', but that got dropped due to the
other bug. This is just hardening the kernel.

Note, this can only happen with the new code that allows trace_marker to
use the max size of the buffer, which is for the next kernel release.

-- Steve
