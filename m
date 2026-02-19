Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AC34CFBA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518468; cv=none; b=WvEFqIC2PDf9qf82fIKvvg3VvTS/Bnb4c8mutb/lXBY/BJ8iTq4LPZKAGkAkWHJtgxJSb/6oDA2QvRDfqz0AQvmRUg5c1LFefuSugVlr/pFSBU8cbR8u5g5tecNuYL090dDNEAO8V86/19VsGtu6hngdYBJFOAgHpXutWFbxxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518468; c=relaxed/simple;
	bh=3aIPneSbFeQu4MdSA2qZGQY/yDCy+AZLupTPmFmOaUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psBdvrBbexFqPdp0GjAeyt2fk7JF26RzS9sc3qNXH/1cpPOxPz4FDi5lx0rXIsRL2IkRKkbd3CEN3PaYbSK2JtSBEKRG/5Fu3o6lxDY2DpoKLHTEZzTk6TVJqScG6dpSeOH4P4NGXbEHLw6mZsAwmMth03bj6/iqpK8OnDLKjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D6SzTEh9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D6SzTEh9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a16a400so1040675f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518465; x=1772123265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8pmqafAMo/XejBQW7PotvCqT3/aAFA10KU7IAZ4oDE=;
        b=D6SzTEh9p337AcddKGb2SDqBg+OyuMU95ATEYHUSIX6x7tzZ9tUKLf6jaSx1Y68LJi
         db4FdChaPPyw7VHggEJvySO/qGyfhlCMEYjNLnUvf9R4EIjhuXARqI4GeYF9N5IRqspP
         vfYwp3AW42yEIUnYx33CLEbrDpu3OFnmR996ZchSsxn0J4TohHIbW/2AbMySzDDrAF6F
         iuevlurSivuH1kU0GphtcBLkVGYxKxjFeJmG/1HrK8v/dDj597ZRHY1te3Q4nHI5FAFd
         oYgUQ7VJYtED9u+v1Rh/bG+8ttlpNaErgsQW7Nms3MsMiNJcc0PnVCb+plpQVoNa4/EG
         ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518465; x=1772123265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8pmqafAMo/XejBQW7PotvCqT3/aAFA10KU7IAZ4oDE=;
        b=KjKmh/jV6PB+FWWuQUnGnnAWkufWncGjTyVtT8Bs0rNB950PWKq79QbnqQUYKxYL5U
         UKVK6GLeoGvkQvnemK1psMobiC/jtfvas2Lh89WMctzwwN2cG/bXLteHxkiUF5QuJ/yH
         kZD87ClywOgwFYtT47DVcOrmbiRjGykTi3+WDGLlu+nQwdyQ3X33iCMArHReWQXWxbjp
         EfVl3bJm+LxWxlQTMXsH+AAmoBVieHvnKAeJSEW87jZx8hjVUb2GOUkIyaOYximA+aAv
         R9hYXZhOg/CzSZdrJZVqwjiewyzRZOn8N3kchIrEhBNhE5Uj2SJz+MwRBzgPpMqBEu0T
         1zQw==
X-Forwarded-Encrypted: i=1; AJvYcCUtu5RuT/RgsimD0MDzSIdf4cUMitT16fvgphyRfRXBJaL22UC34POpvAyYJSPPjWYKYyJq7NFdVHOJIcR8XMxYsXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfwHE0dmIfljRtxGfX3YrBFvaRC4F/DkxgFf3PSAMmsr8X9+/
	XJz/oDposKz3H6zV5TBcpOWpeAU8JKeLWdIHUnMAO4MviEgG8Bsr+wREpkdJrHNlAZI=
