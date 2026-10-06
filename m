Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24604A0933;
	Tue,  6 Oct 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305257; cv=none; b=jqMhJE6Uo0W5j61awGUOVzmPLKlodB6YScZc6Lq28pf6sYOeeAz4CHL473LPTpsT8+2GbWQmbLyDOvE90iSZx+FilNG79wcmU+FNArZShLRAWQl+FhDlDvvni2hd4nk8dL+gm8FUd6SKChE5d/jIf7W8hRdPVHsgvo7h3BJCojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305257; c=relaxed/simple;
	bh=SbZJyIDyuoCRXMzc9/M3jdswFRFhzp6+SVIngArHyLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOyszpJprdWLtYedyUiwqsFJl12TP5BzQWvTU3LlpWaP3e1Suo3DaZ+brbv0fFCVGn43kJZnfrPa7dTgkEMWREptTm5bGdiFefHzvUDjXp9kNr+n8e50I9+7DkHdKFf1/+VzE7pcR4nAyuZ1iynUZzcW7hKqRuQgpLM7AU4ZlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jQJ6xLPm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jQJ6xLPm"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E97420B7166;
	Tue,  6 Oct 2026 09:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E97420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791305199;
	bh=XpR1tp6rPwdK0atTsauVUj8vnctdj0bL4cviJYgQdg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQJ6xLPmJFH6qS+WRADna6sgfe+iO7yI9lIMzeCOAxPLXws/aFbIcM/878xTqweXw
	 tko0QaAFStWmFdDnYOi9wwGwlRPpykP4XTuDKf613eOFHRunR22/KjZbDZjWO4u18t
	 2aAA6z6SlbMs6p9bCgG2yQX0/Fo28b9a8h5O44Ts=
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
Subject: [PATCH v2 2/3] tracing/user_events: Share event state with existing threads
Date: Tue,  6 Oct 2026 12:47:19 -0400
Message-ID: <20261006164720.3940272-3-jeffbarnes@linux.microsoft.com>
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

Threads created before the first user-events registration share an
mm_struct but can each retain a NULL user_event_mm pointer. After one
thread registers an event and publishes a user_event_mm for the shared
address space, a pre-existing sibling can otherwise allocate a second
wrapper with an independent enabler list.

When duplicate-enabler lookup runs for a task with no user_event_mm,
look up the wrapper already associated with current->mm and attach the
task to it. The group reg_mutex serializes registration paths, while
user_event_mms_lock protects the global lookup and interlocks attachment
with the final task-count decrement and list removal. Increment tasks
before publishing the wrapper through current->user_event_mm so exit or
exec will account for the attachment.

Hold user_event_mms_lock only for lookup, reference accounting, and task
attachment. Release it before acquiring event_mutex to inspect the
shared enabler list.

user_event_mm_attach() cannot be reused for this operation because it
publishes a newly allocated wrapper on the global list rather than
attaching a task to an already-published wrapper.

Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 44 +++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 24983f68d075..da07b873cd48 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -754,6 +754,20 @@ static struct user_event_mm *user_event_mm_alloc(struct task_struct *t)
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
@@ -817,14 +831,18 @@ void user_event_mm_remove(struct task_struct *t)
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
 
@@ -894,11 +912,25 @@ static bool
 current_user_event_enabler_exists(struct user_event_group *group,
 				  unsigned long uaddr, unsigned char bit)
 {
-	struct user_event_mm *user_mm = current_user_event_mm();
+	struct user_event_mm *user_mm = current->user_event_mm;
+	unsigned long flags;
 	bool exists;
 
 	lockdep_assert_held(&group->reg_mutex);
 
+	if (!user_mm) {
+		spin_lock_irqsave(&user_event_mms_lock, flags);
+
+		user_mm = user_event_mm_find_locked(current->mm);
+
+		if (user_mm) {
+			refcount_inc(&user_mm->tasks);
+			current->user_event_mm = user_mm;
+		}
+
+		spin_unlock_irqrestore(&user_event_mms_lock, flags);
+	}
+
 	if (!user_mm)
 		return false;
 
@@ -906,8 +938,6 @@ current_user_event_enabler_exists(struct user_event_group *group,
 	exists = user_event_enabler_exists(user_mm, uaddr, bit);
 	mutex_unlock(&event_mutex);
 
-	user_event_mm_put(user_mm);
-
 	return exists;
 }
 
-- 
2.43.0

