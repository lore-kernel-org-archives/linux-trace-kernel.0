Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443A1F7568;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456884; cv=none; b=N58wpZSBg67o/QeX9sNjy+gS/Lw/GNtwBmlViUu7lzyhBxRiaGQEPY0ABbKIiFFrYSepzQiOUmOMlf2KRDToe7WEeJhwZkPN6dZrIqEZW8Td0LgL9aHhqMK4Uo8Z92StKs7pWvFIWHuW2xapn4LiVYAa6cVPkmbl8gHq663tCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456884; c=relaxed/simple;
	bh=i/J2QgKa2bToPpARuv+8BicGd4s22Z4ij6tO6G64X1w=;
	h=Message-ID:Date:From:To:Cc:Subject; b=o9AXIdsg73J3qDJ1/EE3fAX2PUBawIjFLC9p0c7jT3vdsV5i77J5xkJ+zUH0JnWFfr11Z5dm2bOD75y+fkE0f9QKKZvRkl7LFPz/YZwamk+1QScBs+f0fuf5e6+2AzhC3yMlktYGaHqfZMv5CMs+4v1hSr7zVi/WlrUFfPEk4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBB0C4CED3;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNbTc-00000008ctZ-1Bvx;
	Tue, 17 Dec 2024 12:35:20 -0500
Message-ID: <20241217173237.836878448@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 12:32:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] ring-buffer: Hardening of the persistent buffer
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Harden persistent ring buffer:

The persistent ring buffer has some assumptions for it to work correctly.
Currently, those assumptions are not forced. This changes that.

One assumption is that the data in the persistent ring buffer from
the previous boot is for the same kernel that is currently running.
That is now enforced by adding a uname into the meta data and if
the uname does not match, it will reset the data. Note, this is not
meant for forcing this during development, but only for production
where the uname should change when the kernel is updated.

The next assumption is that modules and dynamic events cannot be
trusted in the buffer that's from a previous boot. That's because the
addresses, and possibly even the event types will not match. To prevent
this, module and dynamic events are not even created in any instance
that holds a persistent buffer. This means the "enable" files will
not be there as the directories that are associated with those events
will also not be there, and the events cannot be started in the
persistent ring buffers.

Finally, because the TP_printk() can have various pointers to strings,
force the use of the print_fields() output function as that just iterates
the events fields and prints them while ignoring the TP_printk() format
of the event. In the future, the TP_printk() could be used, but that
would require making a copy of the event data and updating the pointers
before passing to the TP_printk() event and that is out of scrope of
these fixes.

The print_fields() needed one change to update the pointer to the "%s"
that can point into the kernel.


Steven Rostedt (3):
      ring-buffer: Add uname to match criteria for persistent ring buffer
      trace/ring-buffer: Do not create module or dynamic events in boot mapped buffers
      trace/ring-buffer: Do not use TP_printk() formatting for boot mapped buffers

----
 kernel/trace/ring_buffer.c  | 10 ++++++++++
 kernel/trace/trace.c        |  9 +++++++++
 kernel/trace/trace_events.c |  6 ++++++
 kernel/trace/trace_output.c |  3 ++-
 4 files changed, 27 insertions(+), 1 deletion(-)
