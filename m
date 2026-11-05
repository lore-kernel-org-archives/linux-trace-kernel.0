Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900983;
	b=EeOmdo0nTQjoDmLbNEm6yY8MTxPDm/0wfsG73/PpQ8cVGOIzzQ9S03owV32rCpMvrIMz
	 TG30gVSL+Wyn3gW/n2tgOOj/fMk7cnEMvcQXokXulqpx5CzO40Sz3Sf21AaYWIIrUcGsg
	 Jqvlw+m24rieuiQxlFfsM1xMXVR0XtAjsRB9EsvTWhqne5n9QEA4tpdYVQJdKg77Uu6Sn
	 s4FIb2FSECKlevpfa19NOjFBO5G7TtR2u01xP1HGnCWorX9N9YtTUbFkXF7G1E0aYbq+H
	 vQXBo3/IyOdT3BkeDZmurD+Kpso01iDP2rPVTIBgL6+BDw8SMtPg/5ncMwzr3YSgWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900983;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zGdfdjP6a+TPueYJm2dCOUdQPj2v0w0t6X/7e4tc8d0=;
	b=ak3Q49JxHUyq+9+16shs5dRuqe++UHoCFB1rILnrqNxD8d+Oq9ASTsn9Cek4x2Y/t0Sv
	 gOW4TrkYcLJKT1+SyyQKdK9qI4ilaM2eV9HP5hRk9ws2VLELIwqeRD6fHckQvHgf9Sgzd
	 OF9xPAessIAOw1bbgBuKOZRrPDUBhQ/CnKiJ6Z+iOIdNpow1B7n/WEcAEWwQU7LzqUmcE
	 daz8zh+C8lqCXGJ7Eyx24hbiuez2CBrBNOWcCd1RvI3toKqPMJjj+PCPp9q3JmYktPYbo
	 2pgC4yat/F5FMBjmoZm1n03MUJ0KfqdEgcEcQ2R61WzCfAr9+eX3udViWFrBeLq/SKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k8R7zWoX;
	arc=none smtp.remote-ip=95.215.58.189
Received: from mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A66606A328
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A66606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k8R7zWoX
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4mrAIQI+m0F1K1NEKjyN89vPwAwdMuNeKG+UaA+E+X0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793900981; v=1; x=1794505781;
 b=k8R7zWoX6JrA7XKmvK2yfHP/Gy1Yluu7AhZ6zqRMDrbEwmaOTudYZwTeHre51q+LP3NcAhTY
 Xng6ydkkbe1TFxnewNVFpc4Ohw097hom7d8ymLu64yRkOkp8bkSnjJ8HHNWa0lO98ZWeVSBsB2z
 dnRUbXz8kS8JyiD1DX5nPaoA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c0c82de5273c4f68;
	Thu, 05 Nov 2026 17:49:41 +0000
X-Mizu-Trace-ID: c0c82de5273c4f68
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 01/14] rv: Force environment reset action on HA monitor start
Date: Fri,  6 Nov 2026 01:49:01 +0800
Message-Id: <a5dad02da683a6a5065c4e803198f6de7a21f018.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
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

