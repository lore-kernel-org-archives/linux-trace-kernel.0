Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEC33F6;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903458; cv=none; b=ppKI0sFTPlwiSlupxmf/KU4ne232g6X8Phd5TmjK6CR6GMPknzIEOJORf/wMPg6LALcdt5CW4M/4gjU9GB7enLeK2FfI0HhZ2hP8im2tuEMah4hly8IhuNm4a6dBeQ7GF8st5W/ztBfBTYLPzCgqduTLpc/YDPUYP3PI9khAHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903458; c=relaxed/simple;
	bh=ePAu6b2ejLc5EckGSKNGVrNy/YST0BNRLyA/OEfJBeo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iIO7s3Vt2ZvYd4tq3MEkibhg1/TqXomDZI29vjYopOMsozYbBtxPOr0vjrxTHzpFta68ETq7xhgIxk60JlU61oy3duIer/DG5u/24E+NEjXysXlYaBGAg9bKkAx7i9FxsUaPErRQbMCDg5nYCemuZmZZ1WluczI64wkMh8sNOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKrJmbW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKrJmbW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CC0C4CEF5;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762903457;
	bh=ePAu6b2ejLc5EckGSKNGVrNy/YST0BNRLyA/OEfJBeo=;
	h=Date:From:To:Cc:Subject:From;
	b=lKrJmbW9tDXSxjD4/pd4d0fNQcmwIuS63uq0m02hxKpKcKLYK4a387/AlWYVve7jN
	 XFrZMRBneKbiUA9A2hRBuUIA79GW0cxQB7dE+qBCxq+hWP40YZop9uups2JAGMC7+N
	 OL4rO2gHgBf0lQa4gIRuNqUf6+qUUqYWYrm4qfsgy4hV4pk8/uHC3bEtACc+g4N5al
	 ckel89vY/n5GVCFfbVDhVMLSV/cxTCkGC1DRNl+HShuzFfWc1kdazaILnUeryDbyld
	 s9zO9nZA7FzbmlRcTDvBMlx7RkBVhWKwa4zoJcWlmqnICmL/wpkahtM9DZHEhz66KJ
	 sTLjA5nemYw2A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vIxiv-00000000uRN-19eM;
	Tue, 11 Nov 2025 18:24:29 -0500
Message-ID: <20251111232406.183056289@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 11 Nov 2025 18:24:06 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/3] tracing: Fix tracer options per instance
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The tracers (like function and function_graph) have options that modify
how they behave or how they are shown in the trace file. As these options
were created before instances (multiple buffers), the flags variable that
represent these options were global for the tracer.

Now that a tracer may exist in multiple instances, having a global flags
that kinda affect every instance of that tracer does not make sense.
The reason it "kinda" affects them, is that the code that updates an option
for an instance, only does the change for the tracer running in that instance.
If a tracer is already running in another instance, it will not be affected.
But because the option is saved in a global variable, if the tracer is stopped
and restarted in the instance, then the option will take affect.

Since each instance has its own interface to modify the options, the effect
of an option should only affect the tracer for the given instance. This means
that the state of the options for each tracer must be saved for each instance
separately.

Add a new struct tracers field in the trace_array (instance descriptor) that
holds a descriptor that points to a tracer and contains its flags values. This
will be used to see what tracers are available for an instance.

Now when a tracer option is modified for an instance, it only affects the
tracer in that instance and not semi-effects the tracers in other instances.


Changes since v3: https://lore.kernel.org/linux-trace-kernel/20251110234157.808080361@kernel.org/

- Fix registering of command line tracers.
  A command line tracer is registered before the global array attaches
  itself to the list of instances. This keeps the tracer from attaching to
  the global array and that keeps the tracer from adding itself to the
  global array, and this means it fails to start at boot.

- Also add a warning if the starting of a boot tracer fails to start.

Steven Rostedt (3):
      tracing: Have tracer option be instance specific
      tracing: Have function tracer define options per instance
      tracing: Have function graph tracer define options per instance

----
 kernel/trace/trace.c                 | 257 +++++++++++++++++++++++++----------
 kernel/trace/trace.h                 |   3 +
 kernel/trace/trace_functions.c       |  10 +-
 kernel/trace/trace_functions_graph.c |  18 ++-
 4 files changed, 202 insertions(+), 86 deletions(-)
