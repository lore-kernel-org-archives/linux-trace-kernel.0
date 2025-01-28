Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDBF9F8;
	Tue, 28 Jan 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078650; cv=none; b=Ea8SCvsjCCU4qg5TQSeYvhA50P+CUIvLghoHYXZA0RPxswzPcBNVddL9DaTdJPz5AMLV3hBPG1tp/kTbyBNJ/9OTp2fI9TwK4WNIDITJkxj0NKqn3UcK/0Aa1q9M6OHp5yVPemAzlQHZI9X38iyVyvZ7M0pKLNEL0EFeVhzoqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078650; c=relaxed/simple;
	bh=bpTuAHnmxxYJi8aMzZEmI5QzeBf7azj2pbNnpxLLXXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAEpyaGF43kGkj8UuXIYhe/flaU8496YhDteiceAx6NBsBkx92m3Ay2WoJTjxrE0jHTVMBSRtvX3F6jPgxxpdR/5/tCKBireVKZL0tWI/a2/VKtUH8I+5a/Fos6Vj5B13GZKggzQKDI2+iIKwMfIdInUtZieuMKi9gARb7a2I0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kREJGJlo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kREJGJlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1C2C4CED3;
	Tue, 28 Jan 2025 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078649;
	bh=bpTuAHnmxxYJi8aMzZEmI5QzeBf7azj2pbNnpxLLXXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kREJGJlouXAym197/2wwbyFQfmdwyrPAH2jgYX8Oucqg/Z/qZWu+c3WEpehVhSO2b
	 ilpoN+tHplJHvHjfja9OLWfhjuXC1xL2BmF0rSaLA/3ZBoU27tCkCAg7ee0uAaERVR
	 7dMS/nwrQI+CQ4jGcg/6yDtLTqd7RmxMQPQRuUcgqWlIht7w3vdCd9WYh08eiRfniP
	 lTjqZ1NjZ3qx9V1jq05Zg4KgQb4/uGqTet1WDaOXYQyDtU6gvUYqV1WNviW9vlXl0D
	 voTpHsq+uwA374fbVarimhXCnLPQNk/o5i5E7hAvGCkWu21wawygN8eckSu+SwJIth
	 s+4auv03+igqg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [RFC PATCH 3/3] modules: tracing: Add module_text_offsets event
Date: Wed, 29 Jan 2025 00:37:25 +0900
Message-ID:  <173807864506.1525539.5749974707383492634.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
References:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
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

Add new module_text_offsets event which records the offset of module
text and init_text section address and size.

This information is required for decoding the relative stacktrace
entries for modules.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/trace/events/module.h |   40 ++++++++++++++++++++++++++++++++++++++++
 kernel/module/main.c          |    1 +
 2 files changed, 41 insertions(+)

diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index e5a006be9dc6..1e5c84cc8d15 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -47,6 +47,46 @@ TRACE_EVENT(module_load,
 	TP_printk("%s %s", __get_str(name), show_module_flags(__entry->taints))
 );
 
+/* Module address offset from _stext */
+TRACE_EVENT(module_text_offsets,
+
+	TP_PROTO(struct module *mod),
+
+	TP_ARGS(mod),
+
+	TP_STRUCT__entry(
+		__string(	name,		mod->name	)
+		__field(	unsigned long,	text_offset	)
+		__field(	unsigned int,	text_size	)
+		__field(	unsigned long,	init_offset	)
+		__field(	unsigned int,	init_size	)
+	),
+
+	TP_fast_assign(
+		if (mod->mem[MOD_TEXT].size) {
+			__entry->text_offset = (unsigned long)mod->mem[MOD_TEXT].base
+					     - (unsigned long)_stext;
+			__entry->text_size = mod->mem[MOD_TEXT].size;
+		} else {
+			__entry->text_offset = 0;
+			__entry->text_size = 0;
+		}
+		if (mod->mem[MOD_INIT_TEXT].size) {
+			__entry->init_offset = (unsigned long)mod->mem[MOD_INIT_TEXT].base
+					     - (unsigned long)_stext;
+			__entry->init_size = mod->mem[MOD_INIT_TEXT].size;
+		} else {
+			__entry->init_offset = 0;
+			__entry->init_size = 0;
+		}
+		__assign_str(name);
+	),
+
+	TP_printk("%s text_offset=0x%lx text_size=%d init_offset=0x%lx init_size=%d",
+		  __get_str(name), __entry->text_offset, __entry->text_size,
+		  __entry->init_offset, __entry->init_size)
+);
+
 TRACE_EVENT(module_free,
 
 	TP_PROTO(struct module *mod),
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..9f1ca8730a71 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3372,6 +3372,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	/* Done! */
 	trace_module_load(mod);
+	trace_module_text_offsets(mod);
 
 	return do_init_module(mod);
 

