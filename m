Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793910735;
	b=btIZ+sWgNLOqEoD+3lJX9x8JfemKvrcyHkdbxD8ajLrFwEFMny5H4dxJzE1rSn1bwAIb
	 tHToZZp0BdFX44yhO3yGv++vvWke0QauS5/di1yK3F+bswAtENuG6TDzAOHfW2BGPPp6/
	 xokfMNmYdqNd62fqSMS/0wgQvrT8ncoGa6lRnfTxBDW3eOHr0V1ym/JySgCC7dcbLCGYd
	 qjzPjQE+Nndjw3KWYnsX71y0CyuMyrUJjE1Axuc+cwUOrwmiJ25tjf/pQvFcpZskW4Viy
	 GLbH4iY5wiBtX95X3mZa2N3sMtOAPjYOBIJCJ32YpvB4wd8X195tfJMY/ApbbVfPomQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910735;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yUaEVVaQzerp4T67xGTyfw9ywiUJggEuAQr5aSJmpu4=;
	b=lk3Qf9ydy6O/tuTfEd5dqL2eRkuVCVYnUvvrlBAZqwUX00ZIDct30WzHZmBpCVIx/YRa
	 j/m//IjfnfAyPH4cvqSLb+Ys40RapsH5VcVTFia6k8EySGsygFHFbAqy6vkpaWquktcvh
	 vLgXk7iyyWqauO3O0pseOWRpIyEePVu0pKaHAMEGqR0zPSLPe1t/v6QQ8CmSUxs6+cY1Y
	 RFjvQMDrMxlnox8AIztam9xcZc/K/s2est2LofHeOQahT3AF9ddpys6Aop70WRBg49ok1
	 syuhuThoSTurXYUp5wr/n/1dfMFlrtLlDHdtsxGCRu+H0fFYPjM+00umP8BoNSAvFzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXV7w7wA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA9606A339;
	Thu,  5 Nov 2026 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXV7w7wA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793910734;
	b=K+Bqv8jQKY1ecj90hxlBrTSHpepnff+RRSu54UJHAs+2cZPfUMra7uoRBlPPtXNpOnF2
	 fEdFsz4g/KLiq3TuwLJlZ2+Fr+nWcRzT0pxpox/NNiuetlYA7YwEkKgG47Mwxsx6ImuX+
	 Wlq/9MXYxO4yrpOLj3HgSUB54MH9cRWO+Sn9GdWSWfIRwUrZTZr+kNipyNBlIysQmPYPg
	 YR1NKBaFrx7JOwyI+U6TD7yXVkUkJONcvn1VeniGU3wSkwVdgA6kRoH2oHp4ApQoa2+gp
	 wynBym87sFyywkxyOcMuZyiCFWtmt7WPV33vHk7TA7pAoTn0gl+6VW9Q7oD2eGDEDhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793910734;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yUaEVVaQzerp4T67xGTyfw9ywiUJggEuAQr5aSJmpu4=;
	b=JyzGvpV8nrjBXS8RzBnCkmLs47IjxLzRPIDXiVOAZHKMNUxBgcTiwKN+pO3ltVFUyX12
	 Z2f3xrrMhdPPsblK+HzeKJzjrUMvzOHO7Rn0r26L76dTskzxPX04d//j7BJIAL9ATXMeH
	 dznJ3PLf89zBwuCXpH/emAW8pk43AcFGrQuC4sYEx5Y8xCnHTISJHu7r4haXjKM6aWh4S
	 ZDG5zHDyJEMcuo0D77ag2nD18ir4w+/sbPQrFxqnJZeYjDXxwJzgCspn0tewu20kB4qiB
	 NhYWU4eb498RZJY1HOkk/0DghLarf/uBj4nBhsHFPqpqI1T+3FcpyCNMC3iWXXq0umA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2B5871F008A2;
	Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910734;
	bh=yUaEVVaQzerp4T67xGTyfw9ywiUJggEuAQr5aSJmpu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DXV7w7wA4oep3MKkDRFX6FA6arzbiMgMOpotfbxlXeYC8L798UyPXOlDVDeZYhoEi
	 TdU7X41HTTjFpf/nLYTX5ojzf2hZM4YQ0FcrImvtfNaRhDV7/CRPNARdpFDHqI839a
	 janDX1dpht4SjgEOHJQJX7VZViSeL1x+eCrYFka4JpTKcZim6QYExLXBPKaEPLjutn
	 eSMmYPNy0DQKu4SZJK4bKUY39ya0Q/dF/tE4Lo6zttmeuRSZVqAWjO9dzkIZTYVaqc
	 xM/p0JN2KSRdGVSZo66deNwV76ayZxHI4DRvP2bm04sFljueKV1J5gEowaIVJuzcSj
	 fHfx0KcFblgzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6F7A41DE1;
	Thu,  5 Nov 2026 20:32:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Thu, 05 Nov 2026 15:32:13 -0500
Subject: [PATCH v2 2/3] kprobes: Do not disarm unhashed optprobe on
 dispatch
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
Message-Id: <20261105-kprobes-optprobe-state-v2-2-7a2f5290baa0@columbia.edu>
References: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
In-Reply-To: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793910731; l=1584;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=q2MgFbRgliZtJJNKFCxRw6QZHPAxcNxpRFt4YgkzeAU=;
 b=FpcUHoZjaTuoeSpXflU6m3me0/LGnND0ixaLOJpFN0TIH2/fx20O/cTZ8tlp+nl8jBXxdmF+7
 vhFuzXo6m7KCXdlMqqKCfX9PFzvwSDluBD2O6g3IZn7vEUxFAgd84hO
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
index 809ed63d6dd8..099a38ca146a 100644
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


