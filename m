Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D294756BB;
	Fri,  7 Aug 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116959; cv=none; b=mTQYtnScxL0WvpnqaSCc0u8TKyNYQWoZmsTzKVfgB5y3mgnWrRbHV+K9e/Bwunlt6PJNnY5p6zMdjVmgaoLHAV7EH4VaV9ROS9oSSBVZFDbjM7mYHY18EAY4tb2/Ynx1HV3S+fP1g1IBlBVr6zkOYhSuDt9/ATNX8eb/Q6Gxm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116959; c=relaxed/simple;
	bh=QCEUV2ppBIx1uTBYnAZATdC1hD95gehKns2thzyzyYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qq9G3fsFXFnfXbeXzd4RZWKANwkJejl4K2812MhPuv+Ka+/GapgbyoaRluebyah+ro8I41lZrOibc+WakKmAzNErTivDKMuVTnKH7QjdSM7sePF4ZsJ/a1EfhbPzjKJfWYIlWq67QxJTJLR77XL4+/XemsxCGisSzm7fwqr8cSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=kIyZbjO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4dokHai; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="kIyZbjO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4dokHai"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 76B011D000BE;
	Fri,  7 Aug 2026 11:35:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 11:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1786116956; x=1786203356; bh=zC
	KsWOjVP+uvrq7tiKr5zz1A/zZ3o5u3effFwDv1G6w=; b=kIyZbjO0vcu4G/Hl7Q
	E+0XuxrTl4NveIpafGeZq+kTxgnrmOWVujCmrP9PyCT7JvjPR4NB/YEDpAFgRN8y
	lBCKhWQc/ZWwbuZiLBYYBkN30Bj9Tfk8IiqtkHfGG4S9sw67iiWHt6WAApkhCT99
	aASloFXXEse+eTDirfQtXVd1YrRagbCrm3OugdZq0hjv+NKTje48DgIw2a6SmhBo
	iHyUo7j0yyQoiTIsgIPaO5wVvXks4UTxX83dUGMljyIpMZJr06HE74ot3EaiuHQ4
	1CUQmP+fm7ofd6xyn43dqsd0oI7NMoAsEAz1ZOWlu/BTVuNFIzgOZvVmitKfx6DY
	lyyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786116956; x=1786203356; bh=zCKsWOjVP+uvrq7tiKr5zz1A/zZ3
	o5u3effFwDv1G6w=; b=E4dokHaippGXgNEzTHfE/DGA9jxIOJAQ/lIoAKqQ6Six
	HT/wOKW7KjQwDfm1ZTlkKrFOBryxtem4NNL+cZA50yQive3YyrR/3UudW9yzqq08
	PoCJH7k/UJUstCJFVQRMX+aQYaZx9m8wQj2bByZQOOp0lLng6J44QYIz1eaJm3AB
	0jpmIG+J+Go8RbDAh2c+Jz9MBqoKJVeSV6D/arylOTJzbtc4W4RU+opaetARrHMQ
	niVZN/i7cvHiu/5gFiexhiYarpYqB0GtUyn72ZUlws0mqjZULXrn/AyczyhkcVp4
	f9LF9x8NKvTdbZ9UbJoWgLcgm7W7NXusefOGjbqU9w==
X-ME-Sender: <xms:XPt1arDwu0Er-aqG_RTa3TTyxyUhAR7IXr7YttTSJQ8UKWlxaWsAcg>
    <xme:XPt1avWoozIXIReCglhyCi2uU6X5r4uXQEGToCT_F3SqkiN3sTPQ12tZC9kZH6q8I
    hl1AvHX4XIIm_3jOQ9pCZ3nNcto8TJfqdO4EuYQfW-me1jyEPqTRf-h>
