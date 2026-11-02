Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620727;
	b=iA0BaXffMEQtDIaJw9zZvhe8FVBbRZzNrCHGOpZ4tTycRKwfuSCDCis6TFMHeB0VOgt+
	 IFFHCS4d9bW4IGFvqvBqHPP7N1g6KEV00m0jSxnbIX2z+cKmHbZ3+EMKSPQl5yyGuqsL1
	 juzx/PLciJNGpn/f4xH9h4ugMdfzsJWRB7aX0FNo+X11vmWokM6IaggYrzYm2/FWsqTLm
	 SUHtVwy6F6vaqpzhY6nvpU0rWKORorsQI5VI7FwGTgzztZnRalwlrHskY4XP6Gg+wsZnO
	 /1+Rzc8Cd3k7bLZc33CAecpELFbeJQ7uuDOabAvaQ6+h5uoey63J0rpGSWzF2+bpxCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620727;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=039MTMt2BSB8g/lZc/n6iywXg8buaWiLt7iqhR1lW1c=;
	b=aP0EPu7/HtVSt/5DFx8ghjD+hYywmZwU1s9Cj74KI8SvvlD2uzX1sXm7guGid8AGYKgF
	 RU2ThnPdbRmfXzJguclFKwUqHeMbvo/lnqjnPqu91PDTYB9iDa5Y2i8PkNnZomQnV//Ej
	 nHYb/ArGK7+9cfS3Ty7UZ0DoY26OcM01oX+IRs36DUMojvrVlI1rvuxj+D55DQx7bp2cV
	 CjkAIC/FBF0JMs5+rYQJ9FuuvweXU0/UiWfvRFNQ2uMUN+p4EuyPsHy6qWoORU1u68LVE
	 DTWZAS+LHOe3wRdRuXJ7uAG8ceAbdRQjFqOaOLbRht8PwVOHqfqKET3LGvxkYB2CG4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=RpSFwV0q;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3708606A336;
	Mon,  2 Nov 2026 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3708606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=RpSFwV0q
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234d;
	Mon, 2 Nov 2026 19:58:43 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
Subject: [PATCH 0/2] tracing/user_events: harden dynamic field validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c20456603a2kunmab045f0fe84e3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHx8eVhpNSUMeSk9OS0NOSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=RpSFwV0qikGlPVllKRCwIRwuKrFI3NB8XqfqKKNDrydhVoqL42wq6lLm3ViDoNfl1/GFnYfT0MWgRyWJ46u7ax89SgxjOBPcdpP5qjDmUnnCY6EK2V3pYywUFmU2GD6O3NAa08Wg+6qOWjoydzciZIYK2zN8rwJinixFvzNPXY0=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=039MTMt2BSB8g/lZc/n6iywXg8buaWiLt7iqhR1lW1c=;
	h=date:mime-version:subject:message-id:from;

Harden two user-event field validation boundaries found with KASAN.  The
first patch enforces the minimum storage required for a dynamic cpumask.
The second rejects field layouts whose accumulated offsets overflow or no
longer fit the signed fields used downstream.

Yifan Zhang (2):
  tracing/user_events: validate dynamic cpumask size
  tracing/user_events: reject overflowing field offsets

 kernel/trace/trace_events_user.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.39.5 (Apple Git-154)
