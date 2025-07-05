Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FE43159;
	Sat,  5 Jul 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751728588; cv=none; b=MaRpufC3CwuIuH7pAvfxkqDbN9fy7nv6OfTNW5gQx00BYjsfBBuxtzrqyMwpe6JMqILGbUD21DsTwcWdzNESQUMa+lcIEf8Lr1TYSOe32+62l8YiCzFUuVES6z/SmVFQ7J92YlSUETrKx1fdiMtyE5wWcrmK251EFZsfrnHzuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751728588; c=relaxed/simple;
	bh=IVbkd/IVrWWUlEr5Nl9gyhToDCubslv31uTR8EVwGyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdOf+MoxdjAPGLmpEna9MTzD6jO9TGzspUbOQN4xe7WKqGyHpeXSjNt3Q9HHf3k0uG0Lv1XWr7qFuXBRlEi1qStqZ0v7uMSl36Gmpz8bmHNuV9Tg0GooWEGVGi3ZmkdFRSd80tDMXlPMh4H8/W7zMuSyO338sptAuvyJauTrM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1AVvgxR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1AVvgxR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b9dfb842so15144495ad.1;
        Sat, 05 Jul 2025 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751728586; x=1752333386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppkGylIpL3e5C3TVURbfkBpVr8RCQTzH0w7GOalefMw=;
        b=U1AVvgxRr/Hx3pkcc1t9q21+qmypQ5kLXm8AjrmwJI/unmmV5nJyti4LTf25pBtGQi
         co9GOLDcB3EftC3NviKJGTmutfZXCyJ9MjotKcyS7tpz+V0n6o71wRhbfUgGPxhydfNi
         Yam9mzTgaDQfaprpQV8Np5YxswVcuduvGx46aJahVM6+MAYUW7UC+ytdfsRUEotgSuGU
         sZFi7DebWP0jXggEMKPcBv5LWRDnjfxWpfrNIZwpDCbuw6CG8ShyNi2frkc1OsFfA5nV
         ZUidGpfeE9r7QymzhjV9gsvz+fReHZ88RNdJURSEIoGSiGfZsXIZ9baAx8NkJmPHsSXj
         s0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751728586; x=1752333386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppkGylIpL3e5C3TVURbfkBpVr8RCQTzH0w7GOalefMw=;
        b=QKapVNVlAfHkDL9slsyibFXzaSLlcXtuMhKh0i726UoHDUzIVsPcTtSF86A1BHvXwZ
         LgXLxAxk7OxS9m4VwsWjs9iABJJ+psvb/xkrIKpdVsOWnq/BzwlVVgzg6Hmh7AHyjwuN
         72l8lzO/SWWFDR2Kz+GRDiCzObQJdoFN1Bi20BhEv34ZOa9rFUURyNC1iqb5AcVZRgb2
         2WYqepFGnX7CVCb0AKPJbSCkumHXYcBj05M3V4zITGfErAtFI/Kh/rv2lIYGt8tOvUzQ
         U0YrKfpwXZbs2h/D4wbtpuuz92WWuuuU0clUhbg64yNWawm6n1DWCFRAEIgb8bkUN3DS
         0HTA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Fpm9pacN+Et7Z24cmUrwpZm/+PN9OinPoGXIS/dROl+qQxmhMpnpb15q5yBevrBPZExCtKF2zXut6ptTJu4qvaj1@vger.kernel.org, AJvYcCVBBNi0mplFmsqE/kbiMEgWS3yfFls9OoSG1i4a3ElDbqQzWA2w56TKXJm0fiwkGqiOpzLjQ83M8kgZpbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQG1hNaVAHeDOQtbCho65na70fnmdfumnLWhqmb9xpIv+GqJiP
	067LDYOLAozTnZEM79SAIPzQNOdHDt6V2RcIk30E7lnKk8WyzADgcVjaedyXKOGvTkU=
X-Gm-Gg: ASbGncva/aYB9cAxCECHscaz6v3iUvnH5ztgY+wEKjJhigfQHsQLsVe0ejOeXriuxZO
	ALasJ0odvC/csfsnic/cn83U/Mtd22n1SsPTXMn7YUeVI025pkwo67D6/jis+VfDBYfAXY63T+O
	COcjuZqE3GMv6vp9TfWb5WtXxWxFqf7mfRAPbBUZ+v0uzGBvuoyucUsEnLb789ofV4OqbwiIVwA
	f0T2Fa2RYBnCKw12gy6T7veNiUH5K5xdHORP9bcogXWn8VCqP18522g7kMiPAQouRnb2myELJ7A
	QnC/jDhMdmrptJMD9iKmkndS4wJHCcTQCP3ogfQv70hB8rQLyjDmW+pBJi6sOArpzwKQPBVksrZ
	v
X-Google-Smtp-Source: AGHT+IENTRwP9/XEq552vcsWILcUg7zV7ZKO0TjnKhOOgaoX4RsFlYOE2TspM2LWSIIQ4x3wJKNKKQ==
X-Received: by 2002:a17:902:f609:b0:234:98eb:8eda with SMTP id d9443c01a7336-23c8755bdeemr102662375ad.28.1751728586446;
        Sat, 05 Jul 2025 08:16:26 -0700 (PDT)
Received: from gmail.com ([2402:e280:3e9b:22f:a1d5:dc5b:40df:a106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845b962asm43463035ad.237.2025.07.05.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 08:16:26 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: mhiramat@kernel.org,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] Documentation: Remove duplicate word size in bootconfig
Date: Sat,  5 Jul 2025 20:46:17 +0530
Message-ID: <20250705151618.4806-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate word size in bootconfig.rst

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 Documentation/admin-guide/bootconfig.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 91339efdcb54..7a86042c9b6d 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -265,7 +265,7 @@ The final kernel cmdline will be the following::
 Config File Limitation
 ======================
 
-Currently the maximum config size size is 32KB and the total key-words (not
+Currently the maximum config size is 32KB and the total key-words (not
 key-value entries) must be under 1024 nodes.
 Note: this is not the number of entries but nodes, an entry must consume
 more than 2 nodes (a key-word and a value). So theoretically, it will be
-- 
2.43.0

