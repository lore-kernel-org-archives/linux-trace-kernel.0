Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECA2F0C49;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148180; cv=none; b=AVE+bWlPP2XOgx9FzNo8EckcgVXFonrTDTVZMBda1rZDEa4nuLSx2oYCaOm+QTRrRxPghY3puVIlCGra8dNmxRlHXVqEbRDoox+gkHF8B65klgBayfmgonOyBompByf9gf+FPukbSgw7qkav/ZksLrvseWG0+4xnyiBqR5F2sXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148180; c=relaxed/simple;
	bh=wqppwOtA8IOh/F/MxSeFA0aCK+EkQ/ZAYyt6w2wpB4A=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jeZE8s8c6rz94oHJ7w8vKsHIEaTbSRkZekLvAM9ClICUNXknRmf0xNie7av0xP5UdPJ8oVuYaqvx+CmlHlZ1GMH0xB+XHHkTJiA5FgKTlp76zNSOTskNsQ42+EqDQEr64XJ18BfFiBm/RYqk0PiiRHja4nnhbkmDMXpS+cFoKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1vIbZ39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1vIbZ39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F47C116B1;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148180;
	bh=wqppwOtA8IOh/F/MxSeFA0aCK+EkQ/ZAYyt6w2wpB4A=;
	h=Date:From:To:Cc:Subject:From;
	b=Y1vIbZ39fD5QewpNbHyviKQhm95KHISwbKBsSeVR1FFyillA88DSkLtMU1nkAQPkd
	 BIF4jcOiUMc895fmeZB7JVeGlCP6utLPsvoOog0mxDgV567uLi01z+Tjo4XEmfReXJ
	 iciAqS1kOCPp8Gs77bC6j5KU740Izkc2mF7flgU8jLjnpN25/24qrzCxDeEZ3+MOSw
	 o1d8R1S++GjRCKj6rJLlROLxnDoCTjNGSp67z1VaWGbhSJSjK485a7VOx8L8W7PogH
	 wvuj5ZqfUzZTgtD5GojaiDFW9EReqAp7FvQMGEn8pbreiBmIhyuGGeZvHIaAmHgjtM
	 OgQr5ju/9+G5g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJzOA-00000001p7Y-2PDK;
	Fri, 14 Nov 2025 14:23:18 -0500
Message-ID: <20251114192229.829042264@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 14 Nov 2025 14:22:29 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] tracing: Make more function graph tracer options per-instance
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Convert the function graph tracer options sleep-time and funcgraph-irqs
into per instance options (as they currently are not consistent in
affecting all instances).

Also make graph-time a top level option only, as it only affects the
function profiler and not the function graph tracer itself.

Clean up the function graph tracer set_flags() to use a switch instead
of a bunch of if statements.

Steven Rostedt (4):
      tracing: Have function graph tracer option funcgraph-irqs be per instance
      tracing: Move graph-time out of function graph options
      tracing: Have function graph tracer option sleep-time be per instance
      tracing: Convert function graph set_flags() to use a switch() statement

----
 kernel/trace/fgraph.c                |  10 +--
 kernel/trace/ftrace.c                |   4 +-
 kernel/trace/trace.c                 |  14 +++--
 kernel/trace/trace.h                 |  18 ++++--
 kernel/trace/trace_functions_graph.c | 115 ++++++++++++++++++++++++++---------
 5 files changed, 115 insertions(+), 46 deletions(-)
