Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BF51D506
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799185; cv=none; b=XPk7TO3yYiFK45w8n5h5+FL7LZ9WcIIXXnGgpiv2fkdQKZ1BFaOjYfi7UmxzHxiNNyVQotB6JFU2qPDIc1aFgarvFu70S1BFHlgRQ/pXSjpvTcSXyC1HJEvDQ4mJDKpHEA5I7u1VHnk2/24rEea7NHHpxlhGwEFzKBc4I57SXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799185; c=relaxed/simple;
	bh=4NloKFPqZMjUIN1w4xBl3NH3xZG6HQaaJ2E3rDhUMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY6XAo4H2S1UBU6soNOhG16bBSpz4HxzyGE7QZZn6IUWxuW6M/nehrqroTnq1nanK+ybnywv31AGohpeDj/FROB27V6XZ2gZ0IAbkqi8H3XyWPnJaH3XRcWtnUDE2kT6NwBdt3sNmHOnolvAusB3xlvkjzf5Eq/9T+fzksdRlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLa2OTBV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLa2OTBV"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25b661d37dso506792766b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799182; x=1789403982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwDD4c2/RUpMOgZpwicrnDhtfhOW9xqP82DMYtNr2GY=;
        b=FLa2OTBVVt2ZchezksgaUcigsLZPMWKdiiEvN4CWrvjcmD4e/e52VomQtmsFXLW0QL
         vCe7y824cw1xH4H0nEtZTQnObBkXkKBNWGXOaOwzBTzNQdIbrqyBtbVFMCkE9TlYCspS
         b4xt6JpMwI6iKzBEfw+ojAdFe7SxhycoVy/iJtDhNKC71WfMatcO+tGroD0FFIvbFJqC
         hKQACDREj1mGvo2TZOzNyetQTizB0sUWbyIRNIeiYPBEhJMMVyrQYhQcVYP+UDCO5Z6j
         ujOL0mrVCy1OVQF7NSm8S67OmsASiIiF9kP9IvgrpW9pNUetk+eDTPZEr+XlT7b4lDEO
         7usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799182; x=1789403982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uwDD4c2/RUpMOgZpwicrnDhtfhOW9xqP82DMYtNr2GY=;
        b=cV8yOEccHYcvZ9LGWwL3xE9n2O0WWGwbP1IfHKSqY2lE2yT0yYtgVs6MUIyPvMwvZC
         TXc5N5NV2sagZ5keXH2v6rKOQsOcLuLwSyEVJf/KB4cfLXrqwXpwMOj186KYmrmBYXIn
         0glTApuT1kl3PtB8ibdTrcSIvD+l3OK1yV90bUnWoF87rCoGlZYF2k6jBPphlcJnPrNG
         DLDtfXIEkERVPyJLC+gLYViAlbTAnFhikzFv9g0VAtwzT5W+v7lfvN0FfNZn3TNOMiDe
         JUDBIfsBGrggGZfGWBTT734tyadOyF2BOfmAxKezKQp9FcgmO0Os2tnbzq5AOUgtdbud
         MqJg==
X-Forwarded-Encrypted: i=1; AKwUvBygCeKiEw/4Q60rKwJHcgOFRaDBHSIAQdsIcKnW5qQY606adjVuoHaraj7c7vUYdiiLR53V0Oyt0/CJFwpNAzIAGPc=@vger.kernel.org
X-Gm-Message-State: AFuF++mvegKEZgkuAb3GiASvSlLklWAHh3korpkuUKomTCZQW10gCfNU
	x6641ahh5opH1NmYYKaoPvqWH2xqkorKWc5CZrH6JR/tpRiHrwpf5q0O
X-Gm-Gg: AYBFou0saYAzCkc5Eu1FIopHfsgnjAwoY6ffK/zzFXo0vthFI4HLHuqpYTIkBjkvcs7
	O0CrFELwnxo61h1wwMNF/6nMULFOjKVtASLf+1YmcbU8eF62mHXdMXtcKDDDdQaFFVnrWXOmeaB
	Yt9WUvA65NeImAWTKtxkF6ZNUgVRP3y/P7yXdT6bAOVsnUvLRNEA0ydwidP5Nvd6wuCKB7KsIeT
	8Rxte0Gywolmkt167teFdGQiZcBjzrKCFekLzNDDUGRSMIk+0LzQ3UqLp8ROEW4G7nQ/+mzgdH8
	k4j8iu7oTAovDqU46Kd3rItZ0PVz+5BoMHBaSN/B+KrLZSogIaWKy4HKfLTnz61OiSu1OPne1Xy
	i87aDUxqpQQ25N5Ke/boa1EL2LDhq7ZoGPNR9/mKlzbZpWJdxRp+k2RuBVF6U8i+Op1tn8I+EHO
	BS/NbVkoeXVVEBWAdXOMc3MNqJe93Okcwh3NGbZ/upXYEwbPysErpnXEEc
X-Received: by 2002:a17:907:d503:b0:c21:792:8257 with SMTP id a640c23a62f3a-c260c994e17mr930468266b.15.1788799181596;
        Mon, 07 Sep 2026 09:39:41 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b89sm483434766b.10.2026.09.07.09.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:39:41 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5.15/6.1/6.6 1/2] tracing/mmiotrace: Remove reference to unused per CPU data pointer
Date: Mon,  7 Sep 2026 19:39:18 +0300
Message-ID: <20260907163919.183961-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907163919.183961-1-alexevgmart@gmail.com>
References: <20260902122613.442176-1-alexevgmart@gmail.com>
 <20260907163919.183961-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

commit 6936298393d8d8bc3cec6b704f6a774162cf9bd3 upstream.

The mmiotracer referenced the per CPU array_buffer->data descriptor but
never actually used it. Remove the references to it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250505212234.696945463@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80689
 kernel/trace/trace_mmiotrace.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index c523ce5aa495..74f378fca518 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -292,7 +292,6 @@ __init static int init_mmio_trace(void)
 device_initcall(init_mmio_trace);
 
 static void __trace_mmiotrace_rw(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_rw *rw)
 {
 	struct trace_event_call *call = &event_mmiotrace_rw;
@@ -318,12 +317,10 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 void mmio_trace_rw(struct mmiotrace_rw *rw)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_rw(tr, data, rw);
+	__trace_mmiotrace_rw(tr, rw);
 }
 
 static void __trace_mmiotrace_map(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_map *map)
 {
 	struct trace_event_call *call = &event_mmiotrace_map;
@@ -349,12 +346,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 void mmio_trace_mapping(struct mmiotrace_map *map)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data;
-
-	preempt_disable();
-	data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_map(tr, data, map);
-	preempt_enable();
+	__trace_mmiotrace_map(tr, map);
 }
 
 int mmio_trace_printk(const char *fmt, va_list args)
-- 
2.43.0

