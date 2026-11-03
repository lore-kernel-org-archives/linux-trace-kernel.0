Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673928;
	b=FUAl6waZpyPed+insMXCuzXdM0CKV9iK3F4UD64UgVnvlENjceWYdUNQaeKX/gNCaTxG
	 OLBrVOSbAezSRHooXL7RUP6jTUoFkCmD9Y32eIL9aPbcwNo4u23fQwG9eVbdlJxN019KH
	 WDmMxRzhhDcA9yLjBTikkCHiVl4XCCmvaIALXmsyPxs4Yv1HK2H5gYt62RyHrUxZVk/FJ
	 Fm2u0KIbEU/rzypk/5+s+aaHmiUl/8wI+RFNZNz/vpYqCI0hY1vjPLdEJJ/wrHkRPTTA8
	 lvZWdnFWlOQHdwxL5rGuxarfhnjc3iuXhPpi6JWE5YKNqFjYQmI1kOoAcz7dXQXFUQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673928;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/ngpULnaXhaU5GuFthwy2YOGmezEvt/HiY1ZID8yDeU=;
	b=hvU4ss4R7hTN2uSssw2f4+rIKv+m/mpQgBleefxB1GekTBHVDT8jmzpclDQSTt6TzY5A
	 +H3d7qK0S0MM6K74ggVkllbiPhHhKK7g7DMehLsPIbzG9guN+wOGOEUsFN4oMRREKcCe2
	 L3i0ikGUbPIQnffDppnhSxd9AsAm0Th83FGJ8M9fbBn9+hygHebChgF/+2LTZPGTdEuH0
	 DjSwbADDO4rn9jdugYH3C/ozEKv7ZSC4/1/hJwZUV1vFBIMqR/6w9eyJ6Tgj0UZfQ4ATg
	 TvyV8HoWYmsDVREsQpNZ6N0o3YIEOP792MWOcRTQBgC/2FEaN7YAHOvW0lxpfdoKW1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Yb8PspPL;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11592606A32E;
	Tue,  3 Nov 2026 02:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11592606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Yb8PspPL
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a3d;
	Tue, 3 Nov 2026 10:45:23 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.1770217673912340635@stu.pku.edu.cn>
Subject: [PATCH v2 0/2] tracing/user_events: validate dynamic field bounds
Content-Type: text/plain; charset="us-ascii"
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
X-HM-Tid: 0aa19f4c0bd703a2kunm153cdd6b10a85d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxpJVkNDHRhKSR5NQh1KQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Yb8PspPLd2IQ38PMXxQtLXQgkf5hIDGnzV53CTHcRc8sF5BJpVj+9AKFjmtAHyGUgn6xV/4kqJsb/jdGh1db5mzlEPGheKsPzXI/+hX2mXiENJ7MUHjQUDgZOLUJOYYiPBsZj9UtRLEdad8g+bjqH26IXmiK2MOCmGj/LxWtE4g=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=/ngpULnaXhaU5GuFthwy2YOGmezEvt/HiY1ZID8yDeU=;
	h=date:mime-version:subject:message-id:from;

These patches validate the size assumptions used by dynamic cpumask fields
and prevent explicit structure sizes from wrapping field offsets.

Changes in v2:
- parse explicit structure sizes into a u32 and reject values above INT_MAX
  before assigning them to the signed size variable

Patch 1 is unchanged.

Yifan Zhang (2):
  tracing/user_events: validate dynamic cpumask size
  tracing/user_events: reject overflowing field offsets

 kernel/trace/trace_events_user.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.39.5 (Apple Git-154)
