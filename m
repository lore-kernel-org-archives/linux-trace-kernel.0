Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BE14EC60
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260731; cv=none; b=l6LjQCd+qjVO65nfdkjXW52BklG3Ryauk2m+ZY/DDWNJRdHhMZ0VBGpoSb0Vv2dIo22IyCSQ3hd+f8rhsHWuHv0zP6Tpna2ak2JKtQTDXB1quY0qUJtPKeclEWi6EA2dZr6EcF31WyRPrd1aozjZW81ElVje7gGxLjtlUdZ/L+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260731; c=relaxed/simple;
	bh=X9sVerEKt1nc4tLYSxrNubeU7Sl3l5tWPX0PaqpOl08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uq+a4QdNLgzM942Xj+/yALf4BzsMqiWTxXyD3P1lCytEG31Jtr/X6+1DcRNRV1I+TWqEIhiNCZZdDHM1M9ap+Hg1hm1CKqAr99lMNvaKTHd0HOr5qPnqmtQo5XkGrkmIwLDf9u9kELZ0YdTxB4EAOMENguHq98QLC9etPBiAiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+UlCTgG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+UlCTgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722260729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UC5k8OWRnrWIz59qmM+Ye9mbOt6cZoUGhOumaByMXUM=;
	b=Q+UlCTgGntwfmZ/OOfpUHl9FKDst+W8axW6c55QHo7K8xbpgUsiDD2GX8JVU6D6aKs7RM7
	WTEJSoEFSpTnZLn8GF7yXulfmC7W7NcOytdGeaVVivwD6NvUK2Au7KWcHFytupU15u6ciy
	nj9xgtlrk/CB3Z+v8BqHQ6wHxzJX+qU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-A3_kniPaNqWixaxdn89sIw-1; Mon,
 29 Jul 2024 09:45:25 -0400
X-MC-Unique: A3_kniPaNqWixaxdn89sIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1ED1944A84;
	Mon, 29 Jul 2024 13:45:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5B4D61955E89;
	Mon, 29 Jul 2024 13:45:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 15:45:24 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:45:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] uprobes: is_trap_at_addr: don't use
 get_user_pages_remote()
Message-ID: <20240729134519.GA12312@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134444.GA12293@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

get_user_pages_remote() and the comment above it make no sense.

There is no task_struct passed into get_user_pages_remote() anymore, and
nowadays mm_account_fault() increments the current->min/maj_flt counters
regardless of FAULT_FLAG_REMOTE.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73dd12b09a7b..eb71428691bb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2035,13 +2035,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (likely(result == 0))
 		goto out;
 
-	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
-	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
+	result = get_user_pages(vaddr, 1, FOLL_FORCE, &page);
 	if (result < 0)
 		return result;
 
-- 
2.25.1.362.g51ebf55

