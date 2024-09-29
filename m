Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5B17BED6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620948; cv=none; b=QIb2rqZtcNYnVs5LwdEVXHSyidRHFrZ0L3qsOeFFiFRyJ5fyrRMDbpZ0x35ON4dM4KJSXNoTAejaV5mtvmylR7FK5WN3P8YTTp3QFJ+vSZkHBMvNSShnUN7nQN+H/c5vXdSHgMivJh6FXfvWbcVYmbq4m8c9jH0azM1MmAPY1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620948; c=relaxed/simple;
	bh=YatX/cZk2OijMoQ5PN15nFDx9HccMY1rvaaBj2LpHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hwiz8ceEu0lPEG2q0T91F0VdKEtRm4+hasUNWoNCurae4zlS9pRHIB6iPFCYfMsJEFIpUYt8vTLxlO83x8241qa54Hwai4BWcuhmBWVqhlECcMcH1fGMxUNXTXBQFdpWu1hCR6HGGbAckai0iyRBPskaYSw9svaATCzOyAz9uYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FU9G4knK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU9G4knK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YatX/cZk2OijMoQ5PN15nFDx9HccMY1rvaaBj2LpHoI=;
	b=FU9G4knKc1ByNXxBISYkhsxrrRsybciiVFbjSpaEEgmpW4nq/ZWYBCrXJEX2aH/WRcHXN0
	Ct4DRhKiliawxP4Z0Rgah1XC3eW/IxsuaurDHA9d7Jb5+36NuvNvnBTiLnqza18xATBbPn
	lPqHq4CpbDpEyy7JJTxaXY4i2hiWJ3Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-JUdHGhsPMoWHFXMnOnuLzQ-1; Sun,
 29 Sep 2024 10:42:20 -0400
X-MC-Unique: JUdHGhsPMoWHFXMnOnuLzQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E853190ECE8;
	Sun, 29 Sep 2024 14:42:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 113671944B22;
	Sun, 29 Sep 2024 14:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:05 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/7] uprobes: deuglify xol_get_insn_slot/xol_free_insn_slot
 paths
Message-ID: <20240929144201.GA9429@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

No functional changes, please review.

I'd like to push these cleanups first, then I'll send some optimizations
on top of this series.

Oleg.
---

 kernel/events/uprobes.c | 111 ++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 74 deletions(-)

