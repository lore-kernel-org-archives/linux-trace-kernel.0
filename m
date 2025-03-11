Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970132566FA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695363; cv=none; b=QnQ35YVJA0letfYAmVaCMzvhrkdYvIg1y7pF8vsYBk+oK+h/cS+TCG63IT5q3scSpf9lsRTKQ6Ep/q+nfu2V7YDkUc+QIoQdUpIM9/BKb1ZVU0PCKg1QBhQW23oolrAqhYUMZpMqLaeHOcu8R+g/ingWph/7V1n6bhMWQZDeRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695363; c=relaxed/simple;
	bh=JmYUzDvAxPGj4zbO2i1wDLyR5cCoRXGD9vm51/Rv110=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAvHpit6Rj1jWCnQeJhJnUhzQIlmQRY26G0vR5m9OKP0bsYUw7UHQ6SM8JqOPCi4unsK9P9c289ro0u8uJ3J0+YEKwKHGokwCZZUn4EYAzDvv/XOhmXEmCtWKMLDWAmtvgpGyU5NDf5u6XXxGgomnnjUqePOWOoli+s4NSt+D3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA/A2BMx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA/A2BMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L66ODmBs+dCHgrMRGT2Pjz0+6wIG2q2DYOyUrGumZ1k=;
	b=IA/A2BMxJcQX0aDo2+980d2g3y2Njn12cH9RC3JAIaMusgyJ/WpMT4hdfSEI5C2nTKDJM3
	KCoeLtDGLXZNyBiV1FDHhaxJOr86Ln2+2jyoqpRhLemSScEnd3XvTyXF1mSlXIC8bn05Ro
	GtKm07cSuJR4fqHfSmfb/LTqkr1c2EM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-F4Pfz6OmP5CPe6M57fyX2g-1; Tue,
 11 Mar 2025 08:15:57 -0400
X-MC-Unique: F4Pfz6OmP5CPe6M57fyX2g-1
X-Mimecast-MFC-AGG-ID: F4Pfz6OmP5CPe6M57fyX2g_1741695355
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87EDE1828A80;
	Tue, 11 Mar 2025 12:15:55 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEBD01800944;
	Tue, 11 Mar 2025 12:15:52 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/4] Documentation/rtla: Cover BPF sample collection
Date: Tue, 11 Mar 2025 12:49:32 +0100
Message-ID: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is a follow-up to the BPF sample collection patchset [1],
documenting both the feature's build requirements in the readme and
the feature itself in the manpages.

A few fixes affecting the same manpages are also included in
the patchset.

[1] https://lore.kernel.org/linux-trace-kernel/20250218145859.27762-1-tglozar@redhat.com/T/#u

Tomas Glozar (4):
  Documentation/rtla: Fix duplicate text about timerlat tracer
  Documentation/rtla: Fix typo in rtla-timerlat.rst
  Documentation/rtla: Fix typo in common_timerlat_description.rst
  Documentation/rtla: Include BPF sample collection

 .../tools/rtla/common_timerlat_description.rst         | 10 +++++++++-
 Documentation/tools/rtla/rtla-timerlat.rst             |  9 +++------
 tools/tracing/rtla/README.txt                          |  7 +++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.48.1

