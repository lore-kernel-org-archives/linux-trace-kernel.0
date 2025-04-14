Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE81F1927
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668505; cv=none; b=nmqb1MCSeZGAonqYVKsEAp1Ri1dVJE+bezm3cWX+daD8oBwnqENGrNBGJoC2S+qZBkb+Ek5KzUNWU0Rz9z/TuSDxgUiesFBPYG+czJL1ADaJG2jJQCsHwUlx13TVuRxcfCin0kzjkxrFOfi4aeJl9sFiEuTgG4zzMfKZHnHaTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668505; c=relaxed/simple;
	bh=ZQqDjpLvAa6SMF2b8rUqqfvpCFXxaImQ/0oDxePwhQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb3QOZv/eqy7o24BQC1r8nmPcKHfcp6I8h9CYrB+LVMHelW14z8ZCHfsSAEiIU4vtgbj9KGkQZ5b90l2/X8DR0lQtyE0AUo5y2jhDqtkjwd5BWnODI4Gq+WY2/LTeCFtALSKLe9cJ4OdbKQW0/+exSsxJyN8K2p1wxbDdKe8auE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMlabERP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMlabERP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744668502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7UZe2oIzsDa6S5L28Z8pby9GjFeNNywMq4TlSe4zv0=;
	b=hMlabERPlm/fmmYJI5hCQj+jf+8jULdYBgn6ul5lhMq5IVcUr6xxtbwa6YW988m8rP6IbL
	4KeeacH2EBLyQTjEDnsU58F5RwBQR2rwjzXvwXbycfc15c9Cd5QCgweyBasOgQdU/QVwfF
	fAgOYkuW8CM9V021WudATE4h8Lr+tg0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-Ofd_pkTNOEOBqw--4P-yjQ-1; Mon,
 14 Apr 2025 18:08:16 -0400
X-MC-Unique: Ofd_pkTNOEOBqw--4P-yjQ-1
X-Mimecast-MFC-AGG-ID: Ofd_pkTNOEOBqw--4P-yjQ_1744668493
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A7141955DC6;
	Mon, 14 Apr 2025 22:08:12 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9187A1956094;
	Mon, 14 Apr 2025 22:08:04 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com
Subject: [PATCH v3 12/12] Documentation: mm: update the admin guide for mTHP collapse
Date: Mon, 14 Apr 2025 16:05:57 -0600
Message-ID: <20250414220557.35388-13-npache@redhat.com>
In-Reply-To: <20250414220557.35388-1-npache@redhat.com>
References: <20250414220557.35388-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now that we can collapse to mTHPs lets update the admin guide to
reflect these changes and provide proper guidence on how to utilize it.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index dff8d5985f0f..f0d4e78cedaa 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -63,7 +63,7 @@ often.
 THP can be enabled system wide or restricted to certain tasks or even
 memory ranges inside task's address space. Unless THP is completely
 disabled, there is ``khugepaged`` daemon that scans memory and
-collapses sequences of basic pages into PMD-sized huge pages.
+collapses sequences of basic pages into huge pages.
 
 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
 interface and using madvise(2) and prctl(2) system calls.
@@ -144,6 +144,13 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
 sizes, the kernel will select the most appropriate enabled size for a
 given allocation.
 
+khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size to
+determine collapses. When using mTHPs its recommended to set max_ptes_none low.
+Ideally less than HPAGE_PMD_NR / 2 (255 on 4k page size). This will prevent
+undesired "creep" behavior that leads to continuously collapsing to a larger
+mTHP size. max_ptes_shared and max_ptes_swap have no effect when collapsing to a
+mTHP, and mTHP collapse will fail on shared or swapped out pages.
+
 It's also possible to limit defrag efforts in the VM to generate
 anonymous hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
-- 
2.48.1

