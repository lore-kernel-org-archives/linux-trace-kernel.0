Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9E4B04A0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785084; cv=none; b=lw1VrO43tflRCPm/NLcqm4c70Q1S7MupKV33QrtPq32oKxd4JfGTxe/QlWp8vHVKKv3i63GG8cg8r3wPK1mVmAR2WE+UUHEQpom0AIw5OZI34o2WIAMYUhTLSu4beoBzXs2U/90HQNxjPF0oiphNJWyM7MeWQicgAq9qDYvl+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785084; c=relaxed/simple;
	bh=L31dJLB138outhVcfW0X4aGPP9PzfKLuAQivI2gWuvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjHVSoTtfeQQn8FA26cbdDL1jXhyiNETzKLH4YWUzBOstrU5NV0Io1KjVb4l3qDxbLxJfGMmBBhb9RmYeQuDQiSDzfZNdj5Vk9tj5OqmBPZBjxU7J+reoNKz8/7IyuuejxgTSESCJtvXunh9dOeULtqSGCfiy5rO8SefDkf4SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olwi98kN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olwi98kN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d9004f39d3so43020465ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788785074; x=1789389874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lje10pCj7urJUHzIwnwqeIHuLqNQwa+6AfG6B0cmdh4=;
        b=olwi98kN9NUp+mKDIqsrkbaEJsU2Y5XYlnNse4JYBNucivjs4n7zZz8y0bI+jsl4HU
         ufgvZviXX/TvZniNxnENBSlEE7c2KuhvqMjckSosjIuqM3dqoWOpNFPX3XYfeOZYNKVo
         RwqRIDvYaYnv0vD9fMjENMOJ5zdzUbGusKaZV1pYnBF7wNs16jTvUGttdpFuBjbTblGg
         wYMpnE9k6QayqMXVtLoovzFR3l26mrRs1MeGZRBfo0BCRRgSun2ngagYjFnZBpzodI0g
         a+qcRRLa/5lXlfVFQjO+/nk+kZrYK03O4bNPeZVzZCBmyXIBgJiRyiOxAPIs6PRDGVQg
         Zu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785074; x=1789389874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lje10pCj7urJUHzIwnwqeIHuLqNQwa+6AfG6B0cmdh4=;
        b=OhaylGj//+0urUxDDAgzudL0yPgMHiCKy/xJ+5P+u8HuXk0Ov4z5QjuqFWKLWBGiZw
         vIP1FYbrWmrAgSN30V/XLMXAhYA/1tgXKUWqVN7b73GaC2k3O7QF6b/b3lQ2fPaP+XNM
         cgFRZeZKAXOehnO1WXJORQzke2/4mKi3+1gIa1lNpyOXfYahKMeQUt+2Vb1PMqKO1I39
         lRqzQLEd762h7H4mUycWuC0whXFJS+9oO3GdkXgSfev5U+IjdcQ3fgMvs4fexFO8Ir+B
         fes4J15XeJ2mZjw1ZaOI3/vTg90XRKydzIqHMWCgCwAgtX65+qml6b7bWpjtr7B0KBgJ
         zWuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvIn3mbcm16/3eJ4C/aQoKBz3d6T6B00lnu1tFdJMwLfkWwPX9vEa48Nl+5fl7twSon7g1qtA+5G/eLHG8LZtqruM=@vger.kernel.org
X-Gm-Message-State: AFuF++kDtqeh6TL8w8duClaa8U+LjCV0UtEu4KdyVcghxPly3dP0eGdh
	JX3meoZ1xngDyXdkcL0jIgGV6NmMzO27WZ7C6x4xH+Rl1VA0fH3nLRo=
