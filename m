Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819031;
	b=uK70KYNDPf/ghAEgotqDfHCBwUlTl4Ws1Ol+4ofQFsN5rNyNYFntSNbSopowkrjV+0Qk
	 Nb75FXruxapjfm91hdkLrNsmZrm5YiN9BW7CZElRz9bt+ycDcIxl67DeM2Ia50Hr6KZUW
	 nLU7AzfZvoze6bNb4lPLWoDahJXLKQmOd0X912/dYJlgOIz9PmkdsTqdmW4pzFfoaHAWF
	 UJCIth3biTCJTzD1aUnj4Vi87eVJ02CerbgNtv0LE2H6b8bpiQMZBGFAmsWg3ak7uQmCf
	 mV2kCcz+LDCCkoItGFmNINjpASKp6H5R8Zb+OfR/MTwIEKIo6Y6jlZAG8q3btnvXiIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7OmYkeQjJlaMAhfwUdrmcvladMFZs0EhQUj92Kic0fE=;
	b=dZZAHoC67vQ7cPbOSrEacA5k6SNnCfzSe54oP4pytpJDLbB3Ya8WWwCk2KoAbn9xzFpK
	 MSoYga8nwnU5I6s8HSlgpE4uBVpi4HMHn4NWARr9m3KetdNK43Wc7HzILaKQKVEvJI/gc
	 +Hc8SoS6bP22AzUuPk5refNnzCFop5BfUL9hJvMONQ6chGnOFVHGlWqdh75x+V7dnfc+c
	 yYIUuHx4X71TbPM8G242XulvNIOZ3OmFaD09Qa6zV47UX8avpHBo7K/9xX7vz3yWpciKq
	 93pBK6+MpSyZXtAE4GQsm1cIcCQijpXrMVtCsqZeNE6u+GnxL94qC2XAjZD5u4oJVog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZfVWzrV5;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4101606D830
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4101606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZfVWzrV5
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so3565734eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793819030; x=1794423830; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OmYkeQjJlaMAhfwUdrmcvladMFZs0EhQUj92Kic0fE=;
        b=ZfVWzrV5Ph+pnMdzkqWZHB6km29f5dMyqz84Cy0eNlvyr2lRAqykfmwNbW08Af7F/m
         nXWxvnxdfJSDtQFgn2g2q/wm9NRQy4IBOiLA9E8vkM1ec3AHrBeW5k4oiC3nKQr+T6to
         I9HEJMbGLWKipIjLA5TIqz99BD+hvtio3/DE+fxhjhuKVurgv/hR1fpQizssAg9TMWFx
         BUN+4XxheEZjKzgl0PNPAb/KYxtTUf8G+05ikas+WoOvJzJzlPegj5TBovbEIweuWts2
         cJXTypM+sjYf5JEqaKl+94WVS5fKvXTUE5aZlck0kl0PatyfgRGl/LoDFEhj+i7xBtFu
         C64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819030; x=1794423830;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OmYkeQjJlaMAhfwUdrmcvladMFZs0EhQUj92Kic0fE=;
        b=JQlb8iLh8oakzyltewIX0F5wFq+2nKEVqwdaXLL/dMgmtl7mMLv6vdm4v9OD75C4TH
         rctSjmLkyhCtzM0lww1APEsCl/Z36bmFd/GMEBaDPJdnL8e/9NzjOr+EYX3u9gq80dM8
         bfJjSJz38jb94mvrjfNLriKFV3tCATEMl7r9teyE2It/0iqemezMh5nWzduANYNWQ/ea
         W0q7p6D+HVJqiWmcitb+9SHXX7fz1u45qfgD4IgcDPahga6oYiIITEty4OROzxjHO9JZ
         vnI/lzpNoWkUTskz083WEfnfyjoUWKSwoE4mDzspyPA+phhxMAku5tnEvB3X9z1ngldX
         9Fyw==
X-Forwarded-Encrypted: i=1; AKwUvBwFZqkarvnXwdJOqNzTPO/sIIT8o/1S8/MkoqL6qfUyLYDd+1KVZuNAycJz1ZGHydlc7oL6+CFicJwMQk2SXWDUd9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E4x6Xp348aJh2Mw1J4W88EhY49pAVz1c+CaO6rlzy9qXiJw7q
	D9dyMOXaoJ9HkUM7p1GNCcf5w+f9FhTYqTKM8No16kI7pGysZEhDplhO818U0yrd9tyVH67E+hR
	y2Njo0wnzgbGEzXJPf/cS79+LE2EPy5K8CQ==
X-Received: from dykb32.prod.google.com ([2002:a05:7300:8420:b0:353:41aa:1e9d])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:f3c7:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-36bd3dd3294mr7405560eec.19.1793819029200;
 Wed, 04 Nov 2026 11:03:49 -0800 (PST)
Date: Wed,  4 Nov 2026 19:03:40 +0000
In-Reply-To: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <14ace814ca8c05196ebecb150cf710399a040b59.1793818636.git.abhishekbapat@google.com>
Subject: [PATCH v5 5/5] alloc_tag: Add a test for trace state toggle and filtering
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
 .../alloc_tag/allocinfo_ioctl_test.c          | 114 +++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c b/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
index 74fd64b2370c..300460084d9f 100644
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
@@ -514,11 +520,107 @@ static int test_lineno_filter(void)
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
+	if (target_state)
+		filter.flags |= ALLOCINFO_FILTER_FLAG_TRACE_ON;
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
@@ -526,6 +628,12 @@ int main(int argc, char *argv[])
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
2.56.0.506.g506a7eabc5-goog

