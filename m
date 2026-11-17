Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882523;
	b=bpza8kUjSaUEBucgRJ4Ol/nHgQ+RzX2v8DL8x759hscfPUvWk1Ik9LOTrKonUcE7UJvg
	 XZbMvqDh+/G07Ro7Xodg7AXSHJwlGm87tRY/erBW0Mb8cYdfVrwpJJdLgyxTS7c1OALi+
	 I4Lx/EZUxkgV4eI01ZK0i2ON6cnW07nVjSAkap+CrtN/djDTs0HUswYnX7s56rBXigVlO
	 iZDDCk0wfwr/QbKANU/yDZZ8QsargC7tkaAsdSe+dgl9oIHusvZ2iP+wHZECpQBojCtlO
	 s2aGhXp6TZsPR0no48K6HdoNJHbGpl+cEC8/K6RPkhgihHYPcF5LvF7nJFpBCXX38xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bL0PPxjIvEL6hVmCZdriwAe6JLC2fG6POL7ld3LJpH0=;
	b=a0jaFly2IIuBFI2Eo5HESeHnbYBnUznWxhWIIOnHJVJpK+QfLAk98QBNLiY4gjMRc6p4
	 ceYz/PVwLP61r/8gHqPK/Sler5K7cJuxuo82Ldj/lhtxRUIWi2sozNpopH0dmEL6ItWOz
	 rqVB287OiR9tQx2VqfmE859CXU8R4yezljMR5Mq8wHgJKQ8tvlVGZCHMK64+ksvOD4EE/
	 dqRzM3YJIOSaW9dQ0GZmftkdJlJvm0V30+aBhB96iffaFvjktH1QlYRYwvMSJwbDvHnPp
	 Sh8YeVDorDs1RIfKE91OqckyObF1aqy9DBqks1idHP9ERMfHl2TKNeOxgyxOf5ZfGMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ji8nKQK0;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDD606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 02:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95FDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ji8nKQK0
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so83661eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794882522; x=1795487322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bL0PPxjIvEL6hVmCZdriwAe6JLC2fG6POL7ld3LJpH0=;
        b=Ji8nKQK0LfJB18ltdwI7lWUon6kcsIhCKlygC6ST/FoiXqPoWHljTdSpyw0rqMHYfR
         yZ6uscIEwiqiTTGLwZFhMomKnX09m5kbxmL15ZCI2xnAE4uZfNJkDoxsqnIGocgcsM1d
         1pYb6Ta8IHFFCGSTz4GDM9UxY3jrBejarfCWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794882522; x=1795487322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bL0PPxjIvEL6hVmCZdriwAe6JLC2fG6POL7ld3LJpH0=;
        b=YcWD1R5ddh1yveICuCGjeq+AtLdwhRvM0S+tas7Dv5YecvGLCVoU5y5mwFEsrn42Dl
         jdnltuOCPmqSulsW7mTHOYbrKTWzcJ5ZsTBLQ9oAT1Xtczt6ww70G4vOGfTHcUhaL8CP
         4oia05LYUhpfksMSEhAcL/6vwn3w5D9ayoSJf5INwy3L9UCTBZNft0x31d3VimQZTsIv
         bOKiJWD9//LmjRgmX2/5xy+dcloiATb/004P+XzZ/DQgl7v0NzSfZoXBM7dKzvweeKpq
         ouqS92VbXYaKgeWSE0Czujyhxa8UM7u8Zprw0KuAMqUyfyk6+Cl7so39kxY5sZKPHuyN
         y5mg==
X-Forwarded-Encrypted: i=1; AL+hErHe4lIq+nmfU584tBRIo5XCJCwTHaaUqtAaS2CLbW1KC1n2U5IgX50ZPuBuJJwxwM/35VVtg3OOZlzK8wrm7WrTIo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QRe8KGRDSdXuvW67oHUzncZ2ypyq+RKtxOE/JLAUafmDdx/g7
	0t1ws0a6VMq3Z9RlPnxIlz97xdcBHZMkgQb5BzHVZFgCzel2bYWK3RTWWyQ81x6YrQ==
X-Gm-Gg: AZFdTZfNloup/skCGjej2IEkTKD8WwTPKZESMCttzU6Poow+4KkXZ9hxGNT6AVY9j/B
	679EjAASA0hlKY9sAg+3JhW8eAAUmUaDau4nXfe/bTSI4SKZIMjq+SxBybqct/9kwCbhYEJzMJT
	z7K5dnI09ZjZVHHShMO94OmaL3qDdOYJaTmIX1JZduLD3HGoukT/ok8nCeNB4YyFyl+hEQMzQlx
	exiNIXlzu/0Aa0nHZVTqr5rdwzQwqxLrot/t73L3fPo7BEEd6Ua8Ste0pxfMwi4DtK0jscmKbCo
	/nRE5c1zz/sBZuYH2o70/ApnqRXRXJa1EwXHtcnTpaRp75Tl1aQ/Yvt8imIPm8kPiDpdo8bXe7h
	46bltmnE4MLCJfdenXLZ5RGRNAFF+cL6TCH1P79PAGGYZy2pD2SSx0qhrB8IIvcYkvGZbkf6b19
	b/7rCj9mLzUOpHS8O1vUbgb80Gn7TBqYKRsNGzK4iJJipKCsZaaq2p+EFbApTpWw3BGjerhqtZt
	1P6HGVXygWJjf0FJ3+67tHIGp5PIRvo71vylYmgHJBSujkKXIthp4nij8gw5NQknZJoedmQpvE3
	Iqr3sfgEWErmoApB/Midyj803a5EWApRLsXWIyC24SHT5EILXhvF0RWOAGq++tF9x81J
