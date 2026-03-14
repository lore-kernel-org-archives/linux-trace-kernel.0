Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858C383C96
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519283; cv=none; b=gLR1QcvgIIgDptIanZ4NjbT3kLfKm6czogwAcZpsrVxHFQaPVOmQhKLcgGeC4abrlSMx0jzzP8vl02LfYQdltjrdpoetze6UFBk9/6U7qYdNyigqW9Vyo2QeUH/nU9ri1ely38IahYPBasKGTWCaffP2UIoDBSp3rPyHjol1R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519283; c=relaxed/simple;
	bh=BynOgwAYPtb/KpshiEi9Ah5xEZa4UMFbs/5oRQMyRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbfXFsw/f0Q1q6PbehDWDn/jNIcADhK4UDXDYSCP0ux/h9BjwwGxc9kZsDlOZTP8OK9YhMsIqer4REQnBcDTah2YqOR+Ge/s9alFc2Ya8grAuqU0CcBkcD6glOSXpGcH7SyxgK+FtOetNXOKX8hWEBzofNQYqTRha6WGl5vA58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hro6Tiyy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hro6Tiyy"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40946982a78so1278331fac.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519280; x=1774124080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZQP7SyWGDwwAMOAnxSbi4O+tM8xtS6WH81TGDPwQ5w=;
        b=Hro6TiyyKbllqTwuYBm8ZLytugkPa7QgbTUsOycf61G5oWgwGxQ8mFa88taodDMlLV
         e2e5r6pIvC+SyxZ/w2RzZZnPfrjMOcdUGdFbAdMoHEULawFq5m8QanTVSw+6Oawc8M5B
         bJ9ZYk41i9HkS6xB0RIfyZDG55Z1Olr8qBjbxGVoO6vpHG/oA8zz1kZHopN/YrDuaQsd
         pNx8erJaKVb0RK+jca5AxZ1JFMntIX/bZDOA84Lofxk8/EGhD86e/X+JJ40XCq3wyQsG
         wS/XjtW4vvUbXL7IcaXpfeGh0KefJ4KtRApp/c/TFEEPmwyrHmf5UtgCB06ZSp6OZsGj
         3mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519280; x=1774124080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZQP7SyWGDwwAMOAnxSbi4O+tM8xtS6WH81TGDPwQ5w=;
        b=HOQjuCj6obUlEspzdaL8ONSix7qH1zYtsf5iv5oRXG/GZUKvEQtNYoBWpH3dyctEFp
         B+J3edj8Mi8o3Tpcby0GLLTvGGqM0csbXNdnyFy14MTsfpvXgVwHTnozQHiH/s4TatDH
         ZWm9fM88vyC5ttQrkQFccKreBMBmtbU2ebPos9j5mE0H1UgMaRfdCfO1xUwHv0VF445s
         LuEpf/UsovEaSLagvfL1nb8iemlAIO7a2EclYa9cOWZSEenhxalhcYe7du4K2INGafFH
         dndizCgEB2MF2HUEK9+9kpbUnXwqAouY0Ariz0SGGqwFXRDyA+JH0XosSt1mkOCAAuKw
         x8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzt9QfNqUh5me48V7jvxqN2x5MqD1bSCaZBSGAa8tmrLbgaxBtvkX3dQfqKzLt0TRfdBP8KlrRGFlz5DUDNsE4Umc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIj3a1T8GUoSB4koNzfVOjNtGax3BRDeWZNlY0/OkjTkGVCI9
	fBBm+WdZ0Tlr+xmhAzmDs4VCav/xy95F9IvV9rBX3nk4S3Fxq1R/itE6
X-Gm-Gg: ATEYQzx9mQ3oW0p8s1azODklsC+3nrdB1s/oHOSqppzEKcNYrebyc5dkWULfy8X5hWM
	4AujmHy396YeRG84nX/7uj7lvoCxQDz1OgZxtA9wL94FZubQE/pnrs6YeFpEuhDKXqwnhGBOPd4
	GQ0c/5KIL/AeWZHfkiTWn7nRwUapMk2LunVCHiUtl7dkEcJCdb4mJcpwukxJSPja3I/DbVmVwqH
	Ztf18r9UOTpTK+KYmEGwB06eTzqjz6tSXO032RvMPsxj4FFXMXXH5bygQoLLo0hbDS3UghRuCA7
	1lrGLj5kl9/ciJsjk35oH1kuagt3DHDdzW9AaRe3fOriauRAf0a2Wahzj3HQBWIv1TEb8LBmlU7
	DBQdPhuFjliQpH3omLQshceDEAgG2XfIQJxhDsRu1aQvSq3fYCMUxmd3MIxIPI4qqfESc9nArB1
	08daDoJ6528da38YjBzwFtRCZ5jv9k8Rs5DXWnOf65Z0NFSxTEIILY+dFC6UWYXcpGjqB+nSDqm
	sHdohnE1hN87u/HwSS96DkPmEMpnXZH85ocfiiq
