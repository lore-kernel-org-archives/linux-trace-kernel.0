Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7F3EFFDB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752996; cv=none; b=m/l21VUqtd82ibyuO3V/frXi791utQdmltvlmDf+/PFfvkfJpG/ZGubJU/TXi3KUvx8yex4m95h2VzDPjyw1L2gU/45dOW5s8H53kUgtTwtwL9L/aN4/VF5qno/SMH6sAon3p2v+zwIgKzrF5PsDTmWc4fEb0neMSmto9gLbGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752996; c=relaxed/simple;
	bh=nSW4NsKwkvH7BmiQJChN9fC/TyPeSFa/im/kFV67DP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjEIDl/KlIm648IwV2GYySCGvHKUrHFh+rKPpqybVqtH6ePbLPpmghkXmHOdhoIfZfxZ07ChGMWd0cFZb/UMrerN00q2+GAFDAB5BVJxmdl2HTesJiYlXu+DKxGp0C0/7078Q3rdDhW19ulPX9eQZw91fp9sRzX4OM14cZDRSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxAtvJxp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxAtvJxp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8f265cbe6so22250175ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788752995; x=1789357795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7q+VNGVNrcoYTCPMYgbT4Asobyd71i+FBLenDRfuM4=;
        b=gxAtvJxpc8sRGfJuUKaxpjv6LQxsZgOH3Vfoocnp6ZXxkmiZzZkv3EDYKFJnRZi1z4
         RQazJOj+eWQCtQAw07vtefi2Iv/g2B9G7A9I88DqCoMDxUrBav7tZCAO8FTMiGTzZzNC
         tAzOpiKDGMCXy8IlItlydf7ObtxcMFTuXlFRCLC6UOVVxeiKerjT4DqzC6MqmsXcQ2cH
         oYkguADWGxJqREpaqHVrWwioMBrBBa7K/4aRCaDpEu9W5Npe0tFCDNYKXsfOa1CRh4Ie
         qYe4qBKZnzaQyX30lCJhdcQ8ntZUjeHsQHFuO1ODnrM4210Rww6ey2Wqx8Jjn4AprTFi
         csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788752995; x=1789357795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7q+VNGVNrcoYTCPMYgbT4Asobyd71i+FBLenDRfuM4=;
        b=TnqoaJ5jc+ICHTjH1+laH7sve3+H6gM5twxJS1ZH8ZH8zqsfkj99j5Thry/zuiuOpI
         3+GckDVuAhBV8QDIl+Zh+6GrMGYrZkEhbMe2TzQsUZntQQJmXOCOp6DqLB49yz6N4Cl6
         A7cRW7/HYsN78tulkbhyegW9gnfWG6ITitKydTJ+gq83YLGja9K0nTj6GophKxXRogde
         vQTUIqG1mrxgVJPKBRmgIQE3rFL0RN7idIk/zQIo7gZVWgnjK4WrIk7rLgYNAL8BiDI2
         f+g/bWhIwkYxI2fG7N1VX3qpnfI6y7FeWwO3ulauM0KcDKkS+s2hNewSir0ujyKaa4GQ
         G5PA==
X-Forwarded-Encrypted: i=1; AKwUvBzZWl+XAK6AqWCWpWgXkzE0s7oguSE4n2b0N5D0VP5txjPKpSCWuZ9mEWprbYXlInkOths7NfyeU8huluFpbYCt9zc=@vger.kernel.org
X-Gm-Message-State: AFuF++mn/pGu5IQrsDomgb0euvsFYTxaLerT72urwVuA96B/bS9ED2lV
	DtgSS6MSJtp1rBnRP9UzWc1zDS9CVClXRmfGLqozWybBco+b0kmx0e4=
