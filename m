Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9D275870;
	Fri, 28 Aug 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923396; cv=none; b=TglCvZiYy9Lw4bPsjckaQZKm9P4dmcA456utLTjra2Ldd3LIneA9Kp8eQwO2x/e1oMCVb+xtWS3X/cuV1zGBRP1v3TF1UiXnbtyC/0ifNe+zttmBHhJNf6xRY4X4vhn4jndSn23y86dygNnPGyf1rDlVwmU01jM9thJbGe/zzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923396; c=relaxed/simple;
	bh=mULhCKQDfBUQVEeKODhkV5wtP2cVxWicbhiuL2evrEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D78R3bLn4bv9w3VmM3GH3ytwldiduLG5ogQ7br3BsxsQVnWTarOT2gfacD6b0Kv7BYbmczCZjcxRkarYbpYQHDOlp9TL5XcPoQdNAGzwJuwqJqwnuB+uyWFt0ehmiPZaEtTiskmT4+FPIdOz6SJ/oMgexl6rLnK6/t7y3tNe3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Vj5FRXIq; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Vj5FRXIq"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 152371A035F;
	Fri, 28 Aug 2026 13:23:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 4075E6000C;
	Fri, 28 Aug 2026 13:23:08 +0000 (UTC)
Date: Fri, 28 Aug 2026 09:23:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, falemi@asu.edu,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: use-after-free in t_start() when a trace
 instance is removed
Message-ID: <20260828092357.3316f95b@gandalf.local.home>
In-Reply-To: <20260827202859.3573c044@fedora>
References: <CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com>
	<20260827202859.3573c044@fedora>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4075E6000C
X-Stat-Signature: 61wugffh5whnrgu5h1yuqiz7htzf39yp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xCeDB3O/RG8wzaxXmda2FcWUAuTLtzTM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=6th4h7r05UFCfgkGYPzYvhEbJ7acyljeAK0pF8rreH0=; b=Vj5FRXIqwb6XLfQ/27NwhuKWmOYhqDZY04ceOJXPLQL+5fT/MVVEh+3idBtbKTPoSYLONDKFy53Ob+Tqw9ZFHwYKeP00NuuviVdqxA5qyuaeJZEABnCceuz4Tfj07dzwzk/HyL3w0Fhdc1xRYtA1uI7SbjeJmKtCj1OUEz98rGc=
X-HE-Tag: 1787923388-705373
X-HE-Meta: U2FsdGVkX1+4e+hjlU9eyt8P2HxlZI+dL4ZpmQllPLFPu+j+2kXBJirmv9rJOp8mtwA4BbOjWHXBJor7sExXvF3FIbH96J1U+qCPTePZ+8Cw85gxxSb+EN/AMW6jRQeVkQ9xPGAMSR07g1CTLEn061JKsh49+qPJKJpVZeQvsZMIxGlBSknoyaLwxwVW0PJl2ph+dBIx8P1RTwBp4lbbuoEISJH7raRFD1qDNZznYW1cIT3QFvbtlTNCAXl+TAXcxNZ1Mii9E3yEvfjYw3PxUpvtmdkLCijbyEndCSK+BDUns1POe78Sw3gbMa1EfsLRH581Qfaq9viC4OUaULbzF+/9N29ZDR9AhuaAqMgUC2Ie1wR8WP5uuQ2/9w6gkmbB

On Thu, 27 Aug 2026 20:28:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I see what the problem is. I guess you were creating and removing trace
> instances while reading available_events. All files that are part of an
> instance needs to get a reference counter on the trace instance when
> opened. This prevents the instance from being freed when there are
> opened files in it. I see that the available_events file doesn't take
> that reference which will allow its instance to be freed while another
> task has its content opened. When it reads that content, it will
> trigger the bug you see.

It's not available_events, it's the two new files that were added that
didn't take a reference:

  show_event_filters and show_event_triggers

This should fix it:

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1d39eaf6a0f7..9dbc2441763b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2736,14 +2736,14 @@ static const struct file_operations ftrace_show_event_filters_fops = {
 	.open = ftrace_event_show_filters_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_show_event_triggers_fops = {
 	.open = ftrace_event_show_triggers_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_set_event_pid_fops = {
@@ -2908,7 +2908,17 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 /**
@@ -2922,7 +2932,17 @@ ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_triggers_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 static int


-- Steve
