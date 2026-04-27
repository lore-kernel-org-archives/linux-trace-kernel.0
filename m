Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC432F764
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302733; cv=none; b=ck9hUVmJBu74fNaYgI1QNoLJ8/w+6Tz43aaY95Np3u2hUiOd2WjEHRaJKhG0+S/A5JBZjLZoKgRPsznsuZ6T/XyRsJr9IgV1/9JN1rxma9Tz909BKpFW+Ut4jT3oqYNJmVYGvQnT4MeNhxEnPF53rwFiBgLd73snCR66jELmjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302733; c=relaxed/simple;
	bh=yanRkr1omWUe7+Y8ve0695lEjPkzp32wA58du4C99I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AgwCgFbgjxvP7rWk1SHF7GN+eAIzs7VhkR1G7WVqtn19yOmo+KAAF9C9MB60klSdVnA6xbCgjvD1UMnxbHGU4LeE6HiZfBlGE1I9+Q2cEl3a8wFMd69qxxMbY8OADyVFa/f6AVnbLWb1by+OXllHZkb06gA0PhRDrlv+60M7+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFS+EnOY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFS+EnOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2CkjPQ41NgjD2YBLAZEQz/znIbuYPYXd0FmuIaxcQE=;
	b=VFS+EnOY91ZshD3wvDfXJ51O/jMf8CVPbmylO2VJB9P/ORlWa6iXe8uqs5E4Y67rE97ciK
	WKeA+q2Z6kIi+u8pFUO0x06JIZGzeW67s7fBHGxoGQeGKA+UwUfMkGlKB6DCTe3EBuVTf4
	0Sx9sPNgOzkplrs8S1Bbto8FRPdO4LQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-3Ogq1sXDMUqyyvQSGPzLkA-1; Mon,
 27 Apr 2026 11:12:07 -0400
X-MC-Unique: 3Ogq1sXDMUqyyvQSGPzLkA-1
X-Mimecast-MFC-AGG-ID: 3Ogq1sXDMUqyyvQSGPzLkA_1777302726
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A87219560B7;
	Mon, 27 Apr 2026 15:12:06 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9366195608E;
	Mon, 27 Apr 2026 15:12:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 04/12] tools/rv: Fix cleanup after failed trace setup
Date: Mon, 27 Apr 2026 17:11:26 +0200
Message-ID: <20260427151134.192971-5-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: s4dXlHcAo9NZtAyctppFTwz107A271DkPW9qLfqlKNE_1777302726
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently if ikm_setup_trace_instance() fails, the tool returns without
any cleanup, if rv was called with both -t and -r, this means the
reactor is not going to be cleared.

Jump to the cleanup label to restore the reactor if necessary.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 95adae321c11..131a6787d639 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -809,7 +809,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	if (config_trace) {
 		inst = ikm_setup_trace_instance(nested_name);
 		if (!inst)
-			return -1;
+			goto out_free_instance;
 	}
 
 	retval = ikm_enable(full_name);
-- 
2.53.0

