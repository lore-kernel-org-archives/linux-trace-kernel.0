Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC33E3D91
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795465; cv=none; b=prhnTwdWOSYvJaFB+qzXIPYpOQwIoqdZMaG+c6qO/mEbtuflRdPpMcvHjk9AZnrWQh+ZTkV+Iuw/Ku/fejnU3plfZQi5Boe8fhx349NmuHvv+7cyENdiaWZlxR77euog8xz2dOuRSZsXKaJXhZaN+z7mHyPSdAmtYpbmDp1B3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795465; c=relaxed/simple;
	bh=EoKlLzVEGQUTEHhNXiSKXlzVVWBxr3b2WMKw/edAkWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lg0T9vIQZ4SYmVQxBkb+zdUhphZe0S+B8XQ66hnzSm/6LLrxpTqNjR6HQZwAQRKjzMB/shPgR2WbncEmeBnNd2fHh+VDOd8zL+bDF2guE4IuM2stEB9lxFr4EJLlAtrjHOy1P/is9cmEdJMMdF9JEJEec8IBnGyZmChSfj8kEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGae/F5g; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGae/F5g"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa46a95e9eso695522e87.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795455; x=1780400255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OB8PxKu5O1haLqyjpxm1OAl69TGxKZ6MYUXMP5i6NZk=;
        b=FGae/F5gt2Ik/oUpNqWHN0Iyi4ZIMKpvAH1UWjZKMqm6yaHNkfhp/nDNRnXs9gbdNJ
         l/DkIDXMTsjceprFZoLzRl0k3FA2tRyLrT7n7zL8McrGik/YndLLNYAfMSmOcfZ49COE
         wUrWrQod50B1qj5H60a0F9lpgL9htN10CS/Hzd5wJd8vV5lar8bNvk5HgL7vYhDjPKPR
         /6kyEoXQVuzBx77TBmdJ4+Am3izrOnqyi46AqP2gyoU/Y7Xs8gNUIq46heCvTRwMsjfW
         VvbpwlkZHoXuTZEcUV2Oo8UrH0vjJP9OQgzUkeuOcOYSOJBc2PlSUonI+2+9p/U9E50v
         l65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795455; x=1780400255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB8PxKu5O1haLqyjpxm1OAl69TGxKZ6MYUXMP5i6NZk=;
        b=h7TW65krfkSecfXx5DPcT8KYzI/2baoXRgmnfURutP7LcUaiuqTrB7W7XzSGls9dWB
         lFlJ4TvmGNeoINeLKFTpv2yt4kBsAjuTJ9cc2E8LCyQJ7YqzdYaD/Qgnfw+FO9+1w2ig
         wgKDDiZFWBcPIwlaNTqubRa825Aw/7dugjC7NPzYWoqR4sdXgOekXFMRmogAtiVMOWf1
         MtiN3wXorXhce3KDjdxPIyN7fIXXtRvP+7agpu/Rv+Wk3mF7v6rfTpsQ1XuGJhqylJe0
         uFPhA8AghSaO1cr+qC7Pkn2relh9H+jssR8f+L2z+adS2NWLIG1tT/8704aYauvKEDD9
         X4+A==
X-Forwarded-Encrypted: i=1; AFNElJ+rADG+0oI4LGiGYDKK3S856Z0KJHnR0ZZPgQz+WEjgrlESqxCOtx8UVffmo6YvSy44kLKJgUrCDVg65zxFfVojXfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/3LDh6Q6ObL9Ehjmc6QV4xfipP9LLrf1pm5jCy5mELdJ62uW
	3Qg9sI+2qnJhSVI4bb4i+aXOt9ZJipLQYH35lTOkvzbXDZzogYThg0hY
