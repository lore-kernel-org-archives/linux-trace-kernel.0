Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440035;
	b=n2exSeaUViXqOyyA2koICB1CfOjVQg9x4Ox3vGqr+slmEebD0FB19JJAvg4i1ag8zWj7
	 +NcVxHFinTHmDpI8WMrPBnwv5lIxhMJvJcHRlwwt/GyJ+vE3SSpnCsybfH5KnfZbaXUdH
	 5Se6NSl28TETrrDfYcWPXaLjDXDtl2jJsIoPpxthsqdtioyBDC+BXB4ZEWwMv/c4TcC4R
	 kpcd0iEg40EMSaQbVL4G4oxiGpjgueIfEfynAFXE2Q0uYrMokk0qtAVm9MupPupz8NMQX
	 hLqYd20QcwVlWM0HSIgIRrvwfbqdjSHFXaEfVrtIcinuI1nVuIz0aAQOlttTSNxoimA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SBnUl1ocqF3UAQpeER9AJDXEwbZWvYBxgk+LZjJZJiE=;
	b=pBBXd9juxKgycFMptVU1wf/P46qfqhCDd3Q5QVsVMgGBM3JQwvpMqcrYO7rstESCUxwS
	 32soz6HNUFrulwtrc9Bi0rcQc0AJBsCek1v/qUMwE69IA4qufyjg9rRHn52eg6eVzZan+
	 yEs4rniwdhDVocUYRPFfGg02WNIOtVpUnnbO8PnfoDzer4PaqMLnNMGbbRxBWmw5dzdJK
	 J+RUJujK8BvRkVRt9pi21VBj5JYZautPGWazI3fDfQSiFwOKhyMSAOoT4JylNV0KtW6Zp
	 MrjDybV49mdRBaNLT8sqFR0fc3H5N+iCA53SOOnYn4XJjo6nH8HhlmkwuDljP4vmutA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Cqm2+kxj;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7260A2613
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B7260A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Cqm2+kxj
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a4d2e39acso7338547eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440034; x=1793044834; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBnUl1ocqF3UAQpeER9AJDXEwbZWvYBxgk+LZjJZJiE=;
        b=Cqm2+kxjUrbWySDd/qFS5IuY1SBM28sbnMUEVieGnPuScEQJRGxm2mRaFkX8YvauQn
         KzUqjaZYeD+nmw1jaHumxrYby075GdQl5mbpQ4+whVWs7NjJ8yJjpBpnz3XPi0q/Fav+
         PcemuZT9QxzLIilSsPQheFo7vwrcyNG7rf9scE5MUWZKg7hFwfjqlTRieGLP+LXm31/B
         uD0Yla8dvkj+g5OJya6yu/jwdznage4+UVfPdyB/LijeQkRe7rpBiIqao+eqnJZWWe1G
         NDnVbJLmJeL7q/LvV9WvwJMpT38eQ7FS8UQ+K+XVJwYZBmGanYypRUZU9CfCkHtlhV7a
         Qe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440034; x=1793044834;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBnUl1ocqF3UAQpeER9AJDXEwbZWvYBxgk+LZjJZJiE=;
        b=gAOSIRhFaVeZWdPYkm750Bj/bL+JixdPyhhesz0s/i2S4GxOrekcCqtifeBqzQFE8Q
         ZEWOLHhpntEx0rvsFz6FFxJQC7O9OjsITG+m5Our5UNfD87+2U7s2NsEXRr7A1nwBGs0
         YZtn0SaP2AXDZnxAsS1OsRn64llSPvNMJTTwZ+LTT3lAnO1mt75hoID2K+0rw0WsUilZ
         Ck04Wdk+ywzAJbhrz45KyZFCMAmuu5LJWmXHdTKPVjBQ+iAvXowoxM1kDiafSR+RDzba
         YaQ+O5hCHnrSzxD2h9jiOanjH7pES6eKR7V5wlEb0/3V7xsJ+NOOmo0wv+beXjRMz8sE
         4kgw==
