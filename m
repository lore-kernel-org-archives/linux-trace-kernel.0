Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAA345CCD;
	Fri,  4 Sep 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549344; cv=none; b=J1TxjPYpPhtAmgIqVEKM0PxOdqrWk5la5ccZAIyOSs3o6ASoqMZb3FBooiknq5AXvvgPmmgLntELl/dXrl20ry+o1XZr8ApmWoWTTk/qvSZBjmcHhDHnjC3KxXP2re3E+wE14Yo9iI7/9xw3ORlJFSegbbFBUuDoeXxXMsnoe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549344; c=relaxed/simple;
	bh=+3Ds5Gq1u175Hlow3Rzkg33W5qXfKfIlFdy+C/U/5Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iLRTv//i7wq8GgRSXvLnojUZXKht2Rg8XWg2htPav9gLNDZau6HELupID3+nniVjj/tZXNVMp4seNavkPObZgiPXFCpb0rI/0u2Mr5B45jbfGedjcqZ3sxYPwmIm5H+YHbYMZ9xh14VqqWVJPWdP8W/hp/rfdbkE0KConHkTg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Py4Ij9FR; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Py4Ij9FR"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6C8FB1201CE;
	Fri,  4 Sep 2026 19:15:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id CEA062002A;
	Fri,  4 Sep 2026 19:15:35 +0000 (UTC)
Date: Fri, 4 Sep 2026 15:16:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Use a macro for static buffer bits
Message-ID: <20260904151641.17eae0aa@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CEA062002A
X-Stat-Signature: om3stoke54uwziekxrzie33okgtuugp5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18v7hUYL6adM/ScCQsoq+/rQma261e7Pto=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3B9mKRTJEn62anHtOeqV1zOb4pQdNUm4Nc45WbFuPA4=; b=Py4Ij9FRq9O2fV2RHrMpDj5FSdhK3ZavpFCeYwzJ4HV4gzqZmamv71grbmNvk+kcV22w3uxaCTDpPBQ/SvVMmuZT7WdHqj2hMs690WgM5AEVOi4YpSUs8AcLYyfKb9QosCk0FfR469NazDB72leLHPEJwAmXNcCHGG9nHU9wnoM=
X-HE-Tag: 1788549335-690543
X-HE-Meta: U2FsdGVkX1+gwCjavrRpAH6KEWsIbdI+p9wfHHgjNZyyBr6alqKyuYp6xm7CQf+CmaD2NfAyouEx98ls50HJplmiRkdx5f5LY2tlW4IKhYhWsF0hRuFq6vd4MYeASjxsLKMs7ApzPU72R9Ti2XP665gRjnlGsngtpuAE4DgpvLVwLkOKeEIse0JEpDO6dR28vOFjbK9LEKbBpBvjNgFjiCG6wLk66RxL+zZQu/3qKOtH1j7PBrOCh9XcgbPXYXKoEqh61B0LFnbzm89oepkcrL6ql8byRxHUtrAeFmIr0kKLfE55wPcT03J/GPuTYCKwzrCT2XfDEkvT1f4iOdrlMk1z5ObCKHP9cml5rMvEUkIcyT0ibzhkiLHjuAcxw8iG

From: Steven Rostedt <rostedt@goodmis.org>

Instead of hard coding 30 for the number of bits used for the static
buffer ids in two places, create a macro. This way if it changes in the
future, it will change in all the locations that use it.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 220b8405adfc..b88c75b52e8f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -335,6 +335,9 @@ static __always_inline unsigned int rb_read_page_capacity(struct buffer_data_rea
 	return (PAGE_SIZE << rpage->order) - BUF_PAGE_HDR_SIZE;
 }
 
+/* The number of bits for static buffer ids */
+#define RB_STATIC_BITS	30
+
 /*
  * Note, the buffer_page list must be first. The buffer pages
  * are allocated in cache lines, which means that each buffer
@@ -350,7 +353,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
-	u32		 id:30;		/* ID for external mapping */
+	u32		 id:RB_STATIC_BITS; /* ID for external mapping */
 	u32		 range:1;	/* Mapped via a range */
 	struct buffer_data_page *page;	/* Actual data page */
 };
@@ -663,7 +666,7 @@ static unsigned long rb_static_max_pages(void)
 	 * Static ring buffers are using bpage::id and must account for the
 	 * reader page.
 	 */
-	return (1UL << 30) - 1;
+	return (1UL << RB_STATIC_BITS) - 1;
 }
 
 struct ring_buffer_iter {
-- 
2.53.0

