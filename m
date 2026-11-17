Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882521;
	b=4dFPLl00qUpQFRBtJSMqCHkMidUJJzQzu7GL6wM81DMPdkyiyY7KelA3jXhcMhJO9Zxv
	 J1OGhFHez3qke9oI7TRu/8BgI66KDrfW9ATwM9+YOVsXBWFGLyFx2WU1PFKdLEg4JOJ6g
	 EtZ3yhHC45xVSuMmEKoe2oB6ri2yqyKJuzakCeqw7YHoIyNO7hQ7ygD/DGgEK1Y3evh9E
	 On5f6ipkCbdZ007CAc9InUV0vt+i72LXQvQaAY1NljtmnvdNebtgiFmn9mT5NGQCqP1GB
	 w3zrlVCNzEd/SX/CipEh/2urxJT+4okO/1IRAruHdKc3ZPS4ui2T5Fuih54O+WtZ01Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ypFwQA0FZOPRuiqI0RyJwEY/z4AuSyUwMT7yZK7iq/g=;
	b=rXCNZw7oxVVMz8FyCppPAW00g4+s7uz+PcP+e8dSmp3X2VasW68sDUDOniGcwZfB9BtK
	 kf41P3co4ncHP9sd1V9iKESWEccgmxzzy4WKhNSAd1GEzw65jKWHu/I6A2OLC9NqCwrFu
	 S2SDTDzYGGAjOxjcQ8un97sgK/3pWdQOHxgbqywWt27TBG4iSLXn70Q+DUFEr+ua9i7XO
	 wH0gl9FWdXNJtsmmCJfKMLB/spRAzj9dOjFAq8aFijSVCTTH77QzK6hxpy2bc9oh3+FfM
	 Us0G+82VB3DePaUogQyJ5BdVIW9noU4okeHxBUjA4qlQ33inVnJkbO83pXGpsj9I1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UUIAycOK;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92060606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 02:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92060606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UUIAycOK
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380c28f9e35so484976eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794882520; x=1795487320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypFwQA0FZOPRuiqI0RyJwEY/z4AuSyUwMT7yZK7iq/g=;
        b=UUIAycOKp8saHa3hRn/60RdoK9ypwBXAxgMsedsROiE7Kq5HCJ0vR9h/QzRk63ncXw
         s76HKQd7otKxOUM6wG56oONR0zaKQxxusnekj5ajpK7acbCGmUctYK6+h//RHM013zW6
         V20Flvt7xwcvvwy7M4IOt+8RMVmtwQbmxmdXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794882520; x=1795487320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypFwQA0FZOPRuiqI0RyJwEY/z4AuSyUwMT7yZK7iq/g=;
        b=lTcnSUA5z/ek2VBax1VQNH9FVijIVNZYfISqm2OI5WDNLOjHWrtzE1JbRuvdiNXbV9
         s4jgxi4Ff/qumhi1GB2UWvTE82+Ls3LzXQZK8c5zqkOyG8EzIax4p3w3uZLh0jfcucZC
         ZNpIKpLOsWMgvt9wdYZJ/bssib+ZcjJpnd8CaLm9ANV2y+yK1WQALyfknfyDDA63nkPT
         VoVCmAz3qqngd3cn5gJpxiPgEhLQuBl3fJeGtRn+9Dx1mzhiINdu21BSh6RBwvxXuPnK
         CllNUWyZoVnZIUcUyf9XdZPDkzrU9Hg/+hlTMNvS+elJmtYaVM93a6ZOv09rrJ0BOBq7
         mj3g==
X-Forwarded-Encrypted: i=1; AL+hErEXWTMEpjHb/CUbev4txqCw+kkReYX4fRajtmuXFzNgQPDKCpUUbt+9zhBpyhLnqg/Smkk3xQ5+76Px76ETtqlTtwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z98EFDCgM+v6BS9f8+CK67lb6ilLxErRFHphH7CxSp0A+MY35zc
	AG52FBH4LZnM+PnAXKOmL4Catalge/ZwHIPhu95nsiV+rPs3fx5rqDeHXl4UT58ULw==
