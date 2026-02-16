Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E713AA2F;
	Mon, 16 Feb 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234219; cv=none; b=hpY3N0J1/Gqzjj+BMxgXv3DiiMboKiAP5vKDzezxLL8KuuE4jZpPsF3ACs1Sm2+195WZvh/Vurjn5xH9GHlvF1wqt9dEVNEgyN8NnzyFktJtlJJVUYZ0SlJQS9RkbP4Mz8KTiM1xNFLx0i+P8lSwoEngnKmifXUoDd+bTFaNQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234219; c=relaxed/simple;
	bh=On3wEf0+yn7vkojIv4yWSrS26SXQspZCTu8heTQRUD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmW+hFUrzwdu4TwUHmB4ldIDZ93e76tX+jvPSofKTF9Q/VcPu31Nj4uX0Yzn6QekYSCs8O9cLlp6gVXNArbI2dzr7N7j5v3oeRvMKp/KqpBes++xSitQNG954X6bSMWl0JDqpeiVWA5lDW5PXxS5Ah7dNFiIL5vLQwsMrDfmwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3TjRsc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3TjRsc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ADEC116C6;
	Mon, 16 Feb 2026 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771234219;
	bh=On3wEf0+yn7vkojIv4yWSrS26SXQspZCTu8heTQRUD0=;
	h=From:To:Cc:Subject:Date:From;
	b=H3TjRsc4L3l4HZjeu0D7Py+oyVwZrDbW3qHOAsTzIMr6So3wi1ojvp5oTza4EmT62
	 dNnaFsiSjyX/qtzYdRCRUJ2lCtM8nSy5CZUMpjiIHcTvaDXFOqWtrX3reUMSwHhuBi
	 epueCJZRA4zQcB4CZKwCNR4HaOoK/nsdafI8n5IxmkN90OZ5G5J6uxatUyIfqJUxBJ
	 2EjTvdQFszKgKXUVWPIaybDMe7yyonZh8ddX7556FGwTPBBfbnnKki0GCaImkellZ3
	 2mGYsJ2E5Zqg6STXd2NVxTRP+OH58G7bLaGYhaWsPBJZB2/oGxVuoGXHu8E4GPvwnV
	 0lr9GmJzaL8Kg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: ring-buffer: Fix to check event length before using
Date: Mon, 16 Feb 2026 18:30:15 +0900
Message-ID: <177123421541.142205.9414352170164678966.stgit@devnote2>
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

Check the event length before adding it for accessing next index in
rb_read_data_buffer(). Since this function is used for validating
possibly broken ring buffers, the length of the event could be broken.
In that case, the new event (e + len) can point a wrong address.
To avoid invalid memory access at boot, check whether the length of
each event is in the possible range before using it.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 630221b00838..1ef17d6fd824 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1848,6 +1848,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	struct ring_buffer_event *event;
 	u64 ts, delta;
 	int events = 0;
+	int len;
 	int e;
 
 	*delta_ptr = 0;
@@ -1855,9 +1856,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 
 	ts = dpage->time_stamp;
 
-	for (e = 0; e < tail; e += rb_event_length(event)) {
+	for (e = 0; e < tail; e += len) {
 
 		event = (struct ring_buffer_event *)(dpage->data + e);
+		len = rb_event_length(event);
+		if (len <= 0 || len > tail - e)
+			return -1;
 
 		switch (event->type_len) {
 

