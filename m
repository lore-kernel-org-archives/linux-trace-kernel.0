Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802D30E854
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249394; cv=none; b=NeVVk4x9b2FzYXXHwszXvHrvv7iOSD43idRH+3R8m8ohizPLCaEG+80zHeM9+S2jtlq6YdAr52fuIOf2cK/fbEUOIdlqk9mHp/p/Hd5C7S1bM8FRtNeIKBLboAKHqG7yOJaVgSM+AdGIYu6Li4/QOE/T0ciL0R6yKH+5hrqBnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249394; c=relaxed/simple;
	bh=33NvmzifiaBRigoFifMef35hi/yQkfKUWjLhPBQHZC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajxsP19euzxwmojjubg8vH2HaMtlJ3N5hdJuSBvA8y8OjhoGROgGkAdW8fe7fR+pcEmTFJmkD4a4gJlIseQRQMs2hmwSWKwqzRAx+jXjUxruN34jqJgey7p8mr24in4YZ5OLlyWbDZSMLqlj+OEtfgLU2VIa5eAvBf7HctsbGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RKWcAa77; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RKWcAa77"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436263e31abso3089674f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771249391; x=1771854191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHlgJV/WzhgeNXBdeNtIIZu+ZwNnn+yQBr5wKMb7lyM=;
        b=RKWcAa77lpb10O5MnDtr5VaK7M6v25kfM9ifJhCHx/7fBjPQO87Qc6xrXFuxjSO3f+
         wsCWew92zoMGSxMlvjxps5ZbkHswZneiITzk0N8grriSOf6L3okS3Qd72aDW6vXpOtUo
         iWJXi+QfuyFoZM1G7i375PNfZElfGmDHJJqbeZIojB1xaVhry7vRJijG8c81UINhTkLE
         nDRvarjv6a56Rrv4ol1UZ9s+mPdTjJC1mCoI+3kTbu3cyk72Cjm1DQ5jkAfhM6iu1YNC
         aE4riU+Lsv3rPDvX4eIAL3mdnINALPasf5oNO6uxYiCMGIcBilCsd3xzSsZeqMC0SXLd
         sqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771249391; x=1771854191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHlgJV/WzhgeNXBdeNtIIZu+ZwNnn+yQBr5wKMb7lyM=;
        b=U00URrqjrt9/q7rzythmx8uS6eK6qTZPicfOUmGxuEKg5JRaxjIXp06j45y4ENZiyf
         aH7CbDqVpkppNxbsMG+dCGl/IF/1l8lQg8wK25LImtwEutlz42I3eca1dvdUmNDn070o
         Ch6V1UGhzaZDWyBDaJiq2cCWtbVMzkoma/V7pgrKkM3qH0og/HOMxu9J08WkZHgC47WA
         Rx4YbI3pKkv/9guSQQzjfh1Dih3ThiPuuTS1M6UIwz6kInCBoX9m+stj2KVjNdwuHFZ5
         K/LGArZvxE68fGheXxx7FpZQn0sLBoIeBVVIRnZQu4F5f3vXu2aCJw8WUxGm850ulvdi
         TUJA==
X-Forwarded-Encrypted: i=1; AJvYcCUKZOSDnDZD5UJF+XWKezLc1MNb+WbwtCAIoPnx3Odpk+6TJryttecKyIBvG34XimAMIkdwG1Y8q7hX4sFzvonWvUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZx5JYW02EwaVBsa/jSHM+BKFsUpzXoLVE0RP0V8IviQ1KAlZ
	kF6VBXebmWZBZrxuL3vs8JHvuxiJKD8RoBUpLssRdofg45kQH5WrqgCStAUBIgpnZ3c=
X-Gm-Gg: AZuq6aIe28/s6R1qANinJ6vk6ZWWQTk6BTePLmqK/afBEG3E6tflqdWsU2MQ83FPgWt
	YrYUFpzF4OPuuFw8CXFJKue9ID9nU9sXo+/J0+qx+XK3a6ZGhnTHeH3FdlGV8EmJt0RufY2bmyi
	M7zUlmH0Ajx/RVzBnFUGjmB0rqcS8pmXNx1wtiu69Qx5qLpo+Ibt72dDVjAKSEdXQgkocl9Maun
	QFJaSlqgCDuNc6W9vHVM1wxtV3sCnYcYLguySc5XM4KLRCl+04nYQHU0GQqOZqflr8YsH3uw6Kb
	/rRQSl0RpEGBtWpXfdWL3D+IMrRCcRUZaStwbFb77Le4276f8JWFbmvCdJ4EQppN5k8eS4Pu10A
	WCj05ZlkorEBEkE/8bvktO84BQDixU1P3p8GfvMp9EV4TRj3h0fdpwi0zJ53wwIdsVI/wW6gfvv
	RInh1S9wVVUXLoieoB2pfYhjwoh79OyNOW5nf+9gCyqk06K0Y/ayk=
X-Received: by 2002:a05:6000:2481:b0:436:8058:45a with SMTP id ffacd0b85a97d-43797913eaamr17300323f8f.39.1771249391215;
        Mon, 16 Feb 2026 05:43:11 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm22103738f8f.15.2026.02.16.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:43:10 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 3/4] tracing: Clean up access to trace_event_file from a file pointer
Date: Mon, 16 Feb 2026 14:41:59 +0100
Message-ID: <20260216134247.1311631-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216134247.1311631-1-petr.pavlu@suse.com>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
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
index 8428c437cb9d..27fb3fe6a7e0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1739,11 +1739,6 @@ extern struct trace_event_file *find_event_file(struct trace_array *tr,
 						const char *system,
 						const char *event);
 
-static inline void *event_file_data(struct file *filp)
-{
-	return READ_ONCE(file_inode(filp)->i_private);
-}
-
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
@@ -1764,12 +1759,22 @@ static inline struct trace_event_file *event_file_file(struct file *filp)
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
index 2ca76b048638..d23e7a9d07e6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2090,12 +2090,12 @@ static int trace_format_open(struct inode *inode, struct file *file)
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
2.52.0

