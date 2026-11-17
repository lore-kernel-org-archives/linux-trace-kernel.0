Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928539;
	b=p8Xq0qS7GzHI9D40WxKpcARl0viKcfbNRQCk7IDcU9Nzv38TqU8ZwJXcPmxM6nXBJZGv
	 zcihsCuvIqF3a1WL9O67nP+tqECgACVHhx3iYvXZkfg+VNLU5azk0C7PJMMq9DOGlu7d6
	 AOUZ80ejR+4l8UACxDi26/zk2hNZ504z9GWbG0iBT/jI/YsHzv3gtRAanI9KlEzP5K8vD
	 PTfWG0IMHSxLmIxp542W8yIwF0eJx97NxCfJsdR99mvJj0i+oAjn7qYeLKUe1cJ16PCLc
	 cm8tce1zEOc/lhbu2DyzmBNNuhG8+TF1lbgTNC10UTwh7D43dtYZgWsF4Zil/uqQH1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Dvb/uhBRLlieD3DxnBsDgJCSszczVxiDnHK5Gq+WxBM=;
	b=i9twnDeTaS0rTpnF0Cwm+kiqpm7Nj6EG5qjZq0/rkz22XcLne3vwh/r45JxV82SJld9z
	 yquTfuvdCV/rFkeenVp//xOytil25n6ehlf9yBxU4av8mUjRp/Ak0pnpy1D6gYPNNCq7p
	 Bc/otSGM2lT2IVD4pqenS1QOr8JXUyo44nJ7indrmskur0MotgBplgIiYf12ZlbGYUSKx
	 2O7XSci0woOosFe+PeZf5hjl9o6tgzMIVcRJNPMFVKK9w0INYNsE9a8P9hsfAytB3szYd
	 EuEY7MpeFNZrVe2hi+pZrPKqfvG3reVh+8FayjP2fIc7W2wJobQy7YNQdCwsSx/CpiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gZ7LyHkW;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAF606A32C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 15:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2BAF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gZ7LyHkW
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso39690045e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794928537; x=1795533337; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dvb/uhBRLlieD3DxnBsDgJCSszczVxiDnHK5Gq+WxBM=;
        b=gZ7LyHkWCMegg4n/ftFMALR0gv4RAhOwmXgxUt9tftmwLqxIQnVGempw5bAeO3tUbg
         N/ZhvYb6ZjqUSHeM7Vo42L/ICA+zZ7b8DN1K/JdykT+0CajA9cTkavV6jl5HGXREjMZ7
         kLyf9h/Kw2JfKUTkmk0GUM0oaXLY+GjoFrDq9ovSpufU9dnCp0kxjNKM9UcL8ZdLWgYb
         ZDjcVczOeDwTV629wZgZanG1LoEJBdWFgkDIOBTp0qI58SKETNz5DP+3bqnXek6hgFgK
         yCr8DNDln17CfQ+AIqa09HS0BhRPtIuXniEtRbcfnL3KJ1+BxtJUgjYThmnQBzNywpQk
         Opmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794928537; x=1795533337;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dvb/uhBRLlieD3DxnBsDgJCSszczVxiDnHK5Gq+WxBM=;
        b=TdiFehxVZ8ARnRytC/CD7yV+WgDUiwxft9FVCf7zxYL67Q/wGdzWJKwo7c7cFcnoRT
         auxJmBnjmZXe8xsFAAOMZ/v2enzxsQrcjSuSoVqGTe0rAOGMPa6NYWwpKVANJlCPGy8w
         y6d3GesJoCTaXT05SIATw1qzxzyyK9F3LcfRr+erIyopIL54WuUi2oB89TMlSSdr90Ke
         CpbWOX4Ksv7vLw4+KEs4InPXS6pmqfMhSfRJnwThgLjFDcYq4DCRWGa8QOHh1OIO1oam
         dYxNf9+uBt+SPj1fbR4vZ44TOFRy2U72hQY+BewiyyJ+buhkwpjubyZOPvVEjagUjsIo
         RPBg==
X-Forwarded-Encrypted: i=1; AL+hErG0ypGz2u/D0vIMZVTZZuQvTAKYm/Uiw2YwY5Qjdyt80W6lGueka/7s50hkWrge7tyL3LChMlIqFqXleTYUEV6S0kw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/070fG23KtEpQvcI/W+LA16QqG9i56LlgbVE2gM52jCY7V7GmF
	Up9TxeTA3GD6xd2rnqcdeOd/UXykHwIPrmhUuyjJ3SGfR+RtRZ27eQjqOlcqLbqU+LBgZ0PPaDN
	Y5vqIpiDM6sli9iPXiGcxEA==
X-Received: from wmox16.prod.google.com ([2002:a05:600c:1790:b0:4a2:11fa:1981])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6097:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb66265d0bmr200655825e9.20.1794928536708;
 Tue, 17 Nov 2026 07:15:36 -0800 (PST)
Date: Tue, 17 Nov 2026 15:15:20 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117151520.3972146-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Add missing cnt increment for remote ring buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ring_buffer_per_cpu::cnt member tracks modifications to the ring
buffer links. It was introduced for rb_check_pages() to avoid locking
the ring buffer for the entire duration of the check. The reader page
swap function for remote ring buffers does not update it. If a
concurrent rb_check_pages() recorded a page as head before dropping the
reader lock, it misses the list update and loops indefinitely. Add the
missing increment.

Fixes: fbd1743ecba1 ("ring-buffer: Add non-consuming read for ring-buffer remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..d386da1414ed 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5878,6 +5878,7 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->pages = &new_head->list;
 	cpu_buffer->read_stamp = new_reader->page->time_stamp;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
+	cpu_buffer->cnt++;
 
 	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.703.gf848ed807c-goog

