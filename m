Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5381EB5C2;
	Wed,  8 Apr 2026 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775621384; cv=none; b=uHG7klJGpvE8MvDvPVP4bN2ywr71OKYvhXgEvf1lR/mhcWdUHb2fJYLwwiB0lCawdSlyr4SBx1oRtAMU0VkOi7DnlaI+WR80pzhjNKgydakxjE/FZ6gv5Uj6NTVR5jthlmlZdE3/cU9NM/qrI5MoHn6X0o98wziO+kZUnIpIS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775621384; c=relaxed/simple;
	bh=4hokZU4LwgrOJJN21TuJ4uoF0Bfuo8T97cVYlYs+zRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPcbLe8trbKqiFRETcQN5a+9A8bY4gHMpk8nn9c7WP4VJ2e/Ltwwjthw3jtBzFLPWJPs0UnVg/ItO0IX34Wuk+IEY+wpB+0YZnosECmv2o3/37cu+sixYko0kMyuRcVGtAglwC8Atu2sLHB9+IhjHyh95+xSIm5kW2qbzRUrYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tm1xX3fR; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tm1xX3fR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=4hokZU4LwgrOJJN21TuJ4uoF0Bfuo8T97cVYlYs+zRY=;
	b=Tm1xX3fRtopuyJ+6BLpSD4dUJONx/G3vYwUri/zWMbJuTWKRHTBjHtPGvflQFB
	n34cULdZe7VVFWjxPzHPL8lAk1MlIZqyU36Jrq9W60p8nMCqE67TSE8RRGyzyHud
	phKcKypFcilR9v/UuTG7eX07J+1rFIB0sUeq7MnEBb1k0=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHo6fs1NVprBUZVQ--.83S2;
	Wed, 08 Apr 2026 12:09:23 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH] selftests/ftrace: Account for fprobe attachment at creation
Date: Wed, 08 Apr 2026 12:09:16 +0800
Message-Id: <177562135674.3342.17510076733132622922@163.com>
In-Reply-To: <20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
References: <20260407115751.96184-1-create0818@163.com>
 <20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:PygvCgDHo6fs1NVprBUZVQ--.83S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUApeUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCvxNBemnV1POHTQAA3G

Thanks, that is a good point.

I need to separate a clean source tree from a clean tracing runtime
environment. I will rerun this in a fresh tracing environment and
re-evaluate the testcase assumption before pushing anything further.

If this testcase is only valid for a clean environment, then an
unresolved check or a different precondition will make more sense
than the current patch.

Thanks,
Cao Ruichuang

