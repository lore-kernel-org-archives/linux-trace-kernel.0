Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65043C056
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974942; cv=none; b=GWDG60XMpULiggOSFDTqzhQnNrNu8X9w3veFFjqOZxokE2ByFHIjYYM6pAuep94DwVqs19isNMy0jVc/bBLthTC/n4TM+zS693u0PtvuI+f9uMa30u+eiEWHLYzdWWiEDvpTHug2oc4IitJrqzNaukZfstKod6iwOKu0C54NLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974942; c=relaxed/simple;
	bh=+aLf8sJ2jSSh6RfXGhvqvy30hVqnV99JUTrdKIVPIoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqxO4k+YlBK9IHYQ9A1lWNxUNr4HtwUXTtxl7utF3LjoZeyfw2LatTbQDkdbG1e37qBLt7iAVJJFi7HExswdUVYP1Ym2Pt+OvcU20Rf1XqqmxLmJGOV9Y/XmNDL5i2FY4NhwWKQ+tXXrvazLnHFB1DWUtsQ95rpv4jz3OKKSxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMTT5sQo; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMTT5sQo"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so30427385e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974933; x=1787579733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBxDFwerGNp3kLgXxOLNRiwJfs3Kv7+f/0VlNLh+Dd8=;
        b=AMTT5sQo9wqYdw8rHv0hBJsLInfNKE+ORM3MEGxySuJd+PPIjXSAum56Mq/Kv1EWTq
         t6fnd+kH0e/sD+/yJu+/YKW6QvJPeDCah1D7xtbbwz4lqdsakXDhjtUn48pwEiFgB063
         gRr/sQFmhGVImKf3UheZVxgt9+Yg38Q0dYPe35KMWyIneZW2nMAYAHJGU5HrMErlMC0F
         3Q4SOaPVlpjK/VfHLNah5PNF1JgRvjwiTaqNhaXd2WBhcFsqvAfwhI2mghiomD6yl6Ty
         ufS/acnEfXMvyy6/aOAI6AX/n26EDYHS7QagqnJQdFPzfsfnwlBEY8i9iklha4Vw8mW+
         5Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974933; x=1787579733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBxDFwerGNp3kLgXxOLNRiwJfs3Kv7+f/0VlNLh+Dd8=;
        b=WMMY4iMNX+qQ3P0QZyCE4tgAUfxC5KTorAsupCGDZ4hEr51xT4Rs4yi+577s9NMh2Y
         zwulKlc08dCU/9V1CMqb922pIlL/ZzGjZHU2Rjc3kLGACpYe2iJ/lFDpGNAnSiZ+GLFg
         rxHF9l2ik9HyR5i1qr+fFgjGB788MTCKil1mSeToabYeC/UKD/OwkhVe/EEzfC/rdnLm
         EXwzo+ETlRwqGjTLRiueqBcNFCdV5BQvY83ReX99otrkG4/wIIwy6hqpRI2+phYmqfYD
         OD21ZINoebAoiuyQB8rX9q6llUvt1YCn58iSTEr3EjkqbFA9vnMkN+j6igJ7tR+HLPMu
         wBOg==
X-Forwarded-Encrypted: i=1; AHgh+RrVEZCc7bRIUvYLSojlEO4wM0D69beBfDWAAl0IZgRH6mhP28GqUXjrWx7Qo2/H0uPVqAubgfPsKixzfXwF+r36dLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcsRWvjC6lVs+DfwxlnSVE1KD+joR+ZxPHU6vfkCqlgLAY26bG
	WiuG/r3qFfgQLN1vLKlATIyYeeRAZlO6I76o5T1Us5ZuloNiZ9IHjYRJ8GX/ta0y8X+TJv27I99
	xij3TTrhmrVyq7Er3/70rgQ==
X-Received: from wmqn11.prod.google.com ([2002:a05:600c:4f8b:b0:493:f301:6d01])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8b:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4999fb04106mr6371255e9.1.1786974933303;
 Mon, 17 Aug 2026 06:55:33 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:11 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-13-vdonnefort@google.com>
Subject: [PATCH v6 12/18] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77561f90d0e4..290c5958c053 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6851,6 +6851,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
 	return 0;
 }
 
+/**
+ * ring_buffer_poll_remote - poll a remote ring buffer for new data
+ * @buffer: The ring buffer
+ * @cpu: The CPU buffer to poll (or RING_BUFFER_ALL_CPUS)
+ *
+ * This function polls the specified remote CPU buffer (or all of them)
+ * by reading its meta page to update the local reader's view. If new
+ * entries are detected, it triggers wakeups for any waiting readers.
+ * Returns:
+ *  0 on success, or -EINVAL if the CPU is not in the buffer's cpumask.
+ */
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-- 
2.55.0.691.gc56d675ccc-goog

