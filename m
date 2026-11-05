Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793910734;
	b=rGHdiuNhz8tZ8PLNbJ795jIXMyxwmDo5mbp1YflfZGUwtBcc0sfdmi8glwc3RHc9OJci
	 AYmNrIrti42spnGZG3TGwzfIHuxphq8sbqfI/3Fhvk9925H58SqwpbIuSggbdwZ3ava7n
	 rO3nVdXfAk6Jcorvl76JMsrTP/cse0fQx0aocCJs/HuAoyMQNzRjUGyrThaiAT8N0qvvv
	 GWDbHp+0e/ea08avXkVOcjZp/7HkGeGTzCzVKEs5/DZKN0SAr5BMZ8n63F7JHIUEdQm7I
	 kEu3GMxM1rfKO9vuQcOorkyTTjT7+maYcxue5HQooCZbpOtXtNm0Lx5b8VSLpw0YPVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910734;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=/Om29JukjjZSVfBlDLA5oQz7EwPvW6Jr8YPY0sVbqO8=;
	b=xb6Iyb4l2e6xg3q/ILDMEl3FcBcknks1VVNqujM+1CjM8ffA3vrPPU/B3X+/2ibnrdNK
	 wNVcQNZ9yD2W97nNCH4PxukpjXX3rVSsXO3dsk5DOmspy7DZT9Y6zIhgoSLGJoS09WXAB
	 JI3W7LwCEYwA+89gf2s+XzW7/QwCAQmWu0WkL5CmOPelvvEz9GxBX0YHTGNQxhDZnmPCG
	 Tct0HsMKLWvF+ElqyL+gScDcfFUs9Z2MGuIlcy/Me7AgbqKb+XczBcjjcUv7TYNW4ecBc
	 nupYIDGJYiUOwica1gpd1uqOJ9x0BRSkQleVIt2qeqAqJXCOkGcTteDRedwWGLVSB/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcCY1U5z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EA606A338;
	Thu,  5 Nov 2026 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcCY1U5z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793910734;
	b=kecb9e5HtF+BU/N2dJFHDfVZRgOoym0MfTOJfhwLO1Tpk6OrQamqTOOSdLAj9EfV0wkq
	 6PGkBM1IxkjwD51CH/dnVICj6vPSab41GtDcy/Boe6ZuoAVe4iwWrWXVS8Vakz3adoC4Y
	 kUt7YM4UlBG3/TefQgI0FX51C84jnYU9XeaVuqLNiyHS8HTSPmhcKS0QpKSs6xjgee2Hl
	 Ah1Dpfovo2XVWBkxZc9CQqjUKslC/pE3lF2Z5uVJpVspn1wTl6NJqxmCqXySUQsKnTFe2
	 CvjXicUcBbvxWEWc1FFJ4EqgTICRprOHNpR+ZjcJ/IZvUF9UgvawkEROT+DjdNBVPoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793910734;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=/Om29JukjjZSVfBlDLA5oQz7EwPvW6Jr8YPY0sVbqO8=;
	b=2T2majY6BogxaSrNz7EFgUNOgUdcqdYMslKaALkG1b7dMlzzEjLoen5iLy5XYyiOM/6Z
	 6ng0PCOEMFuWVE5k1OVo+BWhbu/8MtPeDANkothJk4oj3mWfe1FeZMPgx9teKwPfc29Xm
	 ycz+POfK9eRFwZLW9rGRz3QJOmvN3guGTcCtJTlTKm0Z33sAGqUQsQhfR6dxiEl0zaKPQ
	 sGuLxPtHNBxvO9cf+Mdcuk30BWkRzaqRH4zsxABDqFpA8c8Gsd6AAv+lKzScpxcMRYPtU
	 +HNUTqtnKrGRC87Z9qmZABIDiS/vdBpe3KTATxyjmBqu3ORxtn2b9g5NQh6vmO2a7hQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1AA231F0089F;
	Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910734;
	bh=/Om29JukjjZSVfBlDLA5oQz7EwPvW6Jr8YPY0sVbqO8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OcCY1U5z8KeYHuerBqIDC0UfMUp+FhhbpFVBBVx/iVsqEu5g42Rhvddd9onc16bR8
	 eerT/IWbQLV8GDpv6aGF/hZfUke7yGRH6E2GT/AwcWGphplxwjlsVb4sTX3CQzT0Sb
	 dgoVhq4rcfv3Hk8ufIAgyvo/U0QhYm51pah4sFg1I2n+LEOKuYdqpDZcdivl/HAO6k
	 +8UOlIHH+Djvvk24d/oybiNRYyyqr3MucLEU74xV55+bdICdZ9VYtS7vvYPcnZhXGg
	 Oquux2NXv582a5haAig6erb4JAjx6tV3j/gBTmTnFxu2q+sFunrXtWQvCEDvlFneSi
	 pJADy38bjpn1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6AC4D40759;
	Thu,  5 Nov 2026 20:32:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Subject: [PATCH v2 0/3] kprobes: Fix optprobe state after forced
 unoptimization
Date: Thu, 05 Nov 2026 15:32:11 -0500
Message-Id: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Zi2ShNdeQ/DYloGGX8oaQvRE
 O4u4AHcvS95730TJI7CCc7FBJFHSRK6BcyuAN9Sd2OUemEwylit1QEffQyOE4Y+bwlTpsx4UrV
 rytKZo/WwjPvIjby342v14zS4O/u8vq2NVlIO8bOZR732/kpGjQotEXmrDTm2Fx+ew8sJ7bkeo
 Jrn+QsB++2H0QAAAA==
X-Change-ID: 20261103-kprobes-optprobe-state-90dbf55b246c
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793910731; l=1406;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=hnUymYaUl8Tfgtc5VBb7tf8wxHH8l5HhxgLGwo09e/c=;
 b=D7gyGRXlx/bvfd1JO0VtXlp8l4pqdAQ6/8weat8FY9Y5dR04iMLjmYs8ARYgpq7GdWTP8eQii
 nNCmeVwHqQgDha2DlEoJNut20u8xxLAeJA1MUfbQY7jY6p72SACVYRK
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu

Since commit 06e0d3b89da1 ("kprobes: Make optprobe optimizer
multi-generational and asynchronous") a forced unoptimization can leave
a probe's int3 in the wrong state.  A disabled probe can be freed with
its int3 still in the text, an unhashed probe gets disarmed twice and a
reused probe never gets armed.

Patch 2 relies on patch 1 since it assumes every disabled probe on a
cooling list is already disarmed.

Changes in v2:
- Patch 1: disarm a disabled probe before choosing the freeing or cooling
  list (Masami)
- Patch 3: keep a reused cooling probe disabled so register_aggr_kprobe()
  arms it only for an enabled new probe (Masami, Sashiko)
- Patch 3: skip the forced unoptimization in add_new_kprobe() for a
  cooling probe, which would otherwise unhash it when the new probe has a
  post_handler
- Link to v1: https://lore.kernel.org/all/20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu/

---
Mani Tofigh (3):
      kprobes: Disarm disabled optprobe on forced unoptimization
      kprobes: Do not disarm unhashed optprobe on dispatch
      kprobes: Arm reused optprobe on cooling list

 kernel/kprobes.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)
---
base-commit: d4d028a7ae6401ce70825a3eb663f0a2dfc49db6
change-id: 20261103-kprobes-optprobe-state-90dbf55b246c

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


