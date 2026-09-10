Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1D3A6B7F;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071853; cv=none; b=YAHIiqF2hdYQ5dCOHMhnI5/fT9s92dUSl1p3xF0yvYU5uIrU4quguviXYUMC8bWX+263+jXmmxa8mnh9Us06dhISqoS0bDXBWOgBn6NmAhzY6ia6lYB14VIGJzQUH1jnRljXI+o7vt8xZwpZL9RW3tlEYVdjrhxK05XMcFSwV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071853; c=relaxed/simple;
	bh=Y+vm0E3sGS/g6TKqj8JWr3SZgHp1nQqSKXoHITXNUM4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VN79U3iOUsPvaOEYiYWwvetz6BiL45sRRB448GQsbAKTlgNTDSqKaGgsvg0F8wr5XDtpPmxgHCxYIOiliiJ1uYMaMKKApMvQw/zdHhhp0f+hTymJiDi/F0Zm0kWXKmXOHtpvoXuZL24PImsi781OTnLoY7x3pUSG67Y+V7uM1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGDgY8ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGDgY8ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3190F1F00898;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071849;
	bh=nf5Iowrq89hBObaYg8BcDdNyaarbSyiz1LU3R+pxneE=;
	h=Date:From:To:Cc:Subject:References;
	b=XGDgY8aer/+lSxLiMSolTAis4Os13G+eCrnAM/zEbQeowvTRPHrIXFSGwTYhRRoQe
	 Wdpvd4Oh9hOmwvoU4toNwYKxRaTvLrRdHeiac0m3NT3mVnbhLPkPcR6YSppuwTA/Uc
	 ftWqY7Ab2CK0NZmr6MsjmAPToV2tIxu5pq62MM98yyUzN+62fPprR6zvAaAUvM+D9s
	 tQ2XMFYeyMMrim4dLHnv7Np9xPPqRPyUgAefa3Q0v/drIlgwWD0odMKSrxRyGk3SPX
	 KxCsiQFSn4CI9O4yjXAO8jg5WEc6Yx3zGTnnEFSAurQblU0uwXks2cfiUcgwqA7jIk
	 nbsB/Lq2704Sg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x4lKq-00000008eZM-2rFh;
	Thu, 10 Sep 2026 16:25:28 -0400
Message-ID: <20260910202528.506843293@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 10 Sep 2026 16:24:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] tracing: Do not clean up hiter in mmiotrace read function
References: <20260910202421.612273038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the mmiotrace trace was first created, it allocated a descriptor in
its pipe_open() method. Since there was no pipe_close() method when it was
created (in May of 2008, and pipe_close() was added in December of 2009),
it cleaned up the allocated descriptors in the read.

Now that the clean up is in the pipe_close() method that now exists,
remove the clean up from the read as it is no longer needed.

Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changses since v1 : https://patch.msgid.link/20260721212010.76e9ed61@gandalf.local.home

- Broke it up into two patches

 kernel/trace/trace_mmiotrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 77120d467e11..0034d6af3d9d 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -152,11 +152,6 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 	mmio_print_pcidev(s, hiter->dev);
 	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
 
-	if (!hiter->dev) {
-		destroy_header_iter(hiter);
-		iter->private = NULL;
-	}
-
 print_out:
 	ret = trace_seq_to_user(s, ubuf, cnt);
 	return (ret == -EBUSY) ? 0 : ret;
-- 
2.53.0


