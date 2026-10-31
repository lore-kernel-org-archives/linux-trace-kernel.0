Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481899;
	b=oCMY4QvwVCAkJ5oecdC5u4l43KmpAZtgDIOXYmQNtZhgYX8ML4kZhzYp4xtGiCKeB7Ho
	 SkUQ18xsha3JI5YXPLnZqRdOaLc8uCKmO/kScH4JOYFrp/+Y8YrPNkuDLWBUowk9/wGD2
	 +1rMJUF+x5C7hyz86xtJTNV7IRvJHf4eS83ldPPGBeWnBebPic3ubJJNviq4/6oZC/q/9
	 vrqaHvoYqiWUyHkJLnUThf5dOpS7640A9JAKqH1foXvDTHxZC57eiWM6kCe1fNkL3iuKJ
	 tb71B8NqOE1t9boMMBcB9fFiLdcdWmOJDGVrwrHN2A3PHw55Wv5CHfwK5A7Me5PYVaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
	b=dhq25GiaFsspH43wByuX+hw2QfKI1XqVElAQTp4/3TOZ6ULfjVDKFT8MQtdinD/5I5xw
	 CksmZE0aMlp+nJ9iRSIMOzIX9psw6KOZfERLTxKC9YOEba+F42o2jwQC8GkxHiI8QnSLs
	 co6ZwZHZLgQBW8rO4bEiG5pPLrxhvBJggKuFx+nDN5nGtovid3O3txkVJxdBIvwamdJcH
	 J2/JwMc6ziQNvbX3cQvSkRqIOnDO67FQsIX87vhQB2Yv8WcWXptHl/9MdJMnlWCBN0FYf
	 +2gcmf/QAKOeS4HSsaT8HmziiK+CvY2CJOx2yYDRoEp9uDIIOt/gMUzqJO9fazj1pnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRulVzh3;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4496606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4496606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRulVzh3
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1062414f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793481897; x=1794086697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
        b=fRulVzh31Bhqv4/NY0qSOKuAao7KoNFrPQExsVBxY7qusbFaVTWyHO4RWrHIdAtg07
         vFUPO5eJXntEXjdfR1QLkzpfOsUJKagNOTK8XkC/c0eOnia4NkMKvJI/Nk3VrVFoxsOh
         i3oPWiPPU2rtDbWV4kOkc6izndYKP4KXuDEkGhXYsoeRWL/kH2x1YXIiD+1hnaPPH9HG
         9EzMsLOiHjBNpJGxgjQQzJ7ekqcK37vxtBU4edxk2DSn5o2ErNIoJFaP/+AoToO0aF3U
         MxjsXR6/F34luSr3gv8m2/9Ro5kDnFDCdNXHMzKkM8aUGzvbYkTbhDMjdSXCvtxNlOXL
         N7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793481897; x=1794086697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
        b=y6D89RDsrgr6MeqLnUkzHhxp7KiC9L9h9ubpWNmDXuplKzhmbaHyQuO78y1Q7SJPFY
         rImmpSXiv7i64mXqCAnunPowy/UWET/ak8j0Jj5xLc1rd+iCsbxfVGw3/GLakkTDap4N
         lA5+Mx0vvDETKS1VhA0AjJaaQ0efLxHz/KdiwpKQS5eaIfS9d3vxylD/jTM608GNXjPC
         xphpbopVjgFd3S3IC6sUSfkxhLWnvNjKrYa8/Fgyfk5cNx8Ra6ri4nnsHSkfCt22zK6g
         FfjaNU1yNT9zI1TAFKmwTE76OOAhLKUtsRvZQDyYutBvFHr6Ci4hsVyjNxyWkr/76UX5
         W4VA==
X-Forwarded-Encrypted: i=1; AKwUvBzdy7eIgVZP17BswgqGgwELVHVbMIXeeY23ot3D5P0TE2fvtFNybdxuFZWRg++gVNXJAPM7nrxG/0O4wjGtasakGls=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+SfumCs81cLSeouarD80V8WLhXX2eqDKYH1xhAi2OEoj95aK+
	CqsvynSqXfL7myM7lOD5btwQ9GDojdXBNAqtCcms5899vyoCfpxcPVXC
