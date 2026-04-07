Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A3CF694;
	Tue,  7 Apr 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580390; cv=none; b=cv5zj0FEVRZusjyH7+xwYw6TfBuD3NH+R8wGmYtctQssyEnaSQOf9NmdG5gj4R3ZMA4HvgK9iE0NKPdxaWcel9SHo6ziiOIoTRnFT2dQ+0PIuVijRR97+M9lIPdzQhDNQagqglONVZiik34Eg6X5blpiUvju86GVMBFl/L4WnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580390; c=relaxed/simple;
	bh=6w18DsIy56fmgqCkv4y/6rdWQ4jNuy6ZgyYnGR7oUjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2+ZHYGWRNPCWSAwat5Lp1Xp2/BhC8RzcKmmKMyxuvDHbgC4UBoutU34B1s8//iFqZPCLtLaTaiHyrf3bp4gxMFIEmM/jB4whqL8EeS+0odjM4zfaUbJ2baeE51rG2N+NdrdNOmv+1RtQMC1aeqqxYk1CrVH+jqHBog9Xll1Qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oXL3N5hA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oXL3N5hA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=6w18DsIy56fmgqCkv4y/6rdWQ4jNuy6ZgyYnGR7oUjk=;
	b=oXL3N5hAJ4MGucR8RA0C5TF+tn6Cmsi1p/qzKsil12TF1PSdMq/bgqEI9cfLmI
	3Z0q638gUxyJG2rzRwK3MjF6h/c5QdV+hsud8jvfj8I37mU5gIRmgYDrKLcUZPrE
	b9/uNfo8/OmYIlBHNTXfqIS7SJnYuXIVs1+IpbLvjKJHQ=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3CcDANNVpr+A5Dw--.19062S2;
	Wed, 08 Apr 2026 00:45:57 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH] ring-buffer: Preserve true payload lengths in long data events
Date: Wed, 08 Apr 2026 00:45:52 +0800
Message-Id: <177558035265.28431.15146377071345343168@163.com>
In-Reply-To: <20260407114812.580c27d5@gandalf.local.home>
References: <20260407091550.67963-1-create0818@163.com>
 <20260407114812.580c27d5@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wC3CcDANNVpr+A5Dw--.19062S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUebyZUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwAUOR2nVNMVpfAAA3U

Thanks for the clarification.

I understand the design boundary now: the ring buffer metadata is
supposed to describe the allocated record size, not the requested
payload size. Given that, I will stop pushing this ring-buffer
approach.

If there is a valid fix here, it should be done at the event layer
for the users that need the true payload length, not in the generic
ring buffer code.

Thanks,
Cao Ruichuang

