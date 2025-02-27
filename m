Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E61A9B2A;
	Thu, 27 Feb 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692342; cv=none; b=On9AaZeKk59kTs6PSJvMNfeHJ9ExfNQQ7wIMRxQJH4gFHEeWHiIbydU3gpWcDR6J+JONkitQWCSy40MIfo0H0pXdf79NRkIvVhooCN0y5BSl7Ayws1SBpQ4Fj3/RqVKmlmMDEqPVVVNZWcBK4pRzGOkjWpcOtzvb1UAj8eJDZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692342; c=relaxed/simple;
	bh=0uqM8Rb45de9VzXCu+WOiz+KSieLYf5N5HE7pAVf0ws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qHtx/1fOlQBrQKHs7SOVu8SDIRH9bm9V20/yu7VyiVjOsjwaKPi7/81aNHTmbVG5Sht4dRHd6zKlrDprbMfmVkZDwamuwFSR0vlS/l9myXF0j4xQGpa9c5NQUa96NLMz6SWwKIwgI13gwwSKdQ9SpSEVei5MoWPLbz/8jiJ8+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B6C4CEDD;
	Thu, 27 Feb 2025 21:39:01 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:39:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>, Tomas
 Glozar <tglozar@redhat.com>
Subject: [PATCH] tracing: Fix bad hist from corrupting named_triggers list
Message-ID: <20250227163944.1c37f85f@gandalf.local.home>
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
Tested-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Closes: https://lore.kernel.org/all/CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250225125356.29236cd1@gandalf.local.home

- Remove extra blank line.

 kernel/trace/trace_events_hist.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 261163b00137..ad7419e24055 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6724,27 +6724,27 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
-- 
2.47.2

