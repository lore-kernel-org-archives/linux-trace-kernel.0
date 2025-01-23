Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F613212A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642252; cv=none; b=rAVhtYMr6zjBRPs9cfuwCYxZpxZuLNbsciPGxrpyTxXyXHgob5S5bmhc9Kb5vI0+13+sl8xKJD45KIlgZxghgk+LPSyFXxJhssOJlhviNcJsoWBN6DQ0ojDX7+xe5LXuhjOVV7nvbRh8t1AzFX6WJToXtkIDFJKkujOw+MUx5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642252; c=relaxed/simple;
	bh=II5Eyae/nKkkX+C983iDGseqUUCfhcO2krxnXtRDn+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1YFT+60oyQJHbde5L1rhAFzyHNCWeDBLkMBpReeYtL8zQIw4LAS61LvHnScq1FtVwuxOPW+Vt1flILJINN0yUFo/iO54/Pb3A4DfUZZNzmQ+EBels+9yQiv9k2zYRANWOGYJcKTDVvC7sC8TpyHryFIVLlp5hv8uprwVTvw2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idupXs3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idupXs3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aty2gSuUnc20xeIO+5CFJZ09E99w1W0djcl+iae3VLk=;
	b=idupXs3m1WqDt2uso0D9SEo2IMp7mfFyhO/gfV6X9JvqbHzVJNPowmYyGJizlAPqp9tPKG
	7leHPt5TKksUzP1HlLufuHfMpwGUvO5Ds6oOEaMXTSjQaTgfEk6EvH7kZTlpqnim6aY1Dl
	uh32YI6PoN3IdcInPpC0JfnrrYtctBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-CJcCc9E6PICU-R62_bgGUg-1; Thu,
 23 Jan 2025 09:24:05 -0500
X-MC-Unique: CJcCc9E6PICU-R62_bgGUg-1
X-Mimecast-MFC-AGG-ID: CJcCc9E6PICU-R62_bgGUg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 432C61955F30;
	Thu, 23 Jan 2025 14:24:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7D4C195608A;
	Thu, 23 Jan 2025 14:24:01 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/4] rtla: Collect and print number of missed events
Date: Thu, 23 Jan 2025 15:23:35 +0100
Message-ID: <20250123142339.990300-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Due to tracefs buffer overflow, it can happen that rtla misses events,
making the tracing results inaccurate.

Count both the number of missed events and the total number of processed
events, and display missed events as well as their percentage. The numbers
are displayed for both osnoise and timerlat, even though for the earlier,
missed events are generally not expected.

For hist, the number is displayed at the end of the run; for top, it is
displayed on each printing of the top table.

Note: In the future, rtla might transition to using ftrace histogram
triggers to collect data. In that case, this code will be removed;
nevertheless, it is necessary until that happens.

Tomas Glozar (4):
  rtla: Count missed trace events
  rtla: Count all processed events
  rtla: Add function to report missed events
  rtla: Report missed event count

 tools/tracing/rtla/src/osnoise.c       | 20 ++++++++++++++
 tools/tracing/rtla/src/osnoise.h       |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  |  1 +
 tools/tracing/rtla/src/osnoise_top.c   |  1 +
 tools/tracing/rtla/src/timerlat_hist.c |  1 +
 tools/tracing/rtla/src/timerlat_top.c  |  1 +
 tools/tracing/rtla/src/trace.c         | 38 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h         |  2 ++
 8 files changed, 65 insertions(+)

-- 
2.48.1

