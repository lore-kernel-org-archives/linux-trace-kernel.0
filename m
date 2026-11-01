Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499247;
	b=Y8WNmCLKMvQxDOkC4UtiipaWvJ29W31K6jR0UHqhwxpDnUXMZmob+hVbVcDPs3i6aUVe
	 L0IVzVtvzq/K4TII4RQAabJ6mOjyL/wFGMMEyJGT3sE8qFRAZjTC0ZdPsT97fonx6H/wF
	 NP4ZrmlgwSkyVek6EKUm/503hvFfVZT6NqyaIu0w0ybAmtU7GYGeeQw/ztCo0H70RocDK
	 M6IY2FK16RGIWrxY8buDwu7fjYi8auD/XQnDnnf6BCKiwz2idIiK/zv3sMMndoDfYNTnN
	 ScaK3t8eQF+AiVCO7h2iAtgDdt59oc0kksIo6XD7SVOopPAUTKVaH9XT+eKRRySIRoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8AqB+6Y6YIFn0HjqudvdVztXfdpwTD/bMBAeQqpR7bQ=;
	b=3PHmBOfqkK/sjtd0JvuvkdounxO116sKr3xWPCtxW4TJ6OLLr8hEo4v8in8Tpckm4xyl
	 4B9ch4G8G6Q2StJHqfvwUuBKJXIEWqEaqNtiGqwcXNsHiZz7dmFr/XW7l1/U44Yr5B6eT
	 xMLYk9WjTbaYjxNrJpy1BbA3H0vhWNCGIpSQxtJKZK8YQOX8sNTS2TZEw29teds4XcY8w
	 huFMCMrs9hBeaNzd3FGm7xUJ6GJaMyXEKZy0wIl9CJpZ3O+EFMPCLAQ9FZbDfRCMcNqHR
	 RHNWH78JsWgRyDUjLOT+xQ9utQPDZ2IRV/AR0/9wsNNlmIVsK9d0GN+55euH713eDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e1uprEda;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD4606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCAD4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e1uprEda
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b55859245so30243226d6.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499246; x=1794104046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8AqB+6Y6YIFn0HjqudvdVztXfdpwTD/bMBAeQqpR7bQ=;
        b=e1uprEdaqqiQA9+e2NMUujr/+0J/tLKyuPof7IdUsWRkmSUrnjpcANC78AA/1V59Ni
         Sk+lzR4jYGuSBcTOyp///c6mHM0r737liT5T6jIE5Gg/mSVWq8cez3etq7eYAFVDQIyM
         Jfa2Z7IPtMI4qLCJQpoZ6Kj1ViXx7vt8lDFXnChzFtPM3ZQyL1CeryEwDWgGqH3Junne
         +CrWCxItVxvGKFcydmyv6CtmrQO2XDjUn+EcdNDDSbNlatjzGbPiVM0W6La8oVbcWHiK
         7lfmxkLO6Ek8ZdKkTsn8iz5BSxeMXIlFilw2J5I8a9CSAIkc4D2ujRIS79EsZpgxx//a
         8WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499246; x=1794104046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8AqB+6Y6YIFn0HjqudvdVztXfdpwTD/bMBAeQqpR7bQ=;
        b=lLQrHLp2j4jO90Y+HrcbAOPzFkfPnI6bTgyFiFGl7veI8xsyz5dtA5TaWO7EWwPTZP
         1ZWlPg8v+K+QHCX5N7TRB5i3K5RSTkgUoXnoMfLQ03GMkFXqszogNofQ+ZnJEZf1Tk/9
         I4JbvzJ2tg4l7Pn+wmXLvjTrevNyw++MkuP4B+jb0qMwSiuX+T+Q/qX1xIdCkrO+APb2
         FErYiDbIj5wVs0XfvxHPTzFSUJczx6ZgPLAseMUsBRYdPbzPUjk3zy96zAOwanM4LMpY
         G70kCPQJc5RSbQxGh7HLEMgPCFR/zhtGTbYJW7U3cUlJMDEe9CzhUdCoddNR+FiN47UG
         fUHw==
X-Gm-Message-State: AFq9FYIAIjABZq4quOh3fxZ1i0Q+pmJVU6g4up3ARSSieoKCm/M6mPJO
	fULLvXI9ygFEEgMcD/KFubBGoWhY1Y/bDOtAkKP9s7Sd6eghzBSIKpCyQU55uOaZilg=
