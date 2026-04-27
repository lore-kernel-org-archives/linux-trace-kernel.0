Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80943329C48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302725; cv=none; b=tP+HDd9KOjGdv5zMBZp8GZGNkwXp4vAJH++uwZ0mY31BHwf1h0K87pF1cp6+pXYrYvEF48XY5XQgoNIY5fx63m2C8QmVo7UpZV4VQiDkz2bx9vC2Sq1Bnr1pk0PJ/cZdmiP3Rq+eCW5SwPUuCIrG+2MeF2mWURjnzOQhDm8yY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302725; c=relaxed/simple;
	bh=EwuoDjuH2L2AHR/liN5WQQiaFdedpKkY0KAZL5ARV5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DOUZdod9xj1EhRsgA29MuwzwhJIamr6WJ4ClCf+3SOe887xtqnHsPoyWV3ziyTx4ejgeeeABvpSoW04UCTXdKjo4k4vB+xlfOXBBf45s3rmQeZU9hnLAUeBk/hnhpghWyuhb24YO8ii/5iXL1GxyGB1XdLZ0q2HAnnctOKh+kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCX908ai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCX908ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmBNXsdb7Q8XvflqmKh8X5KCTV2PWqisH1cnCugKrPM=;
	b=JCX908aiyZTeNtiYCvygE3YuOxjxiTmRw8NfFStZLt2ASyM139L+fwdynpkIyjQe+VVk7y
	2WxdBwmjmw96zlBzUSbmA/6sodLFvEAdvoaagP4OiDCDetVkxApsEhHlU9UCO3SyS8OoEj
	2oLiK+ktI9nKaVYDVgxBifAWH5HM0Kg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-iPKg-v43MFesykaZQDkQ_g-1; Mon,
 27 Apr 2026 11:11:59 -0400
X-MC-Unique: iPKg-v43MFesykaZQDkQ_g-1
X-Mimecast-MFC-AGG-ID: iPKg-v43MFesykaZQDkQ_g_1777302718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11528195608D;
	Mon, 27 Apr 2026 15:11:58 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56FE6196B8FB;
	Mon, 27 Apr 2026 15:11:55 +0000 (UTC)
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
Subject: [RFC PATCH 02/12] tools/rv: Fix substring match when listing container monitors
Date: Mon, 27 Apr 2026 17:11:24 +0200
Message-ID: <20260427151134.192971-3-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Vprcziui8uef9cqDSgJ1TXDnbEl7xk7XDyksltERjmo_1777302718
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When listing monitors within a specific container (rv list <container>),
the tool incorrectly matched monitors if the requested container name
was only a prefix of the actual container (e.g., 'rv list sche' would
incorrectly list monitors from 'sched:').

Fix this by ensuring the container name is an exact match and is
immediately followed by the ':' separator.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index a200b63f4509..95adae321c11 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -193,8 +193,12 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *co
 	nested_name = strstr(name, ":");
 	if (nested_name) {
 		/* it belongs in container if it starts with "container:" */
-		if (container && strstr(name, container) != name)
-			return 1;
+		if (container) {
+			int len = strlen(container);
+
+			if (strncmp(name, container, len) || name[len] != ':')
+				return 1;
+		}
 		*nested_name = '/';
 		++nested_name;
 		ikm->nested = 1;
-- 
2.53.0

