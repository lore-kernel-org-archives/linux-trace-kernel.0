Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E402DF142
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799307; cv=none; b=nWeKq2gHoAe/JPA6sWVjYqYmtWzu+LuEHL/wPORvHWP2IqPVY6sPJ8uUV2LBPxjIFhyo50/UiSXruu+fUhd5QOLD9yx/ilGH9cWvO8eqkjjpeKJDyJBsoDSHGnzNatQgiFADgPXG/U67Vc0QB41BWGdPrUcdgmSRw4i0Jw2Q8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799307; c=relaxed/simple;
	bh=vGGg0uGDl0ltxwBZk0BEeqwFGZ8Y6UY0OSrJa4IGH6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=GyWWc2eTmc+8qNOqKCJb/cvPHdMTPegJk5lc3VkDxJ5UVkrh9Ex1eiwN0RjnHccoTdvirqWxTOMD8o03qLJkaJMduhQTaVlxmDXNXDuX7lwWcNaAKuzODng+0emXYZ2NxWtbdftD2KZwC+sDBNS1O9QcmxAe4LOPy5p2USih8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PworuV8S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PworuV8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789799304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Umrh+rHY2meFQ6mNO1XpviI/Hbjs4Z1ocbOmZmOd8hk=;
	b=PworuV8Sr4vGN6vDx6ccZqafhIqlhNkHMgmZatPWhWS6fnR3lC8DkH8XAzTqFTry8MYYCK
	SJsQGzaGKMlu9Wf3NZ8grdebxuzNeBcgZQKnCheSVxiApB9ajAZqDXWEj3eRCRTa8oOIv9
	UMNkr4z7rpIWoJuA39nvLNhglBMXaho=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-yOh79doUOV62F7vqjK-xdw-1; Sat, 19 Sep 2026 02:28:22 -0400
X-MC-Unique: yOh79doUOV62F7vqjK-xdw-1
X-Mimecast-MFC-AGG-ID: yOh79doUOV62F7vqjK-xdw_1789799302
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so295383585a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 23:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789799302; x=1790404102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Umrh+rHY2meFQ6mNO1XpviI/Hbjs4Z1ocbOmZmOd8hk=;
        b=Rw9GN9JkCAtNJomJSBzdN9h8qUnbRvUZArHcEjC8sVPlJyTHytDVLZpZ76ok2fz5Ps
         ejAUF/olWdnWUsPv1IQbKovTOJ083QOY1bwhRkb2eLXXa8bX4e33pgj0v3TkUJmhpLXq
         dOQYwrZbs8/cJGZNKl32+VY+YiW8DJ1z8lNfZg8stkooIiOr968CW+XlnEn36QXhhk3e
         KbdacwHnrpHav8K2910ZMVU1qWL0bw+RS9U/1l8D/4owQ2R0CvM/xkuNCfSMJhybQfbs
         AzKms4VGaHFuY1OQec91jO+oYTpZmMTe4QHH2YpwYQV2mTMaJbQIDNcqcr2HlNxMV3+2
         zxdw==
X-Forwarded-Encrypted: i=1; AKwUvBwI34DUD4b5gWPg2dSKfTwszEOdPp5+VyawrzX6tec4Iz67Wlt6VAU0ZoqBkSTV318/IBIU4ynp63jQ7g6NGICXuqM=@vger.kernel.org
X-Gm-Message-State: AFuF++nL45Qu94OHoNGrFcs2n5rxSSy6WB+FAoOXT/ZJsd1AqDsrrfBp
	mjKDSejsL7EWfIL5Un8TnZb2a1I8ZktDCQax/Nj77tVUG8NRdfveYNBWZ/OX4z6+CnVnU9jRRXj
	NHqjvcmmcHl29kvN9/zMFyiR6yBSEKLlgYK/mKBu2vczMLvgTZLpTNnyYn9d3CGnwXQ/IE+1diM
	N39z+TAQ==
X-Gm-Gg: AYBFou38IPuYkJ2csXGVuQ8eFXXrZAyGOIqGOTtf0l/lM16elkYsd7SK8XBWJVFNSW4
	hvPzDT+4K9jeFcNW9czJmz2iMWdzbqJ9eCIwWriaAbzwSCGBHAu5S6k+uuwFKINQlpyrKCrh3nn
	nDrZrB+TnAxkG8UkGnxJdgHJUZImFSBKjfQ4331eRJUKhAgBLt04Pmi3vKt4mqkJh92lV/+v7H7
	fNIh3Ozhvl5mmsXzmyWkI6lN/z1YYbxtXeqO3hg1yS+8JhsLaTqHaCHn/+rVyk7ZbTZnivipLNE
	voCaW1WVu8Ndk/8k+QyVYxEzRnv5DpTTdPFRWBRz3qOqXNAhPYT9N1Ch+jPivpAwl6U80fHA3n7
	PftAQuxidACOjiuKdGO91aYjTacGsfDZ5
X-Received: by 2002:a05:620a:a28e:10b0:93b:b4e0:1c89 with SMTP id af79cd13be357-93bf5719c5fmr18743885a.40.1789799302378;
        Fri, 18 Sep 2026 23:28:22 -0700 (PDT)
X-Received: by 2002:a05:620a:a28e:10b0:93b:b4e0:1c89 with SMTP id af79cd13be357-93bf5719c5fmr18742385a.40.1789799302020;
        Fri, 18 Sep 2026 23:28:22 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedc103e7sm120834685a.18.2026.09.18.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:28:21 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 0/3] rtla/tests: Debugging improvements
Date: Sat, 19 Sep 2026 01:27:53 -0500
Message-ID: <20260919062756.819701-1-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F4xb1VMGxzYwqSsyx6fgi211rWHgxLHmpO2avGcM4h8_1789799302
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make life easier when debugging failing tests.

Crystal Wood (3):
  rtla/tests: Use absolute path for $RTLA
  rtla/tests: Show the command line for failing tests
  rtla/tests: Add $SUBTESTS and $STOPONFAIL

 tools/tracing/rtla/tests/engine.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.54.0

