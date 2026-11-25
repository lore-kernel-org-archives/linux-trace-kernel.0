Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592399;
	b=Csulv4tiF3w0C0ZhCLmBxXGRAUcJ5hMjhe+b8ddEyGV4crGFSFgJAuqfVht9gP7AarSp
	 7y+cl062D87xzzPRx/sk2pg3BBr4Wl9FYm8PhdQ7odDZyDG1npTOPh20jOAZdX3pE+fUe
	 RdS+lvfKduE7Lk6TXCm0HsXCetsMdfGkveWo+v54bPIuwQPhd/dylFuWDVjbf9rr5+++r
	 RRiwBRcTEQ3P51lWb9qTMelIMu5Ep85YtXSNRQZQ17NO7/C2Pk6LEomwzLxtdAl1BZpsA
	 CLo8Z9+rAgm06z0LZGUAxvWcwWNEgwPv6O3ASD304cXLNGGY46x9yfzB0ydc0l0Dkng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fic+huB0IdoHR3E/p8bmW1S+ux+MyhR7gu/qGNu0uOA=;
	b=i/OZOyF6Ypr5UcCnMPsCX3jUyg5gaHuZienpB6iOSUMK0n02HN/jvywDuBn6/G9eQrOf
	 UdNWGjXZ9jYjE3x+95uyUPuWmzYvtqUn9oQLTJKWmiXNS2LWrY8t8hRDtdz34OQZ6dwbD
	 jBqylHvqy5aenYYRYJWvGbMsiGAV8aswMuTKnD9JWRDUuA4808PrKdHZL48kPtt0XjAjq
	 WTsZzMvT/scRP5yXB9cyCilw0NzLjG90Pi5Q/qCexjUnbT8uc16pJdQZUrf3fO2UrA2Vs
	 nlkfrou+uVRV5W8681XxA7R8dVJib3Vpx5wqgdqIvlxx2PWkwe3jCDF8pzFOc0C/ydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjjSHTcS;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A94606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 07:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A94606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjjSHTcS
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3116225f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592397; x=1796197197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fic+huB0IdoHR3E/p8bmW1S+ux+MyhR7gu/qGNu0uOA=;
        b=cjjSHTcSrHrh4Uxp8wVViuT4smzPfmMkjlhfaP9Ka1QzEjRMy9zDbQziVzv1TaBRYW
         aF7+sjCV5MT4p0r3q7WYpiYe+k4+PwcPC5W4mR+cGDYkLrsQkmRmKPVTi0zkrzSv69d5
         n9A/5nrEsV9exQCHsIhMgOlj4UrbORTRRk4QlZ8a1Th9Hl4b6Kos3hLAXjRCUHDh/FMo
         TFSg1y6DPd+TlFQj9EzNCMjXYHzYJUJsSzhhrlIUjkw2Bt2n7UVUHmrd0e4UtLeyLZXm
         CsNq69+hQCp/Zj13orM1N/2tzNO/LUjU3+7CEiDkxR9Vnmnd9zC/s4ysZbQyZkvz5u0S
         JeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592397; x=1796197197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fic+huB0IdoHR3E/p8bmW1S+ux+MyhR7gu/qGNu0uOA=;
        b=m9qMBusZ0ckg/HOpA03KIIb5WcKuKZvXesrHIQxC0iya5atlZ2D4hANhR+s94L8aP/
         QVHZiy94+CKG0yqzOMK3e79YtNRX8AwbCgoyU2oHLTtgSvK68GhE/UAdm1/PZhw1yh62
         oeXnWHpAS2pj7xSeuoTBBnPRoIxx33fE5oUNOitjYr64u7+nWoF7u7XvsEETLBx4RzBG
         eWtaBgTTY7RnV8YZKggUFXvc6ZS9Sc+D3sf0ag/J2aWngCfKEj77+2Qz5Nz7W1H4ea2Q
         BeQnNAj3EdYlTlo/yKUhFNm9w8KIsjlC2/p5Ons2r/0od3u7frcsDhDTJlMBDCrBC5Z9
         dUBw==
X-Forwarded-Encrypted: i=1; AL+hErENJSeCl69eGHfuhGnTA+1fiWt6+Br92XlEGquYEN82ha1mmFaREvMvxFCfgahtjIUnY8Sl+SskyH2xF0V29AKagbA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qgM9T6YuD+r4KjXhSaMBslc3lvklJL1SdgzJNSoXv7UkGLBZV
	bEnIz0faKR8w1w7i7VRoif4S8JvV3YRRe3ZTNyQiRvq53WC1rb53gLyk
