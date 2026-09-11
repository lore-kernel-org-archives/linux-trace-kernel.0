Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C921493D54
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141827; cv=none; b=jJboOuR7Gq+2StAoGURnjuyoInnRVY+sj3uf+n0P5f2PeNjM5bPYBcrfdtb+BOYv7vWM7KcMBggcBt6MEdHVelWZyiQRS/0Eah09fo9kzcEfm+ssT8DdvuOWu7aJ7TgOusb+MXEqsigas6Hfd5hXQIiDZyGLQLgErSe25C5Vq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141827; c=relaxed/simple;
	bh=su1nVbB/LmrwcbgIHEdASzbwPqD+yvkGmESjKpyOAkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFHA/UMRGMBRCMRWIHbQcBxOxWE6DgCFoO3J2Cwx44c6IAgtkvrvqRbxxHHAgecoRbW65aGW8faP0b08zFNtesOAkkTUI/T/7/FUx0S481NHw+Js9JamIZXWPkDtrYvD6zDJ7UCDja+qNCfc4+pW819YOAHcVKz7w7Z98TAF/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZghBkiK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZghBkiK"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4d03f95dfso463083a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141825; x=1789746625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50ghC1gu7q8PYuqZviUTnNaIyk8GwN9m0Bvx8/rbGZI=;
        b=WZghBkiKUuL3rKPB1nmAUPxFHYhVDok4E1qBqh1+VKb9huTtXGNSAIFEkv/OZXrUYv
         RTt2sQ17Sz8LTijork8YXK0FbmOe6wanW73zwJcXGJBpZli1SWnW/8Nv/kF001tUFqOj
         VQFCawVgReB1mvxpTu2bDLq/17kcrN3WuDjk1MKI86r6Mg6ukCXFe19eGKRoUal05K1v
         lZb1HVoVUezGqdiDlz868U4llnftK5OP7KnBnebkVaAHPJoV7+R9zN04lBHCP1zPAOQT
         gIG9ZvnHNz3XdUBnpd5V80S7DYYEntYxoG1ErJYQ5uocg1A15cAXRMcG5oT4k53OShKg
         rdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141825; x=1789746625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=50ghC1gu7q8PYuqZviUTnNaIyk8GwN9m0Bvx8/rbGZI=;
        b=Gcjs8vqUtFFeWU7uSvUz7xCgDoQ/OhKL3PkuPQTMo/Wzesjp8pjLfSLE5xfA4XGx59
         xkRNZjh8GSm10yr/aHe26EP56yJguOSwt22fMB3AExqN/UHUm+J0PYSpSmBQmSoxa+P9
         V9i193JGwy2Y7Emgbdz/0j4bXra6RuEnl53jYqACOo43Xss/aejLK/+P/lmqgVmB3lNO
         8SsfU7ZX0T/i9HZnL9Rr5Yptce700bNVT8Z+crYkBQWjJR1ntq66EVWbk2btE15izSrb
         dWoNSDEKgc9XruivBYVT216id5mCPfmCHuY+j2e57qxNpxuhn1G3ZoEIDL8kk7zS8Dre
         focA==
X-Forwarded-Encrypted: i=1; AKwUvBypFBEBJ6bXRXeerSxSdnjyuJWqOwECTwRuOv2GVgpT0ibdvXGV09SOKDsgn8C5QKQZym4fttfe4lSckLwKsiFUK88=@vger.kernel.org
X-Gm-Message-State: AFuF++n39mtEkiS1zebpWNPB77o8g5hIiJLwpOUXU1aAWFBGAnytZKky
	jxCY2GGMOcfgpJRn+5paNwD/rtrAIJFr9NgKuhHI2nmcTjDT+NqSkRqsWEIIlQ==
X-Gm-Gg: AYBFou0UTotgfD1W12y3uuwMxa+eq0TN9ojDa2gSETFmkMQvLXKgbTcl1NnwJHLU8ga
	7QX56zucfPQGfjUBxDDvLWcryGtTDkeiEklnoezItDYubrjiaRACTNmyqpzY2f1cD1EOE0yZXW+
	b3IAno8QoFkd4IKgfRBeIfD7kvCv/hFmXkA4T+rCv1ivN+kk4ETI+haa+kEkhCNJnumT1dHvk/Y
	znQvDE/hIX9W3YysVGH7TuTwA3cRYbBomj32Il56a+e4oK6PsLpzKnTdafjGyiBQTrNk083XNe6
	qcSJmWBS6oj+XboAZno905CrjesdePonzW5HEUT4uNC55rNPBJMpEZirSewy5k3aDVeOi9xq2HI
	VnY4JZSDuqlaofclj6g3RV7M+/DjxOuUujrUWM39+6mSKz+Bi07NispCGxmTfDWNYD6scZ4277G
	4XUmsW2QAP3fj4hNxc3L5Uqt+lgJ84eIhv5u9npvz+OHnruNW+CzOfzom3xPQOoypzd5+VKPhng
	XytSK8DJ6vZNm7xQ3JqPvIUGdnmdWmpXy0lzrM=
X-Received: by 2002:a17:90b:4a8d:b0:39d:8222:6436 with SMTP id 98e67ed59e1d1-39d9bd8f51cmr8027254a91.7.1789141824694;
        Fri, 11 Sep 2026 08:50:24 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfcefb6sm13634895ad.56.2026.09.11.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:50:24 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v2 0/2] tracing: add ring-buffer memory usage statistics
Date: Fri, 11 Sep 2026 23:50:15 +0800
Message-Id: <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the memory consumed by the tracing ring buffers, rather than the
usable data capacity exposed by buffer_size_kb. Android low-memory
diagnostics need this to attribute the memory used by tracing when
calculating lost RAM.

The buffers can be spread across the global trace array, dynamically
created instances, and snapshot buffers. Userspace currently has to
discover and sum every instance, and snapshot memory is not exposed by
the per-instance totals.

Patch 1 adds:

  /sys/kernel/tracing/trace_stats/memory_usage_kb

reporting:

  buffers: ...
  snapshot_buffers: ...

covering the global trace array and all instances across all CPUs.

Patch 2 adds the per-CPU view under
trace_stats/per_cpu/cpuN/memory_usage_kb.

The values account for the full pages backing the data sub-buffers and
reader page, plus the cached read page and mmap metadata page when
present. Slab-allocated ring-buffer metadata is not included.

Changes since v1:
- Include range buffers in the accounting (Vincent Donnefort).
- Use READ_ONCE() for buffer->subbuf_order (Vincent Donnefort).
- Keep remote buffers excluded.

Xiang Gao (2):
  tracing: add ring-buffer memory usage statistics in tracefs
  tracing: add per-CPU memory usage statistics in tracefs

 Documentation/trace/ftrace.rst |  15 +++++
 include/linux/ring_buffer.h    |   1 +
 kernel/trace/ring_buffer.c     |  41 +++++++++++++
 kernel/trace/trace.c           | 104 +++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)

-- 
2.34.1

