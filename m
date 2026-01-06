Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29373128A3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707192; cv=none; b=VPBtiwxkSj1pHaOZsLHW9mfuNmcNL8PORSb9xUgNIDQASugYS0d/WHqijiJxpnmTeceh8IB4MvCj1MR6nmoz2H6y98JsGwjz8Ie7QfueKI+Do47iGi4fDEnIv6BFOjoANv0KXJPrcB+AL3mvZRILV9n4Qn+q+g1lBUHmbWddoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707192; c=relaxed/simple;
	bh=XeCKCQslN/bQhvxqvkYZrAg7y9wmgEVBBNPHBVI3M0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPXiiigPpKc21AR8cVehEtfjctx05nlSsUJsw/+SZdKuPNx9eYdZwthAZ8ihFde3Jjy+2x1IybVDI5JdVLc+RChyK9nTwbO5P2KJb/jSm/z9il6RFrA8MjXO0vVt4/k4yAKmpx49sOZIuXAAESpBGavKAyf8sx0MQ9EkLfijXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUTNOqlA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUTNOqlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeWOzu4MzcAw4CDL5ZObANt/PvdTfv+Z8kd/Q22vWhY=;
	b=IUTNOqlAqPb4dUBIpqPweU+0+y7zasDQtc4q0tSRkfbnffYy2+8hK9EC7Uys7b477i3gIN
	qbU50E5ycpXQOKUsTjsHgpxHPG8/FnKXvF67qkSzwefNMGd18D2ST0ApvIMFIG95UosPsf
	HOesnxKdSJ8GYQa+iVO0O6eb9hM5to0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-vsjNaMk4PzqAZ2E8dMoj0A-1; Tue,
 06 Jan 2026 08:46:27 -0500
X-MC-Unique: vsjNaMk4PzqAZ2E8dMoj0A-1
X-Mimecast-MFC-AGG-ID: vsjNaMk4PzqAZ2E8dMoj0A_1767707186
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5845D1801210;
	Tue,  6 Jan 2026 13:46:26 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E2A0180035A;
	Tue,  6 Jan 2026 13:46:22 +0000 (UTC)
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
Subject: [PATCH v2 14/18] rtla: Add generated output files to gitignore
Date: Tue,  6 Jan 2026 08:49:50 -0300
Message-ID: <20260106133655.249887-15-wander@redhat.com>
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

The rtla tool generates various output files during testing and
execution, including custom trace outputs and histogram data. These
files are artifacts of running the tool with different options and
should not be tracked in version control.

Add gitignore entries for custom_filename.txt, osnoise_irq_noise_hist.txt,
osnoise_trace.txt, and timerlat_trace.txt to prevent accidentally
committing these generated files. This aligns with the existing pattern
of ignoring build artifacts and generated headers like *.skel.h.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index 1a394ad26cc1e..4d39d64ac08c0 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -5,3 +5,7 @@ fixdep
 feature
 FEATURE-DUMP
 *.skel.h
+custom_filename.txt
+osnoise_irq_noise_hist.txt
+osnoise_trace.txt
+timerlat_trace.txt
-- 
2.52.0

