Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492897;
	b=0nojcIkZnHBv05mQsRjoyZjGCg4USqsb+cdP/QM483nJ3o8501S1AEzJi2aLybsgJB9D
	 SrMOltNn9TYZO0nnPjl6/pYZCXZ9IUvRPWOaIvm1uVZWPjlBlN6B0dDoSrutB01WVA9WE
	 oLWH/MXAJlgzuxlQCpNbfFJ8intySggvTCAf731cPhJ32IlzHR7dsWSPZVjLGx989HFun
	 NAbnVa5iRNXT0Y75jqNI2aga3wEZI6outeNb/C9J66pBJA6RklhvXmYQmArBNG6rnHU6k
	 OgEJnjh7gOFlWQNzIRH+/d8S1Yd/oZiLe7X5cgAYE79t11gng4/oNc2swRTT3BrdI8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bPHhNNq7w/fLlY4o/ckTx7aGLsEqj2ZGBXvYDna7FMk=;
	b=B78eIrCAGMwXch2kbCfeiX6EcHtl9JQfgv2dHI65nlxUgVTBjKlerBOWPN1ALxiu6DN/
	 W/zfVUasNztTP0Jzz8aQSwlNJbPutfPXyYcz8RM9wUS45URAAz60i4Rqc1Nbx47oyUdBw
	 1cRsuFrarVwr39c6yZWggwFbTOVKZppaEMwmiynhyXQdREBbO0nf22nAPx1VfzBipvs3w
	 +VojKcYnYt/4rCYrSwFU7KnMUN4H3SuJE3UYyApFWkeRIsQmn/OkZQatw+NWHftKLfbdv
	 m2iTyRrn1a+RvVr9UsUXJP2bw92U1tEHpm9UHZLACmr5SpGw3ySVB/z1KGXZVvY/Zwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aBPMgolY;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0260A2609
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E0260A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aBPMgolY
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so3692384f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492896; x=1795097696; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPHhNNq7w/fLlY4o/ckTx7aGLsEqj2ZGBXvYDna7FMk=;
        b=aBPMgolYjE2oADuB7AKiBZJRZOnizT6HeL4Izkn1t4dkeYYC0AFYzRrlsyBGBaMy/8
         vRArOmlI9Ot+jpQ56oHnNMXgOun01OF90FG2GTC/5xac70a1Q6EMaCNqatb2u7jH+Xh2
         ZwQrfa8clbNKTgz0Sa/5F4C3jUp8ssChVmY2+768XFiDTTmcDXVWFL504jg6M/p5Nhry
         2CYjYzkR0QDORIrkVOYdq23TpXcCOH7rqvw8/cWQ0gOoU7IWdikM/xnYHAb8khCuShUc
         EQtnFAxb0GnxNZyyMJ9kVBhwGfbfhnEeu8bukUyB1wWgHm7rXwWAOAK1O7ME8QeilPKm
         x6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492896; x=1795097696;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPHhNNq7w/fLlY4o/ckTx7aGLsEqj2ZGBXvYDna7FMk=;
        b=jK8Iur5+kYzK0uHHjwj81YZjcZ1cXjvp5jnDL42EdE3zZu2bqMLZZdJ9E4AIYUQq3C
         Zis/FXcYRbM6fNyJCo3IIvGZpb5esLmgnsnQ3omeBKQ6YXU9AtAE91gVpLNb0XQgq+dd
         nyxhvbnQcaE82HoURhEQgtOVVpzDedbrLw9Yb/Bshj/tbrfEysGn58pvL6vgNtX2YpQK
         KdP1vLi/1NDw6fSSEZdMIVqCWNYcgTu9y66UMeKMNNaolt/2pvY1V+I5P0zPS5a5HIru
         JAVXptYx3KZRZ5CT0702i+i7jzcFvKjb51A6UmCRI83QsJQx1TETZ10cHgSBCpfnm1Pw
         EXEw==
X-Forwarded-Encrypted: i=1; AL+hErFZW3DuYQR7myqfsHR/fmSqG1wKFTL4otoEkOg09TJOb40LAyOV+wRPDD8jknwRMBmXEnrnI97gavl8to1DhgWt+9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8gpLw/TpyMEp50invkLTzfpElrng9krVrcUx8EmEaN3/yl4bV
	jdvCLGrDiqM1NfR//PTprLH7s78ukC8tdKj87ohFt9I3YjdjA+zz6RqJrHJmvcvrmKjuaHJ8ymV
	iY83LqRMg/KCvclVzaLuxXg==