X-Gm-Gg: AZuq6aJu48YmXcyHnSEqBG4csc+inXnxUM5hHXJtAck6zNBgl52jpM/e12/oduqP+EI
	++9E4+/9iFC7O5jxoJeyZrvpgvmvfPK2vc5VAVaePowPy3a9irSCI6FXsE2Ecm0NPK+v8SNb1Aw
	pMgZfnntpwMBlobeYYoK4Ujw3U+FH3rGhMg+BlCCGbFYLeMeqouo1wMxIy9h9SZ3opWKlILMO+n
	hCIDBC6tvqtw6VkqfWybWsnASMaH4jA/vF4Ei4Ale8t2teahLkhMdTUaUwW6YOvGUS3JnGIPZkA
	Y93gpq9a4aXique78HdPYyvkSyK18KtPzuolyf04XiqIkUr0AsVNPRFhD0GgAoYqPjEQv2i76HI
	vIhCn4X9xh/nq+RhugLrCKmNcR8MWJCaqXCEhQ4E7xZd3JaKyJzcsdtLsW565Wq9/Xk4yWbUSjb
	7U8+iow55sW+OashFcd7HR8+8eAHajbncA+pqy7ji/Eo3tazNYcss=
X-Received: by 2002:a5d:588c:0:b0:436:3536:f698 with SMTP id ffacd0b85a97d-43958e4052fmr10504746f8f.30.1771518465266;
        Thu, 19 Feb 2026 08:27:45 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:44 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 4/5] tracing: Clean up access to trace_event_file from a file pointer
Date: Thu, 19 Feb 2026 17:27:04 +0100
Message-ID: <20260219162737.314231-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219162737.314231-1-petr.pavlu@suse.com>
References: <20260219162737.314231-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracing code provides two functions event_file_file() and
event_file_data() to obtain a trace_event_file pointer from a file struct.
The primary method to use is event_file_file(), as it checks for the
EVENT_FILE_FL_FREED flag to determine whether the event is being removed.
The second function event_file_data() is an optimization for retrieving the
same data when the event_mutex is still held.

In the past, when removing an event directory in remove_event_file_dir(),
the code set i_private to NULL for all event files and readers were
expected to check for this state to recognize that the event is being
removed. In the case of event_id_read(), the value was read using
event_file_data() without acquiring the event_mutex. This required
event_file_data() to use READ_ONCE() when retrieving the i_private data.

With the introduction of eventfs, i_private is assigned when an eventfs
inode is allocated and remains set throughout its lifetime.

Remove the now unnecessary READ_ONCE() access to i_private in both
event_file_file() and event_file_data(). Inline the access to i_private in
remove_event_file_dir(), which allows event_file_data() to handle i_private
solely as a trace_event_file pointer. Add a check in event_file_data() to
ensure that the event_mutex is held and that file->flags doesn't have the
EVENT_FILE_FL_FREED flag set. Finally, move event_file_data() immediately
after event_file_code() since the latter provides a comment explaining how
both functions should be used together.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.h        | 17 +++++++++++------
 kernel/trace/trace_events.c |  6 +++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b8f3804586a0..7db78a62f786 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1802,11 +1802,6 @@ extern struct trace_event_file *find_event_file(struct trace_array *tr,
 						const char *system,
 						const char *event);
 
-static inline void *event_file_data(struct file *filp)
-{
-	return READ_ONCE(file_inode(filp)->i_private);
-}
-
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
@@ -1827,12 +1822,22 @@ static inline struct trace_event_file *event_file_file(struct file *filp)
 	struct trace_event_file *file;
 
 	lockdep_assert_held(&event_mutex);
-	file = READ_ONCE(file_inode(filp)->i_private);
+	file = file_inode(filp)->i_private;
 	if (!file || file->flags & EVENT_FILE_FL_FREED)
 		return NULL;
 	return file;
 }
 
+static inline void *event_file_data(struct file *filp)
+{
+	struct trace_event_file *file;
+
+	lockdep_assert_held(&event_mutex);
+	file = file_inode(filp)->i_private;
+	WARN_ON(!file || file->flags & EVENT_FILE_FL_FREED);
+	return file;
+}
+
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 90915e1286da..c52135cd9265 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2182,12 +2182,12 @@ static int trace_format_open(struct inode *inode, struct file *file)
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
-	int id = (long)event_file_data(filp);
+	/* id is directly in i_private and available for inode's lifetime. */
+	int id = (long)file_inode(filp)->i_private;
 	char buf[32];
 	int len;
 
-	if (unlikely(!id))
-		return -ENODEV;
+	WARN_ON(!id);
 
 	len = sprintf(buf, "%d\n", id);
 
-- 
2.53.0

