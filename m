Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F5346FB6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513430; cv=none; b=Jhg8PIDMPQHSE/+pAA7hexVt7fdeU3hr6AI1O9lU7vUwlEZBDAb96IEEK+0q2iYx23IX8ogUtvYi0IMPnyNbDUM4lBWADoE9PojHU5If8Zwp2Tf9UVjXvC9XaXiah3YcYogiGxDjTN/TSaM+2UGdHH9eDm8Kc+Eh6OFUIctepKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513430; c=relaxed/simple;
	bh=7EE95rx0LrgIT4QyX6117YMbNjqFfAiq5/cDJlqfniQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArIdT77dqtvKIpjPpirt769RiLirTuL/zngOjRpvQ7Bbtf5usabPPCYoAmNJdmE10U9lSstb5005qnxsQbEkxfIjROH8hnpn1Zhcd/dpU5ra7LvcAIJ6Gk2DMllfNxZPmL0NMzGe39f+2hPGk2IiugEUNX5OemHfsDaKJ5VuQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pM/ACyqz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM/ACyqz"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48079ae1001so7399695e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513420; x=1772118220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wD6LPWf1rq+248KhxWwP0GcpeSFjPhgsN1twvSzFVPg=;
        b=pM/ACyqzmsFxsZRHzlR1+Rj8B1sa8Pra5aDb4Sn7QYbBOn9nHohNFHeFUqf1R6sD1o
         AJdsxs6gDm6R+MvJjEEMKCwFIBO7AmXM+D80qGFw1Y0hM3hdPDAObt1/YdPYHvqHBCCR
         p+ZT0uXomG66i9rmfyKSdPy+Bi+2AwvO7g9baHABuJbchln4LGYLhZHUJUSPsonnlkug
         UOalDy1YzBsow5Tqs6MXDmX8A3lGT9J+89tklq/RUcD4PCkDVXVf+qPJMHlKcvrYtram
         3YGaR0HEma3IivVGw2ABAhw314cucIC61WITm2d7Gplm51zfT5LKKUwhMc7aKPzgjQuc
         vsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513420; x=1772118220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD6LPWf1rq+248KhxWwP0GcpeSFjPhgsN1twvSzFVPg=;
        b=ktSykm0LSksqfIBBIJM18L12mdckMe6fsxEXYupagXIQH0g9ZMUfgVH46H73G1gQEY
         m5rJ+X2LdSXwrWFk/oBNSMwgfy7dqd66rlZsSC2RXNVnBRc/4QfayimC+AjjQuOJjcTx
         RVPrTZPY9NMAoRJFaxwd7kiyLWSKrQzEnevrxbgDulWfZQmaFRuTUiVceYQj4SnkBAv3
         88Tw480pZ1PmaO7+2rg/6I85noJI5QvJUvBYyfyLFRN2TWrrU7ehl3CsFvU23/mlw34L
         19Fl25JZ/JlSqpQancNyOxBiJSnHl75HcnPyNDT51Y78fUMwkFZlBkPpBKBhimhfMTDA
         3MKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwiih1HQL+cyku671Fz/xt7UOglhTKgrJ2Osh5HCNWusOpmMfHwxkyE0C/vDTiVjgx2ItZ1z51l5h6ipll+eqV1iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtIWtJ4GBVsWxEYt+PMYurCODYe3n130BzHEb0Jm0Z9HQSQnk
	0tjmxq1Vb8hiKhIpTMv+yKt2VPU+ffVrBLyU/8NIyU5eXGL8ecMuzJ324eGHhwXVr6pkhRXwIWt
	jtWG4esjqkeT2clYFg6AUtQ==
X-Received: from wmxb5-n2.prod.google.com ([2002:a05:600d:8445:20b0:483:43dc:999f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4443:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-48379b318bamr268163575e9.0.1771513419651;
 Thu, 19 Feb 2026 07:03:39 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:55 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-19-vdonnefort@google.com>
Subject: [PATCH v12 18/30] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index d106beca8d7f..3182e1bc1cf7 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -132,4 +132,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
+#
+# simple_ring_buffer is used by the pKVM hypervisor which does not have access
+# to all kernel symbols. Fail the build if forbidden symbols are found.
+#
+UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
+UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
+UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+
+quiet_cmd_check_undefined = NM      $<
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+
+$(obj)/%.o.checked: $(obj)/%.o FORCE
+	$(call if_changed,check_undefined)
+
+always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked
+
 libftrace-y := ftrace.o
-- 
2.53.0.335.g19a08e0c02-goog

