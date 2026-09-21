Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BA3DC4B8;
	Mon, 21 Sep 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985751; cv=none; b=BgPhcF28OMPOz/8yfPK6Mho1TTLaoQfke09Vt4VB89E1BULAKnMt9X0Vg9q+BkcU9ciYmuBk1gKmSlUUciRGTbxNnjjbBufiYDYtMzx77a2lPPCawRGDeDcImrQluRGvBK9EhEAf8jW1CqzDNSsK3OJnF//ODZwTKnGEH3X74ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985751; c=relaxed/simple;
	bh=yeRGN+0wWYWZ65R9hKxmT90VoewUaS+Ba/MM3Z9frHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuQDk+ujqEUMEGmaLcx5G8/M4ZKWlWxeX+AZj/XHszqX0796EZF0bVKyGwZHrMD9EfL9zrEHW8fl3VJ/ssVu8pylljsSl+n2TFgf/2WrbZ/XAuAnnvTDOXFQPaia9RjDpt4azYdHvhyj0aaejGKD+TOmO8zIiH20AGAc1BYbBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yGZKC71J; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yGZKC71J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tETmZyietn5/+Tj0nR7lM4MbsVT0JGLtyF0nww7h+gY=;
	t=1789985749; x=1791195349; b=yGZKC71JzWwS38jFQHJ3Yoq6a2F+2rx1lcsdYkwIfaYuB72
	EBWca0bfwXBSI+arHtLJNOCj6O7yYrMsb6xv8WJg/antEUBDhdnA6FKx2c3gTitfZXeZ9JqxDBICZ
	FjG1qq6nE3XE7x9JyZFtwNG9+kLIkWmmdvp1JmoUwsIjapCM4yZX90w7hrHq554i5uKJ74DAIlnbR
	F5yBP2HmrMaK/smpLVTE0LzPhTyr1AOP6PC1rs6bpCvWc3B+WN9Dyo9+YXAF6KXTWPpIPDrFPb4wb
	/SpEV+NubEg4LG20VQp4St5suyRnq51eQ+Bu8oEgHe2INW8Q67NSWF6hXF0mlf3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8b3n-00000005jvH-3VqX;
	Mon, 21 Sep 2026 12:15:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v6 2/4] tracing/timer: use __print_sym()
Date: Mon, 21 Sep 2026 12:06:33 +0200
Message-ID: <20260921101538.97286-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921101538.97286-6-johannes@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use the new __print_sym() in the timer tracing, just to show
how to convert something. This adds ~80 bytes of .text for a
saving of ~1.5K of data in my builds.

Note the format changes from

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { (1 << 0), "POSIX_TIMER" }, { (1 << 1), "PERF_EVENTS" }, { (1 << 2), "SCHED" }, { (1 << 3), "CLOCK_UNSTABLE" }, { (1 << 4), "RCU" }, { (1 << 5), "RCU_EXP" })

to

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { 1, "POSIX_TIMER" }, { 2, "PERF_EVENTS" }, { 4, "SCHED" }, { 8, "CLOCK_UNSTABLE" }, { 16, "RCU" }, { 32, "RCU_EXP" })

since the values are now just printed in the show function as
pure decimal values.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/trace/events/timer.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index ca82fd62dc30..9a43f4fedaf6 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -441,26 +441,18 @@ TRACE_EVENT(itimer_expire,
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-/* The MASK will convert to their bits and they need to be processed too */
-#define tick_dep_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-#define tick_dep_name_end(sdep)  TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-/* NONE only has a mask defined for it */
-#define tick_dep_mask_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
+#define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
+#define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
+#define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
 
-TICK_DEP_NAMES
+TRACE_DEFINE_SYM_LIST(tick_dep_names, TICK_DEP_NAMES);
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-#define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
-#define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
-#define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
-
 #define show_tick_dep_name(val)				\
-	__print_symbolic(val, TICK_DEP_NAMES)
+	__print_sym(val, tick_dep_names)
 
 TRACE_EVENT(tick_stop,
 
-- 
2.55.0

