Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA58633A;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038127; cv=none; b=QZGM2y9YPFTyXaxgcOgiV2EQs4O5TdYtQapH8DMkyVzf3Zeevkr8fluQZZzLL+SjFFWNGIxfXcFNB2cGztU+gRCVELYjo3oJP8hh46cP1aaqc+M7oz7CEdwPgE/h/duAmcMl4IS5K9ZYd1l2iNvVOdxrPiy9MYhwgHZHc22KOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038127; c=relaxed/simple;
	bh=dBqKsfTrErmqghs273j80/C8lcw6TaspSxB3PweHbKc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qqeUfvPBkvLDP0xuHV1UwAnm1Yl/5rNqLsthzmQ+h2tXjc/ERqvCauVq7rPrBXg6LLpYj89YDqjl95qVUEfey5mveXQRC2guj5QEROs4tybiND3ds9i6imcfhLTvt9Mb6eNxKZ4GjRfwjuTbXZuFsCN4pOia+9MNtJZlyLI7Uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CFCC4CEE1;
	Thu, 16 Jan 2025 14:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYQy5-00000000sxj-0XFt;
	Thu, 16 Jan 2025 09:35:33 -0500
Message-ID: <20250116143334.073917300@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 09:33:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 jochensp@jochen.sprickerhof.de,
 peter.griffin@linaro.org
Subject: [PATCH 0/3] tracing: Add ':mod:' command to set_event to enable events in modules
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


I was asked if there was a way to enable events for a module on boot
up. Unfortunately there currently isn't a way to do so. I decided to
added the ":mod:" feature that set_ftrace_filter has to the set_event
file as well as to the kernel command line (which uses the same code
as what the set_event file takes).

Now you can enable events for a given module without having to know
what events that module has.

 echo ':mod:<module' > set_event

You can enable some events or event systems for a module too:

 echo '<system>:<event>:mod:<module>' > set_event

Where either <system> or <event> can be missing or "*".

For the following:

 echo '<match>:mod:<module>' > set_event

It will enable any system or event that has the name <match>.

If the module is not loaded, then the string is saved, and when the
module is loaded, it will be executed on that module before the module
executes. This means any module event that is called in its init
functions will also be traced.

This works on the kernel command line as well:

  trace_event=:mod:<module>

Will enable all the events for <module> when it is loaded.

I also added a thorough test to test this feature, although it doest
obviously test the kernel command line.

This is based on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  trace/for-next

Steven Rostedt (3):
      tracing: Add ':mod:' command to enabled module events
      tracing: Cache ":mod:" events for modules not loaded yet
      selftests/ftrace: Add test that tests event :mod: commands

----
 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 Documentation/trace/events.rst                     |  24 ++
 kernel/trace/ftrace.c                              |  17 --
 kernel/trace/trace.c                               |  28 ++
 kernel/trace/trace.h                               |  12 +
 kernel/trace/trace_events.c                        | 300 +++++++++++++++++++--
 .../selftests/ftrace/test.d/event/event-mod.tc     | 192 +++++++++++++
 7 files changed, 540 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/event-mod.tc
