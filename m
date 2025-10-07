Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6B285CA4
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863337; cv=none; b=lbO90eMUShy2+r+7NvTDUpqpUhbqICW38ba7yz4evVIpGogqDIS+JM3eF3H0yQWbes24Hg66P3VJmYdYMHgpmliy4MZyeTvlcVKmfyq+KiPPjvT02c1WR+2o43PoqzbxoTZs8sSLEyXkfkA5KDVl89ttdRGPFhcs7J0f9G96Iu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863337; c=relaxed/simple;
	bh=KWXkMIAyDYXJL9ZYFoRhKKia2rw51cLLtwlRksRSZ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRj6vMpTPkFlDuVzoFiRxuGbwJ0vxllExP4qvlX0i3ewKuDbWewZStzfY+dbZZ+DchyF6F4L7fxWI9ZzUtaGGIyrOqJg5zvgsEMiu3VwwRqW+rB3zPKscQJS/BzFMoVKCIr02MEZE5a0LutiCftEPzQV7E7Lb/tIVPjaMs4y2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/FJqmx5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/FJqmx5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so2094618a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863335; x=1760468135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiI8ma/H7AR+p7UC+KuFxeAt/GicErH37Q1yChqPrPA=;
        b=T/FJqmx5OhgQKXHuf5oRZb0KHh4ZXA7VOkFavBchSF2pjlQAsGGknYn3r+Ws/buU7y
         uDGwCvfCoQrf5H13vZfvupS/PzhXYb6hUwauM2zuO9KFt/6X1lmDg+WiXaLKZK2YWDV7
         4R1Y0Ih/R6v/01SCfTn0uwEddsLFdtthD1+FUVVCPNKcBToAdLzOGkuYu9Vzqsh8ivp9
         qx5skZjYao8qwO6TBXgWU/5jOksNmF2OIXkduEHm5R37J1VXf7Ot9Iv7bxFOxDpoG9U0
         IgdOLghPvZfSXwq2IKETUsHHkRFvVFukBlRNRaEb7F5GqWL+prTJ94KE0CMKBgGUGOvB
         JxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863335; x=1760468135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiI8ma/H7AR+p7UC+KuFxeAt/GicErH37Q1yChqPrPA=;
        b=k1eAtBwixDddFhHX7ajQ+opEbGXEgKkpnWIFIxugUAFef6ZySK4hqQj6lKbzPvmuyE
         H9jcT9yOtqX8qx0jiwtQUcyCb7HP8IQ/qVICYNUBCex+kVJdQ0cSrwgCWsxXwy69wHCB
         Jha5TDnMd3tx3gckJeqYCtZ4fwJHCfKpMu6gTE+fEgbo4n0YvR8Qka0qbvavmG6jrqvN
         ameRalKLmOHI7L6blmpGKUL9ARGFSkWod9ctg7gVIg1rfahdziA/e+lPxlqiS4lYNnVl
         LXDrn/RFgrfHUwtmB3jobYTbiI5i0Zx3Lfh/kJXG4JlHx7N8SmlOh1BskK9/0/UNnKlm
         Fn8w==
X-Forwarded-Encrypted: i=1; AJvYcCVuQlwH35UDNPZuPxz6q4GNRHIjuF7eLy8f1zWIBdXi0mQ6CGh8IXRmtCtdxhEyPn7b8fL84/LB5AynChFD2zMoRMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+WOi5tLOfGY5W5dmJWfoBHz4dCYGAYGnZlzYD+87RB6Oy5yE
	H2+NvrtSk6ZY10/zwa7kON1P+Ns8gImMvwE6d/j+1ExxoRUls+Kzt5c/
X-Gm-Gg: ASbGnctm+DeQm/kiYbTjYSGnp+dPWSzLU/3wE/biVxTYPh7ZsJR3xjtNgUXbG2OEFkH
	wvwGZcs0/7ey72pt+aPIP7CntpckOnUQ9O+/qb5hVBLu1UXkehhqS9WRuhBPtn2j5k37aHT/Yid
	FqQExEeGugPFl6frBVhVFDSM9Z+5pq3UNIH9vLpfTYivtUPgdH0I37GGiRUG4t4LcaOKmob7JMV
	hiz48NS/FD/6tXlbM9z52HwCZyVb+ew7ac/d1A1nYMH/3lqDFJu4dtVsPPFyns+VHadwp9qhuhw
	xOsAj1Yz5X1B5v9z18/yYboDop5yBs/tZGgjXCAZEdeyIJJU0w/L+MsFXa6wZP1B4ZJ3dp4mCQi
	bAdHVHCDPDZmrIo47jwKqRG1XYdVISNlbhf5dYA++7TtdGR9DObgmCsfHxuhkPJNYkA==
X-Google-Smtp-Source: AGHT+IG2yzS46KJ17xC1D58qrOL2bjUkWL0tVGQSAERrzK3lQkukSFgqqZhPfcQE1JCH0nzmhBPy4A==
X-Received: by 2002:a17:903:8cd:b0:269:8d85:2249 with SMTP id d9443c01a7336-29027240d03mr7980115ad.22.1759863334954;
        Tue, 07 Oct 2025 11:55:34 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:34 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
Date: Wed,  8 Oct 2025 00:24:50 +0530
Message-ID: <20251007185508.40908-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_appendix.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document.

Rename common_appendix.rst to common_appendix.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../tools/rtla/{common_appendix.rst => common_appendix.txt}     | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-osnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst                      | 2 +-
 Documentation/tools/rtla/rtla.rst                               | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.txt
similarity index 100%
rename from Documentation/tools/rtla/common_appendix.rst
rename to Documentation/tools/rtla/common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index cc2721315552..102654cc0c78 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -106,4 +106,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index a11c485f127a..991c11d6210d 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -65,4 +65,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index c7bc716b2899..58321322d24e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -60,4 +60,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index c129b206ce34..997a981fe397 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -56,4 +56,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 547dfc7ace58..20c1315c21c6 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -110,4 +110,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 3740fd386ea8..c620ab16f849 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -133,4 +133,4 @@ AUTHOR
 ------
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index 20e2d259467f..e66d2588a416 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -51,4 +51,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
index fc0d233efcd5..2a5fb7004ad4 100644
--- a/Documentation/tools/rtla/rtla.rst
+++ b/Documentation/tools/rtla/rtla.rst
@@ -45,4 +45,4 @@ AUTHOR
 ======
 Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
-- 
2.43.0

