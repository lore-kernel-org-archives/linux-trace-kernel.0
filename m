Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FD1DF987;
	Mon,  2 Feb 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046670; cv=none; b=bT01hJDXgp2G3mpaOvenqrDIX5dPmpXlsiOLesgIzMkWOOcwoZKnJh6NtiUE/DCDPJIF9ozHAA6RWL34YDMEyufAOlXeI8mw+2QCK9TmoiC3jUQSuJw3vZ9Fki0iN1fmEm5QUYRYpc78iHhRlkfEfAGx2gMkkvgKRNBXBiasp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046670; c=relaxed/simple;
	bh=99Z7+njMZqEyLoEzdotVB/LxIBorJW1AeiB5c7TfWnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBx4I7pJIs3kc6ROWkSmTS2BH8tuKZw1yuvii91YqLbaBVdlSIv9+yOORGaAQNDhd5lI+Z78WOpYzgUJsDA9VlSGr0IgMYwtYqtxgAWAC1QUIRqP1FL2fLQSFJgzQAZIqQVugBmBug9vRQoXNmtTil/Jm9IelU7dU4R1catCIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 08DF35678B;
	Mon,  2 Feb 2026 15:37:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 26A3220025;
	Mon,  2 Feb 2026 15:37:39 +0000 (UTC)
Date: Mon, 2 Feb 2026 10:38:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <20260202103804.40cbaa27@gandalf.local.home>
In-Reply-To: <20260202123342.2544795-1-imntjempty@163.com>
References: <20260202123342.2544795-1-imntjempty@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 26A3220025
X-Stat-Signature: aa8poim1dk4mbukp5mbm1e8pwadaj6im
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18k1/lIm5+C7RWeFcnaMzeaCiqmBqYslQc=
X-HE-Tag: 1770046659-778012
X-HE-Meta: U2FsdGVkX19SCNGw3W+EIRplFUt0ug3e+K6KC/aLh6iVPqUoIApYQeTfTODs5X+qlBpBwWF6WUwTh28VwmVIq2oQtGGiptiGIVRobG0tfAIaHfP8ULCbS+FyizBePq1xCrqAmuOE2+861Zme1WBqcsDE01zsWLAAWIYXG1wXQhcsrs9i4Z5sYmTRNGg6pgnHqeU6B1wciQH0lF9O+m7Aw8Ddlwxi75RShL3CXpm3p83yTTNhA+VgzEO+YWquDdg5rnhQUpkz320v89KbksvN1vuB3i5xSb/QQ4nWEuIHJsvts9XkvlAR2flaP8QUPnidirfRR5Tm0JVNiEpPojCz5amJFtSdIBDK

On Mon,  2 Feb 2026 12:33:42 +0000
"jempty.liang" <imntjempty@163.com> wrote:

> Commit <66611c0475709607f398e2a5d691b1fc72fe9dfc>
>     (fgraph: Remove calltime and rettime from generic)
> incorrectly modified the offset values for calltime and rettime fields
> in the funcgraph_exit traceevent on 32-bit ARM, which are used to parse
> the corresponding values fromtrace rawdata. The actual memory offset of
> calltime is 20 (not 24), and rettime is 28 (not 32) for the 
> funcgraph_exit event.

OK, so this is a 32bit issue and not an ARM one. I was able to reproduce it
on 32bit x86 too.

Basically the problem is that the structure used to output the field offset
is out of sync with the actual fields of the structure.

> 
> Before the fix,the funcgraph_exit format was:
> 
> ~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format
> 
> name: funcgraph_exit
> ID: 10
> format:
>     ...
>     field:unsigned long long calltime; offset:24; size:8; signed:0;
>     field:unsigned long long rettime; offset:32; size:8; signed:0;
> 
> After the fix, the correct funcgraph_exit format is:
> 
> name: funcgraph_exit
> ID: 10
> format:
>     ...
>     field:unsigned long long calltime; offset:20; size:8; signed:0;
>     field:unsigned long long rettime; offset:28; size:8; signed:0;
> 

Thus, the way the calltime and rettime are defined is via:


> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -127,8 +127,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  		__field_packed(	unsigned long,	ret,		retval	)
>  		__field_packed(	unsigned int,	ret,		depth	)
>  		__field_packed(	unsigned int,	ret,		overrun	)
> -		__field(unsigned long long,	calltime		)
> -		__field(unsigned long long,	rettime			)

The __field() macro.

> +		__field_packed(unsigned long long,	ret,	calltime)
> +		__field_packed(unsigned long long,	ret,	rettime)

You converted it to a __field_packed() macro. The reason this worked is
because fields within a structure defined by __field_packed() has an
alignment of "1" to pack it.

Thus, your "fix" is simply hiding the real bug, which is that the alignment
algorithm is wrong.

Can you try this patch to see if it fixes the issue for you?

Thanks,

-- Steve

diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..68ef39cf0710 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -88,7 +88,9 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __field_ext
 #define __field_ext(_type, _item, _filter_type) {			\
 	.type = #_type, .name = #_item,					\
-	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.size = sizeof(_type),						\
+	.align = __alignof__(_type) > __alignof__(long) ? __alignof__(long) :\
+		__alignof__(_type),					\
 	is_signed_type(_type), .filter_type = _filter_type },
 
 