X-Received: from wmqf8.prod.google.com ([2002:a05:600c:4e88:b0:4a1:f37f:7f0b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b24:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4ba09383fd2mr99227395e9.35.1794492895472;
 Thu, 12 Nov 2026 06:14:55 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:37 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-7-vdonnefort@google.com>
Subject: [PATCH v1 6/9] ring-buffer: Introduce rb_start_write() and rb_end_write()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor the common write-context entry (preemption disabling, disabled
checks, cpumask testing, recursive locking) and exit paths shared by
ring_buffer_lock_reserve() and ring_buffer_write() into a pair of
functions: rb_start_write() and rb_end_write().

No functional change intended.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 106 ++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9834f9dae440..02d3cc193d1e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4495,6 +4495,45 @@ trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 		cpu_buffer->current_context - (1 << cpu_buffer->nest);
 }
 
+static __always_inline struct ring_buffer_per_cpu *
+rb_start_write(struct trace_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
+
+	/* If we are tracing schedule, we don't want to recurse */
+	preempt_disable_notrace();
+
+	if (unlikely(atomic_read(&buffer->record_disabled)))
+		goto out;
+
+	cpu = raw_smp_processor_id();
+
+	if (unlikely(!cpumask_test_cpu(cpu, buffer->cpumask)))
+		goto out;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
+		goto out;
+
+	if (unlikely(trace_recursive_lock(cpu_buffer)))
+		goto out;
+
+	return cpu_buffer;
+
+out:
+	preempt_enable_notrace();
+
+	return NULL;
+}
+
+static __always_inline void rb_end_write(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	trace_recursive_unlock(cpu_buffer);
+	preempt_enable_notrace();
+}
+
 /* The recursive locking above uses 5 bits */
 #define NESTED_BITS 5
 
@@ -4563,9 +4602,7 @@ int ring_buffer_unlock_commit(struct trace_buffer *buffer)
 
 	rb_wakeups(buffer, cpu_buffer);
 
-	trace_recursive_unlock(cpu_buffer);
-
-	preempt_enable_notrace();
+	rb_end_write(cpu_buffer);
 
 	return 0;
 }
@@ -5027,38 +5064,16 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
-	int cpu;
 
-	/* If we are tracing schedule, we don't want to recurse */
-	preempt_disable_notrace();
-
-	if (unlikely(atomic_read(&buffer->record_disabled)))
-		goto out;
-
-	cpu = raw_smp_processor_id();
-
-	if (unlikely(!cpumask_test_cpu(cpu, buffer->cpumask)))
-		goto out;
-
-	cpu_buffer = buffer->buffers[cpu];
-
-	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
-		goto out;
-
-	if (unlikely(trace_recursive_lock(cpu_buffer)))
-		goto out;
+	cpu_buffer = rb_start_write(buffer);
+	if (!cpu_buffer)
+		return NULL;
 
 	event = rb_reserve_next_event(buffer, cpu_buffer, length);
 	if (!event)
-		goto out_unlock;
+		rb_end_write(cpu_buffer);
 
 	return event;
-
- out_unlock:
-	trace_recursive_unlock(cpu_buffer);
- out:
-	preempt_enable_notrace();
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_lock_reserve);
 
@@ -5143,11 +5158,7 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 	rb_decrement_entry(cpu_buffer, event);
 	rb_try_to_discard(cpu_buffer, event);
 	rb_end_commit(cpu_buffer);
-
-	trace_recursive_unlock(cpu_buffer);
-
-	preempt_enable_notrace();
-
+	rb_end_write(cpu_buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_discard_commit);
 
@@ -5170,31 +5181,16 @@ int ring_buffer_write(struct trace_buffer *buffer,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
-	void *body;
 	int ret = -EBUSY;
-	int cpu;
+	void *body;
 
-	guard(preempt_notrace)();
-
-	if (atomic_read(&buffer->record_disabled))
-		return -EBUSY;
-
-	cpu = raw_smp_processor_id();
-
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		return -EBUSY;
-
-	cpu_buffer = buffer->buffers[cpu];
-
-	if (atomic_read(&cpu_buffer->record_disabled))
-		return -EBUSY;
-
-	if (unlikely(trace_recursive_lock(cpu_buffer)))
+	cpu_buffer = rb_start_write(buffer);
+	if (!cpu_buffer)
 		return -EBUSY;
 
 	event = rb_reserve_next_event(buffer, cpu_buffer, length);
 	if (!event)
-		goto out_unlock;
+		goto out;
 
 	body = rb_event_data(event);
 
@@ -5206,8 +5202,8 @@ int ring_buffer_write(struct trace_buffer *buffer,
 
 	ret = 0;
 
- out_unlock:
-	trace_recursive_unlock(cpu_buffer);
+out:
+	rb_end_write(cpu_buffer);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_write);
-- 
2.56.0.567.gdb80ae8cd5-goog

