Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438E51CF69
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686176; cv=none; b=kBUiay96WLX5CMh1qxJ2yJCVMyhzMbW09gIHnFTMAukUJcjumz948w6ZA+8BAYxWOP0A+daqxQUyq8dXYK0V71xoChI0gbQsV/aCVHB3+dYfyN99rllBo6L+vwZdKNhgqE+UBjRPc3aXRPLqk4cKro4euUlVY00BISsqizIkSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686176; c=relaxed/simple;
	bh=EqZmbWOSzN3G5NmVQ7GaJg9DE1KreAuKK+h+UdTnFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pou2QgxKAiuPDU2i6V63EwkUB/SbDN9YtLHgPbPaFYIPnB4AJzHwNMEAwqULz/QmPsBx3mu8EPiEDlt2ozwSDXkgRr4U2Jo3ph5O6QRBM9K/yi9ykVNUhmRoG+tG8wuungHcswbzWPu8g2eTLTcEyeleSA/OfrvAgudaVG1ROVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R73zKHzE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R73zKHzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCH+fD1vc3UUJcFQ9+Om6OLTNJXpyzIp0edH7K0DqAc=;
	b=R73zKHzEsKHNeCQfwXTzU1Y2J3EPZWJRX6i47rJzBPpEQjHB6+6qDjjWjm3Mc5rTIIZVSU
	poXRfPVUMgP6FA8fMKc6vhdjXXg8t1WdroYZ8SbQHGgvS3DyPIcuZTFJchoihRMjcNbfjm
	w909JQfbVdAUgIkSbPBlpZ9Ix7qtFCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-PKIX7teON32T5o4gUq6NTQ-1; Tue,
 29 Sep 2026 08:49:27 -0400
X-MC-Unique: PKIX7teON32T5o4gUq6NTQ-1
X-Mimecast-MFC-AGG-ID: PKIX7teON32T5o4gUq6NTQ_1790686166
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D6E41805A23;
	Tue, 29 Sep 2026 12:49:26 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D7DE19560AB;
	Tue, 29 Sep 2026 12:49:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 02/10] rv: Remove unused ha_monitor_env_invalid()
Date: Tue, 29 Sep 2026 14:49:00 +0200
Message-ID: <20260929124908.177676-3-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 28NvJ3K0PSmJNt-FGLjYagtvg8Ku7Cd4O77lyL-dUUY_1790686166
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After forcing a reset() action when starting HA monitors, environment
variables cannot be invalid, hence ha_monitor_env_invalid() and checks
using it are no longer required.

Remove the function and its usage from library and generation scripts.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ha_monitor.h                             | 12 ------------
 tools/verification/rvgen/rvgen/dot2k.py             |  8 --------
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c        | 13 +++++--------
 .../rvgen/tests/golden/test_ha/test_ha.c            | 13 +++++--------
 .../tests/golden/test_ha_kunit/test_ha_kunit.c      | 13 +++++--------
 5 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 93ac99ff7f1d..87cf91abdf67 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -211,14 +211,6 @@ static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
 		ha_cancel_timer(ha_mon);
 }
 
-/*
- * ha_monitor_env_invalid - return true if env has not been initialised
- */
-static inline bool ha_monitor_env_invalid(struct ha_monitor *ha_mon, enum envs env)
-{
-	return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
-}
-
 static inline void ha_get_env_string(struct seq_buf *s,
 				     struct ha_monitor *ha_mon, u64 time_ns)
 {
@@ -360,8 +352,6 @@ static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum envs en
 {
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
-	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
 	return ha_get_env(ha_mon, env, time_ns);
 }
 
@@ -388,8 +378,6 @@ static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enum envs
 {
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
-	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
 	return ha_get_env(ha_mon, env, time_ns);
 }
 
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index fd3254ea5b4d..0b4e19ad9bd5 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -279,19 +279,11 @@ class ha2k(dot2k):
     def __format_guard_rules(self, rules: list[str]) -> list[str]:
         """
         Merge guard constraints as a single C return statement.
-        If the rules include a stored env, also check its validity.
         Break lines in a best effort way that tries to keep readability.
         """
         if not rules:
             return []
 
-        invalid_checks = [f"ha_monitor_env_invalid(ha_mon, {env}{self.enum_suffix}) ||"
-                          for env in self.env_stored if any(env in rule for rule in rules)]
-        if invalid_checks and len(rules) > 1:
-            rules[0] = "(" + rules[0]
-            rules[-1] = rules[-1] + ")"
-        rules = invalid_checks + rules
-
         separator = "\n\t\t      " if sum(len(r) for r in rules) > 80 else " "
         return ["res = " + separator.join(rules) + ";"]
 
diff --git a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
index 3a72e867122c..7357e182e487 100644
--- a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
+++ b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
@@ -109,16 +109,13 @@ static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 		res = ha_get_env(ha_mon, env1_ha_percpu, time_ns) == 0ull;
 		ha_reset_env(ha_mon, clk_ha_percpu, time_ns);
 	} else if (curr_state == S2_ha_percpu && event == event1_ha_percpu)
