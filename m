Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537C4503EF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Oct 2026 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552544; cv=none; b=kmkbHxg3elTkArkergLC9vaVxXcdYcuglIqz9GF1Ahc7l/bTwMuClFRO/P93jDfvRxcji/nROzZ39UvBAJni5goe84m+ZmcEt5h2F4KBwds9atWFKJMLmNG+Cnds8gTHFkp1ajyZ9VrIzKQQJ2FsoDDGwKS9C4QY/S/Dqe8j47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552544; c=relaxed/simple;
	bh=zd77oAJSN5ZuLQMCEq5iNjH0bvfFx6ptqLP1yQUV+fM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gfsXoEXNXmvL1VvOh5VE7Fi5470IJmv82gh752aYk2m5YYN2njb2DSFmwzLPn8MQpKcEVKu046SP6TATkZZpx5agzYm75a8Az/FMEDxQscmcecRNyplzzRqUinYd6kL0lSlKb3PEgkSmGNP4HYVtS+taQIeIK14nDZo+A7XnsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfJmd4e0; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfJmd4e0"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48afe67dfc2so1099393f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791552541; x=1792157341; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/rPvKIus9N9aL5wDPskeHMQIXHdNdQtdKHL3wD9tCZs=;
        b=QfJmd4e051tDagjk6oKHymahLVMXpwRmhT6VNTgzUYC42MSiIgkOdF6s11OGtXPN+p
         xpndnLj8xYrgtp6vBbU67j6S9mTF11xj+536AlJFiC8HwQWpsi5mxyS6ncFb8wYEneqk
         jMA7nU8FBAf10Niq4O8uMRz31fUTLbTljDSR66Wk65z2a94iVfHohH5oqx0KL4a3vD8r
         J1bYOGlt0qKwmjsoY98x89qvPkajjakyEB3gVy4EbpwmUKSouWYzjQX5Kf5XASaYeN1J
         jG4TngT5RtW7OIHtQYCKqbYCZE4KZecU6Uz9LUI4H5nFDIZUzv7fDIG03PAng+HrYcfU
         0etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552541; x=1792157341;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rPvKIus9N9aL5wDPskeHMQIXHdNdQtdKHL3wD9tCZs=;
        b=VJ8kAzo3dWiuF9SokBYxBFMoSYDzJ7kRCIMWtmpAvc6jPUoTc2kfbdzECdEsOpEdMp
         OXInNc1eLCEdxmyYHKtXmc5ljks1MPWst+11WJk9JAJ4wu5duhPAxz6+ISxfCfqv5r1d
         bvv8emCh7OAwu4kdXwR5NInSONnM+8WX2gvVMhCR5tFLwWMlAZa3wEOBRV90eD7Yh+Nj
         kmr2ZBFPBDjRuMEL5QBPzX9JZ09eY0r3kqXe1JANSb17E+Y/1rEog3Elp9+vxaQ27NDq
         tNQasr5D79v9YlNyfblTaWOEAgD1pxdJxLaelRaIsoF7evPmrtx/nKREmS/HAypo4GjV
         sLlA==
X-Forwarded-Encrypted: i=1; AKwUvBwqlapw5nIgNFrFysMMqWq1meZjvtuQI5IC7wJPIXqlBQazpfblBFSqhk2DOULjA5l+1HsP6kix96/j/0Z8nT3+Rjc=@vger.kernel.org
X-Gm-Message-State: AFuF++lTHyV5zsEOUN1SKNWIlhKsWfFDcJPWmc5tuXEhohwP8sMWdZ7y
	VQ7b7rPtCBi+NA6o37o1ZbEMqpHt8DpbxhR2YygePVqKdHlqjfuJU7RvM5JY6bueFxO4fwJqqCo
	QTRvrEkc8zu5phmoN7h+MPA==
X-Received: from wmol15.prod.google.com ([2002:a05:600c:47cf:b0:4a0:cf4:71d8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr35219285e9.2.1791552541416;
 Fri, 09 Oct 2026 06:29:01 -0700 (PDT)
Date: Fri,  9 Oct 2026 14:28:48 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009132848.709379-1-vdonnefort@google.com>
Subject: [PATCH v1] tracing/remotes: Align field offset in remote_event_format_show()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"

remote_event_format_show() doesn't take into account each field's
alignment leading to an incorrect reporting of the actual field offset.
Use the existing field->align.

Fixes: 072529158e60 ("tracing: Add events to trace remotes")
Reported-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2d5bc423efca..7e35f48ae467 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1098,6 +1098,7 @@ static int remote_event_format_show(struct seq_file *s, void *unused)
 
 	field = &evt->fields[0];
 	while (field->name) {
+		offset = ALIGN(offset, field->align);
 		seq_printf(s, "\tfield:%s %s;\toffset:%zu;\tsize:%u;\tsigned:%d;\n",
 			   field->type, field->name, offset, field->size,
 			   field->is_signed);

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.56.0.385.gd3acb90ef8-goog

