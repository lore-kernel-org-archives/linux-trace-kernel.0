Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50638331E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538701; cv=none; b=qm8VmYoIg6UvvueoJc5u2vTDUrta6q4/MumzOAjySlxI7731iXKs5JHmMp0I3dHC3bm327wJbwmgOX27mwISdCxVqrvvPo6ohw1Fv0mWWPilluD0NjWfD1nR7KJvxUDe/XK9QsBtAEoZXVJ68gdITmeNKLyyhXoS0QRaexm7a2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538701; c=relaxed/simple;
	bh=k5DUmARYleImQiUK4CEKMJhpPDdoiTknx3jR3um/lu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Twm01ACDQhlIwYbmzN2HQPbmSpO/q/v5D1vgvXMypYHwsJjZajXTT66fcL+x6abhOqk/boRH0k5D9RFlYkfDUaoMvPxfwE5e27hAcUjFJvoGEMKTnfos4hLLS81JlK42XWrkgA7wdHr9fjStwEGXbnKvbsEhuVng6GH4gA78F/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYkoBCvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYkoBCvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778538699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z7bzM4re+gpsgMOAEiom9oZXmZaPjcLNvuBcMFxyjfo=;
	b=RYkoBCvOJnmnN1hoe0rB5eon/k1tIMOm7emClYuCY5gPvMu2oRtMns9TNDY0/xz59qakIK
	0nBMDl/v2E5+LtcqchrYkZTa4JVlH46Z4ETK14ca1JISJXPfQpNc1PCUCd7751QheO0hBv
	6GHQW0g+cHUFUrqRJpRATXMATnfIxoI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-0zvJLca1NMuDqUof0yqbbQ-1; Mon, 11 May 2026 18:31:37 -0400
X-MC-Unique: 0zvJLca1NMuDqUof0yqbbQ-1
X-Mimecast-MFC-AGG-ID: 0zvJLca1NMuDqUof0yqbbQ_1778538697
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90c991bfcc3so171285385a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 15:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538697; x=1779143497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7bzM4re+gpsgMOAEiom9oZXmZaPjcLNvuBcMFxyjfo=;
        b=rNbLMZFi3R6LzY543yTKTVzFvtJpywLg7IhRrgGES0qKfi+a6G85XZLJIE4mXX30kV
         Q8/sgYIiRJKvPbjbfF2K47Yt+CGZoyRiRoxrJh7zpFnCJYtp+6RlXKW/xSgI15DXqy2/
         7ES4MIsXnpnDXXIWysDL2zt7/p52y+5VsiRqRcqObfeZbeHolgGsTw8IA6xFK0sBQ1kG
         jbuL1fUcFaLEF8Ib7q2pWmRup3pZFtDbfqCYKvTytmTqEyJp2BKHXiw0li31FEArUmeX
         fkzsm2yJyZuTs36nGi45k6S3HHJbUrj54gNHKcQRVzZxkyPxr11ae4WnnO6waW+EbI66
         KETA==
X-Gm-Message-State: AOJu0YwFQvxYI6TfW5molltBRZnQUMq+DDBDDQZKNsDKVsc2IC9+J0kU
	t6RdDo0oPA9K6RCs1RHxE0zqiweeeSN/HRh5GxQOigW3HCR/qvSZ98P51PWAZxMGG7OqJPcBg9W
	zzfGzdRBe0llV9JoyKI1JU4uWzO89InN/BcxuIujsKNRvnnkGOI1QRPA+QWrUKYdJ1i8w8yxcGQ
	==
X-Gm-Gg: Acq92OF9UD04L4Tolt0n92xQfibNA1Sqh3r53ZWpeY2YxcC3VhwN6eI47ZXTUBP7Y1b
	9n5Dqxm03C6GjNFvrWm9FkZl/LFXo5U9svGsJbxNabdMu8Em4guXeczEtTa6pyom+zc3dH8M5/7
	5mTiD1tEZYGR603q84+o84nbu8trNzbHnDiLBi/s+oUwNjhItop983bjPVTvR5yNo2kUp0vW+S4
	ou32ho30LqP99Pau2FWd1D/RNFL5J/eubS/sCAYxnm4b/wcdyXcP82BJy0lQKtlSLvoCAp7wSXP
	J9qLD6Owd195/fnnulFHSXurlxU0I5/Eych8ULh0vz6NiazSIxQgpCelGjdwPqytwFfqnVN69cw
	6kro8GGZV3iSiVP+dpmTk0R7GyQxAVtwH5wHxsJDA8vCBHc/QTyIeaw==