X-Gm-Gg: Acq92OFP4ZjFWUJFYENlKoj5dH2fV0s30lMUYXbj7H9u8McKhlfwTM2Yfm1LYUywkoZ
	cFFxM3Dggd80JVgQcItGlM52DNWVcFAjPU4gJyaV306pFpH91EKqvPOv2izYSPqPy4zi3i9oeIa
	Mf1GUtkwfpCdX8fgf2t+8649j4d+l5gpwO8+5jSekLew7fEnSf59E8+TExbSRo7WU7iMl9Z6t4B
	GiAlqTc2CWbvhTIDjl5g+umXYCAdKZu1h6+qwog+txKT2hpUsT9yJW0Z8iaV7XBmTeO1eNnMVNI
	tZD+Rr7jlebVCvLeGvRRncKbOmPyl2riDlZ5QBs0C5sNr2i3TCWcLfA6vvdmPjsxS+72ZJgd6Ed
	oVBF5sCouzcqaM3f7hsND2yCwdz3pXiT2whr8Y5PMK0EoNf2B3xLVk+AAYxXmVdr518AoEt6Cjo
	wgPsHsY1cqoe715UEG8xY4k6MUhXxoUuaMK222X2ebysg4EPiCEPBU0UuTr20Q4XMoEjYD
X-Received: by 2002:ac2:4312:0:b0:5a8:a754:4b57 with SMTP id 2adb3069b0e04-5aa323b28e6mr4727265e87.41.1779795455040;
        Tue, 26 May 2026 04:37:35 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:34 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Subject: [PATCH RFC 0/3] Demote to lower tier using non-temporal stores
Date: Tue, 26 May 2026 13:37:01 +0200
Message-Id: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2FFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3aK0ZN28Et2U1Nz8klRdg7TEtMSUtJQUAwMzJaCegqLUtMwKsHn
 RSkFuzkqxEMHi0qSs1OQSkElKtbUAPu0T73YAAAA=
X-Change-ID: 20260526-rfc-nt-demote-0fafadfdd006
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2

In most memory tiering scenarios, the memory to be demoted is expected
to be cold and most likely out of the node's last-level cache (as well
as target pages in the target node). Using non-temporal stores instead
of a standard memcpy path can reduce the cache pollution in the local
node and the bandwidth overhead to the target node. Furthermore, for
certain types of CXL devices that support in-line memory compression,
the last-level cache eviction patterns can negatively affect the
bandwidth of the device. Non-temporal stores can mitigate this.

This patch-set introduces a new migrate_mode flag for using non-temporal
stores that is used only in the demotion path. Patch 1 adds some helpers in
x86 and mm to bring non-temporal stores support to a respective folio_copy
function. Patch 2 adds the new flag and necessary changes for compatibility
with the existing behavior. Patch 3 uses the new flag for demotions and
guards this by a Kconfig option.

Experimental data: in a CXL system with 1 memory expander, a microbenchmark
that allocates N=64 GB memory in the local node and then triggers demotion
using memory.reclaim, shows a practically complete elimination of read
traffic on the device, i.e. write traffic is N GB with and without the
patch, while read traffic drops from N to almost 0 with the patch.

Opens:
1. There is some "duplication" in the x86 tree and a bit in mm. Can we do
   something better there? As it is now in copy_mc_to_kernel_nt we
duplicate the machine check functionality, which if available will override
the non-temporal. We were not sure how to prioritize these two and what's
the best approach here. Can we completely skip the machine checked for this
path?
2. We've hidden the use of the new flag behind a Kconfig option. Is this
   the right way to add this?  
3. We have not carefully considered how this should be structured so that
   it is easily adopted in other architecture trees (e.g. aarch64). Arm
support is currently out of our scope but any input is appreciated.

Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
Alirad Malek (3):
      mm, x86: support copying a folio using non-temporal stores
      mm: new migrate_mode flag for async using non-temporal stores
      mm: use non-temporal stores for demotion

 arch/x86/include/asm/uaccess.h |  4 ++++
 arch/x86/lib/copy_mc.c         | 26 ++++++++++++++++++++++++++
 fs/nfs/write.c                 |  2 +-
 include/linux/highmem.h        | 32 ++++++++++++++++++++++++++++++++
 include/linux/migrate_mode.h   |  9 +++++++++
 include/linux/mm.h             |  1 +
 include/trace/events/migrate.h |  1 +
 mm/Kconfig                     |  8 ++++++++
 mm/compaction.c                | 18 +++++++++---------
 mm/migrate.c                   | 21 ++++++++++++++-------
 mm/util.c                      | 17 +++++++++++++++++
 11 files changed, 122 insertions(+), 17 deletions(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260526-rfc-nt-demote-0fafadfdd006

Best regards,
--  
Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>

