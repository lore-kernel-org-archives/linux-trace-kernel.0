Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE337BB18
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712458; cv=none; b=JgNQ6lgNwHN8a9Mwvytekz6EiQwVFMHmZZPRyarb/qJ2yxjV5yruEC9u4B8/pm9bFWSxRfFrbDHuvgSGW5USZbHGWdQKPMwlCwaiy0rhx1pokuLpzVLOmZZAmCbF55rjJ3AjBP43byjFX29qE5EfZGg+EHiOZc9Cn3zNXzi8JyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712458; c=relaxed/simple;
	bh=ySM2AhjBwiFMKm5SSHzZAepFTB8Y97qFHJbr52FPVW4=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=czOdTHd0nxci1wNxMYr47Ice+lJhoczdOOSIt0rhCDbGgiODcMhYl6+6IlbNIAJgi4TlfcbgQ7pJctxnVWuJMNxFM0/JsxD3DGvnWt4AhikTe6zCZB8j7m738/YTeAgK70iz+6p7N2i+hoYVE0dOMFR1uQtMN3MiYF/NFZMjGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcW2Ue1G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcW2Ue1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706712455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=C4Pv2mgbeXULSv+emhsFpm5NaJgAa5E9O33+c02m7J4=;
	b=QcW2Ue1Gs0zmBR96gT/G7HaKFvqhrpjM8sFAEe0Rq4Sm9wZNXs+bPJFCsV7a+b9HLAXwc1
	zN8tFl6UooJR5l8oCzSBIZLdfLteVLdDB3QN8ROsXMZmP9NscXYaRerWOnLVJCDFCtv1VE
	U3lhs+16ZKkvljiP34LfPTBSSVAgJlc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-bWYbft9NO4KELHmx-ah4bw-1; Wed,
 31 Jan 2024 09:47:32 -0500
X-MC-Unique: bWYbft9NO4KELHmx-ah4bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 391233811809;
	Wed, 31 Jan 2024 14:47:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8DF31C060AF;
	Wed, 31 Jan 2024 14:47:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: dhowells@redhat.com, linux-trace-kernel@vger.kernel.org
Subject: How to display a ktime value as trace timestamp in trace output?
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jan 2024 14:47:31 +0000
Message-ID: <2217765.1706712451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2217764.1706712451.1@warthog.procyon.org.uk>

Hi Steven,

I have a tracepoint in AF_RXRPC that displays information about a timeout I'm
going to set.  I have the timeout in a ktime_t as an absolute time.  Is there
a way to display this in the trace output such that it looks like a trace
timestamp and can be (roughly) correlated with the displayed timestamps?

I tried subtracting ktime_get_read() - ktime_get_boottime() from it and
displaying the result, but it looked about one and a bit seconds out from the
trace timestamp.

Thanks,
David

