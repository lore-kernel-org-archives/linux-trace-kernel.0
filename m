Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795867094;
	b=cwZRchFtn+g3OJhaoQf3dkFM0PvQCIlt/mg6XByRxFJsDRTMMoXshRB3rcd/HgmgkoRO
	 i6v6qEVBZ3Pr/2m6v7A2GJshNkDCR+Zn7icxGWtBjFAiL6pDxfhPeDLofDlplDtKfUToN
	 WLm74vrp2/M9Je41NqV1rYxbVQRUP6LVViQ3Ue85g5dl69C7bpD4NvdqkNk09nkC4qBmF
	 R5lo7v9eq7gonUY2qTzq4tCYtDPntpzP6YJrMBUh3D2mZ4OV1uWPT/xwQw8J9edRRBWzX
	 7LzwKmXeFQQe3KzVc6DwKfr1sB2L5SrDbUD3Bv7Ls1P/WJ+uxY47g+WRp58sMttq3sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SjPI7Jbk9ZW+2UhHnHYD7+GabroYFcfZRUftjzGrH3U=;
	b=s+5Ej0gvQGq/DkKYo83zXi03uulDSIpFaB361hwrxmu2zjil1c/CmkGUjTgMwpQN+hfu
	 ZumWi4MfQsx0W+yRkIbMoD+kR7a0UNc58t2ALjdIGTIdPdkFWMt5H1JMlArlw19ghsNB5
	 4U1BEN+IY2ZUipFipSJpTXNXDejm8vPlVlNfaygfSL0sdfyjFA8RsQYz45XVNVMULgJtT
	 92tWwRhh+kHOtC5jbo7F+osqbyKMstJL+8oUMQJSHJM6lGSRWSHcApe/NxSflHHKNldFE
	 XOM93uBbu+aT8AUkHDKXx3CqngCcf8sbIsJ2UQqoAk9AmBef8RvkEfbJzSH2HLN+0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEHsMOgF;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275BA606A324
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 11:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275BA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEHsMOgF
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dee593f18so8420168f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 03:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795867091; x=1796471891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SjPI7Jbk9ZW+2UhHnHYD7+GabroYFcfZRUftjzGrH3U=;
        b=oEHsMOgF2CsvvJKAvBZxSurRYX7O5jWliShMLdEHmE7x02l0YY23OjRtmSqwo1EpuS
         Y3QXLp+7LZjeWdYhbjnAGp+W6/2i/7Xj7ovV/dF3g0tlxVh9FEeHHpom0giUNGfBXkMo
         K4cSrQQfvFY+VaS0XdpnYfsWqWDYw4pqPZ6vdv+U5WqJCbcZA7pYbCZO87M+tJBDZX4m
         J/OyDPx377MZ0GhDjlP48AyWPZuOu/dQDhoUEAhkTQjjjkidTjGOZ3qUgdetETGV7v5M
         nKN5w2alyG7/YF4L3niAw7Kw8ghhL9gjQ/U0TpqWq6IL/LGgKALeInJsoYB/bsLngR29
         AxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795867091; x=1796471891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SjPI7Jbk9ZW+2UhHnHYD7+GabroYFcfZRUftjzGrH3U=;
        b=cMn2/TuWijqDCVsjABQxMa2PotSkjd1PMXivdM+W4EfvCWqf04KA27WZn5NrLyrUor
         aUv/bg5R74neylWxyXxfP/3NbG7EjiFDEveHArwYxGTQZYVuOckOgwvhbr5N9kp0S2lv
         IH5jgImiNV7nrF5e7q0mW4Tc1/qHdvcxNOrlZZO4KGQ9ftdqdaFjTA2lk0qHRnd+iZ+c
         Ypa+Y2u1j5gw9sBpRpO3gbX01ZI7IApJ2tQ6LweXv6sVQZEP3mFJdLMIKvIpaqFGrOlB
         RmVYTVNj/uJbC5bhpbmSF8QoLfdk93yyZNNdL/KOTV6IgC28jVgqTPmGYwcOVQ3eRvL6
         v5Xg==
X-Forwarded-Encrypted: i=1; AL+hErH0upqR9sgvPpBEK3HSOf9OzegmKJIgnJpeNN58NLVgl7DSEbSndmZPcHOwUiaG2eGmzNIkGoyTovWJsatFY9nyfng=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JVwbiT561v6ZQbZIX/SBnHFaWOwM5FeWfk37yaLvbO/u2e3yl
	oQJV99mMQGKRCsPLG9uU9tOYnBV1qYueD69dXkVgDUp6hz5GHcNAMQXL
