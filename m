Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184902;
	b=dEVLLzEmoeVLoAxqrvuFJDU088n6K+dm5L8jLVFXbC52W+/v7R7rU/lld96Iv16rVm+p
	 JCxP91jCkas3wFW+Iwlm7tTO4gVFXmnIOgRaSv9rPM9C+lczOPowMOl18K+/8P8KIugA9
	 UM5d4PtrLOE3lGZgx8Tc9oyv/sNnXy+sMSPbq8AEtlqK5KzKmbEnBM7FD0fpVmFK205rL
	 PdByYQCCkcN09UXV5WBZZnFO3BJ3F//T2s1tRqoTouqEZHRYtvhhdel5ZHwIcAvxLM+mx
	 k2i1c9qS3n6cpmFznqgIsZQKoEsr7pyHIK1Xm7hggchgSREKPB3YLnKwX3cq773sCOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hSQrtS2TaJsLer6ppkblkbD1rEZ1v9jda0sM2IpgCN0=;
	b=4S06cj6NTV8nwXttYep8ME2PLrWTuldPYKpwbqE6NCA1ADF/rAIHA2X3ZrvSqJyLRqc1
	 g1fAfNjaxDcT6vxl9geoSOq98PU+UwCud+EEEqz/h0e0csYn9oBF4ToOQ3uZBUPBpQHxy
	 1ME1jbg0W0DTF2kxRHjMc08yEbdwwxxaGtMTcvuAyyOEl8QAzdquwxodrZy8iR/ARE2DT
	 sLrcnsmxVcwafw4aPh1UeiQx9QNfbHoQa8klc1naQwR53ReiMx9t4BvX5q6pjUY8+3G2l
	 ArOZYZnZ3gDtsxj27B/cY9MPV8X+TjRXmW1CSbxdKNF2KIxMZkgwVvTDXUQQnEXlurg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acRMaRH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acRMaRH2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5511F0089F;
	Mon,  9 Nov 2026 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184901;
	bh=hSQrtS2TaJsLer6ppkblkbD1rEZ1v9jda0sM2IpgCN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=acRMaRH2zv5LCib4T8FAZCeEeOpS9vgQNAgZ4r2JdSBnkeBxIcIHDRWQlGMgdYPMd
	 3UOQ0iPUufYwDRm45hGQSMrInU7ezofJEif0LEDL9GW59rA5Pd6yGB7IJhnQMBGgql
	 CGSs4qbwOZme7Y87cQ9r/ByCNq6rB9vILUh7ErHhFXu8XqOsC1ygfOnmqMBlUot+U3
	 k6YXwkMwi3bifaJ0jbCceVOJ8qOFNBovyDaFL2CTl/1mzMbpniwdWchg1Rxqc/vDzs
	 KyYatL3L8N6OF127136lOr8z8tfeRWCe0+cjyLz/UCaz0D8n4gvPs1E0h9BsfYCR2+
	 SnseWw4U3q/ag==
Message-ID: <sashiko-outbox-204240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] tracing/probes: Reject array count on
 non-dereference string sources
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179418415672.227715.15166570338029977087.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
 <179418415672.227715.15166570338029977087.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:41:41 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing/probes: missing Fixes trailer for string array support
  commit
--

commit 78c886d046541847b05a6f45643e9267eae178e0
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> tracing/probes: Reject array count on non-dereference string sources
>
> The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
> preceding memory dereference instruction so it can advance the pointer
> address on each iteration. Non-dereference string sources such as $comm,
> immediate strings, and eprobe event fields cannot be indexed as pointer
> arrays, but finalize_fetch_insn() still accepts an array count on them
> and emits an invalid FETCH_OP_LP_ARRAY sequence.
>
> Reject string array counts when the preceding operation is not a memory
> dereference.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[Severity: Low]
This looks like a bug fix for string array support.  Should this include:

  Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179418408457.227715=
.1485179201014819821.stgit@devnote2?part=3D8
