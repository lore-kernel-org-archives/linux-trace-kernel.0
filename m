Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0524AD4A9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211212; cv=none; b=lfgMHh+Bp9xjM6GpXVnh6dSRIAc/ZRVx01P1CvNpngnVlFDkXvyD2PZYgmUk06Jb8LX1GZ+5leSEWi3bmaUmZE1hcdIRapmK57Z8dmTNEDIvD22ol9ow3a0ZdoOZ816K0EaZuL1qkeZl3SSp27YJDjZPmAFyp8J+S4IQII+Rt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211212; c=relaxed/simple;
	bh=1eklDsYY5mU4Ym9StcrWCE6nsYQ9YUVIyLQ3bC9FdfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB3XoGrZ5DtyKJLhHHkM7IUwKzx3qlzA/ODaSOgyLpZ/0bUUtxP1B2u9zkw6Fn+r+L52Ah+Tc8mnZWocXrT1g2ZV5wt6XJ2ZeDEZvgZibquIaFiViz17DBlkCmzsIVTkSPvTdLjjnXBr3V4O5aYsBzQijSC9iuUityLA8jTw798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bCdGHjqP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bCdGHjqP"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5282020B716A;
	Mon,  5 Oct 2026 07:39:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5282020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791211142;
	bh=M0WSn0xBeBW4ksGIw1sL9kz1pQo0Yg414Vx1Vwoj7G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCdGHjqPISz4Pm2YHMcUuCWJoxy8ebrFPx/Z1skT5uoq2fnMbGo/gXTsK0IMbatyO
	 rEkUO68QzWhMPZqUxwnV+ubhwHGrPfeFGzS0wQB+qDnoD8a65/KRue0jLOgFLOxCJQ
	 F9TVbLpNKqkG/FXxsatN1/xvDb8DygfGEmmQoIv0=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 2/2] tracing/user_events: Share tracing state between existing threads
Date: Mon,  5 Oct 2026 10:39:44 -0400
Message-ID: <20261005143944.752112-3-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005143944.752112-1-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
 <20261005143944.752112-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Threads created before the first user-events registration can share an
mm_struct while each has a NULL user_event_mm pointer.

When one thread registers an event, current_user_event_mm() creates a
user_event_mm and attaches it only to that task. A pre-existing sibling
thread sharing the same mm_struct can later create another user_event_mm.
The two wrappers have independent enabler lists, allowing both threads to
register different events using the same enable address and bit despite
the EADDRINUSE check.

Look for an active user_event_mm associated with the current mm_struct
before allocating a new one. Attach the current task to that wrapper and
increment its task count.

Serialize lookup and attachment with the final task-count decrement and
list removal so that a task cannot attach to a wrapper after its
last-task transition has begun.

Without this change, the new selftest reports that the second
registration succeeds. With the change, it is rejected with
EADDRINUSE, and all user_events ABI tests pass.

Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 78 ++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..950d8a3cd0e3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -210,6 +210,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
+static void user_event_mm_destroy(struct user_event_mm *mm);
 static void user_event_mm_put(struct user_event_mm *mm);
 static int destroy_user_event(struct user_event *user);
 static bool user_fields_match(struct user_event *user, int argc,
@@ -754,33 +755,78 @@ static struct user_event_mm *user_event_mm_alloc(struct task_struct *t)
 	return user_mm;
 }
 
+static struct user_event_mm *
+user_event_mm_find_locked(struct mm_struct *mm)
+{
+	struct user_event_mm *user_mm;
+
+	lockdep_assert_held(&user_event_mms_lock);
+
+	list_for_each_entry(user_mm, &user_event_mms, mms_link)
+		if (user_mm->mm == mm)
+			return user_mm;
+
+	return NULL;
+}
+
 static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_struct *t)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&user_event_mms_lock, flags);
 	list_add_rcu(&user_mm->mms_link, &user_event_mms);
-	spin_unlock_irqrestore(&user_event_mms_lock, flags);
-
 	t->user_event_mm = user_mm;
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
 }
 
 static struct user_event_mm *current_user_event_mm(void)
 {
+	struct user_event_mm *new_mm;
 	struct user_event_mm *user_mm = current->user_event_mm;
+	unsigned long flags;
 
 	if (user_mm)
-		goto inc;
+		return user_event_mm_get(user_mm);
 
-	user_mm = user_event_mm_alloc(current);
+	spin_lock_irqsave(&user_event_mms_lock, flags);
 
-	if (!user_mm)
-		goto error;
+	user_mm = user_event_mm_find_locked(current->mm);
+
+	if (user_mm) {
+		refcount_inc(&user_mm->tasks);
+		current->user_event_mm = user_mm;
+		user_event_mm_get(user_mm);
+	}
+
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	if (user_mm)
+		return user_mm;
+
+	new_mm = user_event_mm_alloc(current);
+
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+
+	user_mm = user_event_mm_find_locked(current->mm);
+
+	if (user_mm) {
+		refcount_inc(&user_mm->tasks);
+	} else if (new_mm) {
+		user_mm = new_mm;
+		list_add_rcu(&user_mm->mms_link, &user_event_mms);
+	} else {
+		spin_unlock_irqrestore(&user_event_mms_lock, flags);
+		return NULL;
+	}
+
+	current->user_event_mm = user_mm;
+	user_event_mm_get(user_mm);
+
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	if (new_mm && new_mm != user_mm)
+		user_event_mm_destroy(new_mm);
 
-	user_event_mm_attach(user_mm, current);
-inc:
-	refcount_inc(&user_mm->refcnt);
-error:
 	return user_mm;
 }
 
@@ -817,14 +863,18 @@ void user_event_mm_remove(struct task_struct *t)
 	might_sleep();
 
 	mm = t->user_event_mm;
+
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+
 	t->user_event_mm = NULL;
 
-	/* Clone will increment the tasks, only remove if last clone */
-	if (!refcount_dec_and_test(&mm->tasks))
+	/* Clones and attached tasks increment this count. */
+	if (!refcount_dec_and_test(&mm->tasks)) {
+		spin_unlock_irqrestore(&user_event_mms_lock, flags);
 		return;
+	}
 
-	/* Remove the mm from the list, so it can no longer be enabled */
-	spin_lock_irqsave(&user_event_mms_lock, flags);
+	/* Prevent new tasks from attaching after the last-task transition. */
 	list_del_rcu(&mm->mms_link);
 	spin_unlock_irqrestore(&user_event_mms_lock, flags);
 
-- 
2.43.0

