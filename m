Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C72F691E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961147; cv=none; b=P0tzjL6+cOeWkaPDLlkk7VK4haiMwTvNanK8i8onea/SiK0Z/try5XEbkr8Bbv9cJocgMFFE+dAyP6Jf592N+wKiWgqn3jDJ3d9oiIhte+kqdwcHjSHq4fC3k3gNlwjxp4QOnClLebgjqBorRa5aa1ml9zPeGBlxCSGKPHe1odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961147; c=relaxed/simple;
	bh=82eGO7NsphBcOLPHbN0hzUmxfbZqbPNDSXstdLfpUYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QKvSaKobU15onmGzDnSD6X3Uyk/EwqiMd16kOVPI2vgeZ+rPJsT7oW0lfYho+whqKnG15AeJ8kBH/kXakBypprkHcYLlPyQeJJB9SRhKq1A0MyuCjqWDicnk8pvd0upFXR7GkZnvIZYqZzLxBvZMTTLuYb7HFxNpRJBeVW8gSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVmuzjB+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVmuzjB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyz0rHBy4kYEsnNjJtS5YE7ZQr+wFTAHMP9keSs021w=;
	b=WVmuzjB+/hQSPqamlUjYt/K4X+AOvFh5qMw1UZanKVOMe0HTPHW8gE0KNno7ZlxiUouzd/
	bHD4VYvemNJWweOGD7fXm4o+dRmUkkIfxpAYFRVV5fzpW4epJJFvefZhSbRLdtL3YBToDM
	BesvKpOWoYSVDcYy2jIn7qnTJ5pbUMM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-olg-6Fl9M0inMFdGYNHuzQ-1; Wed, 12 Nov 2025 10:25:43 -0500
X-MC-Unique: olg-6Fl9M0inMFdGYNHuzQ-1
X-Mimecast-MFC-AGG-ID: olg-6Fl9M0inMFdGYNHuzQ_1762961141
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8870219dce3so101640339f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961141; x=1763565941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oyz0rHBy4kYEsnNjJtS5YE7ZQr+wFTAHMP9keSs021w=;
        b=XeN2p+vS+7dx5eqXMqi1OFC6bRDE9pMWoWr/gALMwsL3/ymY3TkhH7JM0lq4wpInoj
         303qXTxJN+Zs7S3J70HDLkmfT88kypXyZlRz4XwbaqTkmOYPWj3c8DIsgsom+lKEhGJb
         u8UifPpdopD8zOevAnmduaSOOSIEpbnWrFTce8cc/HKEdcfKDLslHh2ezVDzfLkR4jBt
         gUy396nGrV+rfZGshRlhKxJMRuX1hZ0PmPNNam8y7D03yX7ul1i4eL+srEuvhsJAYSQc
         isCvL2wVL+PaqSUHmS/UklpzB9AKPEwCC5llPQFkEZZq55tvhIGDwgYMJZlUyfSLvGxM
         wgBg==
X-Gm-Message-State: AOJu0Yz29L+E9qg3OYhmX/5YYi+ofuaGUB7ZZmGaN1/0Htww6jGTwuDW
	kr4M/0/wyHkT1ghkkGwSfSq6KyeFOPbIsqwo4ta44FrNiQESoIx0/XA2erANN6Ugxo1y4Q/JGat
	h5bEZ4O3RoD2hpURRLHgi3OcaqtwVcx9sdooIfDVkTCRtVuq0CCw7c2g8viU1dH2SA8AgUwezpO
	77iZOw5Q==
X-Gm-Gg: ASbGncucnTXfDpJjmiyKC/CcRnIfFt2BZ/KHofSx4MmIaNeRBS/C4D44QpbW1UTlzlI
	pDCXQN6B/WsQvQnDczKGDioqRIzVKJruLBGhsxJ6ri601CznlbYRMPM4bsXPL8BfR5VdKR33pgH
	g6YMCqMMmbEXeZ3QmR1Ti5gRhxSFf49r52La7qa0gHxvs/uqN/gxFVHvrZ0nFQysN9MCsBsWMqg
	Z6QmIyxiJzODTVmfobwvIEc0KPKydeyMEMOe646b98XIf6rjtXxfx7OasowQDhEhCJ3H/Mb+u9n
	e4GBK6HHNnxrQlywYPNxE2joZ1OQ62wTxl//y/S+WRiUnlkECWsS0fZaVLGlifN0DxJ4usR0fsj
	e9zFf/6m2dhoAPNJ07XN/9d+bNIMGXkQ=
X-Received: by 2002:a05:6e02:1746:b0:432:f3b:a809 with SMTP id e9e14a558f8ab-43473d9be4emr38662715ab.26.1762961141164;
        Wed, 12 Nov 2025 07:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAnFKxTVwSAq8IRnacWgJjjq6G6I7G5ZBo6mm3XebwGc/Da3aFhZh1cULXavyn3rQP2LR85w==
X-Received: by 2002:a05:6e02:1746:b0:432:f3b:a809 with SMTP id e9e14a558f8ab-43473d9be4emr38662335ab.26.1762961140788;
        Wed, 12 Nov 2025 07:25:40 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:40 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/5] tracing/osnoise: Array printk init and cleanup
Date: Wed, 12 Nov 2025 09:25:27 -0600
Message-ID: <20251112152529.956778-4-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J592jLwr3DOQ-YP9nNGefahqZyRMXe3EMumAQhn9e1w_1762961141
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

None of the calls to trace_array_printk_buf() will do anything
if we don't initialize the buffer on instance creation (unless
some other tracer called it), so do that.

Add an osnoise_print() macro to facilitate adding debug prints (without
tainting).

Use trace_array_printk() instead of trace_array_printk_buf(), as we're
only writing to the main buffer (of a non-main instance) anyway -- and
trace_array_printk_buf() skips the check to make sure we're not printing
to the global instance.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
Technically this isn't needed to make the tests pass, but it was helpful
in debugging the issues and would be nice to have around for next time.

What's the intended use case for trace_array_printk_buf()?  It seems like
it should be an internal function if it's not going to check the
instance.  I don't see any non-internal uses other than here and in
trace_hwlat.c, which also only prints to the main buffer.
---
 kernel/trace/trace_osnoise.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bb4d195ec74f..b53a698f8e81 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -81,6 +81,22 @@ struct osnoise_instance {
 
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
@@ -121,6 +137,7 @@ static int osnoise_register_instance(struct trace_array *tr)
 	 * trace_types_lock.
 	 */
 	lockdep_assert_held(&trace_types_lock);
+	trace_array_init_printk(tr);
 
 	inst = kmalloc(sizeof(*inst), GFP_KERNEL);
 	if (!inst)
@@ -455,15 +472,7 @@ static void print_osnoise_headers(struct seq_file *s)
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
 
@@ -1173,10 +1182,10 @@ static __always_inline void osnoise_stop_exception(char *msg, int cpu)
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
@@ -1346,8 +1355,8 @@ static __always_inline void osnoise_stop_tracing(void)
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
2.48.1

