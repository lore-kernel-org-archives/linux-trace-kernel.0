Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667038C2B8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486267; cv=none; b=HGgK3j6119FrynRMVaSbGRnnFOp7FzTrvr2atNDH573mcKSVd5LY6uP7e0C0d6yeuVVCxhNQKeWQHiP9JwAow3m0VE4JWMo1Gk/ReXbnVpYvJRP1h62hV3ZT+RGnSmMOeCBBTaLk2JZGNadDggad3CLc00SZgYmpLiHtIFSTxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486267; c=relaxed/simple;
	bh=p0D0SvAiOiNPeriwNwY4FWBYY3sdeg5voF6KW2g27tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBq+fQgCY6VX2Rd0Fgeg5LNFsnmanKNChzzToV4dD163OStR0Q6gbIJQtslDGmKGMw90KE46xqHStxjcbKWL7b6ui2/gP6dSnZsgHbzmI91q6w6PHG4aPZ5zbygcwTEfyLpqgvOhJBF+8HDPixTQ/S6SUKdb7n+kheHlRw/48TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwLpEvTL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwLpEvTL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso456228a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779486265; x=1780091065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0a6+9FSkd4CAvkhrb+PFN6/wUARChFwi4N+F/39VGM0=;
        b=DwLpEvTLoqJjuEz0UqBazmZVWL6k9IHJGqD280ZZJlRAV7r7jZpNsz+h2DQa4c51Ul
         2QJo1U3f609RCjKSCCbjTaj4sedh4m6hZ64yMXxa2AuqgZ16m6vtUneKlobACEPppVux
         S6fj9yfhzN07m5HunFd3E4wU78jBdxjQbPceHhL2WRLjhWGB709J4uNckMHWPThU3TdS
         pBYgWBqk69m33dydg3um6gZX54EOdy3KQqHjZBf/h6deEYd3JHV9cpV2H7STzgkdze+I
         8O92bIvyJI5Y9YV9kqTASMeyMGcHQa1XSRwbMWVJOQ2VgyOKVQm173HtCI4ie9kUDtX0
         VEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779486265; x=1780091065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a6+9FSkd4CAvkhrb+PFN6/wUARChFwi4N+F/39VGM0=;
        b=GD9dfMsy0eoy/BstYWCv0Ln1hB9Tt1j9L3Srh3gDiUhvYgcgEKLmDZbnkDikwMu4Z6
         UD6QjV0pDXAH76auQg5OeDSqIARC8DEpF6xkU+Hpb0MbdCQNMm9tCSwESkSj+T4dr74a
         XwVh1Z1s0+7pvlH5T5SZU+i5vX11oRw4c2wuC/pdxUtziN92qru4NlTHC2uXcJoRfzNS
         Zw8Dq9sXfWoN5pcIzAyhVxaF/RBQAQwlxrV4IRonR/r7xrzHMPniM9ZT/c6hs9WXNQ/M
         Iuj6YdiEuvKY5ICZeIT/31nR4E6tJLhInvN1t+VgW/nVcIARbLqNU0eCmAWI70T0xUzA
         q5Qw==
X-Gm-Message-State: AOJu0Ywcq3SQv4WX1DJQ+c6DJ5k24mavNqgSJEy0YX1eIfM/4XF8OpFR
	mAHmMBP5hoatjD8Hz64oYOiRXuTaUD2wSZz2iVjkPcWWxkfZ4rDmRZhzOOU4Wg==
X-Gm-Gg: Acq92OGc9X8QN1lQB+IZQ/1USRdFn4s5JrHGa6zXl7RT5AmWKF+gitxoNK2I1cdPrSq
	2i4lLCnflttBPoTAXzxKatRJz8PKl/v+F9wWrMY25lTiF2CY5wxanROuf/IB9eSnhUngXp+Nmzq
	+bvBmV32FHjjTUZu4XNFQpCaVVmR4xBL1Wlj5o5P2lvCPW6zbIjWJEcaEHaaIeKXyFbN+lazfNw
	vf7zv9nNNj6pk40r1yEqYSBGRCv7Riah3qvm7wJ5yOzdubSOauqOWm+4c5E8ODIpDalzdsY7ULa
	o8EqcwnEeiU4w6v07FHDwu+lTAP3vv/zOz1kG3UcuuJUIhbeXQwcKXvVVqzSK8gPAX5rI1JFV87
	8WXzEhRwyai9llxvz1qeLOu05cifR6Y1nZAzZzQIlTfNVoQUb2898kBczffMG6rDF0EBuLDG2M4
	lpSz+iT4Huq/If5HnJf0jyteuVrPiVhvP2t/df1jJKCVczkGRwHm+X7NPfLk7jMCsKIJDlrP2vw
	FOh7Bfjxxc5+92q1eTqymHOyNblKgh34LnTReWwtPE0Rg==
X-Received: by 2002:a17:90b:3cd0:b0:369:a962:8cca with SMTP id 98e67ed59e1d1-36a6771bd1cmr5194148a91.11.1779486265449;
        Fri, 22 May 2026 14:44:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c858csm2812300a91.11.2026.05.22.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:44:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] trace: turn hist_elt_data field_var_str into a flexible array
Date: Fri, 22 May 2026 14:44:07 -0700
Message-ID: <20260522214407.18120-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field_var_str array was allocated separately via kcalloc() with its
length already known at elt_data allocation time.  Convert it to a
flexible array member and fold the two allocations into a single
kzalloc_flex(), reordering hist_trigger_elt_data_alloc() so n_str is
computed and bounds-checked before the struct allocation.

hist_elt_data is only reached through tracing_map_elt::private_data
(a void *), never embedded, so adding a FAM imposes no tail-position
constraint on any enclosing struct.

Added __counted_by for extra runtime analysis.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/trace_events_hist.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a64c76f6905f..1fd0899c606c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -683,8 +683,8 @@ struct track_data {
 struct hist_elt_data {
 	char *comm;
 	u64 *var_ref_vals;
-	char **field_var_str;
 	int n_field_var_str;
+	char *field_var_str[] __counted_by(n_field_var_str);
 };
 
 struct snapshot_context {
@@ -1629,8 +1629,6 @@ static void hist_elt_data_free(struct hist_elt_data *elt_data)
 	for (i = 0; i < elt_data->n_field_var_str; i++)
 		kfree(elt_data->field_var_str[i]);
 
-	kfree(elt_data->field_var_str);
-
 	kfree(elt_data->comm);
 	kfree(elt_data);
 }
@@ -1650,10 +1648,19 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	struct hist_field *hist_field;
 	unsigned int i, n_str;
 
-	elt_data = kzalloc_obj(*elt_data);
+	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
+
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str +
+		hist_data->n_var_str;
+	if (n_str > SYNTH_FIELDS_MAX)
+		return -EINVAL;
+
+	elt_data = kzalloc_flex(*elt_data, field_var_str, n_str);
 	if (!elt_data)
 		return -ENOMEM;
 
+	elt_data->n_field_var_str = n_str;
+
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 
@@ -1667,24 +1674,8 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str +
-		hist_data->n_var_str;
-	if (n_str > SYNTH_FIELDS_MAX) {
-		hist_elt_data_free(elt_data);
-		return -EINVAL;
-	}
-
-	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
-
 	size = STR_VAR_LEN_MAX;
 
-	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
-	if (!elt_data->field_var_str) {
-		hist_elt_data_free(elt_data);
-		return -EINVAL;
-	}
-	elt_data->n_field_var_str = n_str;
-
 	for (i = 0; i < n_str; i++) {
 		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
 		if (!elt_data->field_var_str[i]) {
-- 
2.54.0