X-Gm-Gg: AZFdTZeh7H1kEF87KoaYiDRLpSU2ZzrTbjVGZ7rQUW9j1B2VJS5jRyCo2PiYEdyc5AJ
	CZMc6SLKPmnRszNcNm4vWkyT62I9rtV1jzN8GZBcCGyqIVxn+GAxcGXvzqfXjrVgP9/8kUhI4MZ
	Mv0kv7pak2QDW57+tyX9mxfeshAHM0k9zcPmceoL3uN/Guh0vpzXmw7N+WeWLrEhaf0wDfJfQNv
	sI8QqJK7zahK0y6cDGIS3J2TAzA5NaHodg4M3pwPggmfzxFVl3+K6DhtNgip4ki8QtSVLd9K2CH
	CkV4nz5PFiiQh7hpzbej/8lX/hMQ/MFR2JGiMwXs7Pj9UB3Mxl3ifz39pOLPImRi5vJV2b45Vgr
	Pt9eZsAolJjIweyD2RFd48RGaRwqi9tiac+RpN6GVLq5WrxudGawlyJEENDWtxV8FxtR5HGMgn4
	6AB8Enk+oDlRXpnel4mcSGt64rdxsU11bFVzAVHvgGLe9ZJnt68J+7d3JAyxUgy0MsVfTM+j6A8
	PwBWN3eDVDxXohkzRzfMdUnH8vgK4wVwXJg2Ayy7zWJO0Ih9H5mlhu9wHF3My5cbeDs2OeEJEN+
	weSdFLOK1xWdqeeF5o9NA72qU1adcfwpXzlj71gh3tfOBB9lgDDMmiVwXmjfQbwppBIunyfUCWk
	P4+EeEG9Ptphf6h1tNuVe4lxRr7iA6i5Ns/WTQGUF4fhzPrAMiwwGQi4MfFRthC4oT9zhrqhjjG
	ZsYqf8KUNa0bI5eVSz1CidwkQKqCrRz6IlxcBuNXqypFVIfCDHfswCv3O+nXmk+KWnY0/Jqwvny
	4eDUFoWBNzlLQ+rUw==
X-Received: by 2002:a05:6000:2b8a:b0:4a7:b365:19dd with SMTP id ffacd0b85a97d-4abb4b85bcbmr21938249f8f.53.1795592396978;
        Tue, 24 Nov 2026 23:39:56 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm31725489f8f.47.2026.11.24.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:39:56 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: bootconfig: Document the current config limits
Date: Wed, 25 Nov 2026 08:39:41 +0100
Message-ID: <8b11df1def359a2b28cd4bb6c42606e25ab9d6d7.1795592381.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bootconfig has accepted 8192 nodes since the node limit was raised for
DCC support. The admin guide still describes the old 1024-node limit and
derives example entry counts from it.

Describe the current node budget and how keys and values consume nodes.
Document the 32767-byte limit for initrd attachments, including the
terminating NUL byte and excluding alignment padding.

Fixes: 6c40624930c5 ("bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

Thanks again for the reviews. The guide still lists the old 1024-node
limit. I checked the 8192-node limit on my Ubuntu machine and tested a
maximum-size config with all four initrd alignment paddings on top of
your padding fix.

Thanks,
Eduardo

 Documentation/admin-guide/bootconfig.rst | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 3d6412458c8b6..30bf89cf0f67a 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -354,18 +354,13 @@ The final kernel cmdline will be the following::
 Config File Limitation
 ======================
 
-Currently the maximum config size is 32KB and the total key-words (not
-key-value entries) must be under 1024 nodes.
-Note: this is not the number of entries but nodes, an entry must consume
-more than 2 nodes (a key-word and a value). So theoretically, it will be
-up to 512 key-value pairs. If keys contains 3 words in average, it can
-contain 256 key-value pairs. In most cases, the number of config items
-will be under 100 entries and smaller than 8KB, so it would be enough.
-If the node number exceeds 1024, parser returns an error even if the file
-size is smaller than 32KB. (Note that this maximum size is not including
-the padding null characters.)
-Anyway, since bootconfig command verifies it when appending a boot config
-to initrd image, user can notice it before boot.
+A bootconfig can contain up to 8192 nodes. Each component of a key and
+each value, including each element of an array, consumes one node. Keys
+with a common prefix share the nodes for that prefix.
+
+The data is limited to 32767 bytes, independently of the node count.
+For a bootconfig attached to an initrd, the limit includes the
+terminating NUL byte. Alignment padding is excluded.
 
 
 Bootconfig APIs

base-commit: 56bb11fe6aacc7666938e8e6765b44aa0cf1fcdd
-- 
2.53.0

