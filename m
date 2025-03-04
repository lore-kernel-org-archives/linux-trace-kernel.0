Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94E1F03D7;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130122; cv=none; b=GRdoUuqA4A1XOvkPKxF2UkmlYaverEi1g/iUa4bm6EHMLkJbXIHp+XgovkogrtcNWhyO+VYC1V3D2n4B91/XNnESBIorMDrX9bJnEtR/5iVBUx9vahj9y1fw8lbZT5ua6Ht2LDoAI+4ftCo/r7JHtp/UhTPjQ5VSw3RzbVG/yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130122; c=relaxed/simple;
	bh=FaZuYVifpdGQ4c3tmazH0X+ISM0DC5xPiLPJWogEs0Q=;
	h=Message-ID:Date:From:To:Cc:Subject; b=WhJn3s4nYdZMMwP7gz3thVkfI4j7j2ork0Iui1iIdkWucMbjOxwIoAFOJDzoNU6pQae2Un6/2mRqHPMVQNS82sBs1/+MZ7vDZf9jLDW+gSOTwn7V96ajJVrs6sG1dQnEWJjsa5ycz17aSy6FSw9dvzZixgk225E8V4OeMwmH0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F41C4CEE9;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpbUo-0000000CSYu-0JUc;
	Tue, 04 Mar 2025 18:16:18 -0500
Message-ID: <20250304231545.708806702@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 18:15:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] tracing: Have function tracing and events handle module addresses
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This is based on top of Masami's patch:

  https://lore.kernel.org/linux-trace-kernel/173886114516.496116.8314066678313037503.stgit@devnote2/

As it requires the function trace_adjust_address() for both kernel text
and modules.

This updates the function tracer as well as the pointers used in events
to be updated via the trace_adjust_address() function.

Steven Rostedt (4):
      tracing: Update function trace addresses with module addresses
      tracing: Show function names when possible when listing fields
      tracing: Only return an adjusted address if it matches the kernel address
      tracing: Adjust addresses for printing out fields

----
 kernel/trace/trace.c        |  5 ++++-
 kernel/trace/trace_output.c | 46 +++++++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 17 deletions(-)
