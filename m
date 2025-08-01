Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29354A1D;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058305; cv=none; b=buuCgExAoNEGmwbhSi/WSFlNd1wJjYVeZ5GHUlB6UloJKF9I5Pfu0acd+hQpHdrmvpNIGdBTjF4P9HL5zPwfH6NHL2Qmill3h6sqV3+v1hD5rD213Oy7fmje2HjgUBa97j5N7M1xfv/50alTyWrhdNnrRLgGo8IOE/lkHjsqJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058305; c=relaxed/simple;
	bh=RKtK3tlduDJqHLVSLN9tKMiHoz/07ja8yQHHPgtNaVI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=oylGqTzaUpHfc+PVKQMA1Wb9eZhrZmohZXvX09a/8uZR3tf7jOks7K5d7i3QzJpEoQfXYklVEGL4KGQlk+sPVG4pNzvUjRXdsicIUkJnsFVPSILPJgiyJXy1jz4QEqSMUMYWCca75tIZWKxsjgV/pD9MzF+48kHqnJLioRpKNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcDUuMqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcDUuMqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B164C4CEE7;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058305;
	bh=RKtK3tlduDJqHLVSLN9tKMiHoz/07ja8yQHHPgtNaVI=;
	h=Date:From:To:Cc:Subject:From;
	b=WcDUuMqMQJaDqSKLp8W7UCiPMkOYSoML9Ta/68N0Hn91Uh6k8EnxXbJXCHSTIsSPk
	 45QrgTel/t0uqZZrtFURLPvphhYvYjIhR/gwmb6ijDnECJvK/uThX3Hch3N0Q6K/dc
	 M/hTnFVj6s4lByptO9+BqgwpYNLPy1e55XFvcROxh1FwU4N205I/f+b55yz/GpY15A
	 XgJAAz/Vfs4uKHg99kMFJTzCLwQQs2+RGfbjpGak3rOmWSIX3HXUv9CsyCwbAayRNF
	 HOhxOmQ/GX5Ghn4kClpAKBc8dBkK64kT0r5q8RcKi/TwsxGDIPrL5oOGWiT4+qFSpZ
	 jLmlGPTA3Y51Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhqhK-00000007Utb-1BNr;
	Fri, 01 Aug 2025 10:25:26 -0400
Message-ID: <20250801142506.431659758@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 10:25:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] tracing: Cleanups with use of guard() and __free()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This is a cleanup to use guard() and __free() where possible.

Steven Rostedt (5):
      tracing: Remove unneeded goto out logic
      tracing: Add guard(ring_buffer_nest)
      tracing: Add guard() around locks and mutexes in trace.c
      tracing: Use __free(kfree) in trace.c to remove gotos
      ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)

----
 include/linux/ring_buffer.h       |   3 +
 kernel/trace/ring_buffer.c        |  16 +--
 kernel/trace/trace.c              | 290 ++++++++++++++------------------------
 kernel/trace/trace_events_synth.c |   6 +-
 4 files changed, 114 insertions(+), 201 deletions(-)
