Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9921165F16;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389292; cv=none; b=qQ1Bkcc8asLfB+X0PkKQP1vd9yPcQox1CfgCngZAvOQfiXUQPkU3n6ivMisG4rswo3VvXZvHhsbMWFBfeIlEoYOnmHBL77R5IvOEM+1S2Qf2l75T3WfCm12R+u6fEoKLbOPpZ7MeoROJrYi+XLlXQfVjMTcFhFXHM7wx5tkk+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389292; c=relaxed/simple;
	bh=inaIwMT8LRc3FuIz+Rrhmt1pP4/UXcJn/RgVjHM18Qk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=LjgQKlN0hAnWm9HZrqDume+GcebKf1AkXopTEqvUSUSiZstkvjnHcPkl5bqIpqJSFwEYWvAuRFsik4zfq2LMk4jh7xD1nBbl7V0zNraXUScBQeMw92WpAmfdESHeuNe8EPfySGVG/bALtRA8SUxh+80e33l0+Yrato0uczG6+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU8ae5zV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU8ae5zV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195FC4CEF8;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762389292;
	bh=inaIwMT8LRc3FuIz+Rrhmt1pP4/UXcJn/RgVjHM18Qk=;
	h=Date:From:To:Cc:Subject:From;
	b=UU8ae5zVk9K9gq0AUDLpLjJH6V+c/cAuBqTmycuYwr4yuUJ4vzo/LcQoiO0Nq8jmy
	 jlLZydlStx2X3qSwtB7EzhfNUUB5AF2kWqE4N+eCQaK8fTVK8SB7pdkwYAC1nhBGvk
	 MnrrqevLSMKwYZk4fFQxxIXGjk57SM457sDXOVy0+V3++9Gkmnbm7HrJvlVamogxIH
	 41bLQi0jcAW0tRucXw413wnnRXrDmijpFZ3DsaEUs5qXzcBp8F6T7vX3DEvRedg+BP
	 igZu+pCE0B7+UY8GA+4OhFdA+xvbeoP7XD+ASbA8umVqLAIRFgecbakFaKMAk8oXOR
	 jTd0LmpnY/IOQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGnxt-000000019I6-2vJV;
	Wed, 05 Nov 2025 19:35:01 -0500
Message-ID: <20251106003324.964761749@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 19:33:24 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Clean up of set_tracer_flag()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The set_tracer_flag() function takes a mask that has a single bit set.
It then goes through a bunch of "if ()" statements looking at what the
mask is to perform the necessary operations. It is simpler to switch that
over to a "switch ()" statement.

Steven Rostedt (2):
      tracing: Exit out immediately after update_marker_trace()
      tracing: Use switch statement instead of ifs in set_tracer_flag()

----
 kernel/trace/trace.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)
