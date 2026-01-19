Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19931A7F1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823597; cv=none; b=h4KasTVmac47QF4yQAOBcEAPbk8QdHMLZHzF+nONyGis/uhak9HlVzxBAmvXDakkrPVnfVO1Gn9XsyoD6gu7DUO5EDT+hZj5If8FSh2SwwldyhwQ91GVVr/nsxXpOwXVf78BzPHdeo3HSzYCZ/XTnmv0sjswz4cRU3eFht7WfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823597; c=relaxed/simple;
	bh=gC65FxK9WWl1nQ/sKxvKlK5+RVzXQ5pfIjStGWAvioY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDuCiOU0i8v0wib+vOhgctwdTazp3CzbwzfCRNcdW3qGGso4+qit0Hxw4mQIYQaY2bQPqEvRTYfiLSy9XM06bGCcZNIfQX9o1Ykq+i2a4WCv/qZia/7FIgokE7AXX7Hl8wo6DZw7AVI8SMrQJWwNsaWGJm/99rJqpIjZvhk1ND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c00F02bk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c00F02bk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768823590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/wnRNcAtAIQ+j4MbSBlGTDH6BBM59lMxBXdgJ1fkH4=;
	b=c00F02bkwU95r3FOK6MQ6e77rPrzyCVXDkkYS9K1q/UNBTuyfCTyeVUzEYy1yctfKVYwPA
	BYF1VClBk0HtvZbxBb+mfdMOThcBFZuNc0yBNi34L7xjOeQHjMXMDfMHnq7uAdWvZHtULP
	p3SiHkB8QZ2sCxnv4NifuakvpBHKLck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-AWQ30-RJOjie9g0dm7x3bA-1; Mon,
 19 Jan 2026 06:53:09 -0500
X-MC-Unique: AWQ30-RJOjie9g0dm7x3bA-1
X-Mimecast-MFC-AGG-ID: AWQ30-RJOjie9g0dm7x3bA_1768823588
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A91F18AB416;
	Mon, 19 Jan 2026 11:52:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1018130001A7;
	Mon, 19 Jan 2026 11:52:53 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Documentation/rtla: Document --stack-format option
Date: Mon, 19 Jan 2026 12:52:22 +0100
Message-ID: <20260119115222.744150-2-tglozar@redhat.com>
In-Reply-To: <20260119115222.744150-1-tglozar@redhat.com>
References: <20260119115222.744150-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add documentation for --stack-format option of rtla-timerlat into its
common options.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index 07a285fcf7cf..ab159b2cbfe7 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -83,3 +83,15 @@
 
         **Note**: BPF actions require BPF support to be available. If BPF is not available
         or disabled, the tool falls back to tracefs mode and BPF actions are not supported.
+
+**--stack-format** *format*
+
+        Adjust the format of the stack trace printed during auto-analysis.
+
+        The supported values for *format* are:
+
+        * **truncate**    Print the stack trace up to the first unknown address (default).
+        * **skip**        Skip unknown addresses.
+        * **full**        Print the entire stack trace, including unknown addresses.
+
+        For unknown addresses, the raw pointer is printed.
-- 
2.52.0

