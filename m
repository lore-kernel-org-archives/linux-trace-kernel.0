Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE46340416
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747590; cv=none; b=igUXtKIgABalLvl4RdfUJ3TpJCgWBOsLQrYih+NTT7bAKNum+/llP2mKKmfu/sDJDisyb7IbyNgrT8vOppkEHpHqKsW9co+uoPUz3+U//Ec93i4xJsg88VzKpugwSvWRPu38hB+gJ7IqYRGtebp1Txu3AqE0y2Ot2SW/39w04H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747590; c=relaxed/simple;
	bh=4mrAIQI+m0F1K1NEKjyN89vPwAwdMuNeKG+UaA+E+X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYTsfIjGqvcwcRtPTvX8A/doCBd+u3LeUfNmou/ignK6jrwM75dB3o67tDd4fKarimn9nBzkVDCEhgEugY0/fnUE+Zje65krQEq8TbPA/sD5Fhu4HNrgFYV9eZLju31HgRhzvipewn1LLEqiGWImwoOSjphQeVQnOw2kcxu93CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=skAObB7H; arc=none smtp.client-ip=91.218.175.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="skAObB7H"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4mrAIQI+m0F1K1NEKjyN89vPwAwdMuNeKG+UaA+E+X0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747585; v=1; x=1792352385;
 b=skAObB7HCCYZPqtcbC1cp7goDDeXukdxM5KdUPkaEGsqsWV1sXZyjy5+7z7wSu+GadQhC52C
 VS5s3Z9QH7BTeDLHM9qpxkU4tQeS3PA/S+nxm2k68k25adbp47kA5qK3JoD2ndTdz/FXdMAfFl7
 yd5x7clS0VVZzdP9UiooVqAE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ae1cf5677c39f91f;
	Sun, 11 Oct 2026 19:39:45 +0000
X-Mizu-Trace-ID: ae1cf5677c39f91f
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 01/14] rv: Force environment reset action on HA monitor start
Date: Mon, 12 Oct 2026 03:39:07 +0800
Message-Id: <3680decb855286ac73c903bc3101272c0419e783.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

Currently the monitor variables with a storage (e.g. clocks) are
initialised as invalid, then the first explicit reset() sets them as
valid for constraint. This only adds extra complexity to handle the
invalid case in constraints check.

Apply a reset() by default when starting monitors instead of resetting
to an invalid state. If monitors have no stored variable (hence no reset
function) add a macro HA_NO_RESET to stub it, this is all transparently
handled by rvgen.

The reset() action on ns-granularity clocks needs the (possibly cached)
current time, read it directly there. This might cause a double call to
ktime_get_ns() within the same da_handle_start_run_event() but will
occur only the first time and is harmless.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Tested-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h                 | 8 +++++++-
 kernel/trace/rv/monitors/opid/opid.h    | 1 +
 tools/verification/rvgen/rvgen/dot2c.py | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 6e1c7fe5449a..93ac99ff7f1d 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -159,19 +159,25 @@ static void ha_monitor_destroy(void)
 
 /* Should be supplied by the monitor */
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
 static bool ha_verify_constraint(struct ha_monitor *ha_mon,
 				 enum states curr_state,
 				 enum events event,
 				 enum states next_state,
 				 u64 time_ns);
+#ifdef HA_NO_RESET
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns) { }
+#endif
 
 /*
  * ha_monitor_reset_all_stored - reset all environment variables in the monitor
  */
 static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
 {
+	u64 time_ns = ha_get_ns();
+
 	for (int i = 0; i < ENV_MAX_STORED; i++)
-		WRITE_ONCE(ha_mon->env_store[i], ENV_INVALID_VALUE);
+		ha_reset_env(ha_mon, i, time_ns);
 }
 
 /*
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
index fb0aa4c28aa6..f85b1959c2fb 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -28,6 +28,7 @@ enum envs_opid {
 };
 
 _Static_assert(env_max_stored_opid <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_NO_RESET
 
 struct automaton_opid {
 	char *state_names[state_max_opid];
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 22938ce1bf6c..1532e6b6e199 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -90,6 +90,8 @@ class Dot2c(Automata):
                         ' "Not enough slots");')
             if {"ns", "us", "ms", "s"}.intersection(self.env_types.values()):
                 buff.append("#define HA_CLK_NS")
+            if len(self.env_stored) == 0:
+                buff.append("#define HA_NO_RESET")
             buff.append("")
         return buff
 
-- 
2.25.1

