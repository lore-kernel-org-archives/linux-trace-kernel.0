Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CC19E804
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756364; cv=none; b=P7DA/E0kz+Ik/L1r3GxJkD+Oicmq/2dMT1iICPIRVYZSV/KnpIGQQmAoiqK+YmNzuRtaRmSv1xFhEXpp36UDM5a0ISsIbrHNFTZuKA3iA3nBch5DZ0TZNJ0NlcE+uodjfMyWNUB3ei8rmp8PUTuYsnyj9Rxmlb4dlCDq22tQMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756364; c=relaxed/simple;
	bh=55w/VlvPRY6e7SnqUOleIYymHuuR1CoCZShX5ta66N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9KALyPEm+rXy5yxBGFqUwNt3vNnwq008JRk8unUWtWllf+vUtQFbqJiJnk+bjl2DDSRB0IQgvq99f1pXydKA1z2HKQOMuMTrTzaqMBkYSchRJRkFmz4+vkFkXWz+OxWBIlPPOn5eQVFH8IQlmV0FcpYzj7OPN+za+0if+TR9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlrqP44F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlrqP44F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743756360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzpx/ks+8dU83bQ2k/Wg2tkl4O8ewZUp90aomwDKfgQ=;
	b=KlrqP44FunuBOFsV0sOKO4T2JJL+9GY+IGQFOPb/XpAP3QE4ETG3VOIhp1J7LqUHI4dcvi
	qvCD+L0NESkyd2MFO2aQINKgrt5tMy61ioTkXN623J7RTdI5dH/s5FwBCMbZ4NNzmw47UN
	WI2i49Bj4+Wiyz8C1wCUhbuRAqRfE6E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-6ulgx4waO4Ct2kLNXvwf3A-1; Fri,
 04 Apr 2025 04:45:59 -0400
X-MC-Unique: 6ulgx4waO4Ct2kLNXvwf3A-1
X-Mimecast-MFC-AGG-ID: 6ulgx4waO4Ct2kLNXvwf3A_1743756358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FDFD180AB19;
	Fri,  4 Apr 2025 08:45:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C86E3180B487;
	Fri,  4 Apr 2025 08:45:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH 1/9] tools/rv: Do not skip idle in trace
Date: Fri,  4 Apr 2025 10:45:14 +0200
Message-ID: <20250404084512.98552-12-gmonaco@redhat.com>
In-Reply-To: <20250404084512.98552-11-gmonaco@redhat.com>
References: <20250404084512.98552-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently, the userspace RV tool skips trace events triggered by the RV
tool itself, this can be changed by passing the parameter -s, which sets
the variable config_my_pid to 0 (instead of the tool's PID).
The current condition for per-task monitors (config_has_id) does not
check that config_my_pid isn't 0 to skip. In case we pass -s, we show
events triggered by RV but don't show those triggered by idle (PID 0).

Fix the condition to account this scenario.

Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index c0dcee795c0de..72b03bae021cd 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
-	if (config_has_id && (config_my_pid == id))
+	if (config_my_pid && config_has_id && (config_my_pid == id))
 		return 0;
 	else if (config_my_pid && (config_my_pid == pid))
 		return 0;
-- 
2.49.0