X-ME-Received: <xmr:XPt1ahBEmH7x1luxLX7pEBqYQy-BJdOuof7Pth5Xgj3kYOAL4DYiMJ6ygOCM86u-t3ZdPgBA>
X-ME-Proxy-Cause: dmFkZTEQ83VvLX/fJTTNYVAmZhus4La/rf6qQf4q/6qdnFNY2BVrCKdTURHEsMOPHNlgAO
    OwHEtIMAcsrqtxLXca6xu4DaRkfzQB0g17w0BywRqc30TbS4fd3H3q3tx6EzgeWnENljxJ
    lHe7pXuzYT/Y/7Kvy3txu/gdIPQ5DE8b3xWlQVOrxzjYsdZIVx+1tH9xydoLtUBfizNcxJ
    cfCGmJxLmkbREwjJGahSHVNQ/y+xRqPUqgu0+MaBRQAqbu/41EyVhYQgpdP/84Y8zKOeZI
    Z39M0x3mVfmvdTv2DL6ZJ5nGaIOHwpH56JeZSIMsqtf7ypV0UCVQhtMk+VRG1nS253r4A/
    y8hV96F1EN2HjZVZ0lid74lCMMLxqxfTux/LBwX1H2KVfdDoKnuRjivGH61zYjmPcT5gvu
    XRkScN3986oRMlCGvBFcm0ot2ANq+9q/hRvr7w2vdh83xgfOS1h+MkvFisb6qQ6GKyP5AQ
    CHPqsLv1iq0HhdrGJvkM3cvdbvQF1KHDYZ7pE3XmzSHx0rF6sHTaZVZFoohHvq3/2RMOTk
    0DkK+0IDHG9T+58e1dOqlzWkmv6uSKBSPDEzahFOMYqnzV51kSmnh6atnmne7jRIuYU7de
    dooRjusvHSGz1x253VSF3+DZV5OZj564PvVv149AlLxVdXO3lHzaFm0+Ygbw
X-ME-Proxy: <xmx:XPt1aq-oUaGFnILZvaQVP65KlGv9TXLcJRgYYtTSyzL5jwbodmz_1A>
    <xmx:XPt1agEgkdgAyNbtOnjtKSRSyxAYhksohfhZZY1Sjuu1YI3Que5w6A>
    <xmx:XPt1agNtpBJRpv4hPV0eo03Jj1ZF7onrIXFLfdoV38XMGm55befxhQ>
    <xmx:XPt1aievyWWkXCDKHUrMBRrogNRhYosszhtg_dMqaWY4xkRzT2J67w>
    <xmx:XPt1atTxbnqWm9uJaVcHl0v5kjn_a4SnEluANUSGmeg0pP5_8PbOUqa1>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 11:35:55 -0400 (EDT)
Date: Fri, 7 Aug 2026 11:35:58 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260807113558.0ff14e96@gandalf.local.home>
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

The enable_data variable gets freed on most error paths in
event_enable_trigger_parse(). Use free() to free it and just before
returning normally, call retain_and_null_ptr(enable_data) just before a
successful exit to keep it from being freed. On success, the enable_data
is assigned to the trigger_data->private_data field.

Also add a comment to why event_trigger_free(trigger_data) is being called
before a successful exit.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260727155459.202af38d@gandalf.local.home

- Updated the comment about why the trigger_data was freed.
  Apparently, Sashiko reads comments too ;-)

 kernel/trace/trace_events_trigger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index ad83419cb420..149300cc5e8a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1753,7 +1753,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
-	struct enable_trigger_data *enable_data;
+	struct enable_trigger_data *enable_data __free(kfree) = NULL;
 	struct event_trigger_data *trigger_data;
 	struct trace_array *tr = file->tr;
 	char *param, *filter;
@@ -1803,17 +1803,13 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->file = event_enable_file;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
-	if (!trigger_data) {
-		kfree(enable_data);
+	if (!trigger_data)
 		return ret;
-	}
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
-		kfree(enable_data);
-		ret = 0;
-		return ret;
+		return 0;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1842,7 +1838,12 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_disable;
 
+	/* It's now safe to free the reference taken earlier */
 	event_trigger_free(trigger_data);
+
+	/* The enabled_data is assigned to trigger_data->private_data */
+	retain_and_null_ptr(enable_data);
+
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1851,7 +1852,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
-	kfree(enable_data);
 
 	return ret;
 }
-- 
2.53.0

