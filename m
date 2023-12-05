Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BE6FCDA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA32C433C7;
	Tue,  5 Dec 2023 21:59:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rAdSc-00000000PNl-1XKj;
	Tue, 05 Dec 2023 17:00:10 -0500
Message-ID: <20231205215208.195443981@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Dec 2023 16:52:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/3] tracing: Keep instance main and snapshot buffers in sync
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Fix keeping instance buffers in sync. That is, when the main ring buffer
size is updated, the size of the instance snapshot buffer also needs
to be updated if it is allocated.

Changes since v1: https://lore.kernel.org/all/20231205115223.5256e1a1@gandalf.local.home/

- That was just patch 3 with the change log of patch 1.
  That patch just needs to be ignored.

Steven Rostedt (Google) (3):
      tracing: Always update snapshot buffer size
      tracing: Stop current tracer when resizing buffer
      tracing: Disable snapshot buffer when stopping instance tracers

----
 kernel/trace/trace.c | 123 ++++++++++++++++++---------------------------------
 1 file changed, 42 insertions(+), 81 deletions(-)
