Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08B14F9C4;
	Tue, 25 Feb 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505999; cv=none; b=iMLI+xY/QvVTUhT/kJtgsr3soBAhhrRl+Xf+uIuXttuTZYMyogBwrWNFhG2XqCyZxvbbQznFvif2G+qlpustb53YZbZsAHXOTpbFmcuoF86OOnve4pneWoTH8TbWpBx5RwQzy/CRqifI4aw9w5NxQ9Zb7f1CWHg1I9hM96lFpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505999; c=relaxed/simple;
	bh=PFetlwZIjtDHSeCjjYgYXTvGCoSFeYK5lIXFMoq1cNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u+RssE96UOUOcf8RnbmlSl9TyamVG/ycOA3+jFQdgVX3uQDFeX67VnoE3v+VrzAruS1P2gusGCW9cBOEE5eVkx8YXMHd1YJCQC7mpu+E6WQoy9m8LQAKSPt+7O2UhrKxj+XgODzTNBj9tYZ0YJQZgZrr3SEsbIBrpsLy+kjFeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C338C4CEDD;
	Tue, 25 Feb 2025 17:53:17 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:53:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>, Tom
 Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Fix bad hist from corrupting named_triggers list
Message-ID: <20250225125356.29236cd1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The following commands causes a crash:

 ~# cd /sys/kernel/tracing/events/rcu/rcu_callback
 ~# echo 'hist:name=bad:keys=common_pid:onmax(bogus).save(common_pid)' > trigger
 bash: echo: write error: Invalid argument
 ~# echo 'hist:name=bad:keys=common_pid' > trigger

Because the following occurs:

event_trigger_write() {
  trigger_process_regex() {
    event_hist_trigger_parse() {

      data = event_trigger_alloc(..);

      event_trigger_register(.., data) {
        cmd_ops->reg(.., data, ..) [hist_register_trigger()] {
          data->ops->init() [event_hist_trigger_init()] {
            save_named_trigger(name, data) {
              list_add(&data->named_list, &named_triggers);
            }
          }
        }
      }

      ret = create_actions(); (return -EINVAL)
      if (ret)
        goto out_unreg;
[..]
      ret = hist_trigger_enable(data, ...) {
        list_add_tail_rcu(&data->list, &file->triggers); <<<---- SKIPPED!!! (this is important!)
[..]
 out_unreg:
      event_hist_unregister(.., data) {
        cmd_ops->unreg(.., data, ..) [hist_unregister_trigger()] {
          list_for_each_entry(iter, &file->triggers, list) {
            if (!hist_trigger_match(data, iter, named_data, false))   <- never matches
                continue;
            [..]
            test = iter;
          }
          if (test && test->ops->free) <<<-- test is NULL

            test->ops->free(test) [event_hist_trigger_free()] {
              [..]
              if (data->name)
                del_named_trigger(data) {
                  list_del(&data->named_list);  <<<<-- NEVER gets removed!
                }
              }
           }
         }

         [..]
         kfree(data); <<<-- frees item but it is still on list

The next time a hist with name is registered, it causes an u-a-f bug and
the kernel can crash.

Move the code around such that if event_trigger_register() succeeds, the
next thing called is hist_trigger_enable() which adds it to the list.

A bunch of actions is called if get_named_trigger_data() returns false.
But that doesn't need to be called after event_trigger_register(), so it
can be moved up, allowing event_trigger_register() to be called just
before hist_trigger_enable() keeping them together and allowing the
file->triggers to be properly populated.

Cc: stable@vger.kernel.org
Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist triggers")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Closes: https://lore.kernel.org/all/CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 261163b00137..c32adc372808 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6724,27 +6724,28 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret < 0)
-		goto out_free;
+	if (!get_named_trigger_data(trigger_data)) {
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
 
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
 
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
+		ret = tracing_map_init(hist_data->map);
 		if (ret)
-			goto out_unreg;
+			goto out_free;
 	}
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
+
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
-- 
2.47.2

