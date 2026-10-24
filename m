Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855083;
	b=cqvIQcUmiOYNX9Nheg9v4LrQRy+ue8GD5ZZvVEt8ztA2ESEn2p+6q0wH5rlWj/VCtEsC
	 i1TQCQ1hPGlp0Nz8fXl+vZPLYalRd2yCs6yy0DGLvPdY6q+7JlcAfYf7/Wbj1q7sQDIxJ
	 d7krPAa57izLgqBOP3Vrpwb1McSXre21bsEQSZV87pw0YKpdkzQ6HziUv8kbr+YldgW0l
	 lz+i5TDFiyNpqOZT0to5R9FOv3o1l3kOEzcasH+7xCZehUI46e/SMhPG9zwWTHB0EqMGS
	 Ebc7DOcbiGHD898MLmfIOOZE/16Q6K5uD5RMKf9QnnCbqZGtgh5xPzrLLVvEXwIst3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855083;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=FFBc7sAZT89TLlAdtb/PifRoSe8BnNHwA0EhAG89FeQ=;
	b=QtQPDnFFc7SsdO5MZv242/Uv0xjIfUgndh0EXjT7Mt26gCrfrKbDQ1HOeE64drmaD8td
	 skKZAmOvytMTsMTtsF9PwBH3emyTalbNzGuNFjH0tC4wmIQx/AmzGGJhooA3L9QNt9jzc
	 FLEx/yUcKjsVh4a8Obb2j4AXx9P3REL0qnHNWiwxTwu0vgLODZn9Auv8brdRlEhFJtPoM
	 Nau1kS4oHh85Gkomvlfsrm9ERvY2eNaOHzx45LFkxYEVfpk5Qy55io2H/syEEL7PE4Xkp
	 RKUS/KUVn1A1uWkwSH2f7wSCL/wuBsa9i6iBHSoNR/DnXjL6hO1g5OIC9n/L2AKsOog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="GMcLN/iF";
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5A606A31A;
	Sat, 24 Oct 2026 15:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=GMcLN/iF
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4C1A8160425;
	Sat, 24 Oct 2026 15:18:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 72C736000A;
	Sat, 24 Oct 2026 15:17:59 +0000 (UTC)
Date: Sat, 24 Oct 2026 11:17:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: trigger filter use-after-free in
 set_trigger_filter() ENOMEM path
Message-ID: <20261024111756.14a393ac@fedora>
In-Reply-To: <tencent_51CD3420AAC8A722EA2FD5FEFB6524D4A905@qq.com>
References: <tencent_51CD3420AAC8A722EA2FD5FEFB6524D4A905@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 72C736000A
X-Stat-Signature: 3rhrjhr117dfn7ztage4iwijjcaun5qa
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+t5tM3VmUu6Ah5SnRaSk/Nd4i7D2EA+lI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FFBc7sAZT89TLlAdtb/PifRoSe8BnNHwA0EhAG89FeQ=; b=GMcLN/iFd4+lKnEyemdZByvEiMKlyE9vk0QgGvSeEn0OB+6b5a9DGNs3nGqd9ete7GztBttU32SQan3DI002DafwZul6Bnu+Zq5Fe3KO93UL3U3DoxB7ohg8EJMgIgNI8+KKOGRKd34z3JhlabnIewc7bsmoLBVu8Iw0JRElPaQ=
X-HE-Tag: 1792855079-985549
X-HE-Meta: U2FsdGVkX18wFkgskoivpNdycLjtFJ410q1WfoZfwxhO2tQ4A2sCOyNvhjqw/D/6qaT7CThd6/eyXIv1STZho0JqRJWejx21Nl3uDetSIBas/sJuM/wGbM5Yt5hgs0pcqMnR9UaZErWSlMfKRSzP59fImmmqbYvZj5thiFoTfVgFVRFvOAsVepACpfBE8koEOLIe6tMCfCzU2+01jaAR1A1FiACMSrkFZpBm34Cv3IbiTsICSydTkddCfUvt3EdKc9FGCmvGwgQ/ah+LkDfFIgGhSz5RBvFKncMk0jhQwenwOPXtTGTYTChOTv8nSAFY/vlNyT1Zb8MqvSfmqG3j3Pg0TrKwMHcH

On Sat, 24 Oct 2026 22:48:16 +0800
Guikun Yang <yangguikun19@qq.com> wrote:

> Fix: either free the new filter before publishing (i.e., don't
> rcu_assign_pointer until the filter_str copy succeeded), or perform
> tracepoint_synchronize_unregister() before free_event_filter() in the
> ENOMEM path, mirroring the normal path.  The first variant is
> cheaper: move the kstrdup above the "assign:" label and release the
> pointer only after the string copy succeeded.

Note, the entire trigger code needs a rewrite. Something I'm looking at
doing when I get time.

This is a bug but one that would be very hard to hit as it would
require and admin to enable a trigger with a filter during major memory
pressure.

That said, the simplest fix is to simply copy the filter_str at near
the start and use that.

That is, something like this (not even compiled tested):

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4d2fde996c0f..1a6ea4261066 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1195,6 +1195,7 @@ int set_trigger_filter(char *filter_str,
 {
 	struct event_trigger_data *data = trigger_data;
 	struct event_filter *filter = NULL, *tmp;
+	char *str __free(kfree) = NULL;
 	int ret = -EINVAL;
 	char *s;
 
@@ -1209,9 +1210,13 @@ int set_trigger_filter(char *filter_str,
 	if (!filter_str)
 		return ret;
 
+	str = kstrdup(filter_str, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->tr, file->event_call,
-				  filter_str, true, &filter);
+				  str, true, &filter);
 
 	/* Only enabled set_str for error handling */
 	if (filter) {
@@ -1243,14 +1248,9 @@ int set_trigger_filter(char *filter_str,
 	kfree(data->filter_str);
 	data->filter_str = NULL;
 
-	if (filter_str) {
-		data->filter_str = kstrdup(filter_str, GFP_KERNEL);
-		if (!data->filter_str) {
-			free_event_filter(rcu_access_pointer(data->filter));
-			data->filter = NULL;
-			ret = -ENOMEM;
-		}
-	}
+	if (str)
+		data->filter_str = no_free_ptr(str);
+
 	return ret;
 }
 


