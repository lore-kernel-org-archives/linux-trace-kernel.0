Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745114;
	b=3A/mfZbTHmDlg6FUnLqAGP2E6gJCgods5AM5YWyntrq6w1FaId0P/yn+/fTb10CljPUB
	 QNRJmLrsA3Np2Cw11sZTeI/HCoFtkScDTB3sFoNj2wBCwFPWWAX9oTgFV/kaGmcz2S3lH
	 MnjlQ7h5wSCthLItwDjsGaZK4gXFZLY+73SIZTUAajHFarKrp2XyDBdvMXn7CaMXC/9bA
	 Yl4nGrclpZYCoje7QFLBnK4JRl0Ik8qDY/CAC1fBmBXyBCrKE4Yvy8shpfaojIY8aJMxq
	 EmYuMkX/Raevr1gyld0AQE3VnI3NbufwViNdXfRZAyhkzUFsi33mYPuRHVo49jJczxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DmA/Tv3awqiayprrH2/NBc4Xl/piE35b+PCQgPAxOS0=;
	b=ot2bsIbwBnIkFKY2gHN2t6VkdRrs1ASeiQhJu8P50KvAZaVMTqclY3v2qCS6zTqlNmsn
	 gVQZ1EB4TwlSeyjgxH76aEQ/w35B0aMtsT4b55Ax5oTTHU8wEcQIb12VkMxIQFa2DVMz5
	 gp6jl+wjAwUT3MaI2JmZWOXleHxJzElAO4V8Y7XjcAKjjrNriqmcUB3DZ6JQIbQ3w+aat
	 +4oYQ1Kyhfchw1IJptqIV6p+Iy7Re497yrox6Fv0Se5EbwYpTUZYLTW9vzY1vF9NM4iRv
	 ZFcKyK/jEGS/KxjF7fZWAsDU8enAuv+8Rfl0LweLHMODaVYiFrA9DwPX5IXBFTaMybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nhuhuan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OUHWEXOo;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6724606A33C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 22:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6724606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nhuhuan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OUHWEXOo
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b238436265so87376c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 14:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793745113; x=1794349913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmA/Tv3awqiayprrH2/NBc4Xl/piE35b+PCQgPAxOS0=;
        b=OUHWEXOoPGT3Kf+4MlurLNM5cCjXDfXtlTKAL1UrG708GPCMh6fDkZ25mVn7XGdvuc
         +zRjNRFkfck/p784G/XfP0WYwUhiGN/WmlraLfMcO1KRB6wBUoD7MEevxiKxJ8Eh8iWM
         bY8XpJr7ClndiVE0cH8XQC2W6RcuxSoYfaoQXodJXVfVM+NetmGZ1/sJexNBYsSnTaMY
         NQrlb+jEfk696AlaGHYfIs15EPCtmUio+bLNozXmdwZbxLnYAKOKEsRpR6KSdHa3U+nz
         U+ph6Uw07UzqLEmd2gKmxJbdJBlH8TRSvKqVTSq8151JWuqWaN9hRqZzxnBWC6ImgVdk
         wG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745113; x=1794349913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DmA/Tv3awqiayprrH2/NBc4Xl/piE35b+PCQgPAxOS0=;
        b=VRLjOs5PVLOLJVMuB91aPpoMpM+bVhcmBSmVQuyZK8HPJ3H2/Y/KOzTcoRBtXKgfUd
         9zuNrHuutaMqrMGu8LteDmPg+Jtw8YOmT81gYat5XK/gZKaTMPJZueEvBvD+ZuwhTAB4
         +R1YfimIykcddSTjI8rrOZuR+GCjv3Z+vIFacQvcblvqfZ+OHHmHdUwz17nhgQmDcFMP
         RAXsV9twy0xJNHvlf4yiaszy+WpFUk0ojTuDLq/vbNC69amOmPBSBX2NosO66INXP7Lx
         qjNLDDhcM5AMDrAOfNRC/TVxa1MJSUl40P21viTWtdLO1w5Ycy9KrohjESTrvJQGCch7
         zCCg==
X-Forwarded-Encrypted: i=1; AKwUvBzGPokwvHiFHDR/yg7A92l2abaY/6FfPwnDpaHGsNbHrfedlkJm9GLtJQ2QoKknXID3qEcgk2+En4n9/5UWot4V6Cs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pm3Hgy8Lws66G4G2E4eN+sCXkri5j7ej+JJgxbOd3zH6VNFfI
	fPZbefiFP6fPIdFgHVYlKX7fOdmGnwkPZeKxmyFgpNObRy5ZZZvekb506l+x1RT8P1xTS7eV4vW
	alAJ2NnM3Fw==
X-Received: from dlai3.prod.google.com ([2002:a05:701b:2703:b0:1a7:6a69:e56b])
 (user=nhuhuan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2094:10b0:1a9:f3d2:6262
 with SMTP id a92af1059eb24-1ac5d69f68amr21601092c88.36.1793745112607; Tue, 03
 Nov 2026 14:31:52 -0800 (PST)
Date: Tue,  3 Nov 2026 14:30:25 -0800
In-Reply-To: <20261103223025.2482227-1-nhuhuan@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com> <20261103223025.2482227-1-nhuhuan@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103223025.2482227-4-nhuhuan@google.com>
Subject: [RFC PATCH v3 3/3] mm/vmscan: demote folios using non-temporal stores
From: Huan Nguyen <nhuhuan@google.com>
To: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, trondmy@kernel.org, anna@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jackmanb@google.com, 
	hannes@cmpxchg.org, shivankg@amd.com
Cc: rientjes@google.com, dave@stgolabs.net, nifan.cxl@gmail.com, 
	fvdl@google.com, jic23@kernel.org, rkodsara@amd.com, bharata@amd.com, 
	sj@kernel.org, weixugc@google.com, xuezhengchu@huawei.com, 
	yiannis@zptcorp.com, yiannis.nikolakop@gmail.com, 
	dimitrios.palyvos@zptcorp.com, alirad.malek@zptcorp.com, ryan.roberts@arm.com, 
	nhuhuan@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Demoting cold folios to slower memory tiers using standard stores
pollutes CPU caches and incurs memory latency and bandwidth overhead.

Update demote_folio_list() to use MIGRATE_ASYNC_NONTEMPORAL, avoiding
CPU cache allocation and improving demotion throughput.

Suggested-by: Alirad Malek <alirad.malek@zptcorp.com>
Suggested-by: Dimitrios Palyvos-Giannas <dimitrios.palyvos@zptcorp.com>
Signed-off-by: Huan Nguyen <nhuhuan@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce8..b44b7cdf8a03 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1134,7 +1134,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 
 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
-		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+		      (unsigned long)&mtc, MIGRATE_ASYNC_NONTEMPORAL, MR_DEMOTION,
 		      &nr_succeeded);
 
 	return nr_succeeded;
-- 
2.56.0.398.g882cbad275-goog

