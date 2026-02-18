Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD6327C07;
	Wed, 18 Feb 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409663; cv=none; b=Dv81K0IXrdKqZ6xye+0Xx2apagR1Dp6wr6uoM64V37vHwlMPwTbMC4RI/zAfQj86v2m9Zpe91n9JW1//ymE2kJV5++18Hy8vaMPlS2Tna7z1hgY3F99oukigIabwzfT96gY2sl+EKLH0i1J5lMFeafBLYV53KdG2CRBexcA/ZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409663; c=relaxed/simple;
	bh=NSL8LXlakBuOU2+iw8RIEkJEzD0nTYZ79OcqylTu4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxp7izRmQKhhJSu13gClJardepCKCAULNw5pryCLCHQlyBl3OXiNTtmzAmE0Xs78BVqIoJitfHNFXYbABYrHYv3R+WuLg/uAUDZlvKuEU74RxXXqnXmJdfy7JZTHYj3Y3dM2vgN/ixWk2tCKssVwXt/KImoP79DJ53d3AN1TJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8qr5pAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8qr5pAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFAAC19421;
	Wed, 18 Feb 2026 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409662;
	bh=NSL8LXlakBuOU2+iw8RIEkJEzD0nTYZ79OcqylTu4Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8qr5pAWP24BGVzg7TLAL49mzjXojiCEIHA/AwcUoYUHt0K95993aluTyLKLNRAXz
	 2ZPpTko5b17LNEsD1CyPh1tG8Pb4n83ZLAIvvHibxW4qx09UGk0hEo6+e3GxMDC+qO
	 hJkDg9xHsJPwaBjxLuLnsTZYSoFRkRoG6eWh6OSBE0ZTQ138+dffFxtFAhn2NKDQ23
	 3Ua/juQ8XtRyxGXSZpqVji5biMvUXBdTDKfrj6Qq0rwA2KVyOmsupH4kEGecvo/tB0
	 5OYm37tKF9PUYoFGcz1RsRk915N7HBX7sCi8jusvZq5LAksVB2keKIBZHsgmbVEL6u
	 Cq4/TrRAPeo5w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ring-buffer: Fix to check event length before using
Date: Wed, 18 Feb 2026 19:14:20 +0900
Message-ID:  <177140966034.1537493.2009658315480887232.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
In-Reply-To:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
References:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
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
index d33103408955..f7fd4bdf6560 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1849,6 +1849,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	struct ring_buffer_event *event;
 	u64 ts, delta;
 	int events = 0;
+	int len;
 	int e;
 
 	*delta_ptr = 0;
@@ -1856,9 +1857,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 
 	ts = dpage->time_stamp;
 
-	for (e = 0; e < tail; e += rb_event_length(event)) {
+	for (e = 0; e < tail; e += len) {
 
 		event = (struct ring_buffer_event *)(dpage->data + e);
+		len = rb_event_length(event);
+		if (len <= 0 || len > tail - e)
+			return -1;
 
 		switch (event->type_len) {
 

