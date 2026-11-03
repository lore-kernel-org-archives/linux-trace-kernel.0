Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731562;
	b=ZLqx9JJgfEwyHe3JK9U9ihB6kOdZ0eVA9lgh2PNx67mGDPFdRAiSti1knW/tKNLMqyLY
	 7nY7tdRssFspnsrVFSht69xFOjDOEw2jZkGYpUF7vuJPdtRWaCCNr88ZmCJFrVLVIALbL
	 RtYLZsJqTxnYFXknX6VQdNLKxnb86+R7Fm7PU+2aGoFuiXdnUr8CJuHgMn0amdsFzrDYE
	 rmOZSayN+CzwV5qmTOnOAXNo5SVXiYsZ3hWO0MqsyDxV0Eh/Tb93fY7VBh7cwvQLnClom
	 jfiR7DrXkQvxlz2wS95H4vHeRE3vDtUJNO37VFW+XMKuAG/TxhbepnPdNrlWLsYWFmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731562;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Km5aahxmkzkt8Lazdb4luo4YhHlPmTvAK+aT+VjwiuQ=;
	b=TJ+aiHKiXYAdReQfuuFadaap0cJ2835k2CtqjMxldk2cAMQ7FwglrBSMwdIs/nBSQ5SE
	 nOEXzcg2koph5B7dUERt/w1w0i4OqdcXsX4/50DNpqrf0YI5V84VUIqp9oT7tKOzOF+3p
	 M8YPtt+wasdCiaO45CD6GIgBMrGTUgftsQitYsV6jAS8i+h4I8gihk2Vk3UsjYZcnHKHm
	 JoPHZuiuIfFywiDNXXgm/lxlcSvOdHFtiwvbC64R57aMCot4xUJSqYscBn0nMtsayR///
	 XnH3IL0zJ9xkJRf3iOsPx+hhpRkwIBSPuy1MKGiSkOQaDq6LY9aeepupVveQE2uMqNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8qABGQC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABD606A31B;
	Tue,  3 Nov 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8qABGQC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793731561;
	b=Ov2lq/f0r7+YkSRP9BLkUFP73z+sNiDeAgjgNa8m85/G28LaWuNhnkkGkRqMqHvASzEB
	 6vqyZd6TlYvIvCi2nxtNl/N6pJc7Si4w35b8wr438RVAQdxtZ8MbpMEJrWZxLf8Ug5Aha
	 /yGVvTJpupo97hyn2Go1Ke54/DH2Wo/5tXLqfWaLjb+ZlCJHChTUqgQDKcYp6hvp22zjD
	 GJaLNvz1Zx3dvmP5i5iZD35cUIfe7DMibLyAAaQigq4fok+8S2MJAxMJNe8bB8azAOpB/
	 0wXqtNxeRB7RTKHXdNyWKX1NKP+lJptZl4ErhWsVy+rV3oK+kENgZpBGg0jYqZWIKMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731561;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Km5aahxmkzkt8Lazdb4luo4YhHlPmTvAK+aT+VjwiuQ=;
	b=ZRn7nAPWfea1hvPDJ7yVvcqcUpv+Bd+esXYDJwETe9vPI2g31EL2jMqhQgMnnutW4en/
	 vr9KM9G7PiS4t0sdGevKCv4JGjSevnB8uyOBpOmbiP6U43GKyR7HiQVjQYptZ07MTntrw
	 oP6LuZfsnyzOUZmwEY6rbLwYwFmM2H79O3bQXZMfKHXMOHAdwxBekW46zqAq5NiZyb3Dh
	 N6SufIBBeFERL5TYRtMgeBwQhfeBSR07O2EJ33lXP4ZSyn2Y5AmAHsbaCLNdXvrpxxiIP
	 o/AfhE59/oVRnITag89etDefpyJqPltu1IuwC1Z7f8iItz2H0QB6W3YQZEPJoVjTQkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60EDC1F000C1;
	Tue,  3 Nov 2026 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731561;
	bh=Km5aahxmkzkt8Lazdb4luo4YhHlPmTvAK+aT+VjwiuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=f8qABGQCNXNG8sdZcq/c906lvTkZZTeu7Q5HWOsiycFqJwGF062P2RxoM4rFO3B2z
	 vEGYrpTaXHU9iB6mh+405/xNhbtTiIwr72dXzV4G/bvJenhnEfRecxjBv/+X6CX8SD
	 trmd3sFy6W7Ke8ofnyLS77NXlrMcfMm4m2QN429SOXyuON7NfwzE3e02i3aJzxyX58
	 DIrJWQDVkcDTt2vDjk0NA6AQEL+LqyjarptMcr07Hka+AldMu5ztkzNpGvrbgiqx7O
	 GNcFJzKqLNNmlNII0fXiI3AbZ9oVDdtWdR7Uex7/OHw4BGnuEmzKJDsHFPCIZh+k5C
	 hXzTv68mfBTcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CF19B46A9E;
	Tue,  3 Nov 2026 18:45:59 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 13:46:00 -0500
Subject: [PATCH 2/3] kprobes: Do not disarm unhashed optprobe on dispatch
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
Message-Id: <20261103-kprobes-optprobe-state-v1-2-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
In-Reply-To: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731559; l=1584;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=Om3AtKcwPFWlxp01iOZS0Qnp5RPyFOsMjUmMCXTC9sk=;
 b=1mdCWbPBhnKiRso1MCKdtJtHCkzmU3TM5i/hj61G24x3drWztp65eK3l8QVJDc8KSnZUQYBVc
 sgkk/8Jc9MgB/2y4/yBoQOhs73Zz33TfD9en9LJ5JGmL/a+ZWmdFyhj
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A new probe at the address of a force-unoptimized probe can stop
firing.  When unoptimize_kprobe() force-unoptimizes an unused probe it
disarms and unhashes it, but the next dispatch disarms it again.  If a
new probe was registered at the same address in the meantime, the
second disarm clears the new probe's int3.  For a module address the
same disarm would write to freed module text after rmmod.

Skip the disarm for unhashed probes since they're always disarmed before
they're unhashed.  With the fix, the new probe fires.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 kernel/kprobes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4c35cc24aadc..84a5f68476eb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -631,8 +631,12 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 	list_for_each_entry_safe(op, tmp, free_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-		/* Disarm probes if marked disabled and not gone */
-		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
+		/*
+		 * Disarm probes if marked disabled and not gone. Unhashed probes
+		 * were disarmed before they were unhashed.
+		 */
+		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp) &&
+		    !hlist_unhashed(&op->kp.hlist))
 			arch_disarm_kprobe(&op->kp);
 		if (kprobe_unused(&op->kp)) {
 			/*

-- 
2.53.0


