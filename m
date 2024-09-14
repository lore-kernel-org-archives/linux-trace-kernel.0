Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457815FBBA;
	Sat, 14 Sep 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350496; cv=none; b=fxgwmGHtOxhNYV0C7+z1tLJaOFHPx1ziLrwgBLNoTcIXdeSIsAs/NF3yXMTndCJvCJcFDCkusISMfx8Wd+5Ser8uIT1smKCSASGCFxXShDwN+neYWkl+sZvGSKU1s5zXAN7ASfakH5/UfkVI1L4YBuAfUzcAY/TmhOndOfv+w8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350496; c=relaxed/simple;
	bh=9Ow4UoRviDf+cPBifWDjmpa9839dnU5+Pqq49haZ8wg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bD2FbH6i7K3uKLw3our3aECyA/zZ/6God10JxDUE9yBVue+HMemZomHOkBCQ4anBcTgE9+Yf1Q9gSkOeNcn3wV+HZPiFJBQ7PK5gBwOBZ3Ir23aYB6cEXFVA8wE43N/LIqEIZVUt/07lIAxkcLFQV4U/aZFCpc9VPcEbJNreix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6275C4CEC4;
	Sat, 14 Sep 2024 21:48:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1spad0-00000001Gso-39UV;
	Sat, 14 Sep 2024 17:48:26 -0400
Message-ID: <20240914214805.779822616@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 14 Sep 2024 17:48:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 0/3] fgraph: Do not save calltime in shadow stack
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Now that there's more users of the function graph infrastructure, the
calltime field on the shadow stack wastes space and also getting the
timestamp is a waste of time for those that do not use it.

Instead, have the only two users of it (function graph tracer and the
profiler) store it in its own shadow stack variable.

Steven Rostedt (3):
      fgraph: Use fgraph data to store subtime for profiler
      ftrace: Use a running sleeptime instead of saving in shadow stack
      ftrace: Have calltime be saved in the fgraph storage

----
 include/linux/ftrace.h               |  5 +--
 include/linux/sched.h                |  1 +
 kernel/trace/fgraph.c                | 85 +++++++++++++++++++++---------------
 kernel/trace/ftrace.c                | 45 +++++++++++++------
 kernel/trace/trace.h                 |  1 +
 kernel/trace/trace_functions_graph.c | 52 +++++++++++++++++++++-
 6 files changed, 137 insertions(+), 52 deletions(-)
