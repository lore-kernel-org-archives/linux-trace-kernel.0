Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988482;
	b=cdOUf3z63b6eKn1yE+oZwyL6qxgtEET/tGsqr0WRx0BWgf9p/Pqihjm5gQTDsWGBApEL
	 NcqB5kpQx2E13Ej6ZGsjKlQ73+4iPfiTc/6mcFURRYe+tKzZ58xFkjXVDFKS72PS9nNeV
	 lTowNk2uzP3autGPe+rpMX4fJo4CEHyOLk39RVs9fGP4XxGQgTsvOhYFOsQv/8Dg+VAOF
	 sAbNEIVF9CN5qztLTRkjQaut5Lr22lLwSx45kuVYF3drYJbdw5tmBlLSJuEeVqyaBlP4L
	 9T+Et+8jLRy1itYIGdR/c4e9gb7cPW27Mzh/Rsj4/Iqk2EM00iod6q7/zeGP7nyXMuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qecdV8eTNCl493bY7vGgQbKVbShINe6rlolLmOc6oQI=;
	b=Oz8ZoqsQwA5iakT6/ZxE+GbIsVYsCs1e7oTEibpbuWTxmfegJjQD7Ktf+g7ftfELiYTL
	 VKwGSfnsHHqGLTwZCmV4AHgoszyxzkYcPRWjS80nE9eV89LYuRma5b7Jh8bowxO0mSQFY
	 FwaEpagpM3dKA3Inbh6yy6mk0BjX3oHSEJnX6pBbspK0JkD2jqGhZAAFw6Dco+5epQ8lI
	 dAtXbXt7+saZevOUMil8lAt9JZS/YhTEvCEiBtyxI+6g9vESDnZP9lcQ7UWUUNxx3SJrm
	 Pne9ldsSUUxM3hsilHtV6KkatRwEjPpsVArAfxAKXdxZSKJterEbhsuN3HJY54v3ytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6Is+m+z;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636126082BEA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636126082BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6Is+m+z
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48fcb657f32so646285f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988481; x=1794593281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qecdV8eTNCl493bY7vGgQbKVbShINe6rlolLmOc6oQI=;
        b=e6Is+m+zM4gsRbuAZ0y0CF9pa3Srdf4jC9H0RbcgGSSLkfImjQuKUVX3qkNKrU9YIg
         zKBz9ij5fTBUgy8jMmyDTdW7aycc2J/z05iIdwJmpyaUpZA9Uw3TpNjH5caoE85m0piA
         KMnYs2HJDK+LWq/9XGZQPwd5cVu7XpbBo0ydli7yKvWcffWJtJKfjoIn5zZ6NPXcSRQn
         XcCchuoE4vb8JNP+VinpVHZaVvHHeW8qVAFSZYliVFmlxoIquDbJYH/uXDJBzTWDll43
         fsyQFvYnq6Zf4Le+gAx4fb1a2Usx/8odmjWn4kV201nePeq+/kkjLLn2XTvvkNBkBrmA
         omDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988481; x=1794593281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qecdV8eTNCl493bY7vGgQbKVbShINe6rlolLmOc6oQI=;
        b=fV9R66YTeEgdy9uVetLx3rocx9amTxn3tphoN1ixWC56G9Vwf7JhJTPRtma0Jt/4hS
         S8eWlwJ0QhSoWqctYkP4dqX2rkovFBNB/2L18tK7ebNx1jVW6wymmuP3H15uo2auT74R
         cb3ArW0kK/B0c7vc3fSZ6X+hu2ayQaMtdMFdKiYKV0xRKSAezo4bjqj5WrWVml2AKbyl
         KfTTDmAqUl2mhnoh2G4WBNSn4vIbXaZm1hlapaTzZhJ6T4PVtgyLpSW+g7CeBxkvkS/I
         w66ehHJ++UfnKF1886If/njW1S4n6g3iLbSVSKT0zKXtrfYdetiKLuoXHN+9hQreUSq+
         rXrw==
X-Forwarded-Encrypted: i=1; AL+hErEgfYUCTeFk2nSBRR30fJNTxtjmRVJi7rEoGrjjCv+a9+BRaQ+cflyHziuHrMnTs5iVgsXALNX0ue7MHZVO8Jsa/Bo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hSPRRcKfGNiqOkun7SMF01tPTUkRgKWYm3A523i8hPhj9HSQu
	o1jvvKsh7yezTjBsmhdsRpPkiNhxFFrkgt+YeWRhv9bYDhkHZSSuUb0RvjyLAXDfyMeaOFTyrUi
	KIsbQhJkIeskqC6f4BzDCDw==
X-Received: from wroc13.prod.google.com ([2002:adf:ed8d:0:b0:48e:7f1d:d017])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:310a:b0:48e:5444:a1d3 with SMTP id ffacd0b85a97d-4927e553b25mr5552552f8f.11.1793988480221;
 Fri, 06 Nov 2026 10:08:00 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:51 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-16-vdonnefort@google.com>
Subject: [PATCH v8 15/21] tracing/remotes: Use ring_buffer_capacity() in trace_remote_has_cpu()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_remote_has_cpu() calls ring_buffer_poll_remote() only to check if
a CPU is in the trace_buffer cpumask, needlessly polling the meta-page
and waking up readers. Use ring_buffer_capacity() instead to check CPU
membership without taking reader_lock or triggering wakeups.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 3dbb4912dbd6..276bf94e837b 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -351,7 +351,7 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	if (cpu == RING_BUFFER_ALL_CPUS)
 		return true;
 
-	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+	return ring_buffer_capacity(remote->trace_buffer, cpu) > 0;
 }
 
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
-- 
2.56.0.455.g6c5a503b38-goog