X-Gm-Gg: AZFdTZeRVN9Hiq1lkWhcNjA+zBtT/hJ6Xmzueay5q99KtO59PWaneeDbaE+TXoLrv7p
	VoL6KTXOKTiVGs4uqQPf1jaurQorj771s+HIKnfn5O8EgOvGwIJKGLmiwY9J6otIl+GoscUWdp5
	XGLxM+1tQj5rja7DHSUNKrf7Rxq27XWSmROnYFKE0+aa4LiUfpIX9O3+Gt4l8bokbHQdSqAPNTz
	IX63vbRAcMWPzvFrkvYNmPTGeobBzCuh3bclTdMC9GkTXlLvmYfKoG0OX+VckPV+mUwJaKPjX45
	MRW9jaIA+L3dahTE+wrk9Od9jAFpZiARou3wwwbvyOJMHOmGllfOI2aDMV9VittOCQsWj535Wac
	eZCH9aDQ2rzNspd7uiPSVAM8DjYLPIJUWENpbPKxHZBdZ2VZpkxiGOF5NjDyAsGGc6JiIQnZsKE
	KKJhDZE0EXEOrL/tJ/f1ogdYcHrwZvZyyhOhim5NlP4husq9cm4L13ZGb6zq9YZ2rtpR4MoSVeF
	944dWcj959JqCEY4IFCW7PrT0xlVoDRxyNjUxM3Ea4nm8R+4JssNLtpF9bS3sEkS+uX/2nVjBfd
	8C6BYzoUKiLFKbMxM6oycN7DIkr9m6UJ9Owyo3Q+Ayv8pOwfNvjwjyxnrEDeJ5vL8/4p
X-Received: by 2002:a05:7300:b21:b0:36d:158c:e31d with SMTP id 5a478bee46e88-3810f21a0bemr1286841eec.18.1794882519385;
        Mon, 16 Nov 2026 18:28:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-380d5135221sm3648441eec.24.2026.11.16.18.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 18:28:38 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] tracing: Properly match strings that start with numbers
Date: Mon, 16 Nov 2026 18:27:10 -0800
Message-ID: <20261116182710.1.Ic0625a2bd2e6f8960c0f75e5d15f14f3c84d1d38@changeid>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
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

As an optimization, set_ftrace_filter supports writing indices (numbers)
instead of function names. This support was added to the generic glob
(fake regex) function, which breaks the ability to filter string
patterns that start with a number. For example, PCI device names tend to
look like '0001:01:00.0', and a reasonable filter might be:

  echo 'name ~ "0001:*"' > /sys/kernel/tracing/events/rpm/rpm_resume/filter

Move the MATCH_INDEX code out to the only place it actually was intended
to work -- ftrace match_records(), with a 'func' and no 'mod'.

As a side effect, this also fixes :mod:<module> function filtering for
modules whose names start with a digit.

Fixes: f79b3f338564 ("ftrace: Allow enabling of filters via index of available_filter_functions")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/trace/ftrace.c              | 3 ++-
 kernel/trace/trace.h               | 1 -
 kernel/trace/trace_events_filter.c | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d36d..6654da9d1bbf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5029,7 +5029,8 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 	if (unlikely(ftrace_disabled))
 		return 0;
 
-	if (func_g.type == MATCH_INDEX)
+	if (func_g.type == MATCH_FULL && !mod &&
+	    func_g.search && isdigit(func_g.search[0]))
 		return add_rec_by_index(hash, &func_g, clear_filter);
 
 	do_for_each_ftrace_rec(pg, rec) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0635503a31dd..3613476e5508 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1807,7 +1807,6 @@ enum regex_type {
 	MATCH_MIDDLE_ONLY,
 	MATCH_END_ONLY,
 	MATCH_GLOB,
-	MATCH_INDEX,
 };
 
 struct regex {
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..07ce75244233 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1118,9 +1118,6 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 
 	*search = buff;
 
-	if (isdigit(buff[0]))
-		return MATCH_INDEX;
-
 	for (i = 0; i < len; i++) {
 		if (buff[i] == '*') {
 			if (!i) {
@@ -1158,8 +1155,6 @@ static void filter_build_regex(struct filter_pred *pred)
 	}
 
 	switch (type) {
-	/* MATCH_INDEX should not happen, but if it does, match full */
-	case MATCH_INDEX:
 	case MATCH_FULL:
 		r->match = regex_match_full;
 		break;
-- 
2.56.1.703.gf848ed807c-goog

