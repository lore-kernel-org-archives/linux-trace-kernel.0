Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF81422AD;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536534; cv=none; b=PkCRF/uBIhvugqME3zqObI2fcoLEClH7Ei+YjkVZSc5BgmxhHkbYhhRmDILt5LM7cfNLIw85uLae5GgdTayJ9ptOWScfcH0I/TId2Mi2dpaJo17QJDE8diKyHAgS8k+HkaCaLkLppsi03ygXtEdidiWs6FRBxDblw7rxZN/7K5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536534; c=relaxed/simple;
	bh=gzuMoHpSvUC71Fv0Tg5dkH6tkrJ5zCwfPg5xYrrAB6I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ngj+DHmo8/xEWj9YJBg/0elb+SXl+5e3z2Id0zitkUtWWV2BZnkvXXSbYUIJl77GLyrczJnFMELxdFymqZIev/Qs4IPL0DMH8qRFlq62fNhhjMAw0pvjsNWGRtqlfCCzMFkJMKpvWjOhK+JaCcP2C1G8c/Zz+l7swCOa6hDrTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02786C4AF07;
	Tue,  4 Jun 2024 21:28:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEbiA-00000000bDo-3cdN;
	Tue, 04 Jun 2024 17:28:54 -0400
Message-ID: <20240604212854.725383717@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 17:28:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/5] ftrace: Comment __ftrace_hash_rec_update() and make filter_hash bool
References: <20240604212817.384103202@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function __ftrace_hash_rec_update() parameter "filter_hash" is only
used for true or false (boolean), but is of type int. It already has an
"inc" parameter that is boolean. This is confusing, make "filter_hash"
boolean as well.

While at it, add some documentation to that function especially since it
holds the guts of the filtering logic of ftrace.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9dcdefe9d1aa..93c7c5fd4249 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1701,8 +1701,20 @@ static bool skip_record(struct dyn_ftrace *rec)
 		!(rec->flags & FTRACE_FL_ENABLED);
 }
 
+/*
+ * This is the main engine to the ftrace updates.
+ *
+ * It will iterate through all the available ftrace functions
+ * (the ones that ftrace can have callbacks to) and set the flags
+ * to the associated dyn_ftrace records.
+ *
+ * @filter_hash: True if for the filter hash is udpated, false for the
+ *               notrace hash
+ * @inc: True to add this hash, false to remove it (increment the
+ *       recorder counters or decrement them).
+ */
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
-				     int filter_hash,
+				     bool filter_hash,
 				     bool inc)
 {
 	struct ftrace_hash *hash;
-- 
2.43.0


