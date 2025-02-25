Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966663CB;
	Tue, 25 Feb 2025 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444722; cv=none; b=gRzzgyTz8ju8Mfi/cg4iLZJk8wBvEpMT3TheGwcN+XZ/oMn4zGgzFyC5VivG4Ys505I3+rzjP1MQEK996AVzWoeheeBPokS5LoI3nZzyyOgyh69xgAH5RkDCEZ2lUJHRB/jmdX+tTgHJioPKXzc7gxufsicmjqH3fwDy/gYm+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444722; c=relaxed/simple;
	bh=/1w756IoIZoyt+xrBxOCyfkAvJp82Uk9V5BE3AKHzBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxcbhI3B/mG2ted/8nwVz2U1rEubxwR8tqbBn+1JJvhMe1owM0WwGFBaXRL/2uU89HGWxzMg0klahwfN8gSA14vFmg57aNHcQ5nYdrR1VRbVdFdvKWh+5pWk1DbllYmi/Axd/KDrxoWISDbfheFoHHXKCBYwXepIpYU3LysDar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221CAC4CED6;
	Tue, 25 Feb 2025 00:52:01 +0000 (UTC)
Date: Mon, 24 Feb 2025 19:52:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [BUG] Crash on named histogram trigger with invalid onmax
 variable
Message-ID: <20250224194804.73c57307@gandalf.local.home>
In-Reply-To: <20250224131049.3a4d8945@gandalf.local.home>
References: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
 <20250224131049.3a4d8945@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:10:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 24 Feb 2025 16:22:39 +0100
> Tomas Glozar <tglozar@redhat.com> wrote:
> 
> Thanks for the report.
> 
> > I'm not familiar with the trigger implementation. Do you have any
> > ideas on why the hist_unregister_trigger fails and/or a fix?  
> 
> One day I would love to rewrite the trigger code. It's really convoluted
> and not easy to follow. I'm constantly trying to remember the workflow of
> it.
> 
> Anyway, I'll dig into this.

I think I figured it out.

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

The next time you register a item, it accesses this freed value.

So I moved the code around such that if event_trigger_register() succeeds,
the next thing called is hist_trigger_enable() which adds it to the list.
Probably should be port of event_hist_register() instead, but that could be
part of a clean up.

Looks like a bunch of actions is supposed to be called if
get_named_trigger_data() returns false. But that doesn't need to be called
after event_trigger_register(), so moving that up shouldn't be an issue. At
least I can't find one.

Can you try this patch?

-- Steve

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
