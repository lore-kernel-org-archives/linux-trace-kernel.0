Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F847F2D3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581968; cv=none; b=J2uPkfVOEWCIdSbBHD8yMmm8VNcKsmkiLWFHTFZjBgyWT9AyRYQe37sgD8iLp9fnpoo9qzj9OtCozMPT0mKMyvA7GEbuHsYDZ1ppaaxPmkMgQqNbqs6ejeOXxF7VC6H7fMqzBWTkoK+g6JVVYWSUbry3L83Dp/pCLEF22qYQWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581968; c=relaxed/simple;
	bh=Uw9nvY02UpD9KblUh9qxg1lYuQx0XJfOh5p3fL9sDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=QwkVb8g9y+8eSSPlgc7XPOTLOGxXYyPymJ3txUccbn6XvqmdKBv60bFAwDvCQlDg0xrM0l/FY01Irw23PcUsX9olGrbDUfyj/HdbpvrSbv7d78g8tR6yePY1NIl4S78SebHCTk0WYlfhkaA6GsjAm5FQwHc0AXY1Et0Dg7iLHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJnqVsdP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJnqVsdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780581964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLBeflr380ZNAPXfrIYScBzonk1AK7Sdg9uhhywNY/0=;
	b=UJnqVsdPpumPow7FEDDQdIJWR/0RTrVkMHOtiwPzl9CIA3yGVzf9LLDBP/tc4G2yG2xPdX
	p17c5FnmoaRU2fioRXtp+jIn2qbpWUx/PWJS3DOadtEt6yohNrN5sxAcSywOhcu5cGnGdh
	rnFEm+op+700Cg1pb/gAnFo1Q8o9Qd0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-bjyXuGTkOUmeHGwvVY61AQ-1; Thu,
 04 Jun 2026 10:06:01 -0400
X-MC-Unique: bjyXuGTkOUmeHGwvVY61AQ-1
X-Mimecast-MFC-AGG-ID: bjyXuGTkOUmeHGwvVY61AQ_1780581960
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 030761800D92;
	Thu,  4 Jun 2026 14:06:00 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 962D7180049F;
	Thu,  4 Jun 2026 14:05:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] rtla/tests: Fix pgrep filter in get_workload_pids.sh
Date: Thu,  4 Jun 2026 16:05:47 +0200
Message-ID: <20260604140547.3616495-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7WuO3sJGt01iI6ZmrAdW6okWnHiVcjZVe2UJi_8YVFY_1780581960
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Multiple runtime tests in RTLA rely on the get_workload_pids() shell
helper function to get the PIDs of both kernel and user workloads.

On some systems (e.g. Fedora 43), pgrep matches kernel thread names
including square brackets: "[osnoise/0]"; on other systems (e.g.
RHEL 9.8), brackets are not included: "osnoise/0".

Accept both as valid workload PIDs rather that just the non-bracket form
to make the tests work on all systems.

Fixes: a98dad63cda3 ("rtla/tests: Add runtime test for -k and -u options")
Reported-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

Note: the file touched by this commit is included by .gitignore, that is
an error that will be fixed by [1].

[1] https://lore.kernel.org/linux-trace-kernel/20260601091835.3118094-1-tglozar@redhat.com/

 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh b/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
index 8aff98cd2c1f..d10a4e3b321d 100644
--- a/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
+++ b/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
@@ -5,7 +5,7 @@ get_workload_pids() {
     local rtla_pid=$(ps -o ppid= $shell_pid)
 
     # kernel threads
-    pgrep -P $(pgrep ^kthreadd$) -f '^(osnoise|timerlat)/[0-9]+$'
+    pgrep -P $(pgrep ^kthreadd$) -f '^\[?(osnoise|timerlat)/[0-9]+\]?$'
     # user threads
     pgrep -P $rtla_pid | grep -v "^$shell_pid$"
 }
-- 
2.54.0

