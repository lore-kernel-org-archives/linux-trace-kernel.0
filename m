Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806388;
	b=aL821THzTBGDiROfodYM7fn7fLuZSJJ9qJcfVG9teRGcE1pbIcoeoJCmqSuOUex7YTRy
	 tB7N7CMEjo9ETT+QR1U5xYKTJVgKAnzKtmU4HyDeqwKbr52oL+Cd8ae3OUjfaFhCeWIBI
	 xc1O9mo43rSeX8RVbYUDjl7w0SWDCOaK6vadciJbKgvnO6IrqTws6ey1h5VnUjdkcfiDo
	 58L4VC84MnlYZbqn96jAvK6d1cRyUzt5ICcZajOFcqPCuETJwCXWlIFRKwqigDlBwrIyA
	 3AOYFN7c54OjLI0s5yPDQkhrv9G/AYAPgQkgGNzq+JyiPJGa+XWB/5kjldLHrXy8iUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806388;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=OZxJ0b1DAe2W6h6ON48HJxM4S/YcAq0RnaKf6tiQ/+4=;
	b=jMG7ixXj5E5EnjEWgslTHMeuPc033BrTldRSzW43Z5S6mjw1aufJ1IOxikOnC1D1FrEI
	 0DqRlFdleVIZ2q0JRJMWLVHi9YaCCwhOoqRyUJ1GbPmFNj3vAdFGkCpLCNMDIJNuyX5BO
	 7FDW5NfVQOtM8c5VuooVrENgd73Sm/SusK3RsQTkfPB2VJzImdEeT+Nn0E72t9i49HpOf
	 SSbu5zjhNgEmyV7mXkgnwEZ2QghzBxZ/ob5+kKfzoSOLyX8O/FfjddqgMWyLVRSZY/2Ld
	 S3XzS42ZzAD48wHebOsp+oBpmJ3V10ELQeLh7Xb3aNuIkfGsEWbD5GF3k0XevMqfXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=wOI29Kiy;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F2606A31C;
	Fri, 27 Nov 2026 19:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83F2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=wOI29Kiy
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3CC69120481;
	Fri, 27 Nov 2026 19:06:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 498A92000E;
	Fri, 27 Nov 2026 19:06:18 +0000 (UTC)
Date: Fri, 27 Nov 2026 14:06:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, vmalik@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] tracing/probes: fix race between probe execution and
 event unregistering
Message-ID: <20261127140616.20616c68@gandalf.local.home>
In-Reply-To: <20261126132830.14992-1-atenart@kernel.org>
References: <20261126132830.14992-1-atenart@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 498A92000E
X-Stat-Signature: 9ikrewumikziwyua1dmmkrp6jtz3eagg
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ldCQPsIbSeQQ1USvM9uLvXqCICDktYVI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=OZxJ0b1DAe2W6h6ON48HJxM4S/YcAq0RnaKf6tiQ/+4=; b=wOI29KiyL6CNN3/0Zg7Pww8V1i0J/JdtPJN38W+HIENjF0Cy4qgC/sqdWXvE6LCEK6ihTsTiP6fIOfwNJ/t/DY9mMt9tyVHF5THp1TSn9wx7zzp08/DS0xpmtEnrnSzckw8ddH3Vo1QHs1jAvkNlljslxtAM8CqqRCDJ2xubtG0=
X-HE-Tag: 1795806378-566714
X-HE-Meta: U2FsdGVkX194Uoqr5igP2liRgVSWx9MCgmEg20Cmss2t7mqywcRC4n0W6qeuEvxAM78IYwozHDHmLnMVO6V3GlgFtvEqz0HQ91yJqH7FSIG+bv08dHDHNtJHBIy1vJw6yjBkfQFTnSOyHU1MStJBiXish1cJxlkr7+LAQabHAQ2jpX0WzqtUOaZ1fJsnUL8L/sQOKnzOBvRY/H2IpuKf8Xm2xTG9YDCG5je9S+y/ohSw/vZq7LC1ccLUmojVQS7f/7raIH5xWMihVdBLLSB75HcZgA6uQieDi34f2RBkRmTlIomLxGkACNxFWoy5sNg2VJMOnZ+UoUhWB7SeD4DhQJ3kbQFumnLubDWXt/YCKIgfyfQMhQrWV+6AJkN56IGf

On Thu, 26 Nov 2026 14:28:30 +0100
Antoine Tenart <atenart@kernel.org> wrote:

> 
> Hi,
> 
> I found this while debugging another (downstream) issue, reusing the
> same reproducer on mainline. The reproducer registers/enables and
> disables/unregisters a kretprobe on a syscall in a loop while triggering
> it (I can share if you're interested). It should work with other probe
> types.
> 
> I'm not versed into the tracing subsystem so I went the safe way and
> reverted back to the previous behaviour. There might be something more
> clever to do.

I would hate having to put back the inline synchronize_rcu() as that has
noticeable impact on removing kprobes.


> 
> Thanks!
> Antoine
> 
>  kernel/trace/trace_probe.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cff55dcae36f..8addaf641431 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2841,7 +2841,13 @@ int trace_probe_remove_file(struct trace_probe *tp,
>  		return -ENOENT;
>  
>  	list_del_rcu(&link->list);
> -	kvfree_rcu_mightsleep(link);
> +
> +	/*
> +	 * Synchronize with probes being executed. This is not only for freeing
> +	 * link but also for related objects (e.g. link->file).
> +	 */
> +	synchronize_rcu();
> +	kvfree(link);
>  
>  	if (list_empty(&tp->event->files))
>  		trace_probe_clear_flag(tp, TP_FLAG_TRACE);

Would something like this work? I haven't fully tested it though:

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cff55dcae36f..c249256dea80 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2812,6 +2812,7 @@ int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
 		return -ENOMEM;
 
 	link->file = file;
+	event_file_get(file);
 	INIT_LIST_HEAD(&link->list);
 	list_add_tail_rcu(&link->list, &tp->event->files);
 	trace_probe_set_flag(tp, TP_FLAG_TRACE);
@@ -2831,6 +2832,14 @@ struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 	return NULL;
 }
 
+static void free_link_rcu(struct rcu_head *rcu)
+{
+	struct event_file_link *link = container_of(rcu, struct event_file_link, rcu);
+
+	event_file_put(link->file);
+	kvfree(link);
+}
+
 int trace_probe_remove_file(struct trace_probe *tp,
 			    struct trace_event_file *file)
 {
@@ -2841,7 +2850,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu_mightsleep(link);
+	call_rcu(&link->rcu, free_link_rcu);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index d1fb3520700f..aecc9f24951d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -281,6 +281,7 @@ struct trace_probe {
 struct event_file_link {
 	struct trace_event_file		*file;
 	struct list_head		list;
+	struct rcu_head			rcu;
 };
 
 static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)

-- Steve
