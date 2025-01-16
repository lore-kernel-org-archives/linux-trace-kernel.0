Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EC236ECF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039015; cv=none; b=hDE27PgKPvAa0QE1E7wLt6jSSHLl+Al/UIT2SMMeL99mu9bTzF7DNE+BOqxkYodYPZhDJ/+vQjvrskzHuZ2tYm6+b8mugTyWz8jgxKCY8elNSB14nPxKHvYWt3enppOjvXpdIKBqf+OumpsJyMbZbSQeckxqzwbwHfhopMiS16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039015; c=relaxed/simple;
	bh=ZA0uznOxxOkReK0eBx1x1YFyXkxnbMJp2BWmAkgSaH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao+0liYGpMxoqTeMwahfTGEpByGz+DjOxr9IFjNEHFaVA7TsWO3Ge10lhFQsehLsUt/PLuUbnnZDHX4o4o8Ro97Yg9g8h3IMEknNUiDvK9Ilp2GfdcY400QIdXa813fMobMkyDuaWFZg+eBli1JNWaDJ6q3o6iZ50jXV/QVIKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PifGchPN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PifGchPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljB/jTPeegmqKMNR9/yFI/zpZzn2PMwEe4k+JPxJfXk=;
	b=PifGchPNS8Eb0wDQn3SEgxdk0ZpEJTfqvhODX7q9Ue4q7Ds4WPfE81Is5m5Tsn/SOvbSyf
	dR4idVZReRIcPc7o3NFF0A8IfNzaWkoimFs2VSCCpqM72r+3mSKgOniu+qCAXgyGBWLSCV
	VFUsSFfhQc7UzM75yk9JpPuXpZvbJ6A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-snPktqXaNYGPrE2floSaGw-1; Thu,
 16 Jan 2025 09:50:08 -0500
X-MC-Unique: snPktqXaNYGPrE2floSaGw-1
X-Mimecast-MFC-AGG-ID: snPktqXaNYGPrE2floSaGw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DF351955F67;
	Thu, 16 Jan 2025 14:50:07 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 234E319560BF;
	Thu, 16 Jan 2025 14:50:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/5] rtla/timerlat_top: Abort event processing on second signal
Date: Thu, 16 Jan 2025 15:49:31 +0100
Message-ID: <20250116144931.649593-6-tglozar@redhat.com>
In-Reply-To: <20250116144931.649593-1-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Apply the changes from the previous patch also to timerlat-top.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d21a21053917..d358cd39f360 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -903,6 +903,14 @@ static int stop_tracing;
 static struct trace_instance *top_inst = NULL;
 static void stop_top(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(top_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 	if (top_inst)
 		trace_instance_stop(top_inst);
-- 
2.47.1

