Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3634BA29;
	Fri, 19 Sep 2025 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244561; cv=none; b=tfTRyD0UTEO3Te9nkapxAKK6eLVa2vxgtd8BlYhhbfDCRP2aPCKfAvlHGB8yvbuQhLfbtHyaFVR5qUed/DwaBtCgliP/OYPTjWC1Ly5AyS0seBSdv+b/VHzXIABA5PgUo53nUG2ZrUPbCBRNfMua8LqPhWA0o5YbCKAKKiA+2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244561; c=relaxed/simple;
	bh=adBL6r2OhKuN6ZIaoCI6yJU/ioElJyofaoeuh+1/HVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pe6zG2TpweVpGChLAFE7WDB2RoxCbezdKm2U7q3mz5BUf2F9CIOWjkiB5daINFmCTvB2lbD1+rUEyuEtOco4YkYYWFUCalCINRzCgzUoQT+KAeI2nIC0R8dMnt+EtjjRztUdTTVgowqzaP8Pugb1k6baALU40Bcul4MbvxzZKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVF1g94K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVF1g94K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB3C4CEE7;
	Fri, 19 Sep 2025 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758244560;
	bh=adBL6r2OhKuN6ZIaoCI6yJU/ioElJyofaoeuh+1/HVA=;
	h=From:To:Cc:Subject:Date:From;
	b=tVF1g94KiNdUeIv3rQlsJvOG2RZAT/FMpnVFOReQcqjW0DHXWXjz0/JcbKbI6RZ8O
	 wYPm3jr/3MOQOS//q9Pl/71q+4qBzkS4zpJ7JeV97OJ3qo82WwqAPsyGct0GkVWwUZ
	 9VpllrAj/T/y3Js6AlycI8eWxsRDJrHQDtN0VYAA8LEiy0bLoMx04z23R4nP5We2Ri
	 kWUqXeFI8LnhaeiZUWDDRdFpQa8+1JGjD2N61uunrqK7ZNtKnCXqfEh2Xplmi9mxvQ
	 Yy5mxiZmBZGsNhgqlDgH21q0JWNkjZur2oA/akZEtvGbqA4s0rmqxkMjqPnuPSv/2S
	 l8x/QGVYzaCHQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: dynevent: Add a missing lockdown check on dynevent
Date: Fri, 19 Sep 2025 10:15:56 +0900
Message-ID: <175824455687.45175.3734166065458520748.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Since dynamic_events interface on tracefs is compatible with
kprobe_events and uprobe_events, it should also check the lockdown
status and reject if it is set.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5d64a18cacac..d06854bd32b3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;

