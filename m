Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BC413224
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086259; cv=none; b=sHuoP/JUA8q7Y6F3zxvAYA6t7CGHWn1LG3n+p4aZgUNC+JVUZMv0cShB6SlGlZ+bU/H9JnsvRgpPxF1omR9/Sp4eM81UE4dOZ7b59WQNg/YLPQoRz0kUXSl/f8ZyLOyS8NmGxLENIf9k8xoTzOXCybW/22HpLJGTAL/qhl1MqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086259; c=relaxed/simple;
	bh=8TFHIE5dNF7Z28ZUMjjGUnP63BDq64UYTQHL6hzQnKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=c4SlMTnwbkVN+BnkfSb0mg6bXnhTuXVY2E+u+lsFL7RPqcJqs6KCPbis1RC+I1jRVRGfAMNApa951wNNAprUkTFdct7Pv40NqUCkd6ziOzzz4/nYI/ieVy3lvg+kx7ptYPQUZxxKYg8ffwDtNOPJhp5Wq8S2n7fXMIlQlFAkc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VscFrZ4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VscFrZ4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Il3Krob+nGyCDOWEKlqe2ZH6ODKvfSQlcgWeOunjik=;
	b=VscFrZ4USXaJevUvd4q1a70whLTj+CaOMPb5MGWKTu+bBDXYI/dI7u2KSoG3W+RH35W/5c
	+6ZAwBlRej6WJKUPaUHhxYWNyxmdkhDFIN7nQROioLnTBZXX9pQ6VfoGMExjvHZkfswfTE
	6aCRCgtcfbvQC8+HtwKrhXoupqTXGx4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-s36_sr11PoGm6MWiKCfvmg-1; Mon,
 09 Mar 2026 15:57:34 -0400
X-MC-Unique: s36_sr11PoGm6MWiKCfvmg-1
X-Mimecast-MFC-AGG-ID: s36_sr11PoGm6MWiKCfvmg_1773086253
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F7E1195605F;
	Mon,  9 Mar 2026 19:57:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C8A30001A2;
	Mon,  9 Mar 2026 19:57:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 08/18] rtla/timerlat: Add bounds check for softirq vector
Date: Mon,  9 Mar 2026 16:46:21 -0300
Message-ID: <20260309195040.1019085-9-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 2puoO6VxA8H-bY4Hp5Co-be2pm5yDOHHGSTLFxmecZ0_1773086253
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add bounds checking when accessing the softirq_name array using the
vector value from kernel trace data. The vector field from the
osnoise:softirq_noise event is used directly as an array index without
validation, which could cause an out-of-bounds read if the kernel
provides an unexpected vector value.

The softirq_name array contains 10 elements corresponding to the
standard Linux softirq vectors. While the kernel should only provide
valid vector values in the range 0-9, defensive programming requires
validating untrusted input before using it as an array index. If an
out-of-range vector is encountered, display the word UNKNOWN instead
of attempting to read beyond the array bounds.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 30ef56d644f9c..bc421637cc19b 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -417,8 +417,8 @@ static int timerlat_aa_softirq_handler(struct trace_seq *s, struct tep_record *r
 	taa_data->thread_softirq_sum += duration;
 
 	trace_seq_printf(taa_data->softirqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
-			 softirq_name[vector], vector,
-			 24, spaces,
+			 vector < ARRAY_SIZE(softirq_name) ? softirq_name[vector] : "UNKNOWN",
+			 vector, 24, spaces,
 			 ns_to_usf(duration));
 	return 0;
 }
-- 
2.53.0

