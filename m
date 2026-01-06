Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC81342148
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707009; cv=none; b=bCMdc07yf8V8hnTsU8N6g4fXn5h0T2/JeoYEL6dC3c6oxBWH/whfdCfoewL0hbiLC+FouJSL7/fLmKAHo9gnLPMzVYUAr8NJQa8v3uKPCj4Gb8MF2/5nEkPVfJGBfcch4Ty0v/HD1HsRyFyHoGQGCSFHEqvaVaxySRcyEN+Ujvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707009; c=relaxed/simple;
	bh=32UhQmIuVg7RFlQt1JWZY3VmEmTIMShoXJksn4Mgi48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwBRHB5jQFTsamZE57p5QoAcyfyeI+ppeI/2+hwD1kfX9pZxMfknUihGe7CA41UBD/6N6Do7HnDWtbH+4oMqo+mVO6Og7e628hsJfCIcAVdCgVlm9E+s8eSuYPDTj7UXfcIZk9omAwSilOQzagsepy2MZ3rvRLc4rQAhWLjuc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T24eX0CF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T24eX0CF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLArHPeP1sDYwq27BLpCMkE5lpVuL1KHGveKa/KTPcs=;
	b=T24eX0CFyAYYI1ZtPF+xaKy/PvXUi5RYTzuVFyArwNBA275SuHSVw6BahkrwZgn7Qaj3aC
	jfbuj/NDjA60/icVGOptvP7QibsPmQkigF7qidpOWN7BuUnjK7wNyp9Amvju/54KNHZYYZ
	ey97YBLk+WHYtD3DP2N/d/bsbtdLPds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-UZ2tysFYMMG8f5pf0ytBog-1; Tue,
 06 Jan 2026 08:43:25 -0500
X-MC-Unique: UZ2tysFYMMG8f5pf0ytBog-1
X-Mimecast-MFC-AGG-ID: UZ2tysFYMMG8f5pf0ytBog_1767707004
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D678019560A1;
	Tue,  6 Jan 2026 13:43:23 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 427151800666;
	Tue,  6 Jan 2026 13:43:19 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 09/18] rtla: Remove redundant memset after calloc
Date: Tue,  6 Jan 2026 08:49:45 -0300
Message-ID: <20260106133655.249887-10-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions struct is allocated using calloc, which already returns
zeroed memory. The subsequent memset call to zero the 'present' member
is therefore redundant.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index b50bf9f9adf28..00bbc94dec1bd 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -19,8 +19,6 @@ actions_init(struct actions *self)
 	self->len = 0;
 	self->continue_flag = false;
 
-	memset(&self->present, 0, sizeof(self->present));
-
 	/* This has to be set by the user */
 	self->trace_output_inst = NULL;
 }
-- 
2.52.0