X-Gm-Gg: AYBFou03VSMdcOxiR2YT/FkOjb+5GSw/FgW3jnPyTIbqet6+d06v9eSv83OuCKPrMNz
	i/XnHWDcsNtUJRaAzBwxminor4qLLLZYOu4v1HMc8qKKs1Z47UcS7Nn4HmcyTUxYMBkg04n+T92
	DfaWmdc92WRZv39kKntwq0SMRpmoym7mAdaLYsZTbg0q8isHoqWHfOKf/lihNOR9I/5nvm0oSJr
	5OxSIu2xHhKkIueFU/TrHEjUiz/7xPwDajeMzQ9G98E3pst7qyOCwM/k2njBc7WfSjb50msnu1B
	lUDybJinbdmMKA/FxYkLxwrVrXvQ/OltgObOsR5PwoReDvS88/r3HOkr2uQ1Vnpjqg5dq3pVXJt
	RRz84iH9nuXIpdqZGxQNcl8yaIbmJ5R/3UTnNVppmZ1AdCcwvd2VHK+er5fs4nudkB3obhKs3K0
	ToEHAac96UY9RLKi9wUrnZd+hdQ1RvYG2AUpejFvaorLjOMTWGLqbQugqLqeOxZMAOz/Kf0a737
	oRfBw8jdNOm8JreqTxPZP+47OY=
X-Received: by 2002:a17:903:4b27:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2db12496889mr314116275ad.9.1788785072459;
        Mon, 07 Sep 2026 05:44:32 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm45350955ad.63.2026.09.07.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:44:32 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH 2/2] tracing: hist: undo the registration when enabling the trigger fails
Date: Mon,  7 Sep 2026 21:44:20 +0900
Message-ID: <20260907124420.607097-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
References: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6f86bdeab633 ("tracing: Fix bad hist from corrupting named_triggers
list") described how a trigger that is registered but not on file->triggers
ends up freed while still on the global named_triggers list, and moved the
registration down so that hist_trigger_enable() follows it immediately. One
path still gets there. hist_trigger_enable() adds the trigger and takes it
straight back out when the event cannot be enabled:

	list_add_tail_rcu(&data->list, &file->triggers);

	update_cond_flag(file);

	if (trace_event_trigger_enable_disable(file, 1) < 0) {
		list_del_rcu(&data->list);
		update_cond_flag(file);
		ret--;
	}

so the list walk in hist_unregister_trigger() matches nothing, test stays
NULL, and the ->free() that would call del_named_trigger() is skipped.
out_unreg falls through to out_free, which frees the trigger anyway:

 BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
 Read of size 8 at addr ffff8880091d3160 by task init/1
  find_named_trigger+0xac/0xc0
  hist_register_trigger+0xc1/0xa00
  event_hist_trigger_parse+0x3146/0x6af0
  event_trigger_write+0xce/0x160
 Freed by task 69:
  kfree+0x154/0x420
  trigger_kthread_fn+0xfd/0x160

Leave the trigger where hist_unregister_trigger() can find it and let that
undo the registration, which is the only code that knows all of what
cmd_ops->init() took: the named list entry, the hist_pad reference, the
reference on the trigger a named histogram is shared with, and the copied
cmd_ops. It also pairs the failed trace_event_trigger_enable_disable(),
whose sm_ref and buffered event reference are otherwise left behind.

Since ->free() releases trigger_data and, for a trigger that does not share
its histogram, hist_data with it, out_unreg can no longer fall through to
out_free. For a trigger that does share, hist_register_trigger() has
already destroyed the caller's hist_data, so the fall-through was reading
freed memory there as well.

Move the enable_timestamps check in hist_unregister_trigger() above the
->free() call for the same reason: hist_data does not outlive it once the
trigger being removed is the one that owns it.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3D@smtp.kernel.org/
Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 kernel/trace/trace_events_hist.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c6c04926bdf0..1de224a5a2bb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6679,11 +6679,12 @@ static int hist_trigger_enable(struct event_trigger_data *data,
 
 	update_cond_flag(file);
 
-	if (trace_event_trigger_enable_disable(file, 1) < 0) {
-		list_del_rcu(&data->list);
-		update_cond_flag(file);
+	/*
+	 * On failure the caller undoes the registration, and
+	 * hist_unregister_trigger() can only find the trigger here.
+	 */
+	if (trace_event_trigger_enable_disable(file, 1) < 0)
 		ret--;
-	}
 
 	return ret;
 }
@@ -6761,13 +6762,13 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->cmd_ops->free)
-		test->cmd_ops->free(test);
-
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
 			tracing_set_filter_buffering(file->tr, false);
 	}
+
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 }
 
 static bool hist_file_check_refs(struct trace_event_file *file)
@@ -6972,6 +6973,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	return ret;
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+	/* The unregister frees trigger_data, skip out_free */
+	goto out;
  out_free:
 	remove_hist_vars(hist_data);
 
-- 
2.53.0

