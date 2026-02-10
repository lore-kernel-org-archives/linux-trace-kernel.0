Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C331B13B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723299; cv=none; b=TtABjeve2k5cEY6zRPWq3oXzzUlwLA2vYtMNGl9YHGhVFiedeZ+QSJS+Di8tZmXtIXt/NJ8zXRvKiItQkqjO5v5GHpeHrIUn3ckWAgT4JTZo3EN46bsonoga72kPQ01/RKdRsJtsPi+OL86M6qihfGz+Zpu7py/IJ5MeHoz+KS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723299; c=relaxed/simple;
	bh=AZbPmQspnfdPD1dkBj8q9VPDlES/gdctt4sqkPbmfJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWf7wfx91ogc02B3uZdLyS4wHqi4Gi9SsH9Zu1NJY2OaScmb2/L5pUYijD9KSBj44LsqPdHQ29ZraOozqOiiLeyTMqs4bmbIVrjLP2+PZx7VM3UZLTpKRCv8RDGzN8jnFxwQvWjTKcrXf9Jb67UGO3+ESQJp5UqU31jXScZmXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CbzLe7XG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CbzLe7XG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so531066f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723291; x=1771328091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xzTbvx4j2WGhpm6B/fN7XDTTbeiE+41Vj6geLDrtfc=;
        b=CbzLe7XGv4OoSFfaG1y1qI8DN0Vql96lv/kEtcDfFfFafD7L9qo0b+SHT8tJLmTnsi
         OKEVBjRgSMwqiCXxn35uuhjczofjEssNTc6aiEqhpNSh2rjjBGynoAuQjX5jESTBIxDK
         CtRJcoUSQA7KVhJyBnFr82BWZQG/pG2RPJhvxKpB5iYKr5Dwz6Njwjb8gLqwooTqj6PR
         KeIEAZaboD1wu9wiMWorK4r7MYd02s2okZpJROLeYl08/9JmWp/JsnqLGz+ph0Una50i
         e4xqIdi8PW9QmKh8NIqvfw65tBtThg28b2bOTRFETyGhKdbyFvUgvM0e00yIj+4yJZI9
         Qkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723291; x=1771328091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xzTbvx4j2WGhpm6B/fN7XDTTbeiE+41Vj6geLDrtfc=;
        b=LmGtVi65+0W5wc6gWmVbZPRva+2m0Qz25JZbpbIxjxe31tZpM04kZxO/IjGJ116qpV
         nuboaatGn2RsyKEeioxbw+IWWMSrAnK6a+v2ZxD32GKq4d9eete6rvYFUZsx2LxZQxkg
         tcyesW8ssZxUs6Z9yPIrx1FSCSNVOf/b92BFuOLqLPP5ZvCjQUdS27HR6RuM6g6BtnKY
         579ePd0uaaId/skgo/MP1fycOncamnHyhypwiGBm6LMJjmqG3z+qY3YEQI1Pe54L8Lfn
         YcPHOizWMlhJRMHIPso2gRtSJVXhE4RVwEpraXRLkl8tNACXHwcPdbV6KmLtH9gUTfr9
         BD0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdpjDt2hNw7QoUSSoFoJqEFLkhjHC0x2o/lYEFpkom/8FITRZR+kWft3RpoYdQz4dydlHP90GUySAikfgrtLJctXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSN6LiNBEmXya5XA9XSkdoNyFv9qSrKFnoFPLlY8T+A7648XY
	LU5oD/EhIk4C+FvOIp05K8SSiqLAX86L6z/Ayb+CuW/0EMmuGNdCr+tqPkXiF4OInFg=
X-Gm-Gg: AZuq6aInYjsy7pw2RtZVfdf3+Ik789P7tPU7q/WkedR8zu3UvNLMzuZbUTiMdcHdHK3
	qWxA8FUw7e1C71XZQQ3z3krY00wSrLbJOfuaSx2MQiMjbeh6/nei9cPErpaOkEeXwJqDXv2wFgN
	BmBTb/SwPEMoPnDVe3EQa/fh9h5dRl+izyVdxmMovugx0eZgF7lwI+StDOpo8vwPqewRLBW2S1i
	QgkL7owsVd/WHtMxTt5SzO19kycaYT2UhS5X73yXk7ezkpNxkmpFX2+Z7mTURzcHHdOTHY9eUVv
	isy9QK94VUhgVZNX5aOkfabxCYKGiV4k+/mIazCPczt7uKWk8Bcbpq5LfJ9kXV6HeyAQwWvc02K
	whCcXfXA5JySKOsc2UUmMnvu+YMfg6Czx+wFkgsgpUdcGGo1yGxs5PVWpZQfc86I5rpR8MFaWjq
	EGIn70zgDS9VX5R9s3jwP8SSc/dU2xAhFnOOX+acj2dYZhk9klpAb66G0IBMUAICTKHUBPqvnaZ
	zb38yEjr21WJUd2WosJX4Al
X-Received: by 2002:a7b:cdf0:0:b0:483:2c98:435e with SMTP id 5b1f17b1804b1-4832c984526mr130383165e9.34.1770723291435;
        Tue, 10 Feb 2026 03:34:51 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:51 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 4/5] tracing: Clean up access to trace_event_file from a file pointer
Date: Tue, 10 Feb 2026 12:28:19 +0100
Message-ID: <20260210113427.1068932-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210113427.1068932-1-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
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
inode is allocated and remains set throughout its lifetime. A previous fix
also modified event_id_read() to read i_private while holding the
event_mutex.

Remove the now unnecessary READ_ONCE() access to i_private in both
event_file_file() and event_file_data(). Add a check in event_file_data()
to ensure that the event_mutex is held and that file->flags doesn't have
the EVENT_FILE_FL_FREED flag set. Finally, move event_file_data()
immediately after event_file_code() since the latter provides a comment
explaining how both functions should be used together.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c11edec5d8f5..c6b450de93bc 100644
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
-- 
2.52.0