X-Received: by 2002:a05:6871:ca:b0:417:6237:cf82 with SMTP id 586e51a60fabf-417b923e031mr4502917fac.23.1773519280265;
        Sat, 14 Mar 2026 13:14:40 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:39 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting across ratio drift
Date: Sat, 14 Mar 2026 14:13:34 -0600
Message-ID: <20260314201348.1786972-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised, even if
later receive-side truesize inflation lowers scaling_ratio or the live
receive window retracts below the largest right edge already exposed to the
sender.

After the receive-window retraction changes, the receive path needs to keep
track of two related pieces of sender-visible state:

  1. the live advertised receive window
  2. the maximum advertised right edge and the basis it was exposed with

This repost snapshots both, uses them to repair receive-buffer backing when
ratio drift would otherwise strand sender-visible space, extends
TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
truesize-drift coverage through TUN packetdrill tests and netdevsim-based
selftests.

v2:
- repost to net-next and use the [PATCH net-next v2] prefix
- rebase the receive-window accounting changes on top of the retraction
  model
- split the series more finely
- snapshot both the live rwnd basis and the max advertised-window basis
- extend TCP_REPAIR_WINDOW to preserve legacy, v1, and current layouts
- add TUN RX truesize injection and packetdrill coverage for ratio drift
- split the generic netdevsim PSP extension cleanup into its own final
  patch after the peer RX truesize support
- add the requested ABI/runtime comments at the non-obvious review points

Testing:

- full runtime selftest coverage for netdevsim, tcp_ao, mptcp, and
  packetdrill; all runtime suites completed successfully
- tcp_ao completed 24/24 top-level tests, covering 803 passing checks,
  6 expected failures, 36 skips, and 0 unexpected failures
- mptcp completed 588 passing checks in aggregate, with 28 skips and
  0 unexpected failures
- packetdrill completed 219/219 runtime cases with 0 failures,
  including the new tests
- netdevsim completed 18/18 top-level runtime tests with 0 failures,
  including the peer RX truesize and related netdevsim coverage used by
  this series

Wesley Atwell (14):
  tcp: factor receive-memory accounting helpers
  tcp: snapshot advertise-time scaling for rcv_wnd
  tcp: refresh rcv_wnd snapshots at TCP write sites
  tcp: snapshot the maximum advertised receive window
  tcp: grow rcvbuf to back scaled-window quantization slack
  tcp: regrow rcvbuf when scaling_ratio drops after advertisement
  tcp: honor the maximum advertised window after live retraction
  tcp: extend TCP_REPAIR_WINDOW for live and max-window snapshots
  mptcp: refresh TCP receive-window snapshots on subflows
  tcp: expose rmem and backlog in tcp and mptcp rcvbuf_grow tracepoints
  selftests: tcp_ao: cover legacy, v1, and retracted repair windows
  tun/selftests: add RX truesize injection for TCP window tests
  netdevsim: add peer RX truesize support for selftests
  netdevsim: release pinned PSP ext on drop paths

 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 drivers/net/netdevsim/netdev.c                | 156 ++++++-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 drivers/net/tun.c                             |  65 +++
 include/linux/tcp.h                           |   2 +
 include/net/tcp.h                             | 118 ++++-
 include/trace/events/mptcp.h                  |  11 +-
 include/trace/events/tcp.h                    |  12 +-
 include/uapi/linux/if_tun.h                   |   4 +
 include/uapi/linux/tcp.h                      |   8 +
 net/ipv4/tcp.c                                |  75 ++-
 net/ipv4/tcp_fastopen.c                       |   2 +-
 net/ipv4/tcp_input.c                          | 160 ++++++-
 net/ipv4/tcp_minisocks.c                      |   4 +-
 net/ipv4/tcp_output.c                         |  25 +-
 net/mptcp/options.c                           |  14 +-
 net/mptcp/protocol.h                          |  14 +-
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../drivers/net/netdevsim/peer-rx-truesize.sh | 426 ++++++++++++++++++
 .../tcp_rcv_neg_window_truesize.pkt           | 143 ++++++
 .../net/packetdrill/tcp_rcv_toobig.pkt        |  35 ++
 .../packetdrill/tcp_rcv_toobig_default.pkt    |  97 ++++
 .../tcp_rcv_toobig_default_truesize.pkt       | 118 +++++
 .../tcp_rcv_wnd_shrink_allowed_truesize.pkt   |  49 ++
 .../testing/selftests/net/tcp_ao/lib/aolib.h  |  83 +++-
 .../testing/selftests/net/tcp_ao/lib/repair.c |  18 +-
 .../selftests/net/tcp_ao/self-connect.c       | 201 ++++++++-
 tools/testing/selftests/net/tun.c             | 140 +++++-
 28 files changed, 1911 insertions(+), 76 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt


base-commit: f807b5b9b89eb9220d034115c272c312251cbcac
-- 
2.43.0

