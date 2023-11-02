Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09B15D2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A4BC433C8;
	Thu,  2 Nov 2023 02:46:48 +0000 (UTC)
Date: Wed, 1 Nov 2023 22:46:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing: Have trace_event_file have ref counters
Message-ID: <20231101224646.5d9c21fb@gandalf.local.home>
In-Reply-To: <20231101223254.7ec2a1e2@gandalf.local.home>
References: <20231031122453.7a48b923@gandalf.local.home>
	<20231102111433.5330cbb98cf204b4063924c0@kernel.org>
	<20231101223254.7ec2a1e2@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Nov 2023 22:32:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Ouch! I thought the file descriptor has been hold by the opened process.  
> 
> Well, the struct *filp is, but not the filp->private that points to the
> struct trace_event_file *file.

That was supposed to be "struct file *filp"

-- Steve
