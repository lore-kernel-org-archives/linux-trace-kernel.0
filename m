Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F303DD84B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791156; cv=none; b=mGbkIjqg2gi34QOQde0PJFT6UETKTpbGOqlva3xvTugHC3HbqQkPzILgQqbVk3tiUhjG33gw3vFriOtfF7DQZFNMD+WSWAM4bK0xvDLNMKhb+0/ZbR+VV5XAxCkXIqD8TENlLhkAKCn4gJkHcNkpWF2H3MhYnAj7MNUOUQo53zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791156; c=relaxed/simple;
	bh=xyWil9E/hfSTf4YL19B3p4uMvIYW8HK03xdRDohahEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nowE68RBWXE62kmDMk7Bs8dkuztTTpgpbwUD37NVzwNjX+nExyL59aC4I45Pg+LyWOiJiOAqwgkL8zj9gEfo+MHxyTeymQVBI1Z6icEjD4Str/me5KnobjTpIdjzFNyd36Go0JI92cGIHs6CpHuhSJfLwL0qQap9Um+1tCrLTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaIhCnXh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaIhCnXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWyDT3+amO0hhbiASLQR0GkSPDynWEZVnuJh4CmBXZ8=;
	b=WaIhCnXhlhjcObpXU+FopRZe0RaDtL6CsploG40LxMeaUfNCSSt2DffNh23VOUK6sG8jYZ
	yiigsx1kQzKRq/BuLzphJT1vV9Pmtxk5ibfB7WatkT6jIXVnRgFTUBf19skGYrABmv+/Mk
	vRHoTVIecFG8ccz0ewr48GAP3LAf4Hc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-oNcjpHB6NMSp5TubGu0bxA-1; Tue,
 26 May 2026 06:25:53 -0400
X-MC-Unique: oNcjpHB6NMSp5TubGu0bxA-1
X-Mimecast-MFC-AGG-ID: oNcjpHB6NMSp5TubGu0bxA_1779791152
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C8701800371;
	Tue, 26 May 2026 10:25:52 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AB911956056;
	Tue, 26 May 2026 10:25:49 +0000 (UTC)
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
Subject: [PATCH 4/4] rtla/tests: Add runtime tests for restoring continue flag
Date: Tue, 26 May 2026 12:25:23 +0200
Message-ID: <20260526102523.2662391-4-tglozar@redhat.com>
In-Reply-To: <20260526102523.2662391-1-tglozar@redhat.com>
References: <20260526102523.2662391-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 1LqI3ZlLJlPHlghRsD83RqzA4i3QZ4NjO40u0sgnaPw_1779791152
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In case an action preceding the continue action fails, not only
the continue flag should not be set, it should be unset if it was set
from a previous run of actions_perform().

Add a runtime test to both osnoise and timerlat tools that checks that
this works properly by creating a temporary file.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

Depends on "rtla/tests: Extend runtime test coverage" patchset
- https://lore.kernel.org/linux-trace-kernel/20260423130558.882022-1-tglozar@redhat.com/

 tools/tracing/rtla/tests/osnoise.t  | 2 ++
 tools/tracing/rtla/tests/timerlat.t | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 9c2f84a4187d..a7956ab605cd 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -65,6 +65,8 @@ check "top stop at failed action" \
 	"osnoise top -S 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check_top_q_hist "with continue" \
 	"osnoise TOOL -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check_top_q_hist "with conditional continue" \
+	"osnoise TOOL -S 2 --on-threshold shell,command='if [ -f a ]; then echo 2; exit 1; else echo -n 1; touch a; fi' --on-threshold continue" 2 "^12$" "^2$"
 check_top_hist "with trace output at end" \
 	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index f3e5f99e862b..19fd5af26ebb 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -94,6 +94,8 @@ check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check_top_q_hist "with continue" \
 	"timerlat TOOL -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check_top_q_hist "with conditional continue" \
+	"timerlat TOOL -T 2 --on-threshold shell,command='if [ -f a ]; then echo 2; exit 1; else echo -n 1; touch a; fi' --on-threshold continue" 2 "^12$" "^2$"
 check_top_hist "with trace output at end" \
 	"timerlat TOOL -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 
-- 
2.54.0