X-Forwarded-Encrypted: i=1; AKwUvBz6FCLV63O4mhJCerfxqqPDMvPpwohmlNO8t0SM6BDmvDeoqVtbZydPPIzxSHO5GlXJXJSW8nELeC+RKJqviINc1Xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkuOFvyPiOjToaekJ4L2AmBjNJqSVAFAhAxVn6qqGCf7VHgH6o
	F/oXZh4dmwsu8jRoccuEBquYwyTJ5vhAo7QgR3G9CZ8OyrToKrL8lGCbDlPl7rypqZQBTlh3Ifb
	rwHEnqD8Dxhdvnod9jax2XTHhssIICXmyjA==
X-Received: from dlbuy10.prod.google.com ([2002:a05:7022:1e0a:b0:183:f9d:1eaa])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7e8c:b0:149:1feb:6d9d with SMTP id a92af1059eb24-18512f1ca43mr13500938c88.19.1792440033889;
 Mon, 19 Oct 2026 13:00:33 -0700 (PDT)
Date: Mon, 19 Oct 2026 20:00:27 +0000
In-Reply-To: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <902ec60f33dc7bd4136100322565615dd9d2e61f.1792439751.git.abhishekbapat@google.com>
Subject: [PATCH v3 4/4] alloc_tag: Add a test for trace state toggle and filtering
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the introduction of the ALLOCINFO_IOC_TOGGLE_TRACE IOCTL and
ALLOCINFO_FILTER_MASK_TRACE_ON filters for selective memory allocation
tracing, update the kselftests to validate this behaviour.

Introduce `test_tracing_toggle_and_filter`, which validates the
architecture by:
1. Dynamically flipping trace execution state for a designated allocation.
2. Query the same tag again, and check that the returned tag reports the
   new state in its `trace_on` field.
3. Restore the tag's original trace state, also on failure, so the test
   does not leave tracing changed on the system.

The test uses `dup_mm()` function name with the function filter in the
IOCTL to run the above steps. If the `dup_mm()` tag is not found, the
test is skipped.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 .../alloc_tag/allocinfo_ioctl_test.c          | 113 +++++++++++++++++-
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c b/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
index 74fd64b2370c..eb52ca1a1dc4 100644
--- a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
+++ b/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
@@ -48,6 +48,11 @@ static inline int __allocinfo_get_next(int dev_fd, struct allocinfo_tag_data *pa
 	return ioctl(dev_fd, ALLOCINFO_IOC_GET_NEXT, params);
 }
 
+static inline int __allocinfo_toggle_trace(int dev_fd, struct allocinfo_toggle_traces *params)
+{
+	return ioctl(dev_fd, ALLOCINFO_IOC_TOGGLE_TRACE, params);
+}
+
 static bool match_entry(const struct allocinfo_tag_data *procfs_entry,
 			const struct allocinfo_tag_data *tag_data,
 			bool match_bytes, bool match_calls, bool match_lineno,
@@ -289,6 +294,8 @@ static int run_filter_test(const struct allocinfo_filter *filter)
 	return ret;
 }
 
+static const char *target_test_function = "dup_mm";
+
 static int test_filename_filter(void)
 {
 	struct allocinfo_filter filter;
@@ -304,11 +311,10 @@ static int test_filename_filter(void)
 static int test_function_filter(void)
 {
 	struct allocinfo_filter filter;
-	const char *target_function = "dup_mm";
 
 	memset(&filter, 0, sizeof(filter));
 	filter.mask |= ALLOCINFO_FILTER_MASK_FUNCTION;
-	strncpy(filter.fields.function, target_function, ALLOCINFO_STR_SIZE);
+	strncpy(filter.fields.function, target_test_function, ALLOCINFO_STR_SIZE);
 
 	return run_filter_test(&filter);
 }
@@ -514,11 +520,106 @@ static int test_lineno_filter(void)
 	return ret;
 }
 
