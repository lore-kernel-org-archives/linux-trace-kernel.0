Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398027E04C;
	Thu,  9 Apr 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711942; cv=none; b=au0jUizB/WRIJoxqvPnr5syPgPi4aymHVVf91aYfH4tJ2TCCl7vbNQoKDOLqxdwiKiOd+SQnP4iNcE0gZsHFXt/rMLYmoUob9raK/sFhBrK6k3FQZsAoyFMp1uofCWC6xYXG2QgIKJ93dhqoBo0gB+btE2ZXISuvb3mfW1F3vEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711942; c=relaxed/simple;
	bh=GFsYLMNUr3uVsVvY1jLqpD+R2zFlh3BtjgwnSq2+Dig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id; b=EP7IoESxvjKGdYwMXP7NcIvI86xqNVQ9exUI6nPFATwiRdHUr05xfB65mwZYAFQLMs3Qxm8RFNZZzpgQXxfPR6MjjdBXoMkyQ8x4M/Q4Aa+oVvYVbpdYczSUustqChTvtux4w/vUgi+bV2BLFwTgw28C/PD3r7+1j4o4uxGCrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UhT0gShD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UhT0gShD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=GFsYLMNUr3uVsVv
	Y1jLqpD+R2zFlh3BtjgwnSq2+Dig=; b=UhT0gShDQqPC9zl/QH2hvKUisogWv6I
	mFg90ApTyo8OC0Lzggs+XED/KkrVJddB/kPZ14UCoUOZgceya6NCOaMDJRvji2S9
	25CD67JK7CENXFiQec4uNy1WvVddFN2Kp0mzNuliGjz0Ji6i05kweUf7+JCBtwaG
	77Hs/F5Rn7a8=
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAni46cNtdprldwEA--.4156S2;
	Thu, 09 Apr 2026 13:18:21 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH] selftests/ftrace: Account for fprobe attachment at creation
In-Reply-To: <20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
References: <20260407115751.96184-1-create0818@163.com>
 <20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
Date: Thu, 09 Apr 2026 13:18:19 +0800
Message-Id: <177571189990.17594.14983613605049028604@163.com>
X-CM-TRANSID:_____wAni46cNtdprldwEA--.4156S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOPfHDUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCvx4FPmnXNp5RPwAA3i
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hi Masami,

I reran this in a clean QEMU boot environment with only the minimal
tracefs setup and the add_remove_fprobe sequence.

I saw the same behavior there: after creating myevent1/2/3,
enabled_functions went from 2 to 4 before any event was enabled, and
enabling myevent1/2/3 did not increase the count further. After cleanup,
it returned to the original baseline again.

So this does not look like a dirty tracing environment issue. The
failing testcase assumption appears to be that the attachment happens on
enable, while on the current kernel it is already visible after create.

Thanks,
Cao Ruichuang

