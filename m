Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD414A05
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429207; cv=none; b=GrLry4NVoqwQ6tmFMexcf3MjtLr+CgJSthxcyRN1OsN1xLoRFY6WjH9fcoc4efKRSA0D6kLR02YTUezVZzQ8Fv3jQEBmMKDkZsXID5srmj5uoL61hD1ezIPh/fWDy3COK0Nl/K2JMKj1LmJP10vhGykksqwzyoNdUFRgfUC/jnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429207; c=relaxed/simple;
	bh=Uu6ffgw5ANp4RrdWNurpzkvUhN3Hlg5sZPnNxmwEMzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOp669R9XsakjfZhQPMnYde7aSyqHHjfDr1iMd28kSFwtNsAZ7Xe589kx2u1Xr55JFUCapW/xkg00ufvTjIu5djCMKI0k/VKGX8RtJaNUr6Hd2hQcev6d1PCl2GO6louHY1o37dI6aEgGAnq3k294kQNlHbVQnpBUjmN/MYC3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwkjeeuH; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwkjeeuH"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so655856a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429206; x=1784034006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRG4koxyQiwY5tLrrrfMaCr8tCYmTMxhC2SFHMMXrW4=;
        b=PwkjeeuHcuI7JrU3TRG0eyjEBDcKRA+t32SN+/gGpoHv65T062UMR+lPu08l9P3GwY
         NIRLLrtF5NNrr6NSLQEuelBD9AGdNEUTz7o1bvq6nGpoM7Q3fNA0wIHXp/cQh4miMHJg
         47m/5ciV0PDdBSgYHZlPOT1e81mZdmdcCqd8cOoUxx1UJco/yLu1DATr4PnReHFp+Tv/
         eQm/xpP15DD7cf3t/GCY0cN1s1gHARSdJWfeYncrB53L62xrH/2UnSZDp565kCv+bjdf
         rvIjtx4FM+TgTazzc8dy1WyjqSEi9rUiTmFUt54EK3W1jPCFgkmwGYdxFXwexz98SZHr
         Lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429206; x=1784034006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dRG4koxyQiwY5tLrrrfMaCr8tCYmTMxhC2SFHMMXrW4=;
        b=d31M5GdWKNeAdo0Bb4BgqJwQ54pWamZrKIPw8xsDV3iVFDMIaK0NVyZp+xxklwDSSj
         he4UdLHTxqO8iOLtkGCPDqf/9NgtX/fNBTUUZTGlulr+HeGrZtvUR8YCCMbu4zIU+ju5
         VKuAbxj/GTYYA3GN3ofODQOjC8N3lgHWcL1S7QyXDOkH6yWP4uoz+o2VgMrHfODmiI/5
         R4H9iRzQwdmKwuiHrWCcyF/t4d1OHQwB7r6b2klyqUL3wpvdiiLvzA3UWc4odORFKirq
         TVdXUCrgNtZTjj6lsGzgq1N95JbgB40Gpja+gWOm2X0t1n/uwyHdg6q2Y+FtRrpk4tKZ
         0euA==
X-Forwarded-Encrypted: i=1; AHgh+RruI9n8wByJt/ACblIRHT81c2q8TIQGyLlvxv7obhSzqBxRnL0wuYDt9ShjXfGGgt3kprgwU3c5edpCCqixsXwMBXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXixm0lA+ORNexoVCzXeeCX3tdC90FTtsBqiCTm7zgAgBS/f5
	wHrsinc5UIY+33TSFx7RwmjX827+hNo7t3sxhTxCWjkX1C2enZY/sr/s
X-Gm-Gg: AfdE7ckl0wDDlUqzCTKXO19iiLU5BQpyQwcNRP7iBKU+HXmyO2KqgpiyF+z2ejiOOM+
	GleNXFDxqBpWv2rsTrs/eMkDXSTUDASnSNpt3M8LhM0UJB465n1ivFJDt0CgC9ThWsy6E4vGHnz
	NM/sXaCitW014uHc2pDCxfW41fKDbANMiejq2GkPwKNzX6StRIihp1Jzfxtf4X7KQhi4l9uNFnO
	fk5sHgUBo9jzUcmj/VuT5mdrHVTLwUdRIOjKbWt8X//iilnpu1mzCwBOSxnvI7i9mFBrICeSv6M
	nS0wgI8zPGoMfgPtrpFGWSQd+4pUDu0ZTOR4aI5it/H0/SkSEzfsmX5WT2ZYT677Ko89C20ml95
	NF0ji07pz4WRyh1UeQclOnH72F0fGWu/Jijazyc2oIWPYfMpIqqMZSeaKegbKJyrAojiNBOIEzn
	o/stB587D19xAQVRmXsTn93viT54vyFkzctonx
X-Received: by 2002:a05:6a00:3d0f:b0:847:6ff4:da97 with SMTP id d2e1a72fcca58-84826e92efbmr4766809b3a.61.1783429205836;
        Tue, 07 Jul 2026 06:00:05 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:00:05 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 2/4] mm/mlock: wait for migration to finish when mlocking a folio
Date: Tue,  7 Jul 2026 20:59:23 +0800
Message-ID: <20260707125925.3725177-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707125925.3725177-1-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

In RT kernels, sysctl_compact_unevictable_allowed is false by default,
when the mlock/mlockall system call try to lock all the present page,
the mlock_pte_range function skips non-present entries. If these
non-present entries are migration entries, and the migration is not
guaranteed to have completed before the mlock/mlockall, it may result
in a page fault on subsequent access, which then waits for the
migration to finish, causing spike latency in RT kernels.

Fix it by waiting for the migration to complete during the mlock/mlockall
syscall when sysctl_compact_unevictable_allowed is false.

Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/lkml/c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org/#t
---
 mm/mlock.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 97e49038d8d3..ac65de40b22b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/compaction.h>
 
 #include "internal.h"
 
@@ -361,8 +362,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
-		if (!pmd_present(*pmd))
+		if (!pmd_present(*pmd)) {
+			if (unlikely((vma->vm_flags & VM_LOCKED) &&
+			    !compaction_allow_unevictable() &&
+			    softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
+				spin_unlock(ptl);
+				pmd_migration_entry_wait(vma->vm_mm, pmd);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
 			goto out;
+		}
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
@@ -383,8 +393,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
-		if (!pte_present(ptent))
+		if (!pte_present(ptent)) {
+			if (unlikely((vma->vm_flags & VM_LOCKED) &&
+			    !compaction_allow_unevictable() &&
+			    softleaf_is_migration(softleaf_from_pte(ptent)))) {
+				pte_unmap_unlock(start_pte, ptl);
+				migration_entry_wait(vma->vm_mm, pmd, addr);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
 			continue;
+		}
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
-- 
2.43.0

