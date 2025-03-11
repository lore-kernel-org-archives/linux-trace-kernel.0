Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4F241682
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695366; cv=none; b=IE7iv5Gb1GOEgGL32cxxiPdPARf6ppWiA4r9L/tVP68ZJk2rrco8B+QgtQruPGvOpEnlk03yINjJM43MnD5BsVIYZ8G9KLd3d/u4xcr3k5DUTsKRoV0FylylEel7lr/WKCuDFOG3vxyvJxBSL+zpuJZakFTCWpcZ2akJXKGn/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695366; c=relaxed/simple;
	bh=g/7/Pp470FP6TgvwycWV0eB4gqoj4CMPEawr7QEOXdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb0OvzWiLSsQOH2RI4RuwaazG+Lg453JkWRVt66pGwjNz4aul/sFSrhjHXMa8vqeytjzz8v8whgvk+KotAs0OVxgsSUlxHKmX0GIgCkhpi2YO7NjC8QHJC5HHu0xLkRvLaam9adffgPjiuSR8VXQUU61HSx5GY00kOdwL5AoInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+zW7n8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+zW7n8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q00eFPM3hzXmp5e1a+Kka7caZYWvITiN2SgftwFNp7I=;
	b=J+zW7n8wjvOo7XbqWOYVstqJ+mzuVkp5Zj2L5H5wrqR+FTf0/0rGGQ3XDoJ5lb7stYYCN+
	Wl02ioxcvxsDSX1CD76uPu/OYizL30Bw5qyF1CGkLZFME3S1jP3NdoxUjnUhYFWMb3aEDl
	0oHxjbJLCed93hPhXwGH8gNhJcnnsH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-SFvWvBGfO_OUsVZznUwA0A-1; Tue,
 11 Mar 2025 08:16:02 -0400
X-MC-Unique: SFvWvBGfO_OUsVZznUwA0A-1
X-Mimecast-MFC-AGG-ID: SFvWvBGfO_OUsVZznUwA0A_1741695361
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171E7180035C;
	Tue, 11 Mar 2025 12:16:01 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B46B71801751;
	Tue, 11 Mar 2025 12:15:58 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/4] Documentation/rtla: Fix typo in rtla-timerlat.rst
Date: Tue, 11 Mar 2025 12:49:34 +0100
Message-ID: <20250311114936.148012-3-tglozar@redhat.com>
In-Reply-To: <20250311114936.148012-1-tglozar@redhat.com>
References: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The file says "rtla hist hist mode" instead of "rtla timerlat hist
mode".

Fix the typo.

Fixes: 29380d4055e5 ("rtla: Add rtla timerlat documentation")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/rtla-timerlat.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index b334fb00ba0e..20e2d259467f 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -17,9 +17,9 @@ DESCRIPTION
 .. include:: common_timerlat_description.rst
 
 The **rtla timerlat top** mode displays a summary of the periodic output
-from the *timerlat* tracer. The **rtla hist hist** mode displays a histogram
-of each tracer event occurrence. For further details, please refer to the
-respective man page.
+from the *timerlat* tracer. The **rtla timerlat hist** mode displays
+a histogram of each tracer event occurrence. For further details, please
+refer to the respective man page.
 
 MODES
 =====
-- 
2.48.1

