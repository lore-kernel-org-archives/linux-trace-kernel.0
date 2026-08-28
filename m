Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6E44A408;
	Fri, 28 Aug 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923683; cv=none; b=ZYXTyOl+Jv/0iDpLLl/Sr3QtUlz/MYSCgZDearqPZn5ZP8ItmRaqQ+tvLPPv2PTbgSOaE3ymiVgBAsBGy5dhEABaWAmDUq+cC39840wygtqddl5YEKBvBVpc0LWZHOB/UHrMdAh9gw1pGEdR/feZiMqP+xlLZ1jFBc2ErwGkXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923683; c=relaxed/simple;
	bh=CbV7244SQRKhcRy76pR6Gze+MCHkK1P+OPO4LeKQZQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAYjd5WTSeqPpv381RqPgfQkRal/nly7mVnar9bKMlhIigBckW8R7nnWKKXOrETjYCIXPuC1RX3WBC4sO/LJ0Ro2N0B8dt0cxIexFuWHQUO0x6JvHVj9qNGt5W4ur/qHSCrUG6nuLEtFGuPnOb1rPP5knB9PRt9gId9EJfrPGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=DFvIjV+P; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="DFvIjV+P"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7D8D640343;
	Fri, 28 Aug 2026 13:27:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id AD5002E;
	Fri, 28 Aug 2026 13:27:47 +0000 (UTC)
Date: Fri, 28 Aug 2026 09:28:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, falemi@asu.edu,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: use-after-free in t_start() when a trace
 instance is removed
Message-ID: <20260828092837.3b7704ba@gandalf.local.home>
In-Reply-To: <20260828092357.3316f95b@gandalf.local.home>
References: <CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com>
	<20260827202859.3573c044@fedora>
	<20260828092357.3316f95b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g39y64k6nn366155y49ayjzcozbrnypo
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AD5002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UFox4lxSSL0nMOCch/ctcJck18mNMD2k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mdsLgVhlirn3ZgTN2PD+s7nWQx+QXiRdzv8YWdlWRzE=; b=DFvIjV+PUJIcjFvIvCaxDG6NLfgjrFDtpV3ISekjSPBLXYnys/ewmWRoVm6PMYUMc5NHUo2Ojjo64qZXPqlx+oXcKyS5HlEIxbqf3VSGVLZ8Yxw0Q53sGp09kq2JjGg1w/ixkPDKcjoWlFyWhqNnZBmwJXTKA4456UEQXt+ITfs=
X-HE-Tag: 1787923667-692529
X-HE-Meta: U2FsdGVkX1+vPrqqn4SgjvoiVWk/IzkdOHHRSuVu3mABldhWF3muSoW2aG9cQcTZ6AgdXar6oUbY0G+MqShO/cIdzFfP2ga7rxMzj8TnTT/yreOlcHstbHLdX261ltoINNPqxYq0ciKFM2JZ/0oREGADDWsUp3RQKIWdR2R98X/c1pi3ut1ak77eT91RxsjkIsaVbxo0k801yqKhQM9NY+ysI+LaTcRvJgMZlckBTjNiepAEfIKMgYWyoqZ2k0SXycAVDhcNRcTNqioYOtZm4h2jzoDBrSSZNI8H+bgjale4yplTZO1hf8JN+YdWQ4chzWnJIVMdym4huWc13/97v24mZd4RvGzOWHzSmuHK33bNR2oWeiXEyCM666fGPtJK

On Fri, 28 Aug 2026 09:23:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 27 Aug 2026 20:28:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I see what the problem is. I guess you were creating and removing trace
> > instances while reading available_events. All files that are part of an
> > instance needs to get a reference counter on the trace instance when
> > opened. This prevents the instance from being freed when there are
> > opened files in it. I see that the available_events file doesn't take
> > that reference which will allow its instance to be freed while another
> > task has its content opened. When it reads that content, it will
> > trigger the bug you see.  
> 
> It's not available_events, it's the two new files that were added that
> didn't take a reference:
> 
>   show_event_filters and show_event_triggers
> 
> This should fix it:
> 

I updated the selftests with this:

diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 42422e425107..1e3f27d6998b 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -43,6 +43,13 @@ instance_set() {
         done 2> /dev/null
 }
 
+instance_cat() {
+        while :; do
+                cat foo/show_event_filters
+                cat foo/show_event_triggers
+        done 2> /dev/null
+}
+
 instance_slam &
 p1=$!
 echo $p1
@@ -55,14 +62,19 @@ instance_read &
 p3=$!
 echo $p3
 
+instance_cat &
+p4=$!
+echo $p4
+
 sleep 1
 
+kill -1 $p4
 kill -1 $p3
 kill -1 $p2
 kill -1 $p1
 
 echo "Wait for processes to finish"
-wait $p1 $p2 $p3
+wait $p1 $p2 $p3 $p4
 echo "all processes finished, wait for cleanup"
 sleep 1
 


And it was also able to reproduce the issue. With the applied fix, it
doesn't trigger anymore. I'll write up a proper patch.

-- Steve