X-Gm-Gg: AYBFou3qXrUbu+fQCuPC6jYFd8JejFhqSzhkkZWKLsU3cUZEO4y5RpoXNDAtrQiw2b2
	kEkSOwtwiORD/EtugPmgWskAQq3Zql9XmyKFJqrhxnoDqFqQTCPXZK8Tw48fyDivuCcC1ueA5Ql
	sWkM0JSLuxv9yRdDLlnCq2RyxUQq9O39apv1yPKLwEk3zzmvG4N5IBzLLy1NlvXSKpJka7gjveo
	ETJeKr4V/nkkxkocYm5j2xUk6p9eEInTGalOWp3C/d0/B1xWeT/zxEpiwlz7dn3O0yIuwjr5Te9
	AcVdbNfiGbVAXMkJW5XfFWH1UqpJOIjEL6TUYo2CVkKgN6hwapXyj/dqtjVaNOLHN3hPEliWsVn
	Nfj5jhXVaXMQlVarDF8nDus1qqQgmj178Ztingy17DEzsfhWKAufpdOOqHt/EjM6RnvvZ9uUq6P
	ntRnNLJ4AAq9QVexXXZgk4IrVVQasVHn5aJOdojqn2VOjHwTtEdhYtiD+yri/dsldwATBOmKwxC
	COPP0ETWewlPgg6
X-Received: by 2002:a17:902:e952:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2db12754d9emr307628815ad.16.1788752994021;
        Sun, 06 Sep 2026 20:49:54 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae8af3sm37437475ad.80.2026.09.06.20.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:49:53 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: hist: free the field rejected for a bad modifier
Date: Mon,  7 Sep 2026 12:49:48 +0900
Message-ID: <20260907034948.240387-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a hist trigger whose value or variable carries a modifier that is
not allowed there leaks the fields that were built for it.

__create_val_field() takes the field from parse_expr() and stores it in
hist_data->fields[] only after the modifier checks have run:

	hist_field = parse_expr(hist_data, file, field_str, flags, var_name,
				&n_subexprs);
	...
	if (hist_field->flags & HIST_FIELD_FL_VAR) {
		if (hist_field->flags & (...))
			goto err;
	} else {
		if (hist_field->flags & (...))
			goto err;
	}

	hist_data->fields[val_idx] = hist_field;

Both checks jump past that store, and the err label returns without
freeing anything. The error unwinds to create_hist_data(), which calls
destroy_hist_data() -> destroy_hist_fields(), and that reaches a field
only by walking fields[]. A field that never got there is unreachable.

commit e0213434fe3e ("tracing: Do not let histogram values have some
modifiers") set ret to -EINVAL and fell through to the store, which left
the field owned by fields[] and freed along with the rest of hist_data.
Splitting the check into a value case and a variable case replaced that
fall-through with a goto that skips it.

With CONFIG_DEBUG_KMEMLEAK, 200 writes of

  # echo 'hist:keys=prev_pid:vals=next_pid.log2' > \
	 events/sched/sched_switch/trigger

each correctly rejected with -EINVAL, leave 332 unreferenced objects
(63744 bytes) reported at create_hist_field(); 200 install and remove
cycles of a valid trigger leave none. A '.log2' field is two
allocations, since create_hist_field() puts the plain field in
operands[0] of the log2 field, and both are reported.

Use destroy_hist_field() rather than __destroy_hist_field() so that
operands[0] is freed as well. It returns early for HIST_FIELD_FL_VAR_REF,
which is what an operand owned by hist_data->var_refs[] needs; the
rejected field itself is never a var ref, because a var ref never carries
a modifier flag.

Fixes: e30fbc618e97 ("tracing/histograms: Allow variables to have some modifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Tested under QEMU x86_64 on 1fc5a74b108f, both kernels built from the
same config:

  vals=next_pid.log2, 200 writes   332 objects / 63744 bytes -> 0
  x=next_pid.log2,    200 writes   471 objects / 61544 bytes -> 0
  valid trigger, 200 install/remove  0 -> 0

All 400 writes are still rejected with -EINVAL after the change. A
CONFIG_KASAN build reports nothing on the same runs. tools/testing/
selftests/ftrace trigger tests are unchanged: 32 pass, 3 fail, 2
unresolved before and after, with the failures also present on an
unpatched kernel.

 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..b65d79d6e132 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4331,6 +4331,7 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 	return ret;
  err:
 	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	destroy_hist_field(hist_field, 0);
 	return -EINVAL;
 }
 
-- 
2.53.0

