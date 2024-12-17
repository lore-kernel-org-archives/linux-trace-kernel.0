Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E78F49;
	Tue, 17 Dec 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403606; cv=none; b=PQ94boDy0p545i6m/70HdPRCvMecxqXHft9Rg6erC3ZB043Krk1GK7iDDx1GcojpzjBCVCmPjQO3E0ItSfs4EPnxuMnenCmJVdUMscKOq8lJ3Lcy6NKVVZGJoAu72uvgOKRhlBe5p3QZF6xxv0yRt5mR1yux96JxqJ2SjHn8tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403606; c=relaxed/simple;
	bh=+meYEWCHHgJpgYBqdWW8S/7CO2A7qz1tONeLBxp9h18=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jbV4QZuwZfuI9pOCEOQzD07w0BaBMR6mZE13r2tFOEecwjbObjsDcDJiNXwTDSKpNj43hhdUPk7QOkTDzMluDg2vadeCwNzw9bjvaiyJ/p/wgSShH6mYT5TV4B+R4zU4nsGu8rH/Yv+saKs5bXd/3fgA/hxFxy1vGHLTPGLnWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9832C4CED0;
	Tue, 17 Dec 2024 02:46:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNNcG-000000087UV-1P2r;
	Mon, 16 Dec 2024 21:47:20 -0500
Message-ID: <20241217024118.587584221@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 16 Dec 2024 21:41:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/4] tracing: Replace trace_check_printf() with ignore_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


A bug was found where if the hash-ptr option was disabled, it would
pass the iter->fmt temp buffer to the trace_check_vprintf() function
that tests to make sure the "%s" strings do not point to non static
strings or strings in the ring buffer. The problem with that was
the trace_check_vprintf() used the iter->fmt as a temp buffer itself
and would overwrite the content of what it was processing.

On the git pull request[1], Linus did not take too kindly for the
way trace_check_vprintf() was using va_list. It relied on implementation
details of the compiler and would not even work if the compiler used
a copy to pass the va_list and not by reference.

I didn't like that code myself when I first wrote it, but I was tired
of fixing the "%s" bugs that were constantly reported as a bug in
the tracing sub system. Using the va_list was the only method I knew
at the time.

As Linus stated he wanted that removed regardless, I thought hard on
another approach, which leads to this solution. The test_event_printk()
works when the event is registered and it reads the print format as
well as the arguments that are passed to it (what's printed in the
format files), and can mostly figure out if the dereferenced pointers
in the print format are safe or not. Most "%s" in the trace events
use helper macros like __get_str() which can also be verified at boot.
The only ones that can not be, are a few events (which includes the
RCU events, some IPI events, and some others). In this case, we can
tag the event with a new flag TRACE_EVENT_FL_TEST_STR, and also the
fields that contain the pointers that we do not trust with a new
"needs_test" flag.

Now, instead of parsing the print format via vsnprintf() va_list hacks
at runtime, before printing the event, it calls a new function
ignore_event() that checks if the event has the TEST_STR flag set. If so, it
then iterates the event's field structures and for every field that has a
"needs_test" flag set, it will read the event buffer, getting the pointer
from the field structure's offset field, and then checks if that pointer is
"safe". If all the fields marked with "needs_test" are safe, the
ignore_event() function returns false, but if it finds anything that is
not safe, it returns true, triggers a WARN_ON() and writes into the
ring buffer that the event's field points to non-safe memory. In this case
the event's print format is never used.

The ignore_event() makes the trace_check_printf() obsolete and that function
is removed.

This passed various tests, but I'm going to run it through more tests
as well as my standard tests before pushing. I'll create an event that
uses a bad pointer to make sure it triggers (I hacked it up to make
the pointer it calculates from the field to be off by 4 and it did
trigger. But I still want to test it on a real "bad" event).

[1] https://lore.kernel.org/all/20241214182138.4e7984a2@batman.local.home/

Steven Rostedt (4):
      tracing: Fix test_event_printk() to process entire print argument
      tracing: Add missing helper functions in event pointer dereference check
      tracing: Add "%s" check in test_event_printk()
      tracing: Check "%s" dereference via the field and not the TP_printk format

----
 include/linux/trace_events.h |   6 +-
 kernel/trace/trace.c         | 255 +++++++++----------------------------------
 kernel/trace/trace.h         |   6 +-
 kernel/trace/trace_events.c  | 225 +++++++++++++++++++++++++++++---------
 kernel/trace/trace_output.c  |   6 +-
 5 files changed, 242 insertions(+), 256 deletions(-)
