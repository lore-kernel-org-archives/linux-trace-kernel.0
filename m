Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F42E571
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Feb 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771161182; cv=none; b=vFQauoaybDd/QsKZQIWTsNszHlOXuC4yRRjRcTAO/I1k9cle7DHSk2xSK8cZp3NAFM0JrxSiGcKnyto8u9beAo3hwUL6ov07IZzGf4OV6ZOAuVXdKvKEScmd8SB3PqMrud57lSPQmu/kA1h2BiO/WH4IyuezJwZ5y0Mlwl87spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771161182; c=relaxed/simple;
	bh=tt7bxtfArP/l+PAgE09PHLMdbFWOizBIi5oEMs3SJJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tv/LqtK3Ab4y2QXY6ZFSYM7UWJQSg7o27f86O5pKvDGb5oZ0bPIWk1IFvdo5oQEsntmgbfOts3Va7sKaExOtRzn0brl7ElkzkxXbmczmAxQeTFlzWaEUqzHLkG3fO0FwQRlQ6bt0Q2xN/4dykyWb6Ck4960w/mAx5fbUT5l9qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ii5kFSJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii5kFSJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771161179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hh0PgHLJOA2hn/hqzD3P6Oh9Wnz9BFXmuLgfZVc7phE=;
	b=ii5kFSJ0mccAl4GV4WuiWVqxyERZSuYM66gD6mdBigAmVby86t9bwt0n6GmwySpjQzl/Qr
	bKX8iEFzzpETWQwOy+OaSpFGmWOXxJMHu6kNjwRw0CgqPCiZSRqqva5/cdY9s00kuVc6NW
	FEFO3cCerIU80EjNh1yAbtpI6qg1QkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ri_alb6-NE-Ow_WTXhcNPA-1; Sun, 15 Feb 2026 08:12:58 -0500
X-MC-Unique: Ri_alb6-NE-Ow_WTXhcNPA-1
X-Mimecast-MFC-AGG-ID: Ri_alb6-NE-Ow_WTXhcNPA_1771161177
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso16125065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Feb 2026 05:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771161177; x=1771765977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh0PgHLJOA2hn/hqzD3P6Oh9Wnz9BFXmuLgfZVc7phE=;
        b=KBJ9VjS7KCXn59mmNx2Z9BgG28zdd/AL86+GJfgsy9dfDpondOAgiTSMMUQBFyNNXr
         VeIo1g6t2/qVHnePMyz0SShVIWjBSpA/iUdan5jKcSWTL5eWE2R6kab7W8t6n4eNtclV
         FOUEnrC5m1vrsfyzpKNNxxGfbkvyYhkivPVQTQXkbll4XemiXpfPbPOWhVBD+leMGd3k
         EPImmDpze/Q+Jv7oqVQ+0vCEeC2k++8Uwr2fbkQV1iE7sKDB2M735Kj3RMSmZRPmHYNZ
         okzS/c+LZPd2DfkLG1JmI+F5Pvm0KMjGxKc9j7uR0bZPOv4na1GVaP8WTVmLT0DdT7JM
         RzDg==
X-Forwarded-Encrypted: i=1; AJvYcCW6N9MUcTl09mu8g7PgiqwYwU+Vl14qMWeFeNkypFlQpj47zVQDirmIhT+InKYi2vvL8PFMEGpVw2Amu76GCkyu49U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlZkfD22jVbWvEmaXB1QAndSdvCs8rrrlrxHKDAOp2gnnj8Nw
	1WMdiXvaJfSmNrh1fzr5x0QM7JgimZX3SS+G5aqEtniCqKNoXQ8Md2eBFvn368x/scxDmNL72Sn
	5MD3OiyXEhbgkVriaXS6inisgsRuc3T17+FrBFKnqRn+6OXXt1I1O3effpqRCXWJmwiAnIFmeug
	==
X-Gm-Gg: AZuq6aLPGTfbWJ0B4aAzrlmaWaKkf673Y+045AA9/eZkQMyV9QJHwUIyPJlz5eJ2zKK
	wFJfOg/1Qi+/vsHDigEnPIvRmt7jF6RA3GwxNefOfADANZ4S8szNpMfBlCKBB5ECdlts4GOLA0a
	x9XwCDSUmOJncEZPoFsMKcjtyPqlDGZ6xMM/mCY4EHieLyhPiuWrMGZU2dS9CCezBu4QkPS4Ex/
	K+HV1ItZW6cGnGu7BcsZhHA/HnS1HWxYFtAW91L4E3zhEXw5+v5CTPj8tfX/M43yEQwAwpJjvHd
	E/CjaBU3ozPEFmf/T8RP8iHoZmHv+RTSzDsi8iWwfq/oHsuUwYu/4LUKRSLW3h3F9DQyUI7D3I8
	DM0exrKW0p9Q/naUtuEZTw0YjwWYmrZ85TZ/txQ==
X-Received: by 2002:a05:600c:4688:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-48373a37a1dmr111168425e9.19.1771161176938;
        Sun, 15 Feb 2026 05:12:56 -0800 (PST)
X-Received: by 2002:a05:600c:4688:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-48373a37a1dmr111168135e9.19.1771161176500;
        Sun, 15 Feb 2026 05:12:56 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm515148295e9.0.2026.02.15.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:12:56 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] Documentation/rtla: Add hwnoise to main page
Date: Sun, 15 Feb 2026 15:12:48 +0200
Message-ID: <20260215131249.33437-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8S5ccwRkVSq9EoNtGPQ1mKNmEB_kVvx_T5X16ykrgiU_1771161177
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add hwnoise to the command list and SEE ALSO section.  The command list
is ordered from low level to high level.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/tools/rtla/rtla.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
index 2a5fb7004ad4..6df1296b8cc1 100644
--- a/Documentation/tools/rtla/rtla.rst
+++ b/Documentation/tools/rtla/rtla.rst
@@ -21,6 +21,10 @@ results.
 
 COMMANDS
 ========
+**hwnoise**
+
+        Detect and quantify hardware-related noise.
+
 **osnoise**
 
         Gives information about the operating system noise (osnoise).
@@ -39,7 +43,7 @@ For other options, see the man page for the corresponding command.
 
 SEE ALSO
 ========
-**rtla-osnoise**\(1), **rtla-timerlat**\(1)
+**rtla-hwnoise**\(1), **rtla-osnoise**\(1), **rtla-timerlat**\(1)
 
 AUTHOR
 ======
-- 
2.53.0

