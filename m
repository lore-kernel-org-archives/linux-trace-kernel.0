Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910503;
	b=2WRcjaw3cY9LS2UTSjDPUoJE/4VQgy7slvr6iMZrvS20GRP5XTC8UgLKME/cfom/jdMa
	 +tNtqTmwW9KhTkbVxV0zFJjmlOckeePFPfBYifBvAdIzO5pNvwHu8624QjJnRCHFXZC3W
	 eiFYEF1UwVGESvegzmBRpznl6pHSTFja//wvWIneMBmcaXRIO9RVb/SssFScfQ2gFYkR1
	 knr7BrV+w8ZL9gLLyBHOwOxOVqLrEaFmsOPLBYlzXTKWAE6LRdV+GoInxw5mQ72ehJ7zw
	 CNo3ZCUdMx6xFtWkisCdqQ8CAmLHGqodlihYYaOONx2X8/xwcd08jjJluA4y+f35TSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qAX9kyfis4Aqy4pr9MEWnabwBSlgiLOeyPCQy+N3HBQ=;
	b=36wlrQ9X8MQ9JSpq8mNC7EWfaEeYqPFs1y5etuGp5WTgUJD86Z9MOI3ExAuRMa5raAA3
	 3np9c0Yw1A8PT2hM06768xSENgUGKRgjGWYn52mVzFDxQ3Uu4gG2TaisfzcXZ2ucfS/Oj
	 bFUHRC4EDCh2+YbONBGwTIlJm+rsSJHS95QLJ7qLRJROjHmxNN3/VeFmaiR49OfvHAWuc
	 Qt+bweRtvIH3M/jFndOE/6TZMU+NwroY/URk0YNWf3/okYuXWtvAeVrYz0dHX/jMhTpmz
	 M4mQxFg3pN0aJSG15jvP1mY9MezW48Xvgx0yMp839AjrapM4hJo5rauw4tK2p7NsJWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GsIdlX3Y;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAB606A329
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 20:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EAB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GsIdlX3Y
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso14755985e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793910501; x=1794515301; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qAX9kyfis4Aqy4pr9MEWnabwBSlgiLOeyPCQy+N3HBQ=;
        b=GsIdlX3YytZquSuIzg4N+TOwbw8Cz35fPgGQ5WRQ9dnYam2MUyeYgpmNz3mGaq18jI
         JStnAksX2x2Wjf4yBZg3lHFq1q9TY1SCt82SP42m1MA+W5XrOtQZDkrxgScR79pZwq+I
         IN7eItxbUgcIBCZu97t9OSzSXPC/i9Dx/m8K5XlkSUwv/hbkH1oaLOuhNSps2/KRxnyi
         eeOMYg/Ynwpod9fEngbnTjdpIp3wGh8yRS7Ya0ypv3LKb0euqBS6doBqDHfX/BZCm6Aq
         1nHmi+if6ZmM16ghG2iSTDcemXrKZ9fkfjjgFKV3THyIOHUrT50BAtmJxOyGw0jWYpsa
         sgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910501; x=1794515301;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAX9kyfis4Aqy4pr9MEWnabwBSlgiLOeyPCQy+N3HBQ=;
        b=Q2XMVJwXWCNRhLaZ0scHRvpViW1RBt1HNT6NsBxdcUALo5w5/vsllt/Y7nCKpJqfbO
         /ytdlgoWbXL+wHqEvh58KLxDP6Gj4A2iHPG7glL7aOJbh6VQ1I0ZU/W7AG8YIcLTeUl3
         UcSXTM+JnvK1JUAsZeSf041cFTBGU2y7OLJeu5k9HBcp+bj0qIZUfndQSIRQUIbU9O5a
         JfgHeMi9fP7D1ogucw7DIKpKA2fpVyhHfpk9vIw/oU3mI6lAam01nOrLpDSaj2aclHmy
         TcNf8S4v8DlDLyeu4+joB1fDYXViUVaIgAR2zCuy2wfiA+1pUPibVgqEIJLgmLxZJ5rf
         +qiw==
X-Forwarded-Encrypted: i=1; AKwUvBwvVvn++BIgNxeNLonJDLRAFnHr1loHA1juKMW437QlN/SjXnBxvf3pxX+jY41LTibgJFwIPGq81wwNWl+eQBHrSqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+87URQODRyiRd11jp7Ht43vLoFAYs/5eWMMZjBm9CvoEElhdBh
	X67iZ0knHvCSHkz5zZN6kb0ZhyfXSA8iqwozfEwLY+sL4ox+h2tCwH/048KANDo0OKsWbrayv7C
	Cz/CCqikkVIcexGYrqc07Sg==
X-Received: from wrui15.prod.google.com ([2002:a5d:630f:0:b0:48e:1b5c:6e55])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3104:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4b6e054955emr4701325e9.28.1793910501234;
 Thu, 05 Nov 2026 12:28:21 -0800 (PST)
Date: Thu,  5 Nov 2026 20:28:12 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105202814.1350312-1-vdonnefort@google.com>
Subject: [PATCH 0/2] ring-buffer: Remove unused absolute timestamp mode
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
stop using the filter buffer"), nothing enables buffer-wide absolute
timestamps on the ring buffer and userspace has no interface to set it.

This series remove that dead code.

Vincent Donnefort (2):
  ring-buffer: Remove unused absolute timestamp mode
  tracing/histograms: Drop stale absolute timestamp note from docs

 Documentation/trace/ftrace.rst    | 19 ++------
 Documentation/trace/histogram.rst | 11 ++---
 include/linux/ring_buffer.h       |  2 -
 kernel/trace/ring_buffer.c        | 77 +++++++++----------------------
 kernel/trace/trace.c              | 10 +---
 5 files changed, 31 insertions(+), 88 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog

