Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEA2E3706;
	Thu, 24 Jul 2025 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332391; cv=none; b=NcQcgxerVhX9/XpgQLiITX1TPbG9zciWHEiX/ZXSUzTeMKl/fldiD9nYT3aFwZxnlw9IjNgVN/OJFa9lFVapFZN2o5mHDb51MCLtiAGqY4w40a5LkTRDgyyeYS9AB2pHoGhpYM3hGE8AuGDhhmTESzFie+OI/27Xusl35iTbAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332391; c=relaxed/simple;
	bh=UeKSAF9qvjVO5jjRMMvgNkFAJbaG6dki9rMLijYBD38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsph7EsJgAbhF+N+jPJzE1pn5+F8nJpqN8vxb+WpoENBE/Zf6nVxeeTRFjukMwKYjxK78E1ybU/XcIg5hgVvN9kGZUFu27g6kFs4U/wxnsIp/kCW/3cG7Cka08ksXO7jD9aYeZD08CSZWgHxcLuJoqoJhC0wD+7UIvjMfGNluUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjK2BzYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjK2BzYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B01C4CEED;
	Thu, 24 Jul 2025 04:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753332390;
	bh=UeKSAF9qvjVO5jjRMMvgNkFAJbaG6dki9rMLijYBD38=;
	h=From:To:Cc:Subject:Date:From;
	b=EjK2BzYzNj8W97CsP7FnlMB+PFe9QBTYlCk56jXcAa6f5S4oyV0unMaMQeBdz1KUM
	 3nEQ/x/g3GzapsyNwflwA7Pzk9j0zBfkP1oQQJMaNophVmj0gUEAlmu+2nj9Yo7Ptc
	 aWmsBJBOQE1uHap540gemD+F+wppBBvjZIHuUS6bWFcWN1f/WGWgBWFtTBmnCkDlzF
	 2NIPJwez0nn3qEyMsm2L2HBa7kt44T2xtHTXIj2+PVdUowBGNOhiZy12ubKnjGR5CG
	 kzkGsrf9VqYT6Z9aRAQR5C6KLkS1bi4ICRYEP4PgEsvwMod12Xik48pv/KaAEBTK0+
	 3k+U4Mh7e88HA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] tracing: Fix an event field filter issue
Date: Thu, 24 Jul 2025 13:46:26 +0900
Message-ID:  <175333238644.2267214.1835493691667067597.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 4th version of series to fix the tracing event filter
because of __attribute__.

The previous version is here;
https://lore.kernel.org/all/175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com/

This version adds the existance check of btf_type_tag attribute
which is the only attribute for the fields currently.

This removes the __attribute__ from the event format type string,
which can cause issues with parsing (detecting the string type).

Thank you,


---

Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format


 kernel/trace/trace.c        |   25 ++++++---
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_events.c |  115 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 116 insertions(+), 28 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
