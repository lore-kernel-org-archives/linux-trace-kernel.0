Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1083CFF57;
	Tue,  7 Apr 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580390; cv=none; b=m0xnlBPQwNwBd0miGd1t6OUyQN/nfK1XPFk5PlsFfMeoOZ8zFt0BFkP4RI0Zq4gTSqeT606Twhb2+Bu7PtyGVychs9Uf73EJQlrr5jnjzN4DiO+z9YoiM+RKHIbZLcVhqjBZJATVADmQS2QyK6KBkNq1a1D5j2ZOzGRlz8xp3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580390; c=relaxed/simple;
	bh=m2F4YJfRhV+C0WDoXexHl07dTq2V7bN9iRXJr4UNAao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6WRdzoVETnqJswGO70JL+/EoBWfyhWQ4ZUnx6pdC7ROtXhdC+9qbCmM7EVMoujF8gbUUBEuX/Bvh7VyGNLAsJMOIQN5A1JWgv9+JpJHG75mL/KoVLvzfv1fBlLi2HT1/Cq5HbP/QlrrG64B0pWORDxGIsYUyi/ZtIJymcGT73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BzX9zkXJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BzX9zkXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=m2F4YJfRhV+C0WDoXexHl07dTq2V7bN9iRXJr4UNAao=;
	b=BzX9zkXJSM5ksM/G1lJuB5gZz1foaoPE6P6kRKOIl77eXJDwjsGfe5/iSNX3jz
	tEdlSIpif4aTy50xfyeqRa2qKpdA525T9bSaMwtMYgfvbgREXl6TSozj0Tjsg/C8
	7szDUwulhFZqwBLSLnyYmFlH0RwEl/1UqY6xuoYkPu2c4=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3CcDANNVpr+A5Dw--.19062S3;
	Wed, 08 Apr 2026 00:45:57 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH] selftests/ftrace: Check exact trace_marker_raw payload lengths
Date: Wed, 08 Apr 2026 00:45:52 +0800
Message-Id: <177558035266.28431.12958584562831940289@163.com>
In-Reply-To: <20260407101245.78988-1-create0818@163.com>
References: <20260407101245.78988-1-create0818@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wC3CcDANNVpr+A5Dw--.19062S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUbJ5rDUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AYOR2nVNMYrZAAA3m

A follow-up on this patch: I am pausing it in its current form.

The exact payload-length checks here were based on my earlier
ring-buffer change, and Steven has rejected that direction because
the ring buffer is meant to keep the allocated size, not the
requested payload size.

So this selftest should not move forward as-is. If there is a real
fix, it needs to come from an event-specific change that explicitly
stores the true payload length where needed. I will revisit it only
from that direction.

Thanks,
Cao Ruichuang

