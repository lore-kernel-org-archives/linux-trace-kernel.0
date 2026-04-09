Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE02E7F20;
	Thu,  9 Apr 2026 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711609; cv=none; b=RfwUFpAEAoW1ZQDobx6P1SVPsPgP/PO6hvFxgFcrMxWP9aB/OgXUQpA+iF51vCTx47GhcmuMl1ptMeXcJvK6c8XCSKKEexN7fNv3Qelp8HuVvNjch0uEjz6CgzFT/J81stnB1nDWZOiXK19oaU6J/49u6GIxJ9Fn4cD8GTG5tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711609; c=relaxed/simple;
	bh=VxJyC76Khy+ipEcHvx4WFkTcGFDMkZcAej7xVN3EGQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id; b=EczdpjngxUSMvPY8z8wtWk4DCtCo6yP8sPKeI0KKU4gZYgCAbEPbe37Bgu2pK1OdkFXncQ4assb9PjcAvw3opmDROmVw33ZLU8UBnGN+Z5e4cd90VH2P0N8RylFGfHfTmIrmBb9s5AOLIEzz4blFz89P9tBXORxs0ou2pGzEDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=STFdUUaD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="STFdUUaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=VxJyC76Khy+ipEc
	Hvx4WFkTcGFDMkZcAej7xVN3EGQ8=; b=STFdUUaDQTBpb/FtNQtr/Tn8iXAVS6c
	REDwm+r2+uaUR0308NZ8+nWXClequ+OIitDrhrU7UiivNRAQdR/afa8iNEdqsrzT
	L4cDxeJqN2vxBMZsa+TvUfGyNe0F8CMnt9rBDWtPZ3mRqwXz0wWsUaWtgESmXvZ6
	o1grQewapqlk=
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXvg5SNddpyyy1EA--.34290S2;
	Thu, 09 Apr 2026 13:12:54 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH 1/2] tracing: Store trace_marker_raw payload length in events
In-Reply-To: <20260408133931.5755684f@robin>
References: <20260408133931.5755684f@robin>
Date: Thu, 09 Apr 2026 13:12:50 +0800
Message-Id: <177571157074.16992.13126395176871230415@163.com>
X-CM-TRANSID:_____wBXvg5SNddpyyy1EA--.34290S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1DAFyrJw4UtrW3Ar1rXrb_yoWxCFb_Xr
	ykWa1DKr48AFsrJF4aya1aqryfXrWIgr1DCw40gF9Iv340qFs8WF1qywn8Za48J34jq3sY
	kwnaqw1rGrsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbrOzDUUUUU==
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5xay62nXNVZTOQAA3f
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hi Steven,

I looked through the current trace_marker_raw users and the expected
usage more carefully.

The existing users I found treat trace_marker_raw as a binary channel
and parse the data from raw events or trace_pipe_raw, not from the
formatted trace output. Given that, I do not see a strong requirement
for TRACE_RAW_DATA itself to carry and maintain an exact payload length
just for the text printing path.

So I agree this is not really a technical limitation in the current
implementation, but a requirement question, and the requirement does
not look strong enough here.

I'll drop this series for now and close this task on my side.

Thanks,
Cao Ruichuang

