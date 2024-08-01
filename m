Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E8189B98
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518811; cv=none; b=f7E2I5hvh/QkjAETriFK291Z6V07QOu9hXaFAAXmXfRBfiVYwqJ29AbSgBGWRfNZOpAwYhU2pDlQz6FS0aRGlYB751k2ht9gbOhIvaHHmU49lBoVN+jid22dyHehRjQNJ1zi7yhBTPM/4m1GUqduC3JQam/CdGOHDRVEaLTxjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518811; c=relaxed/simple;
	bh=hWsYFooRQcoP2Bz07kAvGISR9ZLpTUwI4zwlWdXj3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nN8fVAfwM7dlmEXdpmfqEIKWfwfYXQdnkVQFChnN3w/64nkmMz4iO+JXYaj3l78f3ILeZe25Vsi4shThdSII1fz+VXNiwBeCSWx2gT2MgjvlD7SRj08iLVm+X2xH2lwn/2hUfiIZfiswr3qx39dcmFDMBJzUrpOxDIakPUbgxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZydPFnFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZydPFnFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yfCti4AmwEcsX6LuFMa3GXv/+hDYeVMmSmtqgkUuKSQ=;
	b=ZydPFnFNeTJKa42DSa3CqArg/M0c+dD970zbPPu1a2MNEv9G16LZmilegNcBJndR8Yq4tB
	duvJyFHvpESQSR2cGZzc+t1+IgeExYzg+TrXRsVitutCrZ/38C9xCsk7EakcJEj/MOHKfC
	0IZPJLA1E2AqxNzRRcfEofl7LL1ZFzI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-gaOQMd0MPGei-zTuwwtcBg-1; Thu,
 01 Aug 2024 09:26:45 -0400
X-MC-Unique: gaOQMd0MPGei-zTuwwtcBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659BD1955D61;
	Thu,  1 Aug 2024 13:26:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5BAC519560AE;
	Thu,  1 Aug 2024 13:26:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:26:43 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:26:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
Message-ID: <20240801132638.GA8759@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

(Andrii, I'll try to look at your new series on Weekend).

Changes:

	- added the acks I got from Andrii, Masami, and Jiri
	- new 4/9 patch from Jiri, fixes the unrelated bug in bpf_testmod
	- adapt tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
	  to the API changes in 5/9 an 6/9

see the interdiff below.

Oleg.
---

 include/linux/uprobes.h                            |  22 ++--
 kernel/events/uprobes.c                            | 137 +++++++++------------
 kernel/trace/bpf_trace.c                           |  25 ++--
 kernel/trace/trace_uprobe.c                        |  31 ++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  26 ++--
 5 files changed, 103 insertions(+), 138 deletions(-)

-------------------------------------------------------------------------------

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 
 struct testmod_uprobe {
 	struct path path;
-	loff_t offset;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		return -EBUSY;
 
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		goto out;
 
 	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
-	if (err)
+	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
+					offset, 0, &uprobe.consumer);
+	if (IS_ERR(uprobe.uprobe)) {
+		err = PTR_ERR(uprobe.uprobe);
 		path_put(&uprobe.path);
-	else
-		uprobe.offset = offset;
-
+		uprobe.uprobe = NULL;
+	}
 out:
 	mutex_unlock(&testmod_uprobe_mutex);
 	return err;
@@ -474,10 +474,10 @@ static void testmod_unregister_uprobe(void)
 {
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset) {
-		uprobe_unregister(d_real_inode(uprobe.path.dentry),
-				  uprobe.offset, &uprobe.consumer);
-		uprobe.offset = 0;
+	if (uprobe.uprobe) {
+		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		path_put(&uprobe.path);
+		uprobe.uprobe = NULL;
 	}
 
 	mutex_unlock(&testmod_uprobe_mutex);