X-Received: by 2002:a05:7300:fd0f:b0:36c:da71:37e0 with SMTP id 5a478bee46e88-37963564bc7mr16626879eec.2.1794882521654;
        Mon, 16 Nov 2026 18:28:41 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-37956bad6casm37765457eec.26.2026.11.16.18.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 18:28:41 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] tracing: Add tests for globbing number-based strings
Date: Mon, 16 Nov 2026 18:27:11 -0800
Message-ID: <20261116182710.2.Ic117871c2b1e94c5a2176903a5c3316a10584e61@changeid>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116182710.1.Ic0625a2bd2e6f8960c0f75e5d15f14f3c84d1d38@changeid>
References: <20261116182710.1.Ic0625a2bd2e6f8960c0f75e5d15f14f3c84d1d38@changeid>
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

In "tracing: Properly match strings that start with numbers", we fixed
bugs related to string fields that start with a number and also use
globs instead of full matches.

Add some additional startup test cases for this.

For easy reproducible testing, I abused the kunit.py script to boot a
minimal kernel with FTRACE_STARTUP_TEST enabled:

  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
      --kconfig_add=CONFIG_FTRACE=y \
      --kconfig_add=CONFIG_FUNCTION_TRACER=y \
      --kconfig_add=CONFIG_DYNAMIC_FTRACE=y \
      --kconfig_add=CONFIG_FTRACE_STARTUP_TEST=y \
      --kconfig_add=CONFIG_EVENT_TRACE_STARTUP_TEST=n \
      --raw_output=all deadbeef

Relevant line:

  Testing ftrace filter: OK

Without "tracing: Properly match strings that start with numbers", the
test fails with:

  Testing ftrace filter:
  Failed to match filter 'str ~ "0001:*"', expected 1

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I was torn on whether to add to CONFIG_FTRACE_STARTUP_TEST, or to add a
KUnit test (such as in kernel/trace/trace_events_test.c).

The former has a bit of precedent, since the existing match tests are
very similar, except they only operate on integers. But the latter
generally has better tooling, and is more consistent with how most
subsystems write their unit tests these days.

I chose the former for now, but let me know if you'd prefer it
differently.

 kernel/trace/trace_events_filter.c      | 74 ++++++++++++++++++++++++-
 kernel/trace/trace_events_filter_test.h | 12 ++--
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 07ce75244233..37985168290a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2784,6 +2784,8 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#include "trace_probe.h"
+
 #define CREATE_TRACE_POINTS
 #include "trace_events_filter_test.h"
 
@@ -2795,12 +2797,22 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	.match  = m, \
 	.not_visited = nvisit, \
 }
