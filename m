Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D04266BE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772092; cv=none; b=B5msOTJDdpVlN/3WavXAQHo/JqshW3TBzSKJ9W8Y3mpli6+wMMwpa8DmiUZFqvKCPDoIrvyJ6yWaY1IdyIKqrMgXwO5owM31sqlhM5RyXDTAKoO6QzP925axCE5WEMZ/Pra3qWe7D93Rc9XhPfudZW/KiRmK6gzwT5BSkbBj60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772092; c=relaxed/simple;
	bh=xlWOjX0aHeizYtQTWJbs4ac9HzSAz6/MExRXYVfRgBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eRd9iN6RvKbZnfClp7IgnanN/T33jdvRjk9s/qvhs1nIYaiiKqUvjQIe0wZLs2nNDuEQOoQVqp53jXUROdeoT4lVd8DnxE725Wg4qO9xq4qlJIWYdBIlTI5hvZWarxlHySKilKHkXtOWo0EH5NscTGQypHao5bvTSzisXdbSEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7pBmi3g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7pBmi3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pd0Ym91wNaAacYPIZyKvEsUJqDPL6I4ObunAePv9rc=;
	b=M7pBmi3gq1a2RpJFvOfkJLsVSPie6wLVm36P/zFPHDhXBHPOIweDdrQIqxmOxpLjgU18wG
	MOoK1StAaVL+xUmtw7BgRq1vHqeuNYR0pvgzwE1yZz0esuHCa9fpvljfMa2c8osiAENWVy
	X1gskZmduxZbuw7a5sOZKpufEF0k0kc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-RH8v-XwrMxSpTSoXZMjW0Q-1; Thu,
 14 May 2026 11:21:27 -0400
X-MC-Unique: RH8v-XwrMxSpTSoXZMjW0Q-1
X-Mimecast-MFC-AGG-ID: RH8v-XwrMxSpTSoXZMjW0Q_1778772086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4E5D19560B4;
	Thu, 14 May 2026 15:21:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 971C830001A2;
	Thu, 14 May 2026 15:21:22 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 03/14] tools/rv: Fix exit status when monitor execution fails
Date: Thu, 14 May 2026 17:20:44 +0200
Message-ID: <20260514152055.229162-4-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: gYNz8bupoHuGJwo5SXnst0OXa8vdI4B_ou-vtytG8oM_1778772086
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When running "rv mon" on a monitor that is already enabled, the tool
fails to start but incorrectly exits with a success status (0).

Fix the exit condition to ensure it returns a failure code on any
execution error.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index b8fe24a87d97..6d65f4037581 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -127,7 +127,7 @@ static void rv_mon(int argc, char **argv)
 
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
-	exit(!run);
+	exit(run <= 0);
 }
 
 static void usage(int exit_val, const char *fmt, ...)
-- 
2.54.0

