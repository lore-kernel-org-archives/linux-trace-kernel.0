Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D5313551
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668213; cv=none; b=dbQsGxs1pAZuMMqRHZ94TSfeMw1sN1ONk7fbNShr7jhPnLj0Vy/ioXt6VBawId8rxQ9hv+Kwtthh4bD/mwcrwP78cu7UOyuk73hKkNbOJYa3RdbWknb2CQuth7Pq0jv24khQHnLDRqMoXhoKmQrd+/Jz1RyQnORXuBAEQtcZ5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668213; c=relaxed/simple;
	bh=RLZlk8xFEYP1he6P2etQc9IP6fyKVIbhnhFBzANhQEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2ZqZpRAn9juVX7wW4NmBlSBWnm8E7k9l5yrmVnZFlBqlmBC+/P2FC4eAeemmYlK2KAu6jP3nOEOSnl+G8IjK49YnrxrqUrMGPGlLLDj78zrqXXkI5wxVTKy6+G4S4kpMoz6/a+uBkhJ1jsjlCwnqKCBqi+rluZzoBD62/Yzvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgbJr7Oo; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgbJr7Oo"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47106720618so68074975e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668209; x=1765273009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSppY5oK+32CD0itjrNWAYgn4J0yGPHY1rA0h9HSTYg=;
        b=jgbJr7OoDaQbO4u9bc7/duJEkQ1DAvY7nqQpTfXSvgL53dzbNaoDL0RNHY2gcJVSqP
         PaP4fooqMuL2weZqxGPzPbGURSCeuqXl8ouZQc+BhTlVurSjGWeWGADgsVDhxQXE2b46
         viXRuNbgJn4kFQkI/yI+rUi0S7O7PZmA9SRxh/QzSaz+4Coa9VdHXYOhogrDETVOjs1U
         73NuRF+/QpL7PWBF+kPk9vnA1OAiVpa+vk17sK2c+5x+7TQk0olj2DMYTGSlrY0bfIGV
         UlvCc0lYQHyNqZzexMbeIpZkPlxmifQc5R4GguMAlf5atWm1rhDYqaCn7BvxWwi8MQFn
         KiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668209; x=1765273009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSppY5oK+32CD0itjrNWAYgn4J0yGPHY1rA0h9HSTYg=;
        b=QZttEEi0Zd46A1FmZk8hGA+LLcw9G2Kk4mNh9pY+nUg2jZaISl1kotKy5bCqhlOIHR
         6dJUgWA1NjGP6YNZ1G5YW97OLBg8ewpJlyzfUbc5b5awGZjhodVsNvI9gSnixcaby4Dq
         bTIAavfqJep1Gmn/qAKiIVvR2/eURAsTLofVOtDbrltIWmkH4qCHoE9hm98raZYRV5eW
         K9NDMqVCcPsl0RMP7qkKESUcPRoIrybFPs4eA0EchVqL60q+M/JgJ1pczCkIcmfoofJq
         t2QiKRLuU84ZqXFIaIey1ZGMZHn1x/kGER5zGkwnecZBhFW3Exfa38KfEpR7TLT4s8TC
         P7+g==
X-Forwarded-Encrypted: i=1; AJvYcCVKUj5V+ogv02LBC9RE9V5f2Lt0YQKLxYZp/kgFWj488fcffO+DUqwvrfCqrZ5Oj41aKHm2HvtfRUnwybuT9LzMHfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8OXqw7N8tFEsNVKTeUoYezPb8NUcWRMpFucJEDtF0HFF0YRy
	3fP5YbOvZFpvjYVTD1oB/9bUMRRuPJQ3m89OnSvQNGS9vf9SJM3OZIAeQKzdfRG31WcDAKkQd3w
	AWsAQymHnP9N7F8c2ZeIYFw==
X-Google-Smtp-Source: AGHT+IEoSfdY0P3iXQY3FCb+tHcmigvpocatUt6YkOF7zXtHSG/5g+bu26HCdo+YrjUqY1sE2DfDGCXrnlid7WmZ
X-Received: from wmrc15.prod.google.com ([2002:a05:600c:acf:b0:476:ddb0:2391])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f85:b0:477:9c73:267f with SMTP id 5b1f17b1804b1-477c01ff629mr365899995e9.33.1764668208923;
 Tue, 02 Dec 2025 01:36:48 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:11 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-19-vdonnefort@google.com>
Subject: [PATCH v9 18/30] tracing: Check for undefined symbols in simple_ring_buffer
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 53534447e70b..38523ea2e19b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -114,4 +114,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
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
2.52.0.107.ga0afd4fd5b-goog

