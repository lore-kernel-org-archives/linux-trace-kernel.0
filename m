Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0C34DCDE;
	Thu,  6 Nov 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449435; cv=none; b=nZbyxFH+M3oAgRMU/RUVw2KrHyNh+6Shv9IU0ea+9JDiSt0zKd3+ZJ0n4UxCfBU/C+e4DDSQw2NstuJaQn0nOD+LGkezZyEi9DVSPVFlHpm1xqB7N5+TVlR92TpSVx/iMTXe+2WPQo7W0TyVpWT1jmJDsHE9vtPMjgCJlx+DN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449435; c=relaxed/simple;
	bh=SA4V/ZR6NhYj5Ik5HVw5Qk4xRM67KxmOYySM+YaJR2o=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Two6FfkyL3RQ7HkM3+STRbZZMtCYOmaP289QmaIY0e3xZTpGEiycUPd6NkTt4U/gwk/oAncYIQ46A8C3hR80P1Jy5DyJr0EvtI7c2paYcORGztILggwFSqnMQgcOzFUuHAEEaC29+R6LnPQMdsMcibm1nSpeCB/Pdal0OzkUAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLTO5bHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLTO5bHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22864C4CEFB;
	Thu,  6 Nov 2025 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449435;
	bh=SA4V/ZR6NhYj5Ik5HVw5Qk4xRM67KxmOYySM+YaJR2o=;
	h=Date:From:To:Cc:Subject:From;
	b=hLTO5bHcbO0nCWMmG0+COx6iFQCRAGkAhQavU7yfuZxC1F20F5GuTKEDHl7a04bPJ
	 9Rr8OV+zZD51pkTf2mqnsqns5nP7gF4JavZQA8qSdrVFixiuGR3BekTRjljUXdCGIM
	 xaYlKItU+oEy3uLV5vkpPZPmR4gMA+oEgjncp3p4SCt8id/ftjmFxAtvO9gJ7N99rv
	 POqU4z5H6odWSPkV7Jp0spqShdfOsc7wIjDVENJQaVLIlb8aq1HV9a1RfO4rEzpd7c
	 cZQuzMc0u2OaJgfPXe/AKkF3i0SmRxrOQzS/NkIX0mBwAOb5AIaz6XVCxcX+bbZWTn
	 WPGFxvGPjKXjg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH3bm-000000005Gt-1NOh;
	Thu, 06 Nov 2025 12:17:14 -0500
Message-ID: <20251106171557.011333928@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 12:15:57 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/3] tracing: Fix tracer options per instance
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

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20251105161935.206093132@kernel.org/

- Fixed build error for mistakes when selftests are configured in.
  My initial tests didn't enable the self tests, and there was obvious
  bugs in that part of the code.

- The first two patches were fine, so I pulled them in and they were
  clean ups for this series. They are not part of v2 (as I already have
  them applied).

Steven Rostedt (3):
      tracing: Have tracer option be instance specific
      tracing: Have function tracer define options per instance
      tracing: Have function graph tracer define options per instance

----
 kernel/trace/trace.c                 | 219 ++++++++++++++++++++++++-----------
 kernel/trace/trace.h                 |   3 +
 kernel/trace/trace_functions.c       |  10 +-
 kernel/trace/trace_functions_graph.c |  18 +--
 4 files changed, 168 insertions(+), 82 deletions(-)