+
+#define DATA_STR(m, s) \
+{ \
+	.filter = FILTER, \
+	.str    = s, \
+	.match  = m, \
+	.not_visited = "", \
+}
+
 #define YES 1
 #define NO  0
 
 static struct test_filter_data_t {
 	char *filter;
 	struct trace_event_raw_ftrace_test_filter rec;
+	const char *str;
 	int match;
 	char *not_visited;
 } test_filter_data[] = {
@@ -2852,9 +2864,46 @@ static struct test_filter_data_t {
 	DATA_REC(YES, 1, 1, 1, 1, 1, 1, 1, 1, "bdfh"),
 	DATA_REC(YES, 0, 1, 0, 1, 0, 1, 0, 1, ""),
 	DATA_REC(YES, 1, 0, 1, 0, 1, 0, 1, 0, "bdfh"),
+#undef FILTER
+#define FILTER "str ~ \"0001:*\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(YES, "0001:"),
+	DATA_STR(NO,  "0002:01:00.0"),
+	DATA_STR(NO,  "pci:0001:01:00.0"),
+	DATA_STR(NO,  "0001"),
+#undef FILTER
+#define FILTER "str ~ \"!0001:*\""
+	DATA_STR(NO,  "0001:01:00.0"),
+	DATA_STR(YES, "0002:01:00.0"),
+#undef FILTER
+#define FILTER "str ~ \"0001:*:00.[0-9]\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(YES, "0001:ff:00.7"),
+	DATA_STR(NO,  "0001:01:00.a"),
+	DATA_STR(NO,  "0002:01:00.0"),
+#undef FILTER
+#define FILTER "str ~ \"0001:01:00.0\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(NO,  "0001:01:00.1"),
+	DATA_STR(NO,  "0001:01:00.00"),
+	DATA_STR(NO,  "0001:01:00"),
+#undef FILTER
+#define FILTER "str == \"0001:01:00.0\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(NO,  "0001:01:00.1"),
+#undef FILTER
+#define FILTER "str ~ \"*0001:*\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(YES, "pci:0001:01:00.0"),
+	DATA_STR(NO,  "0002:01:00.0"),
+#undef FILTER
+#define FILTER "str ~ \"*:00.0\""
+	DATA_STR(YES, "0001:01:00.0"),
+	DATA_STR(NO,  "0001:01:00.1"),
 };
 
 #undef DATA_REC
+#undef DATA_STR
 #undef FILTER
 #undef YES
 #undef NO
@@ -2905,8 +2954,29 @@ static __init int ftrace_test_event_filter(void)
 	for (i = 0; i < DATA_CNT; i++) {
 		struct event_filter *filter = NULL;
 		struct test_filter_data_t *d = &test_filter_data[i];
+		union {
+			struct trace_event_raw_ftrace_test_filter rec;
+			/* Add some spare, to append the string contents. */
+			char buf[sizeof(struct trace_event_raw_ftrace_test_filter) + 32];
+		} event = { .rec = d->rec };
 		int err;
 
+		if (d->str) {
+			struct ftrace_event_field *field;
+			u32 offset = offsetof(typeof(event.rec), __data);
+			u32 len = strlen(d->str) + 1;
+			u32 *str_item;
+
+			field = trace_find_event_field(&event_ftrace_test_filter, "str");
+			if (WARN_ON_ONCE(!field))
+				break;
+			if (WARN_ON_ONCE(offset + len > sizeof(event.buf)))
+				break;
+			str_item = (u32 *)&event.buf[field->offset];
+			*str_item = make_data_loc(len, offset);
+			memcpy(&event.buf[offset], d->str, len);
+		}
+
 		err = create_filter(NULL, &event_ftrace_test_filter,
 				    d->filter, false, &filter);
 		if (err) {
@@ -2928,7 +2998,7 @@ static __init int ftrace_test_event_filter(void)
 			update_pred_fn(filter, d->not_visited);
 
 		test_pred_visited = 0;
-		err = filter_match_preds(filter, &d->rec);
+		err = filter_match_preds(filter, &event.rec);
 		preempt_enable();
 
 		mutex_unlock(&event_mutex);
@@ -2955,7 +3025,7 @@ static __init int ftrace_test_event_filter(void)
 
 	/* Need to call ftrace_test_filter to prevent a warning */
 	if (!trace_ftrace_test_filter_enabled())
-		trace_ftrace_test_filter(1, 2, 3, 4, 5, 6, 7, 8);
+		trace_ftrace_test_filter(1, 2, 3, 4, 5, 6, 7, 8, "");
 
 	return 0;
 }
diff --git a/kernel/trace/trace_events_filter_test.h b/kernel/trace/trace_events_filter_test.h
index e651dfbd345e..74a9dba91545 100644
--- a/kernel/trace/trace_events_filter_test.h
+++ b/kernel/trace/trace_events_filter_test.h
@@ -9,9 +9,10 @@
 
 TRACE_EVENT(ftrace_test_filter,
 
-	TP_PROTO(int a, int b, int c, int d, int e, int f, int g, int h),
+	TP_PROTO(int a, int b, int c, int d, int e, int f, int g, int h,
+		 const char *str),
 
-	TP_ARGS(a, b, c, d, e, f, g, h),
+	TP_ARGS(a, b, c, d, e, f, g, h, str),
 
 	TP_STRUCT__entry(
 		__field(int, a)
@@ -22,6 +23,7 @@ TRACE_EVENT(ftrace_test_filter,
 		__field(int, f)
 		__field(int, g)
 		__field(int, h)
+		__string(str, str)
 	),
 
 	TP_fast_assign(
@@ -33,11 +35,13 @@ TRACE_EVENT(ftrace_test_filter,
 		__entry->f = f;
 		__entry->g = g;
 		__entry->h = h;
+		__assign_str(str);
 	),
 
-	TP_printk("a %d, b %d, c %d, d %d, e %d, f %d, g %d, h %d",
+	TP_printk("a %d, b %d, c %d, d %d, e %d, f %d, g %d, h %d, str %s",
 		  __entry->a, __entry->b, __entry->c, __entry->d,
-		  __entry->e, __entry->f, __entry->g, __entry->h)
+		  __entry->e, __entry->f, __entry->g, __entry->h,
+		  __get_str(str))
 );
 
 #endif /* _TRACE_TEST_H || TRACE_HEADER_MULTI_READ */
-- 
2.56.1.703.gf848ed807c-goog

