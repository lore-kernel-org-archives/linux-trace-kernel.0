Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0723EA8D;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389292; cv=none; b=Yv2RBlqbKPW6SdIjEMRmcE/p7qiEqT2h3sIDUEF+HnhA1J1sbgbZjgvFoPN/UvYgHZh4UK7nUeMU/ytQ67F/NSlFQQzlXSAR6ahustKtdcvFx0671wQ4/2SVBTldARAnaH4TTOe2sm84IVJ7Bxdw50/9sXIizxKpGXc2bBdHREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389292; c=relaxed/simple;
	bh=j3n1MwO17Y5p5+pT63l0Ch5E6qmy1arFkkmm7Z4DFfU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HkpnbFsoi3DOq18f8LzTOczBLo7hHHxS8D30Big9VHvNxk8xakbsKOqgGcPfVqSTUSTVMy+pXSIVMi0Pme+oGwx4PmgpH+/sxHFxdbp9CtYJ6W2Kyr3UJ03jtCeAR/8RnXOsWuN9UbLyh2E/UIbFRgRNM3pk0UiHDFo/EdevTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJIQCmwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJIQCmwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51926C4CEF5;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762389292;
	bh=j3n1MwO17Y5p5+pT63l0Ch5E6qmy1arFkkmm7Z4DFfU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=cJIQCmwPhldKlUmSeNrPUG+GVJNTuA1HTBB4lIgljeeM3QqrOdCsRUXKv0LI/fPgE
	 u41uTPR7vJU6O3SVkqMSwS73RDpzzjWa6gUuf9Ktqq9x9Gae8IgoaHdkdg7c5w/S8r
	 +6dRRSvQJ911/RC+Vt9jDyoY/PO5zssjrhKrtCxkor1/opDswrVcHQ7hsQEuP6nIfc
	 +bdFLWp5VZhZ6wd76io5wu+F42rBMrFgtjbgoU+PPgsJItG6Wtq+su57FDQNut/4M8
	 Ohnk0QofjWvYgg6TSF5/nodP5pveF1JfypClBU9Evq08gQsIZ3gehXAiytv2G4vcUS
	 5EtsotKr9VXpQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGnxt-000000019Ib-3eNn;
	Wed, 05 Nov 2025 19:35:01 -0500
Message-ID: <20251106003501.726406870@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 19:33:25 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tracing: Exit out immediately after update_marker_trace()
References: <20251106003324.964761749@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The call to update_marker_trace() in set_tracer_flag() performs the update
to the tr->trace_flags. There's no reason to perform it again after it is
called. Return immediately instead.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dea1566b3301..07bd10808277 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5285,8 +5285,11 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		}
 	}
 
-	if (mask == TRACE_ITER(COPY_MARKER))
+	if (mask == TRACE_ITER(COPY_MARKER)) {
 		update_marker_trace(tr, enabled);
+		/* update_marker_trace updates the tr->trace_flags */
+		return 0;
+	}
 
 	if (enabled)
 		tr->trace_flags |= mask;
-- 
2.51.0


