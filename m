Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76B22A4E5;
	Sun, 10 Aug 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754824390; cv=none; b=WXhNNeAVYvVOXx0hm5Ps934HlESRgFx/LQcvx4Abs2RCzwL3SAJxFJhaoTfYjfMZn5+8oGBnalqvmRiYMmqND7p6uwOx/Thlkvalw5UtiRf5RiTcR/NT7tguR1nSlfIdE3Id80yiFp12ObSSsFe62dOf5X98IXkYfhii8jMOQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754824390; c=relaxed/simple;
	bh=QhLjmOIS92P7ea/XzuNovZfDinZN9nt/o+nPMeNZ4zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mP+n4u6Uf0DyoXy5EpRaMGY10Sj2oj2GXjmvupwViNODS9qh9N+vDtoPiOsgSlDpHCDEJnYNZ1XEDaEkQYSL7ZnandGyaUumLWrxLUK1Mh+wKX3D9YePkaBg6BCDhvANs+mzkEAXrmBdiGT3Q5sg+Tnh/4oTwqk2VUh00/2+kTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmmLXmY4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmmLXmY4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bed310fa1so2916364b3a.2;
        Sun, 10 Aug 2025 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754824389; x=1755429189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb/Swu0G08J4y82/6Cs36yghjUYUfH8TllUehxDTCYg=;
        b=BmmLXmY4kYy3pOqFq6pV1i3loCDlQ5KFYQS0F0fnpGSEHNlvyaKZT6xOPVWk0hkAer
         J34sHkBe4dc5KZGbOSF6NSqCQUSJzU3EYwq7WRtcsWdIiqlfinM1TkX9NKyqOvAGTmW5
         DsvgXk1l9dJ1hiaVz3BES8+sP506UCBFKT9v/JvMB55puxwxs+kg3qR89K+jalsWFyTB
         wUuXYFFQgCdup6tX5nLNs8PZXzMAqpAej9P6rBotyq5M8IxveVW62NjCzCVK26vhdrdU
         /Bjl9lrOMHKl40NAxA7LPH7/s2ERa54q6sub8MOvxneMRM/mSqk9d4GoiLTBorFEh8mO
         lU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754824389; x=1755429189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rb/Swu0G08J4y82/6Cs36yghjUYUfH8TllUehxDTCYg=;
        b=njGTnVnfeg9ADevJnr1bt+x7x8vGg+epWfJ3/udLaSU3Kbn/OYLy2EwgfqjieuD/d9
         wqEeGY4iNrsWfRZeDBKR9Y4ol8Fl6f3zwQMjeQ132/6xzGoTlODPJUMDHGDszRViHv2Z
         GeeorxypPMLyfKaiIuOavJDamIw9itMJIUAiuNlvtahT/Hv/7vJeUxEz6CXCL4xsPXp8
         paGrwi4UYxLqVn0iliqpmo3t+XLSA4JDvGSDDBl815jjyOi8FHW9Oxf65UimUOc3TqKj
         WwTVZeS4eVAGVnR2/CEB+AxR8X3QR93JQKBhMKKMmywVAFzS0MQD6kmlm908aAH0g9zw
         A29g==
X-Forwarded-Encrypted: i=1; AJvYcCU4cApPiHeR4MyKGSH0gAPmReaEoICBnUt8F/ktckIp/mkFk4MeEOvMNXdiKm4YCLzLPlqWvXITOCk=@vger.kernel.org, AJvYcCV0STYBizgnRgmD6I6l02oZt5JdcxELFtVW/EiDFbdEFR3pK4z1rVQqL01WIqWQwrVaFnSyAUNkEYSPNtpredE7BHW6@vger.kernel.org, AJvYcCXSnoy8gXxK38BXTFu2zXDzhGZKYtW52amH8eNSJ8PnzgCIZ9CdsuY2rqpDW07olQa4KLu152fu7I4c4O9w@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzWXUK0T+1O8uyMU3E9SfdJEeofs4Grwoj/AbI1bo6hqxHWIr
	88X1w+zPK+n+rJQ3yuO4kJyKmwA8P2ZTchVHS7vC+EomAlh6wwgtUjAB
X-Gm-Gg: ASbGnctz28l2HF4eiLxrM2K8ARasyHIAmEVT7GZTAqpRzyNQAJywT+JRNoLSINJ0eOq
	oFHTjKDx6VfWUZC+IuiDwQfukgoJdVJo4DSp6Xjk6+jmbnlBJyc+clX/4MlpzI2xeGwSqRrahnR
	aiKFRF6gt1UXsbEHMwqijOsZLAye0xeghdy5HTFhcw121QR5vNwd1fBck6boigG2AU1e+sJ6QlW
	gk8+n3cuSa6o4xwg4V/8OGteWkB12xCkcnpwtoKlSpJCmJTJmxpT/qeDEyXGkTnBCLd0F27fxTo
	KiYkf3dnz2X0dnKR0l0k8dn0iPW7CNlcshmq4Y2Jeun9S18ox5Sg0L9O95iokN0EeFbvUjERaSB
	s/M5Xi7jvvJKw/cx0ZzxPyX0Apb2OXLIfWBE6+MFk2K4=
X-Google-Smtp-Source: AGHT+IFYbOlLruk89Zs56x9IK75Dy2SXGTNWfKStneEVZOxxj2/Sw109N76g6LUWLW1IDYmJc4i51w==
X-Received: by 2002:a05:6a00:139e:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-76c461b2aa8mr13327685b3a.18.1754824388851;
        Sun, 10 Aug 2025 04:13:08 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c0a952525sm15705030b3a.79.2025.08.10.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 04:13:08 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] Documentation/rv: Fix minor typo in monitor_synthesis page
Date: Sun, 10 Aug 2025 16:42:48 +0530
Message-ID: <20250810111249.93181-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically, fix spelling of "practice"

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 Documentation/trace/rv/monitor_synthesis.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index ac808a7554f5..3a7d7b2f6cb6 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -181,7 +181,7 @@ which is the list of atomic propositions present in the LTL specification
 functions interacting with the Buchi automaton.
 
 While generating code, `rvgen` cannot understand the meaning of the atomic
-propositions. Thus, that task is left for manual work. The recommended pratice
+propositions. Thus, that task is left for manual work. The recommended practice
 is adding tracepoints to places where the atomic propositions change; and in the
 tracepoints' handlers: the Buchi automaton is executed using::
 
-- 
2.43.0

