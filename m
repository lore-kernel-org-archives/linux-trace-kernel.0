Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F23B777E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215791; cv=none; b=dBLgJD0WlccMZNa/X6uuPzGCLM+od4A0y8lrIDqHiAS2U1eDFd5hxxmogqH2Tvn5g5jqbrtG2hbo7iRFZNKogrRL/qxvfUTGPd8gWPwNMknYKXu6ls2H5r+dkjk9278JIPzOEvkeWKHkrLW6eCfyq1V5gckb1uNXrwqYDhaJ+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215791; c=relaxed/simple;
	bh=FDmpie23sScGP+OdflWzKGb+2xENXEuu2nCfUaQR7H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqbF6pKK/9i19fYeKWgndQ7aOIhXqt9cG8hnQtr8+n85DmjIOtVES8xnndXJA1CPUVlTCc8HdXSgovTVjEWrQMoW2syZG6XZMoajq9+Ljot5SFLOp7/gB2HOEwvZaOmT1imj23F7guGGPGe8RvssXyd6hRryCgPaZjrUkZzwrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep5ux/fP; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep5ux/fP"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4043b909ed4so6050641fac.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215787; x=1773820587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=Ep5ux/fPJChFYDWKlpLfuOO1GEiWepqX5YSftIEKjejsYgGZEgeFdk7VC2EWhb8sjw
         yZnAWSme2lhdMgJGZLPGlkWY87JyXHwKw4yrx4cKfk23r8vUdUGfRNsGcr3wepcvvpnX
         +ZBiNo36lnBHhItUD6h+wVdvz4jzLaBKAlOq1ct3IXYo96QCzlMTTcFLlSNkm0Gy/73m
         dbxk/35kkRGr+emMCJkLKVbfK+YxTXvDUZ1LCaE3Y2UvyHgKdd2b9BZSFfc8E3U8nK5s
         GoY5MNQo7LXXV+p5HCmzioTWpk5jhKPwayapprzlHQmD1/h79E7bvS/tQtw1ERPogvQg
         3hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215787; x=1773820587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=xG0pB+RlenQzCH/gB6q2qVUvF4P4+Y261+nQSbIWa/+k1coueU57CciZ99pnF6LZ6P
         xVE3psegjek/1OcH1dr7uH6YG29aAvjSvi/5aqnU+cBCyt58MsVV1GmM4muIUS4XGeDH
         59WdCU1EoyInFoKSivMfG3NLfSD1lKku7vaRPOUljaXnHv5065TXelut1/YbAoxZVCEk
         VFNtWOmWmge79rXeAx4+330hugEj/q9QDSkN9HzzpwNTyfZ3lyvduklFJYT2YW9tnQD4
         LQIEGGOjNCWlwrhPa7LxnOfcd8WRsOQSiEahyAVMG5lGXx84seXTEvH4AxHShq/6wplh
         TuPA==
X-Forwarded-Encrypted: i=1; AJvYcCUqg7aoTkwpyCS10Rb298QZ6wCcFmmSolDrQNjIqoJ9vE9JQNyKUorRHS046TNAhc1HxJAyO3DnEO06YrCl9jfCBGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvXcwvP2/s9s9Fwm4aicNy1RTcdpIiNHLj42PCuRaIRH1W8Z5
	5zUR71B+tTE7L19dA4XOVO6DT6DSXiMnG3OSHeLhfVh8tXsFV1Z7WMmI
X-Gm-Gg: ATEYQzyvGyd9haceCAnG1MGQO0dOCXiHbOLq2duzwimpI6+pNnIDcDH4z5dBhy0T8Bo
	tHi0fMPhoDZlr83vAsB5whJCJW/K38Z2t91qplpc0C1s/7TTIew0avHy4E55CzOXVSfThpDI9KV
	6PoNIMfQptBO+NSHVJuCeFnEpNtaTQRJlCz9Bu0NMIPtZju2V6JGZuWXVY6tiEU55R4cc3tGWec
	6ACgfK4UyNZnEt9uJEg4yV90Iq5P3W73x+dQIQnx5F3pR96ZJDitwy6jXZdQG+ksWMnU8SyDyfa
	dmMXyak0KQr4ehA5IRnDGRCyIMO4Il/iISJpWkQSaNGX4MCKANWxEG9ccyXsBzvjkeOUehKYgiX
	1USignMc0n+x8iAkCXqbzT2jG4/J83k0iEbmtOxx8iRWS1f3faD63FKy8tnTH4BQo5D0NmzOX3Q
	dHvOLWxKgtRDJFXNnRQMLTQU9/PzL1dBfVRL0lsuposkoxyM6zAAZ5KOCR/RJFSgZyu6VfjsyuG
	Lbi7AmVqDpO8Gubqteg+DgjDZZbIxmKGvOc7UWgy77dZkZq
X-Received: by 2002:a05:6871:8a5:b0:409:6862:aba5 with SMTP id 586e51a60fabf-4177ca9e65dmr1127232fac.25.1773215786910;
        Wed, 11 Mar 2026 00:56:26 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:25 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across receive-memory decisions
Date: Wed, 11 Mar 2026 01:55:53 -0600
Message-Id: <20260311075600.948413-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised.

Problem
-------

`tp->rcv_wnd` is an advertised promise to the sender, but later
receive-memory admission and clamping could reconstruct that promise
through the mutable live `scaling_ratio`. After ratio drift, the stack
could retain or advertise a receive window that no longer matched the
local hard rmem budget.

Fix
---

- store the advertise-time scaling basis alongside `tp->rcv_wnd`
- refresh that pair at the TCP and MPTCP receive-window write sites
- consume the snapshot in receive-memory admission, clamping, and the
  scaled-window quantization path
- preserve the snapshot across `TCP_REPAIR_WINDOW` restore when userspace
  provides it, and fall back safely when legacy userspace cannot
- expose the accounting in tracepoints and cover the ABI/runtime contract
  in selftests

Series layout
-------------

1. track the receive-window snapshot state and helpers
2. refresh the snapshot when TCP advertises or initializes windows
3. use the snapshot in receive-memory admission and clamping
4. extend `TCP_REPAIR_WINDOW` for exact restore plus legacy compatibility
5. refresh the TCP shadow window snapshot in MPTCP
6. expose rmem/backlog state in `rcvbuf_grow` tracepoints
7. cover legacy and extended repair-window layouts in selftests

Testing
-------

- `git diff --check origin/main..HEAD`
- `scripts/checkpatch.pl --strict --show-types` on patches 1-7
- `make -j8 headers`
- `make -j8 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make -j8 C=1 CF='-D__CHECK_ENDIAN__' W=1 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make SPHINXDIRS='networking/net_cachelines' htmldocs`
- `make -j8 vmlinux bzImage modules`
- `make -C tools/testing/selftests/net/tcp_ao -j8`
- `make -C tools/testing/selftests/net/mptcp -j8`
- `packetdrill --dry_run` for `tcp_rcv_toobig.pkt` and
  `tcp_rcv_toobig_default.pkt`
- `virtme-run` guest pass for both packetdrill tests
- feature-enabled guest pass for `restore_ipv4`, `self-connect_ipv4`, and
  `mptcp_sockopt.sh`

Thanks,
Wesley

---
base-commit: 908c344d5cfa0ee6efb3226d22ea661e078ebfa0
-- 
2.43.0

