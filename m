Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7052E974A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863342; cv=none; b=qHy4yWiHEvRLf8pPWv/c0krTUztlXyhVHvGmiC+t/rtWNzBwbCY56RebKBm/SkPCHJMOUkmqzJY2AVghm+fSHY+ReUO3vtG9LfAQEct7Gs+OeaGv+K17crw+G/1ZnO+QDiSyO5qEe9kTwIJbLyU8vgfNBLz/KRQzDVaAG+5vdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863342; c=relaxed/simple;
	bh=Yj6qFGpRJNJDFP2ncNEzgdlCNrxdDvojcj05gRJtzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIBwkCZF6TqavryIuPY+Fcyeu9Flc5l/w53TkLU6R8vMKAXBnOtfNvfpf9qK04M2DkIA8RD3orh1SOP9ehr31LlWLLtvor16tS8OnhCjPPq/w4iBv4uTpTlPpOZUF5fxq6lLwJxPu28PxmHAJu6dxBdVU4pFVb3JHHM56Z8NiaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhekp05x; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhekp05x"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b63148d25c3so130911a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863341; x=1760468141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoECoCP08BHgzCQ48qCknodyteaa9PDghFpXIE55+JE=;
        b=Bhekp05xjipuzolMaDss65bhEcl/85WOuwx8le4i6a8M0UwA0BqtKnZ8k3VnankSG5
         ueJXBfvhpKifVAmqT3KcFTHmnR5Mt0/LSLYk2xRlvOSUZr8Gopdshf70AYyZajGTcZdW
         fyTwu2qSw/pdGSg9STsn8jktJYZOOJfdgqtYXj5d5PijDyfd7Ga4zNP3n9A94ri5dh4J
         GJyA3haSaSPxPKsM0sRNWUnv0UnxJK5Eps/3g3ttyrZoVQw3f59X1TeF5fJgRMTm/al2
         7YWf3Nq4FiFNr7qaHhH4gmu9CQMclcHZFJ2WepXJxpuVww9Y/ao2EuSAQ/T4KorlVucL
         1sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863341; x=1760468141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoECoCP08BHgzCQ48qCknodyteaa9PDghFpXIE55+JE=;
        b=AV3qa3jv+98JWWv2+lSXR5zLg+D0KWYdvXTL0a7oHoeoqPBOeA2dR3vSn07fqNA7rC
         MDYs88KnayhuiktSgafmhNUAQ4pEP3+olLZHpKjzF0oGYq+ABMDfB5yz8Q/rJJMZYGrI
         8yoZLCsLfQ2ekmivvqAXR0FQr56p5JR0GJfCACGG1FLTuDVsOKYVTvxd1QCp1ZOye6+c
         p+U+7IGc5Uj2qzXkTVdm9o58CR7PLMgu4Y2JheWqUH5/m/ERRsvZ+fg7KYlHMn5xaQoo
         P7fdATCxm0ZwyZACB+6MEMsuHQIBTcuYB0WfhE3qjodVj0Omaw3VIuV0nZ3xgg1HOV9s
         EZRw==
X-Forwarded-Encrypted: i=1; AJvYcCW/cXt+YnXBJ9HK2dnCxdYNhovAiiBod0WJL3GN3ukbVLsyCqIDkxaCm8hPkAVS0q+GSylHdugS6cwa6ZTaWR2COR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsa0MsRI2NXsm7gmEmhmNzlTwbTMQPEsvltNQoHxYPa+NIzbi9
	xWN/wfPtICaDKrRnQOu7dXJuWWQBvQljaetZFhRa75kr9NtaF4sbDekS
X-Gm-Gg: ASbGncuPJyOzJucRECzRzLISPVEedwfw5toQTIc7wKMQfe1RNdHAEXvEGXSjDIWB4QP
	fRvirfeg2GINAgbEA8vt0cKo3HueD5zSDT3L2FGgPwVurT6NG+P/Q4vCkt1d/bFzUj7AfR1Mx8R
	5lO2ueH69ggBgNeZPfQ2mIbmhzSkuhtJEIhN29CDGqljFTING0JHSg48iTIDjHhSyNTQ+Oiamrt
	F6Zo+Sw2H4v7nRNwwPCRt1S94iP9inbaIAzKF0cKgcd1GZCTLeKqiZzslhDZi54jDRxn4ZxXs/a
	/idEUqafvP8WS0g9vQjRV9fFL6r5hf5o0tVqMBnLGKO+0gooikqd2a/m8B3NHYwdnQY/pPV0oOl
	JadYlyjuuyXDKyLht3bhm+h2Ml+/Cq0koNGMeKOQsEk0cut0SMZ6IhHPcz7pIse7x3Q==
X-Google-Smtp-Source: AGHT+IFJamQeAOOdQ9dqsKsLUKxoiyUO82ESK8nEp/zyoxNnQPXrmUGH61Q/EWQgGDEZfqVMdB2aHA==
X-Received: by 2002:a17:903:1aa3:b0:24b:1585:6350 with SMTP id d9443c01a7336-29027e78f7dmr3818745ad.11.1759863340793;
        Tue, 07 Oct 2025 11:55:40 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:40 -0700 (PDT)
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
Subject: [PATCH 2/8] Documentation/rtla: rename common_hist_options.rst
Date: Wed,  8 Oct 2025 00:24:51 +0530
Message-ID: <20251007185508.40908-3-krishnagopi487@gmail.com>
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

common_hist_options.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document.

Rename common_hist_options.rst to common_hist_options.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../rtla/{common_hist_options.rst => common_hist_options.txt}   | 0
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_hist_options.rst
rename to Documentation/tools/rtla/common_hist_options.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 991c11d6210d..a39285817566 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -26,7 +26,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 20c1315c21c6..43f99bf0f1d7 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -27,7 +27,7 @@ OPTIONS
 
 .. include:: common_timerlat_options.rst
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
 .. include:: common_options.txt
 
-- 
2.43.0

