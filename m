Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F3539792;
	Tue, 22 Sep 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075412; cv=none; b=D+k2Adam/dUwcXO5Bjl7WOQj7NQ1hoIYaIsJbCeaILy/Z84xdCneUH2fpYSAXu7+buAEmWZmDDf6UVOp3E3VGaN9DRZRvjfaCftyfvy8+m+8kZWUuGG99UQgNgFCZ08Ui/WOxlkCeP6V179HkxRxC8vVmE98U+BJJ4qfo+VV2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075412; c=relaxed/simple;
	bh=U/wF73bUTL+X2AJ7y4xpGH5DVUDn4oZ+onncxV1sZoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In7gMJklGcCa6JnIeYJFIjP4ZxBusvZ6B49bHeqPJqnVZ0KEDMQNO1SSMi2KXOVgrjZNyvUSfhU3GP4sOGbeAK202R8PvvdKWSSZ3jNeCLX1P4rh3CqYf/WY0Sd00M+Sbok4207kHT/ptYwWUA6eLE+6Fw0HyPZ341VGShXEZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xqTsu+kO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xqTsu+kO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Fk2OS/uaoIEZ+EhIjAyKTb3h96louAvWPrG4dkTsayo=;
	t=1790075409; x=1791285009; b=xqTsu+kO4bJj6pN7ZeXYAE8m6kPq69pzf2gk9u6baIcSX2t
	5eXwe5QAmEyyo8xo1IM5Kiuosq/RvdOrdHSWVnKYKeMGqHDlPo7Y3NALFQH6NEGWJGaMunISOhU7Q
	cYTuHJWB3OuPbOv3SncL+b4lLYqO3igiBJSkBRMNXQXTNHpjwqjmMa4wyxgGycXT9k4g0pGS4YAu8
	kR9TojKjl9ByPkUeQ5PE39CeSsKjzte0GQbnfF5O/OWHOBK9wwFcXRPEP3TpfyC9Cd6QT/mm0XRlR
	pdGTLEiEe4E8BvSvXIF8Nyb3P7C4LmE9V7XlkGAz/Pr3d9GeM0ZkDj4YVgYLG5eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8yNu-00000006qo8-0ojx;
	Tue, 22 Sep 2026 13:10:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v7 2/4] tracing/timer: use __print_sym()
Date: Tue, 22 Sep 2026 13:08:41 +0200
Message-ID: <20260922110955.363677-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110955.363677-6-johannes@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
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
index 3aa0608c6361..d45259d96069 100644
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