X-Gm-Gg: AZFdTZdDe+hJ1i0rdiiu1PeWRVf+0JkahyOEhdYX+mkRMTB+kE/qSBS6uaLe1qVzuDS
	Y7dzC/ZqqT7LrCRGufOkqk21fcu24hDFq2xURbDdpiV/GEs7kkwt8Zp9JG4QCLNalhi1VM85JUQ
	5tTpPpYbMLOAsL9fBYgX4SyzsfNsHrF1QH3chE9obv1BO7sQ/y2fcT/3Blz/KbYwRivyjYSjQXO
	6Z5wA9rr6F0n08rxh7bWG9SijxqdZwN9aLztah/olvxnQAcarV3lPL45hhQ2NR3jvqdkQiULh9U
	i/VN49X5iv3cpbZt406Fqnqy8zd6+VfFGJ7uJ1aVK/JLANJ0cSmdkjEnXr/pZPD910fXigzMcpD
	5ZbAB0T1aG04KAdsgA2CYknr8NC9PXpkROGOT4eQ3RM9ocBRC3eA+10TSKd7pn2Ruamwkts4k7b
	pJKuR5BJgFrqOdfzSFvQciVpYeuDSDEzeJa1gx3CuEcGQdxgkf5KxJRIFAtOTTCFMfksLX+dqHA
	2nSJsSkyPVhPA7mYDw2p+8Qo9lWcY0TmAP+Px+cApsjMcvb85RrIVZFR0YEuok0Ymus7/ZmJwYt
	kV1/iceHORAlZRZFrHghW69GdhJeiOZtJDlyt5EEO+ImGgnFL4aepAdXTldKJxsGZdlikbw7lR+
	B+/SN2SSWydqidb6ZBHSi0Y4sWRM2gOVuiDqC0hrm2xQ89PzCAk+2xcGtJV8vMlFCDGD1Zhk7Gc
	/G/X27LyviAOnd4LbH/0cRZw1/IuNghAleoLLP7rXEcYd7Q+955eUTDDeEolAtjc+KJMjFsPyYE
	AnZZhFWjoh1TBbkzA==
X-Received: by 2002:a05:600c:5306:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4bb887c9af4mr523131755e9.4.1795867091555;
        Sat, 28 Nov 2026 03:58:11 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-510b-18d1-bc36-7cc9.rev.sfr.net. [2a02:8434:fda5:4201:510b:18d1:bc36:7cc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm832768435e9.14.2026.11.28.03.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:58:11 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/bootconfig: Export tracing state without the function graph tracer
Date: Sat, 28 Nov 2026 12:57:57 +0100
Message-ID: <e8de5737f07a1cfee7f8530b82cfeed3e963ce21.1795867077.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795867077.git.edumucelli@gmail.com>
References: <cover.1795867077.git.edumucelli@gmail.com>
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

The function graph tracer provides max_graph_depth. With that tracer
omitted, the unconditional read fails under set -e, and ftrace2bconf
exits before exporting any ordinary tracing state.

Read the depth only when tracefs provides it. Check each available
function graph filter file and keep the existing warning when an
expanded filter list is present.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index b685dd6b070b0c..de571ec11b4392 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -45,14 +45,20 @@ emit_kv() { # key =|+= value
 }
 
 global_options() {
-	val=`cat $TRACEFS/max_graph_depth`
-	[ $val != 0 ] && emit_kv kernel.ftrace_graph_max_depth = $val
-	if grep -qv "^#" $TRACEFS/set_graph_function $TRACEFS/set_graph_notrace ; then
+	if [ -f "$TRACEFS/max_graph_depth" ]; then
+		val=$(cat "$TRACEFS/max_graph_depth")
+		[ "$val" != 0 ] && emit_kv kernel.ftrace_graph_max_depth = "$val"
+	fi
+	for filter in "$TRACEFS/set_graph_function" "$TRACEFS/set_graph_notrace"; do
+		if [ ! -f "$filter" ] || ! grep -qv "^#" "$filter"; then
+			continue
+		fi
 		cat 1>&2 << EOF
 # WARN: Cannot export kernel.ftrace_graph_filter and kernel.ftrace_graph_notrace.
 # Only the expanded function list is available.
 EOF
-	fi
+		break
+	done
 }
 
 kprobe_event_options() {
-- 
2.53.0

