Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550387;
	b=q/DVJsHm39Hyd24SaUj0i0XfsihOmOdHGYCPBvNmGmibX/NHBnND8qGGzrjqII0LDemT
	 AsUYpYnLxjX7X4fx//Fb5S9d5fUpgeBgbjO3NhhV/UjyGPqKPAh3vJPaqtWWjqUBFhoLw
	 t7OcsTj3IhSZ/FjBaa+Aa3Wldddcz1iTw++0tOTKDHenPWHv7z2re3jXjFRWSwmhmr9xc
	 DnJu/ObjiDY7nD6QbgiS4vXBdm7Q12HRZwfZ2PgnFJIof3lLQyt3qt3Pgm0NtzAsUEjrh
	 MITDUZP0FCC06g/aUVR85bqOAHEmhDLX3v7GyLhMZOhrEEmn2tV6uPqH3EHxxjBwJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
	b=T7nlBEQoqNTTKdYfEpG4SatXmNiApXHiE4yrGnV++g6rlr7RlnNzZde6ttUFS01qnsud
	 PN+jUfxK4EGyf2KYcVpetG4VcyNA+eGHdFwURqZxheE/Z+MKvJXHhiqy2bDDxwr3ZTI+w
	 ddHSc6epcWQiyLOLRVZb3L3UAE6H+xjJ0bDhbb3hFDCInRVOxTZn6PVspeSRGf2TPJ1ZU
	 yi7f+pWsKaharMTUIBQCnXRR6sEcFDTjeg2ZsQfPWFXm4c/7972kDFLaKtBD3/A10E/UX
	 nn55VBz1ywDAY1zdYRSLf4ym02cvtCYXIenpMzrrnHlLqdJLmjCZ7R6YjDpLfkhrHNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DlBQVqmd;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01100606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 02:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01100606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DlBQVqmd
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ba702cceaso3423716d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550386; x=1793155186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=DlBQVqmdggJzMLtVctYMORoaOfmN3U64fiq356uSAOANZVzdQ9oXHdCA96fpkln0YW
         jbjerg8i3RIUGPPHhNsiTruLigBMA7zORq/KYkzeEoJT6eBDrJAZZNDq/deZQlW3u4cq
         ceHB1ClEmbYMlBds20UE8TCR0KAU+T6PttWRFREuWdJXvHGJf93DduBoT/ObaZC3l5vj
         VVaj5po5s1U6oo9fftDJoRDKJGY24THmSDgk9gldIp3GI4HTLEFmCwRVonUcJcdQrO5x
         BSM6CXIQAYjRrdEUu4h4jfl6bUB4gcqeFIl7UkXuDmxnrVCW8UPWgEBjSMHA5u9l6/1P
         K8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550386; x=1793155186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=AUZCn1akH5d1uUD8fVGtv6yDKDRTIK7UflGJer60OMMtVavdNO/ncWKnpFrrE0J3TN
         VENMYoEDFFRvbX63QXMA6EXP7x/UKQrk+qJJsqKb9isFe0ZrQ++PYkNQs2Te0+GYt1vU
         cczHXlLfJwNuouFNTtqgEgK9MYVS7/QBRpVkv0S27BYQrLju3l2CHG8tiCBLCS6uDILF
         AtDt9QmY7/69Yr0pgrHfqlpf9unC/0UQOdwLYUVmaQoDTrQ968Sm20rlnw/dpngCMAZc
         UucMBc+EuCOGcMrbncXQCRCCt1MaAY7zEpMx//UPrpOb+4MW1ZWuyo31wFJ8K5aQoNhk
         JBWQ==
X-Forwarded-Encrypted: i=1; AKwUvByz7pxStFXLkejf7Krxq+tJVCKagEjjMeKncTA7qGA4n7cN9k1rFbq20MHbknopTFZu7KVTsqCtpT6vjXMwgi8/TTM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnOjKulcsslGRt/MAmP/8ppH4fUo7cDKXmNTFpQmd+4BpKimJd
	E97qEFwEg3rO11VL34S5387HJn0tuYp9DrJimz/NHNqjt7J6SQROFc/vMkRTR52wYKQ=
X-Gm-Gg: AYBFou2TEUxdCG57T0x1G/8BlhbS75OiVZjyUs5KjrZckqBhV/97RRmBpcTmO7zkxwA
	KI9pnnMCwgxU4GMIluvOZOXaBVYFeKHb4tafNi+2z+ZqPyRPwPghlRzlnB/4//yl766OtXubJJF
	qdlu7JDEiBU2IdGby11sGzx2ZI34h9SRNAs4/9cce+WH6/sVDYjnk3wktTmtOcrvRVp9yJBItsv
	YU/gb4eL9LlSIMhe9g/RWZHShewaC7kgTlNbmTonMQwGmgIloWT9bSve35Wp9gGe0LFv0Am1aXt
	rH8rDbYdl2kJIdVYQ3WWAxLTZe9PHB1/f/1fgMFHLLAulfo7f6VRNOoTZgCbJwZvsSSu9YVrg9w
	Ca0/lahRW4sEItAZqs9whIoJMSZZmIujYAwHg7SkOLAACD4yBFbNE3sqR13mcoKCtw7FswptKfW
	PBHE71oc0vzjOSdIvAtozbDxUXfBlhlPVQeH+p9m0dlgAFrPOCofDGzEIc/pvvUeo9VryyxymFH
	VxN+PmdMTkydKgTIUnXdJ6E9nFBTpXeSMhoxjxGkVFoVc/TSVG8AkD1x1OSzEFwqlg+hrrf0+K6
	eKhlfRSVLlMZuSXDIXSyaGHid9LdrexYCmLK0fgUnA==
X-Received: by 2002:ad4:5aaf:0:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91c12ed7e09mr12120496d6.25.1792550385953;
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Tue, 20 Oct 2026 22:39:33 -0400
Message-ID: <20261021023940.1940971-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2daf358269ae7..c7125f6693574 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.53.0-Meta

