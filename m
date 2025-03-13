Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A227269AF5;
	Thu, 13 Mar 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883214; cv=none; b=ui45NMULZ7hizfC67TvDVZ9IKQSLDSJOlri/RB99bdxM37RA7sAmn5wQN2S1IdOWLiEmiG0memSQKwMgUcSnsMi47eO979I82R5259nhyiyA20rj530uGyPg6gutjK0JSSw2PlWNBdb0qnZKb0k2Oazn9ULhNX1vgG+gyeXY4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883214; c=relaxed/simple;
	bh=pGMw10kDj5FTIP8+NVIzio5CPevQusxYdDxSiEcp9oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iF56LeG/YKYezwifKLSTi9mJXLntEmNl7GEMQfc9IAA16+7HXmXepawfT10XWLHOyENvksBKyRczHoVWvTvCRVBBQYWjhePHYAMXel2xciXkaKJQNRKim74kdAckz57vU81Jb+3dYl39JvGD+G1QZMw9ER62DQMMPoLPx8hLmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkV0eTfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkV0eTfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F58C4CEDD;
	Thu, 13 Mar 2025 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883214;
	bh=pGMw10kDj5FTIP8+NVIzio5CPevQusxYdDxSiEcp9oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkV0eTfB5k6YVyP1XU0sATwpUYxY+Z/0Xi9RBN5jJb+kg9RIK8YEa2yxnH9LqXtM3
	 n2tkChRhAmkoX3JZF+Y57GuhAAop/wqzeW7C36sNAcPP8Ny3BUKIXYe6fxZOyi9chg
	 ZOsG5hx6AjijwbmAUDRjPDtLrbPY7oBLUiDTPZ3KejVRIawoZ7iTrXCRYRCNfnzTaf
	 XrgDumOA0EghIrXL0V2+VHDIkXij2sPCIZqaeEZhxLoWw+ja8roq0O6ZjyEeAs3rTU
	 GvQWxk/6rfzsuGUBz0cIS5RZ7qW+Ed7pkptQZBHwnAv1a6pz/jOv9LZQap+s7BacZe
	 IsEwZxsCV2c6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tracing: Fix a compilation error without CONFIG_MODULES
Date: Fri, 14 Mar 2025 01:26:51 +0900
Message-ID:  <174188321162.3845006.12665585959241736399.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To:  <174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com>
References:  <174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com>
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

There are some code which depends on CONFIG_MODULES. #ifdef
to enclose it.

Fixes: dca91c1c5468 ("tracing: Have persistent trace instances save module addresses")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..c70b2e709987 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6001,6 +6001,7 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+#ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6025,6 +6026,7 @@ static int save_mod(struct module *mod, void *data)
 
 	return 0;
 }
+#endif
 
 static void update_last_data(struct trace_array *tr)
 {
@@ -6040,9 +6042,10 @@ static void update_last_data(struct trace_array *tr)
 		memset(tscratch->entries, 0,
 		       flex_array_size(tscratch, entries, tscratch->nr_entries));
 		tscratch->nr_entries = 0;
-
+#ifdef CONFIG_MODULES
 		guard(mutex)(&scratch_mutex);
 		module_for_each_mod(save_mod, tr);
+#endif
 	}
 
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))

