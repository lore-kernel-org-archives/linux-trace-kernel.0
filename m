Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078782FB99D;
	Mon, 10 Nov 2025 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818213; cv=none; b=poXPj2Ho2iOPkX7y8ajHw5mtPGUfAeZwFQFAMRm4YDCRHBb785YSiYr60ZEJqbovWqqTS+Gcx+S2a0WKp3H12yrqz0lP6MBx9t9g9zkRr6Gm6fSGYwAAiikTzBP3aU1On0GACkMv80IULMbXNEzTnBU3lVqv9S8T+BXdT35HvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818213; c=relaxed/simple;
	bh=HlTxVdTLrc63r2+iJxCSItKGLvTwsg82jFmrgJbH9oc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=I9C+rWD1RzZtbwscCtzrWDUGQQKnvB3s6n1CmfOLMCQmdIJp+xC+F6ljX0ePa/BcIvx+S8p/XwamriZukau20TtwMM71wXbheNa1RuitgUJH4nj9kVfgZp8SvmSjUpE4jU9YLGSwO/YIfh0uQP7lMYkS2SippSrGYjdux5/l5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUZQS6i5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUZQS6i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC61C19421;
	Mon, 10 Nov 2025 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762818212;
	bh=HlTxVdTLrc63r2+iJxCSItKGLvTwsg82jFmrgJbH9oc=;
	h=Date:From:To:Cc:Subject:From;
	b=eUZQS6i5azLkAvUvZtd3sxq861MbsmzrE/Mythj0YS8kAKGWFcCsetJnuGSUkhkOo
	 X06MfkzIBVHhsK5fFoW7Qf6eLvwHNqLNZ1002HIvrzJr6OzHG98MvbzXinCq9NjQgL
	 jf7zqo2FZPEtkLk0J3ZALnU51dYraw3gpm9LZK9SfC6bkj5BnMPeBIPdvIH/lRST7Y
	 M2iCgfAexWTasXCL0iw8vj5HzYSI+0fuegEKkNurvhM/t2gDfiUvIUUXXm0ryRZqIP
	 PR5u59vOWHsJIqufI3TJiVAAOdZL4jGbMBO09E6hYWVXmGq80J3wdEW0qF0KbdOQY/
	 va78G0U7tUCrw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vIbXx-00000000ac3-35mn;
	Mon, 10 Nov 2025 18:43:41 -0500
Message-ID: <20251110234157.808080361@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 18:41:57 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/3] tracing: Fix tracer options per instance
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


Changes since v2: https://lore.kernel.org/linux-trace-kernel/20251106171557.011333928@kernel.org/

- Fix check of tracer not found in instance. The loop is a
  list_for_each_entry() and testing the value of the entry for NULL is not
  going to work.
    

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/core

Head SHA1: 23857cfa3f9e6c505bf6b7e7cc4344710801209c


Steven Rostedt (3):
      tracing: Have tracer option be instance specific
      tracing: Have function tracer define options per instance
      tracing: Have function graph tracer define options per instance

----
 kernel/trace/trace.c                 | 221 ++++++++++++++++++++++++-----------
 kernel/trace/trace.h                 |   3 +
 kernel/trace/trace_functions.c       |  10 +-
 kernel/trace/trace_functions_graph.c |  18 +--
 4 files changed, 169 insertions(+), 83 deletions(-)
