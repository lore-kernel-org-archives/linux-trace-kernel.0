Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1332749C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606170; cv=none; b=M2gXeoFSynnX6e6nk2SJepk2bEJQakusPvZKMtntsDrMTMtMH4p/afviVORSM7QbXbeR0R0nwX2j63ux+/GpljnOYdAVth3qUQsPDv+6hICQbRIdHrNMVMpVanrdgUCqKMmAWqrxGwD/ckoBzzAPsKzcMmuBgpNg+S7DQvJ2w00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606170; c=relaxed/simple;
	bh=O3pRTqAsEvq1Kiu3DV7vi6sTaJN6oFC49nxk6BngQKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=UrBPzhRhlkCcvZj6gqN3GjQJaVN++lejy2Sq+eXf2njyyOa/ugFcUgCfL1+Phnp1yKX8FQeLOPY83VbEhecaKcqbVgeBdimD4EMD4vjkc2mq5NIGSEt1Mi+UDiZ4JDcjXGImmZaih+RjhDsx6jtcFNte5Qwh40DNqVuGjU9EuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8ESOAi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8ESOAi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787606167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+rR79cVlL8/j1KMYwztFsQXtdGXL1SqDEdDOUZN3juA=;
	b=F8ESOAi6Fc3YP72tA6ZMI30Tg9lVWEuKU5gVTtiWOpOZpyVyKncRZhHr0ZNbB5H7UA9zoQ
	Pv2Mqx89MuXsGgeiOST75X5m0BpARwRe0pYYWtG0bQGboufp3K1jizihZFGjIfcdyrwPPa
	sUXKot4xTUMNXO79NEfKDYBcoCkKOCw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-IOvYD_k_NeGcWAk98_4dQw-1; Mon, 24 Aug 2026 17:16:06 -0400
X-MC-Unique: IOvYD_k_NeGcWAk98_4dQw-1
X-Mimecast-MFC-AGG-ID: IOvYD_k_NeGcWAk98_4dQw_1787606166
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90c8da50f8dso53418626d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606166; x=1788210966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+rR79cVlL8/j1KMYwztFsQXtdGXL1SqDEdDOUZN3juA=;
        b=Y3cv1KoYdnRo0V5jNHM32qzDYDbLPY/DFb6Npfchpowm/mwZL7lnTaZJMvwTrbG0k0
         3oEwxy/81S287Hpq48Uwb9rpoEODcb5Hrp3V1bgPTzpIZXfCxYod7ssBpeYSUA/gT85p
         MYL2NRYRLXmg0t16SMCRdIDCGueKKqMdEKxj6lWY+NlvCOmxj++2yqbgfKd1M+uU0MLg
         /qcTAaIKqIRyhzr+c3RwyydNQ5hWnSEnmpSwocd+ceeLMq/kam6lQSMdDu7aghM+UCwv
         rUE6ndrj7XzcAuOwzxAXsLVwc1NcZ9BOhVJnKXagLWjLKz0r6nhPC6MXXzmLvtGaZVeV
         Q6vg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/x/XneO1QZbmc+EvNQVPLkUxUV+7U00bT0TVWRTUX5QozAHXk1MIisyNp5S61ZPHNnhTWYiJBn+0Ea0Oc+MgPNSc=@vger.kernel.org
X-Gm-Message-State: AFuF++lDmiSYsxDjGosKRGyBNicpWqTnCsyDLP+W1uzYhgBToKIZ4a8S
	6wTq9owLBH8EF8inSX4MIpolwnxlFhiyGcfisbdH+/AvYx3RcTt0hlsh0mJGBDbprRzmDEQfVH5
	Ruy5BlGOWTXWtYTUhsUjpSt4SwivQQyMv0e6p+pcyPXmolv1AjoBjJPZX6GI5jc4ydbf5EgX9sQ
	==
X-Gm-Gg: AR+sD13UxpEmOLdgN9PWVvxkIsN+mk/oLliMetSuLGMoxPKzde92aoRqlDaNfvQ36kS
	6DWfBAoaA0uZryxCaWt4QNip8g81KYc6sMKtc5BF4lmVBM6xo7ktgedXoYxnCBPmp5Q6+nEWV2K
	UJL89ewsRdvCijUgFcmzpBGSnMWxmK18geUKE8a0z3L0Y3FjSvzHc4z2X+CcAtyDEzysWGGKYUE
	lT/6rPOhiXpjU4Pck9oq4pwE7QMRMmEvLqae/xZcqkHkEKlI7djJUqmhwREdPHR5hN/2VqevDNd
	b9JLFIz3fpmH/EGmBdAlxpGpyjhcICXRAerSbZUlbO/9lOKx1LNz1b62NjT1Z3imGp5AzfX0VaS
	U9/WE8vK8+qSUcMxV1yMzyD6QRSvIUmtg
X-Received: by 2002:a05:6214:5885:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-90c8f90bdc9mr253444276d6.7.1787606165786;
        Mon, 24 Aug 2026 14:16:05 -0700 (PDT)
X-Received: by 2002:a05:6214:5885:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-90c8f90bdc9mr253443846d6.7.1787606165352;
        Mon, 24 Aug 2026 14:16:05 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93931452sm71832556d6.26.2026.08.24.14.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:16:03 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 0/4] tracing/osnoise: Synchronization fixes
Date: Mon, 24 Aug 2026 16:15:40 -0500
Message-ID: <20260824211544.3984835-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ns6PC6s6utjuLJDS5qzpnaCDTvtXa5uWz_htPUqwWGs_1787606166
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

Crystal Wood (4):
  tracing/osnoise: Per-cpu mutex and fd detachment
  tracing/osnoise: timerlat_main: Disable migration before per-cpu
    access
  tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
  tracing/osnoise: Take trace_types_lock in timerlat_fd_open

 kernel/trace/trace_osnoise.c | 274 +++++++++++++++++++++--------------
 1 file changed, 166 insertions(+), 108 deletions(-)

-- 
2.54.0

