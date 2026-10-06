Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86A49D5A3;
	Tue,  6 Oct 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305254; cv=none; b=PtuoTf7HYbi59HAKHk214PgAorZNXHkXQq0C1bAtnljHkMdd5gX1Jsdq4Q6pXymkWomZrLe/tTBGywp5xj3s06dTd0Z/H9hgd16SnuRSkvOC9B/nmEJ6QS34CN6qrdoswAbF1w9Hm4SRkGcMhqdgrRZDL71+8oaPziUjJvYuYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305254; c=relaxed/simple;
	bh=bIZ9o4rlincrRp9Oy9uNryV2txmOpc/71Vw9hrmYoOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGOTmH4RsKP7fNcAHvmmp3Z/jowsyAT+eLw9fVFTHumA0uR9MHhEX+rJ2+CrSCqgXxzgQtMswZJZvI7C3vqCMyron6qCkEim2zqSBHFJ48X3CifJvCJcXh5YEqbJ2FQKI54rWBNGYcTotlO5mG7K0+f9mCAWDtVzl7E2JK6DClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IeCj2VoW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IeCj2VoW"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id B38BE20B7168;
	Tue,  6 Oct 2026 09:46:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B38BE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791305197;
	bh=SiMjk5RZVx59TNZpwTv+JLxu3pnA0UCA6+VPCZ5gVTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeCj2VoW8YqKhKZNuHo8FmtsFH5GiU1Nu4Yn1Por3CHmO+Zz+QA530BUl7M7LpfRT
	 Fpg1E8KyTlprEPDC/6dKiuDmXl//F8duW1MdGxld5XsQFnNcO9LQ6nLyaDK2JEvQ3A
	 6sznXLq0UfFnAZx2gPsZrX6xu0e6x6xQGXauHDdc=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	reddybalavignesh9979@gmail.com,
	richard.weiyang@gmail.com,
	michael.bommarito@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] tracing/user_events: Serialize duplicate enabler lookup with event removal
Date: Tue,  6 Oct 2026 12:47:18 -0400
Message-ID: <20261006164720.3940272-2-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
 <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

user_event_enabler_exists() performs a plain traversal of the per-mm
enabler list. Registration invokes it while holding the event group's
reg_mutex, which serializes registration and unregister operations from
that group.

However, deferred fault cleanup can remove an enabler asynchronously
while holding event_mutex without holding the group reg_mutex. The plain
list traversal can therefore race with list_del_rcu() despite the
registration mutex being held.

Take event_mutex around user_event_enabler_exists() so the traversal is
serialized with all enabler removal paths. Pass the group into
current_user_event_enabler_exists() and assert that its reg_mutex is
already held.

This preserves the established lock order of group->reg_mutex followed
by event_mutex.

Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..24983f68d075 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -890,16 +890,21 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	user_event_mm_destroy(mm);
 }
 
-static bool current_user_event_enabler_exists(unsigned long uaddr,
-					      unsigned char bit)
+static bool
+current_user_event_enabler_exists(struct user_event_group *group,
+				  unsigned long uaddr, unsigned char bit)
 {
 	struct user_event_mm *user_mm = current_user_event_mm();
 	bool exists;
 
+	lockdep_assert_held(&group->reg_mutex);
+
 	if (!user_mm)
 		return false;
 
+	mutex_lock(&event_mutex);
 	exists = user_event_enabler_exists(user_mm, uaddr, bit);
+	mutex_unlock(&event_mutex);
 
 	user_event_mm_put(user_mm);
 
@@ -2510,7 +2515,8 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	 * for user processes that is far easier to debug if this is explicitly
 	 * an error upon registering.
 	 */
-	if (current_user_event_enabler_exists((unsigned long)reg.enable_addr,
+	if (current_user_event_enabler_exists(info->group,
+					      (unsigned long)reg.enable_addr,
 					      reg.enable_bit))
 		return -EADDRINUSE;
 
-- 
2.43.0

