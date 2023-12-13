Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A26111
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B41CC433C8;
	Wed, 13 Dec 2023 03:09:27 +0000 (UTC)
Date: Tue, 12 Dec 2023 22:10:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-ID: <20231212221010.70c84d2d@gandalf.local.home>
In-Reply-To: <20231212084444.4619b8ce@gandalf.local.home>
References: <20231212084444.4619b8ce@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 08:44:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If for some reason the trace_marker write does not have a nul byte for the
> string, it will overflow the print:
> 
>   trace_seq_printf(s, ": %s", field->buf);
> 
> The field->buf could be missing the nul byte. To prevent overflow, add the
> max size that the buf can be by using the event size and the field
> location.
> 
>   int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
>   trace_seq_printf(s, ": %*s", max, field->buf);

Bah, this needs to be:

   trace_seq_printf(s, ": %.*s", max, field->buf);

Note the '.' between % and *. Otherwise it right aligns the output.

This did fail the selftest for trace_printk(), but I modified the new one
to add " *" to accommodate it :-p

Sending out v2.

-- Steve

