Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741EC20E6E2;
	Tue,  8 Jul 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966552; cv=none; b=HSRVDMWBKK5M1Mb32E0J3bCCjrdqkqa5lSxhHBxo9GfrNdc8umfrNjjN58ttrn3h+LzxbXtbhzJNTfzqeZZt9tWpdM0jwSSNtde8VNli3T9RNIM9SNbr8wIRcfAi/LNodbbzIgEp8kzjMiOzxDiaY2FS/QaI99+V9qsw2LvZy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966552; c=relaxed/simple;
	bh=77sVB26jwnSDML95AMB5ZHnN2D1iy2E80tv3DtFH/tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8qBZkYVZfKQ6Qy9jpjX93L8yJ2sHdbWgteIu6GRzOG2Ptiqs4DeEq9DxPI6r4g/VGQsJakxdGLUAVPDWsJZ9tkni7aEbGdJLyhaDt302MVw3u45ROMmk6rrk89bpoJ3y39hlw8YzyZjyOFzBS2ebLYV1KMTznQzq6sxK0K3poQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/+YEXbF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/+YEXbF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so43854456d6.1;
        Tue, 08 Jul 2025 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751966550; x=1752571350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77sVB26jwnSDML95AMB5ZHnN2D1iy2E80tv3DtFH/tk=;
        b=i/+YEXbF7kTUAnSpqPq4cGXnGzfvrsDBpPYouPfa7MDPxAF0ZTrHjSb11TfSjlRnW9
         LkU5cyzQ0R3fMZvsseUYUVYEXQ1kbV2yMUj38pwlo0k7/P3fAWFMG2zVUglVWsc8C5gh
         QXecMtirDUFoF+mtwR3s6e4+/KTMuIZ7mlXu3GbwZxtRAoJ7wt937ZjPojFO+af1vm4f
         PTQnLSgyOoefj2vn7MymrdzH1rPuo0yUN7WBX8R27wSqgyO7v5WPpyiUAxhJqaGn+yMD
         rOJINutjvUSlD9PMD+ac9M+6tjXuhazaqGoFfGJELDT48hNULOu36pza6OgdU45hi3RG
         RnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966550; x=1752571350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77sVB26jwnSDML95AMB5ZHnN2D1iy2E80tv3DtFH/tk=;
        b=lJQ70RT5kY5KouPR1QzMIxh1OOsEZt2gZag7odTgv+OHQReptFz/wiY3O1gXxfSS+i
         FFAjVO+ubGHbW++XyzjWVw13hLy2zauybCu6oFJadpkSlDVO5A7H4n/1lMafq4h3rnbN
         T/0bc8pn2mtaQVBv6e2Xvd+0d2MvcVonWyBlw89myLAjmKizo+vyQjuSsa90ioANIEK7
         oLTeeSpvtyMKW6VEIa0LwS2eE4uMQ3HVOJse+OYwn2wASY7OLu2ceXDcnKK0lktZ2iDt
         7dq1AnfZBrDoJv9xS4wqp5emHn2wcUXxC8Vryzd+uOEqJwbEO5eiL07+44vIC9ZrKHht
         W5XA==
X-Forwarded-Encrypted: i=1; AJvYcCWgF2M0lkLGjvG9uGFcmHP8Q2PDSBcb7xdC+Zr0YUHTZYYe+7fBTqhl2NoBkCuy7Rg5kIqlaw4w2JoEA5c=@vger.kernel.org, AJvYcCXxY0qadV1IpGn6aJJSt3UbD3+0/dFqxjepe6UkTbHMTf7ZAM8RA98vIJPXbggWX7KnSpQGcSNlo4ae1oqMfHDg0w+J@vger.kernel.org
X-Gm-Message-State: AOJu0YxMF0mxidW+EV1M943GDd7BRC/AR2i6lpUUf9AmH6Tc1j2pUc5c
	5wTJXdtcom7BC3EdjBD5fCHnFJwEv0XdFd98AuZnPsl1y9pvbuO8Rtl7
X-Gm-Gg: ASbGncu0kqGFmf6XsCLH3sUiJ6S4PrnDLLyPs6QCRhbyH/AQke33x/b7usbkXhZXK6V
	HCfAmuW9+3pLaGsxFYguAnog1ujY77J/ciVNaxmSynt8nLZoumdhuIdW46gwoFu/DCURdBT++Gx
	t7N2ikJYQ0iCetEJFrc/lmzQiqqp2+IpAm0PhBRSONS65KxHq5Zpt0dnZ+Qso1Y6j6NCMc/ACVL
	dZl1ChRS3S/gDw5nXYpaEsZJCDw1UAQEjlJ5X2g8GjU2qcsIjPHVCZUD1dRYZ6NruAgQpqSQba5
	SHmj0BvJA4ikFJ4r9cyUQaeo4VcKj8Wx9Wpln5pIr/3cK+xL4+/dze/F8iKIkmlOz/tCFuNYUyl
	dNoxQ2w==
X-Google-Smtp-Source: AGHT+IHSRzfQIdbKo7DAP1+iZkydKoM5NXdbUrrSwPBS8gomxfUQmwQgpncvTRLwCoXrDZEWMDyFcw==
X-Received: by 2002:a05:6214:54c2:b0:6e8:9dfa:d932 with SMTP id 6a1803df08f44-7047d95a8ebmr32687226d6.15.1751966550311;
        Tue, 08 Jul 2025 02:22:30 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d9f590f256sm112284385a.109.2025.07.08.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:22:29 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools: bootconfig:  Regex brackets need escape
Date: Tue,  8 Jul 2025 14:46:08 +0530
Message-ID: <20250708092204.1558-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was showing malformed syntax colors below those lines,escaping the posix
class brackets bring back the syntatic reference back.

Oh, malformed syntax colors means,(in a editor,in this case Vim, where syntax
highlight is on). In essence, it might complain while running the script.

Hence, this trivialities.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/bootconfig/test-bootconfig.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243f5..211409539737 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -167,8 +167,8 @@ echo > $INITRD

 xpass $BOOTCONF -a $TEMPCONF $INITRD
 $BOOTCONF $INITRD > $OUTFILE
-xfail grep -q val[[:space:]] $OUTFILE
-xpass grep -q val2[[:space:]] $OUTFILE
+xfail grep -q val\[\[:space:\]\] $OUTFILE
+xpass grep -q val2\[\[:space:\]\] $OUTFILE

 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
--
2.49.0