X-Gm-Gg: AYBFou0XXFA5TBNG/2lAWfY/HRGTfnoJUh7olxmU4Zpt6p0QVW3tYtSIR7xT3VfH6IL
	S4kf2t++7CNpzK+UqnRwcZDnB7OMDsWfxU3HmMRVtx1WglD3ZLlZmmz6tzKXXYBYo/20hgawIwM
	v4d4pUWbUVREUtKQqD/GG8t/P50+j5Zy4PRkIhcZ4u/oU2BLay7HKXZu/50pFP68CG7WP8Yx4tN
	d+Qmpae3hRwZqp43+iXsrjnVq194CClym2boTEz6YYSwna/H+HscJF5OCMLcggj8nuzp5JWE5AV
	67kB5bHaifqQJKScCtLaaI2OIQsYXDWCpfFlQ7IA751arFp5OcIQ7BlebIUXK/TwJx/PUhMz0ZL
	t3v0jo1UYBev93IurjNkBvEPWEZbL2++dckRWzOeejUdMEsw96rkLakeFeu9Q9U3njXUwFl1tFv
	6dBHFo5RWywNo5rbs5TJ5vOL8R/PByXAe224XT1Px9Svv+qgqQz2bavVvPKU377tFiMLqbYP5en
	CXIq9xRWNlQoilCGl2QP002evweaswv8cJq4ZLJk4cdYJvsaEpGTAr5QYROsxEG143GaTYH+l5N
	tBUwS7LcMoK8/zjRE0xJT3f8u36IWg5KWNPlaZ30Pk54tE6AKkDKKHOQrnStf3BnLjUinHg/6sO
	LABgf88iP06IwkzUJo/BFel+ZG+5Wif6oejE=
X-Received: by 2002:a5d:4982:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-48e6e307204mr9624281f8f.43.1793481897073;
        Sat, 31 Oct 2026 14:24:57 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm10204530f8f.36.2026.10.31.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:24:56 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/user_events: Don't free an event that a dynamic event still references
Date: Sat, 31 Oct 2026 21:24:35 +0000
Message-ID: <20261031212453.16116-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An eprobe takes a reference on the call of the event it attaches to,
and kprobe, uprobe, fprobe and synth events all refuse to go away while
trace_event_dyn_busy() says such a reference exists. user_events never
checks it, so a user event can be freed under an eprobe:

  echo 'u:test u32 a' >> dynamic_events
  echo 'e:ep user_events/test a=$a' >> dynamic_events
  echo '-:user_events/test' >> dynamic_events
  echo '-:eprobes/ep' >> dynamic_events

The last write drops the reference on the freed call.

If the last fd of a non-persistent event closes while such a reference
is held, the delayed destroy now fails. Mark the event persistent then,
so it can still be deleted once the reference is gone instead of being
leaked.

Return -EBUSY from destroy_user_event() in that case.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: keep an event whose delayed destroy fails deletable by marking it
persistent (Sashiko). Deleting it then needs CAP_PERFMON, like any
persistent event.
v1: https://lore.kernel.org/all/20261031210420.501187-1-devnexen@gmail.com/
 kernel/trace/trace_events_user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..ea6a20a30cf5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -256,6 +256,11 @@ static void delayed_destroy_user_event(struct work_struct *work)
 		 * attempt to delete it later.
 		 */
 		pr_warn("user_events: Unable to delete event\n");
+		/*
+		 * Keep it as persistent so it can be still deleted
+		 * since nobody own this event
+		 */
+		user->reg_flags |= USER_EVENT_REG_PERSIST;
 		refcount_set(&user->refcnt, 1);
 	}
 out:
@@ -1506,6 +1511,10 @@ static int destroy_user_event(struct user_event *user)
 
 	lockdep_assert_held(&event_mutex);
 
+	/* If there is a reference to a dynamic event */
+	if (trace_event_dyn_busy(&user->call))
+		return -EBUSY;
+
 	/*
 	 * Detach the fields before removing the call. Removing the event
 	 * frees the field list memory (trace_destroy_fields() is run on
-- 
2.55.0

