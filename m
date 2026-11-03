Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731561;
	b=dyaDTdT+hVcBpZrDo/YYRPgQHf1vyQMVhbkYWOSFd/B23LhHyS4LL/GFfGPiHRdNTcBu
	 w1Xl3b9ORv7LNmpd7gZnbjgC9c/5FrgXw9Hft/VSIp4b7TyYMZXqqWEHMzt+lVBdgY3kg
	 zmMsqq6VG0/KhEl7tMXOHv/N045vzx3kkNNluinkfMqyrrDKQSKkFGDWJBTUidTp51YGX
	 AOvDk18gVw+Ei83QGY/gKPOQZLNwGta7I/w25oD/si/VTsxORxWj7MV0gevwPe/fd0JkR
	 fTdd/qnnEKJWHRT+rFfueCPhpwA4K9qdIuSFSiswJFnvhxrZhYK2SUbvbUYSkFHQ5Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731561;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lNecyHGRIIaxT1G2r1uMqcZKJaHbTJn9ZphQMR3yKzQ=;
	b=jnmlhlIhxpjL9d6lK2SmYTMzvSdkZ0aci8u81PFY2R8H0r5B/rkQByExzZzVeH7ficIS
	 +5w8c1InKZmvhT5/JzkjVcFzknqFP2Y0Lkn8YMl1HlN6WNAqMdGrMtl87f0QhsoNTTD+1
	 9aIQpvGdFlHvJG2TLFr5uv/ioUop7bPkYJcYiEm8JnoQfDU/xIw5Ub/H0PTTwi9ydfFcu
	 S+SHFEvsqRKy4etPcnsC1QkYDzokBXKugQd/4S4pBfUJU1pPKMdp3FjCPmSq1PBWhjuMd
	 HoJU3K0djht8XHfTuoa3y9/GeTa7r+IYTKDQoLrAPAN0OkLD86ewNp5Co458D3eRvjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPXQTPfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DA606A326;
	Tue,  3 Nov 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPXQTPfV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793731561;
	b=Y8oBFxJaZXvUoyeYfeve4kpmpzZYoWMom1nXlIpUJZMHg7GTjLHeRorfzkpD+7DLoZ/2
	 wL2KWwf6yHkrikF1SnQep/UZGbZL05Q1wa3tdSPI5H5WMBg8MEdyu2i+vGuhsSFf5WH6F
	 YL4nSA81RcHts1xrO585J1YvQph8xJikMOtOctcD1IqcQ+/T37hav/vE6dzsWKVLy7bDs
	 DNOH+w23yxmtfhMYTFldmQAr2kwvFbXVU0xJmzi6Ae0NcLX+12GLNtHJevrqmUZ8f0GY7
	 tLxoDvkWK+TK72NdGBj0u0UTolW13dI4y3fgzS2oWcRVWGO959oZqIDXWRKSNw7Bpwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731561;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lNecyHGRIIaxT1G2r1uMqcZKJaHbTJn9ZphQMR3yKzQ=;
	b=XGzhKzTp3E93gquunWslHkkqjja2RC2ZiI309O6Avj07idO9AyZAhxuADW6YGfPZTslz
	 m6nU0uyd7WMXNuFCfLxcqVINGFhjruwz/TTbaGBioRlGD8liM33CL8FGrc+Ym3LBGOxfY
	 TPyNoPEtGrM5V9Ykvt7JY4t48WWdp36uUWLeL1KZO0BwY2W7V3diCi/66XQKdw67Olfbm
	 mCqpD3+USsdaEZuiPpcU2QXead42I6HUumEC2SOoBF0spNcMm4o55CMXu9PY26PgJu3jA
	 sijgusJT5HxCaZQoExdlUIxfcaQvgKYNv8BME7Ki2Tt3WZSmiE98jjfG8k1T5nDscHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60F4E1F00919;
	Tue,  3 Nov 2026 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731561;
	bh=lNecyHGRIIaxT1G2r1uMqcZKJaHbTJn9ZphQMR3yKzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IPXQTPfVH5DwCLiI8GFHB3m4dAtVsNNcQgt16NR10CZe6vaMe/rQJ/VkyAuVvJg6f
	 PRKwuSgzUPkcn4qCsaToaKUhzWNtrJePH4u7lu36rFrxytdW+QKDkumxnihF/8Ozh6
	 Bmn2lvMWXewuPMBItOt7ujfFzPFbsAMP6zpdo9JQ8hjiYNVQwuKmf8vkPMiCffT7/H
	 w33GJjl8CdYzcs+L78brQHTZ566or7raia0ysqerEw7P1ggh0ojES0N/smZ+h/6+Wl
	 +BvqatqyGHrhOdiG0VrVvLBu8lRoSNftKBBiN6MPOInDUeU/DduSEK/rz3CZIWvUe9
	 QJp0czQSLyYeg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DBFC746AA2;
	Tue,  3 Nov 2026 18:45:59 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 13:46:01 -0500
Subject: [PATCH 3/3] kprobes: Arm reused optprobe on cooling list
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
Message-Id: <20261103-kprobes-optprobe-state-v1-3-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
In-Reply-To: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731559; l=1380;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=A4hzeYXnyu4gqCtaHPk+uqW5lGcpJ7XKim4n6VIIG3I=;
 b=WT5Kqr62jfYJJeNpsYt50OGs4bjDsKR9DqcIbR5UvllsI/9clbltJSFOEdzqct1LaUqj0mxzJ
 6o/UqV1tYYzCMRgryOZ2zzE6Y6D8XVTSRatbx2yR1gEM4FH0Kl11UJn
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A new probe that reuses an unused probe still on a cooling list doesn't
fire.  reuse_unused_kprobe() clears DISABLED without arming it, so the
probe has no int3 until it's optimized again, or ever if it can't be
(e.g., it has a post_handler).

Arm a reused cooling probe.  With the fix, it fires.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 kernel/kprobes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 84a5f68476eb..59c5689299ce 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -536,6 +536,7 @@ static struct optprobe_generation optprobe_gens[OPTPROBE_GEN_MAX];
 static int optprobe_cur_gen;
 
 static void optimize_kprobe(struct kprobe *p);
+static void __arm_kprobe(struct kprobe *p);
 static struct task_struct *kprobe_optimizer_task;
 static wait_queue_head_t kprobe_optimizer_wait;
 static atomic_t optimizer_state;
@@ -1067,6 +1068,13 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	if (!kprobe_optready(ap))
 		return -EINVAL;
 
+	if (optprobe_queued_cooling(op)) {
+		/* Already disarmed. It will be optimized again upon finalize */
+		if (!kprobes_all_disarmed)
+			__arm_kprobe(ap);
+		return 0;
+	}
+
 	optimize_kprobe(ap);
 	return 0;
 }

-- 
2.53.0