X-Gm-Gg: AYBFou3HnOGOcMuhnHUlu3fNErsVAViD61yWUx8rfBQ+RHoMNtcKRDeOSlbFxoeail2
	Jfwc7/oMTC7WGxR9tL3biamdIZdEitbCP3EiWFKT6nsAauHQbCJbPCNWFIE8dFXoiSeS2EOLHnz
	yDqDTkS8L1hVUqVYy0D19x0YxzYSAZiRRpQDvVbrwVD0neW2szGmjOCuw60T/omg6z8FV+5IBLm
	q6OXlO+qyHp3R5MI0UzzN3lXkZuAfLhRGO9M33pccQrcUXSXTM3faFjhnPBCAyt9XLe9/kfxNzr
	pgs8Cq0M4W23w0xfSj2RGvkpQgdgvYDGPmwpRhbbu2ovI7jK3NSdmNCGD7O60onHhtSwh6Gj9Pv
	9mfRMiY/N7PK0X0hBe5/H3BALjitio1D/o71JeDfmMVaFWgaW6e1PTCnKdEHIVT6WN5irl5IWRY
	fMYGsNFNxrLEdFJTGfw7uGTs7SUT8K9laoWaCNoENLKqCmI14YNRCmAHIS702EtDLn3Xxf5+d9Q
	baL/BLkL7E7JLZ7LhXzX44rmiHJG6VPh6PBigAylpih5B6pfelePrUvSVgJv59ybdV43qQ3Y49d
	9YQ1AIDqzmRxXJ+uGylCYxlOI0aQTqOtOmj8msfxGjQSMehnBbjuYclAbzI05Bs8AaDLE10X1TY
	16q4q9xGpow==
X-Received: by 2002:a05:620a:461e:b0:93f:707f:28d2 with SMTP id af79cd13be357-94421712d14mr1095889185a.26.1793499245855;
        Sat, 31 Oct 2026 19:14:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:05 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com
Subject: [PATCH v5 12/12] mm/mmzone: remove zonelist_node_idx()
Date: Sat, 31 Oct 2026 22:13:40 -0400
Message-ID: <20261101021340.2251928-13-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

zonelist_node_idx() looks like it returns a field of the zoneref, as
zonelist_zone_idx() does, but it loads the zone from the slot again.

Memory hotplug rewrites zonelists in place, so a caller that has already
checked the slot can get a different zone, or the NULL terminator, from
that second load.

__next_zones_zonelist() and mempolicy_slab_node() had this bug.

Remove the helper and open-code it in its two remaining callers, neither
of which can race with a rebuild.  local_memory_node() runs either inside
__build_all_zonelists() or during CPU bring-up, which holds
cpu_hotplug_lock for write and so excludes mem_hotplug_begin().

The lookup in mpol_misplaced() is unreachable: it needs a policy with
MPOL_F_MOF but not MPOL_F_MORON, and nothing sets one without the other.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mmzone.h | 6 ------
 mm/mempolicy.c         | 2 +-
 mm/page_alloc.c        | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4bc2318ac37f..72ffb2959c4f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1439,7 +1439,6 @@ struct zoneref {
  *
  * zonelist_zone()	- Return the struct zone * for an entry in _zonerefs
  * zonelist_zone_idx()	- Return the index of the zone for an entry
- * zonelist_node_idx()	- Return the index of the node for an entry
  */
 struct zonelist {
 	struct zoneref _zonerefs[MAX_ZONES_PER_ZONELIST + 1];
@@ -1864,11 +1863,6 @@ static inline int zonelist_zone_idx(const struct zoneref *zoneref)
 	return zoneref->zone_idx;
 }
 
-static inline int zonelist_node_idx(const struct zoneref *zoneref)
-{
-	return zone_to_nid(zoneref->zone);
-}
-
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
 					const nodemask_t *nodes);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cd63c3e2c029..267576054980 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3087,7 +3087,7 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 				node_zonelist(thisnid, GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->nodes);
-		polnid = zonelist_node_idx(z);
+		polnid = zone_to_nid(zonelist_zone(z));
 		break;
 
 	default:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ad979409e5..81c1de714658 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5973,7 +5973,7 @@ int local_memory_node(int node)
 	z = first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
 				   gfp_zone(GFP_KERNEL),
 				   NULL);
-	return zonelist_node_idx(z);
+	return zone_to_nid(zonelist_zone(z));
 }
 #endif
 
-- 
2.56.0