X-Received: by 2002:a05:620a:a515:b0:8d6:e3ff:16b8 with SMTP id af79cd13be357-90cb64fa090mr172513585a.6.1778538697091;
        Mon, 11 May 2026 15:31:37 -0700 (PDT)
X-Received: by 2002:a05:620a:a515:b0:8d6:e3ff:16b8 with SMTP id af79cd13be357-90cb64fa090mr172510085a.6.1778538696451;
        Mon, 11 May 2026 15:31:36 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm3272512285a.34.2026.05.11.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:31:36 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2] tracing/osnoise: Array printk init and cleanup
Date: Mon, 11 May 2026 17:30:35 -0500
Message-ID: <20260511223035.1475676-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U9BeKNau4ye9s07Rn56-gftdYdbcTYI68eGxYQ8mB-M_1778538697
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

None of the calls to trace_array_printk_buf() will do anything
if we don't initialize the buffer on instance creation (unless
some other tracer called it), so do that.

Add an osnoise_print() function to facilitate adding debug prints
(without tainting).

Use trace_array_printk() instead of trace_array_printk_buf(), as we're
only writing to the main buffer (of a non-main instance) anyway -- and
trace_array_printk_buf() skips the check to make sure we're not printing
to the global instance.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: s/macro/function/ in commit message

v1: https://lore.kernel.org/all/20251112152529.956778-4-crwood@redhat.com/

 kernel/trace/trace_osnoise.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 62c2667d97fa..5e83c4f6f2b4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -83,6 +83,22 @@ struct osnoise_instance {
 
 static struct list_head osnoise_instances;
 
+static void osnoise_print(const char *fmt, ...)
+{
+	struct osnoise_instance *inst;
+	struct trace_array *tr;
+	va_list ap;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
+		tr = inst->tr;
+		va_start(ap, fmt);
+		trace_array_vprintk(tr, _RET_IP_, fmt, ap);
+		va_end(ap);
+	}
+	rcu_read_unlock();
+}
+
 static bool osnoise_has_registered_instances(void)
 {
 	return !!list_first_or_null_rcu(&osnoise_instances,
@@ -123,6 +139,7 @@ static int osnoise_register_instance(struct trace_array *tr)
 	 * trace_types_lock.
 	 */
 	lockdep_assert_held(&trace_types_lock);
+	trace_array_init_printk(tr);
 
 	inst = kmalloc_obj(*inst);
 	if (!inst)
@@ -471,15 +488,7 @@ static void print_osnoise_headers(struct seq_file *s)
  * osnoise_taint - report an osnoise error.
  */
 #define osnoise_taint(msg) ({							\
-	struct osnoise_instance *inst;						\
-	struct trace_buffer *buffer;						\
-										\
-	rcu_read_lock();							\
-	list_for_each_entry_rcu(inst, &osnoise_instances, list) {		\
-		buffer = inst->tr->array_buffer.buffer;				\
-		trace_array_printk_buf(buffer, _THIS_IP_, msg);			\
-	}									\
-	rcu_read_unlock();							\
+	osnoise_print(msg);							\
 	osnoise_data.tainted = true;						\
 })
 
@@ -1189,10 +1198,10 @@ static __always_inline void osnoise_stop_exception(char *msg, int cpu)
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		tr = inst->tr;
-		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
-				       "stop tracing hit on cpu %d due to exception: %s\n",
-				       smp_processor_id(),
-				       msg);
+		trace_array_printk(tr, _THIS_IP_,
+				   "stop tracing hit on cpu %d due to exception: %s\n",
+				   smp_processor_id(),
+				   msg);
 
 		if (test_bit(OSN_PANIC_ON_STOP, &osnoise_options))
 			panic("tracer hit on cpu %d due to exception: %s\n",
@@ -1362,8 +1371,8 @@ static __always_inline void osnoise_stop_tracing(void)
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		tr = inst->tr;
-		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
-				"stop tracing hit on cpu %d\n", smp_processor_id());
+		trace_array_printk(tr, _THIS_IP_,
+				   "stop tracing hit on cpu %d\n", smp_processor_id());
 
 		if (test_bit(OSN_PANIC_ON_STOP, &osnoise_options))
 			panic("tracer hit stop condition on CPU %d\n", smp_processor_id());
-- 
2.54.0