-		res = ha_monitor_env_invalid(ha_mon, clk_ha_percpu) ||
-		      ha_get_env(ha_mon, clk_ha_percpu, time_ns) < foo_ns;
+		res = ha_get_env(ha_mon, clk_ha_percpu, time_ns) < foo_ns;
 	else if (curr_state == S3_ha_percpu && event == event0_ha_percpu)
-		res = ha_monitor_env_invalid(ha_mon, clk_ha_percpu) ||
-		      (ha_get_env(ha_mon, clk_ha_percpu, time_ns) < FOO_NS &&
-		      ha_get_env(ha_mon, env2_ha_percpu, time_ns) == 0ull);
+		res = ha_get_env(ha_mon, clk_ha_percpu, time_ns) < FOO_NS &&
+		      ha_get_env(ha_mon, env2_ha_percpu, time_ns) == 0ull;
 	else if (curr_state == S3_ha_percpu && event == event1_ha_percpu) {
-		res = ha_monitor_env_invalid(ha_mon, clk_ha_percpu) ||
-		      (ha_get_env(ha_mon, clk_ha_percpu, time_ns) < 5000ull &&
-		      ha_get_env(ha_mon, env1_ha_percpu, time_ns) == 1ull);
+		res = ha_get_env(ha_mon, clk_ha_percpu, time_ns) < 5000ull &&
+		      ha_get_env(ha_mon, env1_ha_percpu, time_ns) == 1ull;
 		ha_reset_env(ha_mon, clk_ha_percpu, time_ns);
 	}
 	return res;
diff --git a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
index 9047ff725546..a2bd1eb93b03 100644
--- a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
+++ b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
@@ -109,16 +109,13 @@ static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 		res = ha_get_env(ha_mon, env1_test_ha, time_ns) == 0ull;
 		ha_reset_env(ha_mon, clk_test_ha, time_ns);
 	} else if (curr_state == S2_test_ha && event == event1_test_ha)
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha) ||
-		      ha_get_env(ha_mon, clk_test_ha, time_ns) < foo_ns;
+		res = ha_get_env(ha_mon, clk_test_ha, time_ns) < foo_ns;
 	else if (curr_state == S3_test_ha && event == event0_test_ha)
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha) ||
-		      (ha_get_env(ha_mon, clk_test_ha, time_ns) < FOO_NS &&
-		      ha_get_env(ha_mon, env2_test_ha, time_ns) == 0ull);
+		res = ha_get_env(ha_mon, clk_test_ha, time_ns) < FOO_NS &&
+		      ha_get_env(ha_mon, env2_test_ha, time_ns) == 0ull;
 	else if (curr_state == S3_test_ha && event == event1_test_ha) {
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha) ||
-		      (ha_get_env(ha_mon, clk_test_ha, time_ns) < 5000ull &&
-		      ha_get_env(ha_mon, env1_test_ha, time_ns) == 1ull);
+		res = ha_get_env(ha_mon, clk_test_ha, time_ns) < 5000ull &&
+		      ha_get_env(ha_mon, env1_test_ha, time_ns) == 1ull;
 		ha_reset_env(ha_mon, clk_test_ha, time_ns);
 	}
 	return res;
diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
index 239b0539df18..61446e7f32c4 100644
--- a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
+++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
@@ -109,16 +109,13 @@ static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 		res = ha_get_env(ha_mon, env1_test_ha_kunit, time_ns) == 0ull;
 		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
 	} else if (curr_state == S2_test_ha_kunit && event == event1_test_ha_kunit)
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
-		      ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < foo_ns;
+		res = ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < foo_ns;
 	else if (curr_state == S3_test_ha_kunit && event == event0_test_ha_kunit)
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
-		      (ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < FOO_NS &&
-		      ha_get_env(ha_mon, env2_test_ha_kunit, time_ns) == 0ull);
+		res = ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < FOO_NS &&
+		      ha_get_env(ha_mon, env2_test_ha_kunit, time_ns) == 0ull;
 	else if (curr_state == S3_test_ha_kunit && event == event1_test_ha_kunit) {
-		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
-		      (ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < 5000ull &&
-		      ha_get_env(ha_mon, env1_test_ha_kunit, time_ns) == 1ull);
+		res = ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < 5000ull &&
+		      ha_get_env(ha_mon, env1_test_ha_kunit, time_ns) == 1ull;
 		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
 	}
 	return res;
-- 
2.55.0

