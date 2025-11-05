Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0638F33F8DD;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359567; cv=none; b=H0GZK97QxLa+Y/M3uaJZHnLH4VzzcJSKrzEJ89CDwcHaOuWEOmJUCpVAZn0K9nZEq98dm6qasfSiYAg6PXh9a9s/duLlfBgK19sen3YSAqQY0EvvWrQeQpq8b8XlrFBp7z9JQcXUc/mTs4rN4vb5eEifqDJ9PMvNmPIkrGc4Mks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359567; c=relaxed/simple;
	bh=TjYeLGwkVLPEXuPxOINjyyI2z1EA63ulXI1JJ2ZkSQk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jfc39DGXqFWZuf98fDIpvEfu92I83AfSnbCqdPVLxcnIsdto6EzqjyPYUMuv4zktmbxrhABLFW7Nkr0/JFZm8T3eIKW4zVhFCE1KFEVf7IYTWVUvS9xZGLf5N5n/CynJ+vhMui/un3PLeAAhln3qqnF8QvoYuGEZr4J5GQRtJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjgCite/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjgCite/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EDBC4CEF8;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359566;
	bh=TjYeLGwkVLPEXuPxOINjyyI2z1EA63ulXI1JJ2ZkSQk=;
	h=Date:From:To:Cc:Subject:From;
	b=WjgCite/GxljyWNBe7UCrvPCfKXaTjWeaVHJXH1IghaovYhNGrHbCjRw5sGausT8D
	 8edskZQaJxIAhUvwj/FoMd/YdmgdWIsvnZPa7yNlYju7rFkDiIuNl9Itlw5IyQHf5a
	 wUdhAxmBbkEHrLKEUyDbHtq2w+UTQxYOKPXWs7ahtHrLXsiN8YABnsWw4/GNLHBCbe
	 qxDOhTNzdLkthSTQS9INtAW/GlcHL4U4PnvUkU0WtmSpryphy13ny+tocWB+BrFphE
	 F5UFIJc0L74OgWMn3PQt08vOaZ0k2Gqqqs6X6Isk37CaEu4i7I/YsCRLxjyEnwR3AF
	 3a7fIhUe9SQ4Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGgER-00000000pUh-0kEy;
	Wed, 05 Nov 2025 11:19:35 -0500
Message-ID: <20251105161909.590008129@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 11:19:09 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] tracing: Fix tracer options per instance
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

Steven Rostedt (5):
      tracing: Remove dummy options and flags
      tracing: Have add_tracer_options() error pass up to callers
      tracing: Have tracer option be instance specific
      tracing: Have function tracer define options per instance
      tracing: Have function graph tracer define options per instance

----
 kernel/trace/trace.c                 | 280 ++++++++++++++++++++++-------------
 kernel/trace/trace.h                 |   3 +
 kernel/trace/trace_functions.c       |  10 +-
 kernel/trace/trace_functions_graph.c |  18 ++-
 4 files changed, 198 insertions(+), 113 deletions(-)
