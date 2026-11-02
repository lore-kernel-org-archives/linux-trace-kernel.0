Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620730;
	b=qClggeFKZ8+e9M2wKa8GwkmdMfL8Eu5Ah5CQcatmFjx87QzDsKGB2Xy7Vk97OARSvAW3
	 YUWVhB7J/GPgj92yATQTjaHSxQhVl2zS7sFr45VMGikpcN8y7TiEGpypMg21qGMKoi2Qq
	 UMmeGNFJJH4GBGwgono20feLBos+dpa07cfC1w8nZqG5xyDJ1QvtFi4hZXEbw6165yczI
	 y2dtS1UQGn/teIOwKCT+MAjBBFCBlgkiWFc6unRNBXBe6x+eqG8DUXVhGC/JOm9N7RVAL
	 itKPVvOg4H+zwKtA85qoSB6O/LHpQNwzWrLFrWU0333ZG6gIp2NIWMnX+I7dSOyHTeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620730;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Ls5GID7/iiXZlbiZ6u8Bb5VgYUbQ2O4wptGmZmTjCOE=;
	b=TWw12h/oVteS4DVPTG5dKxy8fJOjrfFW6hCrpPVJYeW5YG56aZn0O7xvxQkQED7Z4khP
	 gitkocihsjIC0O2leFR7QwpL6zaZzyd+oqXDFB9DYdJ/tpwQEOmoSDEFcCbWiXG7ImGLC
	 aIUTuaZrNE53UsDTkIf2SVTUjO3f3yDMT8MrFbkabjEDUsnBSJdCH76IZ4O6ZS1XHaTGz
	 k6cZD7vn+H5r0M2sib4gxQbSS+AwNP/fwCWf/VImIcgPTw5UQPY/SiXq12I2sO2v8qTep
	 7ymWyCVxtEwyhod29OfM4sC1tm2yEZ4lNPGfzvuZq882qKZqRhxNVtEIx9rMLVI6GIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b="BxuFzh/t";
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697960A2621;
	Mon,  2 Nov 2026 11:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8697960A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=BxuFzh/t
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2351;
	Mon, 2 Nov 2026 19:58:45 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.16527354623976202893@stu.pku.edu.cn>
Subject: [PATCH] tracing: fprobe: stop when the address array is full
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c20505303a2kunmab045f0fe84ec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk5PVkxISk9MH0hOQ0xCGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BxuFzh/ty7pUjbwpZEEAlMFNko5h+iHwQB4L9FGVVLB1QYP38XAcT+xLNCocrh3sA86IC2SyRjA6RTw0xV2KVMKjVctRgKSJ95hHTgwZuKFebfwB1Jv2fz68d3lZA3hOik4XQj/p0NuY6LfCvqd2Vnc8PTVqrQ09e47n578KbxQ=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=Ls5GID7/iiXZlbiZ6u8Bb5VgYUbQ2O4wptGmZmTjCOE=;
	h=date:mime-version:subject:message-id:from;

get_ips_from_filter() counts matching symbols before allocating its address
and module arrays, then repeats the walk to fill them.  A matching module
can be loaded between the two passes.  If the vmlinux walk fills the
arrays, filter_match_callback() returns a positive stop value, but the
caller ignores it and starts the module walk with index equal to size.
The first module match then writes beyond both allocations.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in filter_match_callback
  Write of size 8
  filter_match_callback
  module_kallsyms_on_each_symbol
  get_ips_from_filter
  register_fprobe

Return the completed count when the vmlinux walk reports that the arrays
are full instead of continuing into module symbols.

The reproducer completed all tested module-load timings without a KASAN
report with this change.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/fprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index da286619c5d89..69d1887790739 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -885,6 +885,8 @@ static int get_ips_from_filter(const char *filter, const =
char *notfilter,
 	ret =3D kallsyms_on_each_symbol(filter_match_callback, &match);
 	if (ret < 0)
 		return ret;
+	if (ret > 0)
+		return match.index;
 	if (IS_ENABLED(CONFIG_MODULES)) {
 		ret =3D module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match=
);
 		if (ret < 0)
--=20
2.39.5 (Apple Git-154)
