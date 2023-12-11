Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92373F9F0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904BFC433C8;
	Mon, 11 Dec 2023 23:13:12 +0000 (UTC)
Date: Mon, 11 Dec 2023 18:13:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Message-ID: <20231211181352.088aeef5@gandalf.local.home>
In-Reply-To: <20231211175904.29e01e8b@gandalf.local.home>
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
	<20231211175904.29e01e8b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 17:59:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > - A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
> >   and produces corrupted time stamps. This is _not_ fixed by this patch.  
> 
> Except that it's not 4 bits that is compared, but 32 bits.

That should be "not 2 bits", as in "shave and a hair cut!" ;-)

-- Steve