+static enum ioctl_ret toggle_trace(struct allocinfo_tag *target_tag,
+				   bool enable)
+{
+	int fd;
+	struct allocinfo_toggle_traces toggle_params;
+
+	fd = open(ALLOCINFO_PROC, O_RDONLY);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open " ALLOCINFO_PROC ": %s\n", strerror(errno));
+		return IOCTL_FAILURE;
+	}
+
+	memset(&toggle_params, 0, sizeof(toggle_params));
+	toggle_params.filter.mask = ALLOCINFO_FILTER_MASK_MODNAME | ALLOCINFO_FILTER_MASK_FUNCTION |
+				    ALLOCINFO_FILTER_MASK_FILENAME | ALLOCINFO_FILTER_MASK_LINENO;
+	toggle_params.filter.fields = *target_tag;
+	toggle_params.enable = enable;
+
+	if (__allocinfo_toggle_trace(fd, &toggle_params)) {
+		close(fd);
+		return IOCTL_FAILURE;
+	}
+
+	close(fd);
+	return IOCTL_SUCCESS;
+}
+
+static int test_tracing_toggle_and_filter(void)
+{
+	struct allocinfo_filter filter = { 0 };
+	enum ioctl_ret ioctl_status;
+	int ret = KSFT_PASS;
+	bool initial_state, target_state;
+	struct allocinfo_tag target_tag;
+	struct allocinfo_tag_data_vec *tags = calloc(1, sizeof(*tags));
+
+	if (!tags) {
+		ksft_print_msg("Memory allocation failed.\n");
+		return KSFT_FAIL;
+	}
+
+	filter.mask |= ALLOCINFO_FILTER_MASK_FUNCTION;
+	strncpy(filter.fields.function, target_test_function, ALLOCINFO_STR_SIZE);
+
+	ioctl_status = get_filtered_ioctl_entries(tags, &filter, 0);
+	if (ioctl_status != IOCTL_SUCCESS || tags->count == 0) {
+		ksft_print_msg("Could not retrieve IOCTL entries for %s\n", target_test_function);
+		ret = KSFT_SKIP;
+		goto exit;
+	}
+
+	target_tag = tags->tag[0].tag;
+	initial_state = tags->tag[0].counter.trace_on;
+	target_state = !initial_state;
+
+	ioctl_status = toggle_trace(&target_tag, target_state);
+	if (ioctl_status != IOCTL_SUCCESS) {
+		ksft_print_msg("Failed to toggle tracing\n");
+		ret = KSFT_FAIL;
+		goto exit;
+	}
+
+	filter.mask |= ALLOCINFO_FILTER_MASK_TRACE_ON;
+	filter.tracing = target_state;
+
+	ioctl_status = get_filtered_ioctl_entries(tags, &filter, 0);
+	if (ioctl_status != IOCTL_SUCCESS) {
+		ksft_print_msg("Error retrieving IOCTL entries with trace filter.\n");
+		ret = KSFT_FAIL;
+		goto exit_revert;
+	}
+
+	if (tags->count != 1) {
+		ksft_print_msg("Expected exactly 1 entry, but got %llu\n", tags->count);
+		ret = KSFT_FAIL;
+		goto exit_revert;
+	}
+
+	if (tags->tag[0].counter.trace_on != target_state) {
+		ksft_print_msg("Entry returned by trace filter does not match target state\n");
+		ret = KSFT_FAIL;
+	}
+
+exit_revert:
+	ioctl_status = toggle_trace(&target_tag, initial_state);
+	if (ioctl_status != IOCTL_SUCCESS) {
+		ksft_print_msg("Failed to revert tracing to initial state\n");
+		ret = KSFT_FAIL;
+	}
+
+exit:
+	free(tags);
+	return ret;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret;
 
-	ksft_set_plan(4);
+	ksft_set_plan(5);
 
 	ret = test_filename_filter();
 	if (ret == KSFT_SKIP)
@@ -526,6 +627,12 @@ int main(int argc, char *argv[])
 	else
 		ksft_test_result(ret == KSFT_PASS, "test_filename_filter\n");
 
+	ret = test_tracing_toggle_and_filter();
+	if (ret == KSFT_SKIP)
+		ksft_test_result_skip("Skipping test_tracing_toggle_and_filter\n");
+	else
+		ksft_test_result(ret == KSFT_PASS, "test_tracing_toggle_and_filter\n");
+
 	ret = test_function_filter();
 	if (ret == KSFT_SKIP)
 		ksft_test_result_skip("Skipping test_function_filter\n");
-- 
2.56.0.218.g1ec904b173-goog

