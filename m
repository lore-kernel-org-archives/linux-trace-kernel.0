Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415F51588F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026021; cv=none; b=ixYt+ACYvE/tcwot3a5X0UXbHDsfVKqTCH955SFqqWNU4472/785cuQWiH0ucgU6Smurjg2jKklcbA7H7HI+34i/nuC/mEAf0wPmOp+mjSdJ7rJUsi13TtcYU87XWatSTc3zwTi04oWZj1FY0Milv/5gXfxEy3nY5dlDrQEejvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026021; c=relaxed/simple;
	bh=rK6SJyn/YB5/uhpulKVt3Q8tkfBa+5FtGVb4YmpINQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SWSzp5IJTKF5J7LYq3OdI02tGf1yf40gXuGvoHWgjpxacdVD73c8HoesDNpkV9O09C9JwuGQ7NfMdGYwUbicXOaL0jLc6Jh/CgiOsCI6y8kmPknCuqVoOfJIAvCciDf32NfKDfeas94s9zM5g3cjczBvk6usABMF9F8GNm8Jkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubio37gH; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubio37gH"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2707373a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026019; x=1790630819; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4svBVXpzXDnEEaPp2iHW0GefZCmj3wqJ5HrNnYa0oV0=;
        b=ubio37gHhkwD6IGHCuB3yEkukouUOZQI13D4gcI+a17hw+yRSXks4hwn3EZ2pc7sRM
         sJKskkg3mLWjC8tn7wPecG/GPAK5sL/AhW8AOiQauU4uU7YOf7aVUwwdfIW3B3J16d+s
         SofUi0a8MGK6pYXslU3n1hYClRaxr6S+LFZ2TgWCC6RyZR2x1Znn0ItY/v7r6rkyWSR6
         mbzqQSs8UR+dw6YglQEUwWZlOhrgdvaHIPygu4WdSL1w3pNjqSXaQGv9qeIcIAQTndOj
         1DFsnJ5uvBekOWoRr143o4jUQXbnNTIYRNr1AcPOQuocTrqomCYf6b0S7T0AY/JVAx9h
         putQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026019; x=1790630819;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4svBVXpzXDnEEaPp2iHW0GefZCmj3wqJ5HrNnYa0oV0=;
        b=aUSyVK6wwhCAst1l6cpyD6cfer+2uTrcoZ7xxRyd+LqnZUF5ydJ/O5oVfT9AxMr07l
         5w9IQ/1gaCJOmEqN2jYWjb4+vARD+RFaejRAyEmuAQ62FKJX3ifEc4rMT6ooboBozVYI
         8o9Dz02HW3hDM7FoDDdy/5Y0d4ORROYkaeB/CGKQ6DLuNhSNBa5BZiOugU+/zVuNOpH+
         B1J7OIIHyNjvHuhifVl+kra/g3gHJtJPcLV561Toa8ETrbQmg/fz7+4L7HiPnvwQJ7AE
         oF6yQaunaPDwMbwQ0UPEc+hAsqLx5N8q14i06JBA80O4BNtG7WkRC3aMNYP4TmF8g/ff
         y2ug==
X-Forwarded-Encrypted: i=1; AKwUvByxalNfMZnTmVKdz2MPPWJIFl6ow1zEOx/ntjfK7pZ1HjjZCK8W06R9hkVvVwN0jejfvgGv0avY7YqTkKB+SleuHYM=@vger.kernel.org
X-Gm-Message-State: AFuF++lTAWsD0dX9ZC8ICX83nVFl4FIMjSo+fjEB0641nYRARGok/Bu2
	A49R5/EyvZX1jSYVVy9nOVCGlPB3ibdNCdITU88Dnxv3apfMeL+G+ARRkL383tBlo8C2PKXe46H
	04Mj70zEEJvxNU4Gj/1ias6SXhhxKXTCJWw==
X-Received: from dyng28.prod.google.com ([2002:a05:7300:7f1c:b0:339:c3e:449b])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1393:b0:3dd:a195:dd61 with SMTP id adf61e73a8af0-3dda195e47amr11865501637.67.1790026018871;
 Mon, 21 Sep 2026 14:26:58 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:26:41 +0000
In-Reply-To: <cover.1790025465.git.abhishekbapat@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <988dddb203416668a10bc9c5e6157a78615d2ed2.1790025465.git.abhishekbapat@google.com>
Subject: [PATCH 4/4] alloc_tag: add a test for trace state toggle and filtering
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the introduction of the ALLOCINFO_IOC_TOGGLE_TRACE IOCTL and
ALLOCINFO_FILTER_MASK_TRACE_ON filters for selective memory allocation
tracing, update the kselftests to validate this behaviour.

Introduce `test_tracing_toggle_and_filter`, which validates the
architecture by:
1. Dynamically toggling trace execution ON for a designated allocation.
2. Evaluating that the TRACE_ON filter precisely isolates the active
   target across the IOCTL API.
3. Verifying that the targeted allocation correctly reports its
   `trace_on` metadata state as 1.
4. Toggling trace execution OFF for the same allocation.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
---
 .../alloc_tag/allocinfo_ioctl_test.c          | 111 +++++++++++++++++-
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c b/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
index 74fd64b2370c..3ef7a12fe35b 100644
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
@@ -514,11 +520,104 @@ static int test_lineno_filter(void)
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
+	toggle_params.fields = *target_tag;
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
@@ -526,6 +625,12 @@ int main(int argc, char *argv[])
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
2.55.0.1082.g2b9226bbc0-goog

