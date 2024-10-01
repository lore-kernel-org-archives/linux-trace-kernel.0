Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34D1C1733
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792696; cv=none; b=rtmCkwxdiA3+j9TUUXHajim+W7Y6aZDHRxinw+ONDXs+SLPd5AaodL8Apq5xckotzTsB+Xpw2Hc4l8YGQEq+QrMfhEgLe04WQFf32baqsjBexMQmphuf/aq/u273hqaF1XCz+4+6snjmW7T0kUe9quVj2p06TWGkkn5H25iMrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792696; c=relaxed/simple;
	bh=GhELIXQEnLOmvW3++pNEmKV/qOEcq0CL1OoAkU/AQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oMpmprWwKJn3p2e9v3v43AZutdEig3rj4nI3kNs35SiFHPHhfoY5CAQY2zPEpqe01Vfa3DksZ1DmoLS/W7hUSBzhGNocpAd40Wqr4rg/YT2co611Xknj3QyjvSVPMOWTQsWXvZvd3Dqy/irPdu7hCRwX1lEd/hYHs3Q4+qi5Gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKeYTFvl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKeYTFvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727792693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YMo3yy8PMkJte30wHnko3dY0ReElk0bDYgkXeRTFMzo=;
	b=ZKeYTFvlfK14b940cQvwS0szLcJ/2QSYT4dVCm4y0nkA8RjzlE3ThvPDbsoOpVoN+LrkdG
	Zc3tI1a2vL0aU2KAVYmB6gyjUZQYn17LJ07muXFZvXo4MhOEbWNfgH4dYDBA86oI1YiGFJ
	N9rlD1u1RjSwEEmME6LavUq/98RYF/A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-nnMdWSITOZ-Hll4tghcaJA-1; Tue,
 01 Oct 2024 10:24:50 -0400
X-MC-Unique: nnMdWSITOZ-Hll4tghcaJA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 347B41944CFE;
	Tue,  1 Oct 2024 14:24:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 89C9818B8F6C;
	Tue,  1 Oct 2024 14:24:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 16:24:26 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:24:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] uprobes: kill xol_area->slot_count
Message-ID: <20241001142416.GA13599@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,

On top of

	[PATCH 0/7] uprobes: deuglify xol_get_insn_slot/xol_free_insn_slot paths
	https://lore.kernel.org/all/20240929144201.GA9429@redhat.com/

To me this change looks like a simplification, but perhaps it can
also be considered as optimization.

Yes, in the contended case xol_get_slot_nr() will be called twice,
the second time after prepare_to_wait_event(), but I don't think it
can hurt in the slow path when the caller is likely going to sleep.

Oleg.
---

 kernel/events/uprobes.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

