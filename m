Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43411702
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6CAC433C7;
	Sun, 10 Dec 2023 15:38:07 +0000 (UTC)
Date: Sun, 10 Dec 2023 10:38:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, Kent
 Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 00/14] ring-buffer/tracing: Allow ring buffer to have
 bigger sub buffers
Message-ID: <20231210103844.7cabaa13@gandalf.local.home>
In-Reply-To: <76797ddd-bb87-4af9-9703-1ec00a0d318c@efficios.com>
References: <20231210035404.053677508@goodmis.org>
	<76797ddd-bb87-4af9-9703-1ec00a0d318c@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 09:17:44 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-09 22:54, Steven Rostedt wrote:
> [...]
> > 
> > Basically, events to the tracing subsystem are limited to just under a
> > PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
> > size, and an event can not be bigger than a sub buffer. This allows users
> > to change the size of a sub buffer by the order:
> > 
> >    echo 3 > /sys/kernel/tracing/buffer_subbuf_order
> > 
> > Will make each sub buffer a size of 8 pages, allowing events to be almost
> > as big as 8 pages in size (sub buffers do have meta data on them as
> > well, keeping an event from reaching the same size as a sub buffer).  
> 
> Specifying the "order" of subbuffer size as a power of two of
> number of pages is a poor UX choice for a user-facing ABI.
> 
> I would recommend allowing the user to specify the size in bytes, and
> internally bump to size to the next power of 2, with a minimum of
> PAGE_SIZE.

Thanks. I actually agree with you and thought about doing just that, but
decided to not make those changes and send out these patches with the
given API first. I wanted to see if you would comment on this ;-) You did
not disappoint!

I was thinking of keeping the same kind of interface as we have with the
buffer size "buffer_size_kb", and have it be "buffer_subbuf_size_kb", where
you specify the minimum size in kilobytes and it creates it, and the subbuf
may end up being bigger than specified (as that's more a implementation
detail).

Now that you called it out, I will add a patch to convert that as such. But
will keep the current patches in for historical reasons.

-- Steve
