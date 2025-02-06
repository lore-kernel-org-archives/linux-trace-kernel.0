Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244481EDA3E;
	Thu,  6 Feb 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861131; cv=none; b=hdmFKfLXDfyL1j1fHOFOwFFIW280VOpC9JI117iKUcBGPUtAdZW9CgjrvQ/jGn7paDkrAU7tjU1EHct7SGXkbolYW1l5F/eHydT2wvkw6tKudXBjTKBBESbFcKfqS9139qa0qBxvIQ5J/1a8Ybnc9d3dR64bPnyNf6tlH7yUIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861131; c=relaxed/simple;
	bh=suqPh1SD4lnh3t+6pnrqVZkyz5azPVfGSsO+TVw9B7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5q+4V19zGo8xt9Axs2bdOhCFXfRc7h6drU5hV6A9GYGc77CWFStJXilNwFk4ojZd9Bk3+3IVHMI0mOibBuwCgajPf8Gmt72iHy4iAv4F3t9zvOh/NObXo+mrYzdJ3Kt2h0mFdVtyUK6+0OB0NinLkIX35U52s12HQjMJqIcHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVOP4iqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVOP4iqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ECDC4CEDD;
	Thu,  6 Feb 2025 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738861130;
	bh=suqPh1SD4lnh3t+6pnrqVZkyz5azPVfGSsO+TVw9B7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVOP4iqMBnT4X0FcAaEr9ym2OOBcTL8aoSAR7C3xDHfPt31VmmYbOp/I+aubjtx8S
	 OLSDepFnvfWYOjg7ZmbtfL1iv9a/8mEQ1dP6D49Hs+g1RdpkR55f4PlqxTAZElYZaL
	 tKh7hEi0GYbwb1zFuohHsVwxn/a+6JPH04dKCCtljYveamAK85LzQ1lW4+Ea9gUlPq
	 5mZT285aPaTopBpFJEOKNJkOHbiblGctfl6fmw5doiFxwH1BX3F16A719Nh4730lXb
	 ghdbHq7o1VrXdA61jdDxblmESG7umlihXvDNkCXOpZG8kY64IwJZmFZQ4ilrmAD2hm
	 xSlIhFGsvgVjg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] tracing: Skip update_last_data() if it is already updated
Date: Fri,  7 Feb 2025 01:58:46 +0900
Message-ID: <173886112678.496116.16133647703573943563.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If the last boot data is already cleared, there is no reason to update it
again. Skip if the TRACE_ARRAY_FL_LAST_BOOT is cleared.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 443f2bc5b856..0f010a34de84 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6041,6 +6041,12 @@ static void update_last_data(struct trace_array *tr)
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
 		return;
 
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return;
+
+	/* Only if the buffer has previous boot data clear and update it. */
+	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -6052,9 +6058,6 @@ static void update_last_data(struct trace_array *tr)
 		module_for_each_mod(save_mod, tr);
 	}
 
-	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-		return;
-
 	/*
 	 * Need to clear all CPU buffers as there cannot be events
 	 * from the previous boot mixed with events with this boot
@@ -6077,7 +6080,6 @@ static void update_last_data(struct trace_array *tr)
 #else
 	tscratch->kaslr_addr = 0;
 #endif
-	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
 /**

