Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0F3A8388
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057930; cv=none; b=HvzzKIqyAWUDywAcIvc/NikQfVggHRMB2dqDvc/tsZS+uJUlEBx1yadM57fzGexpZp3vJaJmbiZnpuVJRnOUYc4YKZNWyVpMxvM+miCo0vEzb/WM3QA9RvdA6Dwvsu3F8HrYIjwA4ELYiWNz4aBMYx3LFc1VtrqifsNTpVsxby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057930; c=relaxed/simple;
	bh=hHcCjfX5AAso8JCRpiIUKEVxhVLz97MMkP1XDFlwt0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qljRG0+o28rzhfhOIVYXmt7rkRwI/oTj+XWwT3gt+PApqPUBzsOtyOoKL7Dp4CcaabKgA6th/h1nv5TC/cLz1LMH14QXKVjLMQqc3px/cYVUcjGe03GXNiDnUVnpEBOsLQ3reMPDuHq/+T0+jN8ahi8DHmmB6CVXjucBs58ToFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGDVI0Ov; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGDVI0Ov"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964e480f76so8473598a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057925; x=1789662725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLi+as5jEqWO7i6q0OigGpuHqT1Wr6BZbntZ1oiMRHc=;
        b=rGDVI0OvbTzds0VuUrtoBaNklo7jGGfHlO+V63KKH3kF5abh2lHu4UFpUH9H74/17H
         pZwNWUa7xF8pjqoW8Xn5zlTCBoej6IBeHMW85HuHq3wQ0E2T6NSZTOFQlrhopXgWIL47
         hkUWZVBpBNizCRkg65iTKbJodUNvuWaIaKaAB7jQRDAt2tdfERu7nw5+mte79ehmUvGB
         nvLbLzJLbX1EJKpi01slPhnrECgFsd3pjlbOqoV3efkGeIQUK8Te3hb5pJhPB4RpJuMD
         S/9G6G6BPTBwEltC7tjNdwm3Fvw2eE9xl3VaF6QX8Do0/+VVHDR7RT5JwaQ8eZQPGwbs
         Xm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057925; x=1789662725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLi+as5jEqWO7i6q0OigGpuHqT1Wr6BZbntZ1oiMRHc=;
        b=RiKPMaozWZDr6YCAVBF9ycjAGSg+tTnIejYRaa6bFwc7Qt65akseweben7+HJzj3ja
         LXWgNtLjLegHOjyMTj9p/x9d1xZH589NUB5ePr1Akq+TYoUcy3BRlA9xjGWVVkK0YaX8
         PBkcRwJ6WFJKMMfXgoe02Ovt/5W0ZPRFWfi22qsbm7z5fX16aVFJhcnvJ8fY66IbW9YZ
         J0Wn8669OJnnJUCGSXF0CIOSPexodZYzdN3vu93t1il/dQ5/O5sGg3ROu23r5OwD0Zvd
         PWAq7s/ErNfoghu+c4se5uonYn2Inv1BmXMxlGbWhtPBjZnJHqTyM4nDajoMQ3beASyk
         C0Lg==
X-Gm-Message-State: AFuF++mNQsrG5Jf78EjkgNwsCeIUFC7Yjw0ySqbjIUMSH48RtWF7uxSl
	xoSGepKm3xkrH77fxXF4eS44uZ48P04vvtdhKVozs60kP0fJgSNahKBj
X-Gm-Gg: AYBFou10V89TPOSO0rOsOZqYaTJGSzEygwhZUTykzD5hUeY8JNd6qN1BnDoOxPUmLTL
	MuJ7zjIoC9RVYl3+erFY//XLufNKYHNjkBkZWzhLYjFeJmY+E6Ie0u6EDjtq59dug9JLeM22uNg
	UYRo2oJnckB9CVFuCN3pvfZ/t/Ag9DTVBBzsVmqNgtGY/H43FsPQqZMOy/AvjNfVpd22S5D0/Yx
	zyTdU0nE2hG3aHx2Yyhnp+zBkjM5KOJfAHXEmw0zAQ9a1G8rxXDFgcozoEJpaDfexpiFYFImc7+
	7zB1C/OOkUHWWdYjjxOXno4kSc4P8I1c+82GjULb0LLm0/u2y+iOqfQ3PFtLkqsvWsrFTcL3B/B
	IS9VyF5yc33bNpfPUCtIkfg1SxfOVQNq1JWAZtDU0xK67puyF9bpb9JbDNSNHpru58Yho6CejLH
	R8vYH8aU5eK14fSPpY2MamFg2wMqHpFbyKLPH7FUpsSuUyh29NLa8slFlqITusT1MvRg==
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr59861647a91.8.1789057924963;
        Thu, 10 Sep 2026 09:32:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98a591a6sm16727a91.1.2026.09.10.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:32:04 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: remove unused PAGE_SIZE macro
Date: Fri, 11 Sep 2026 01:31:50 +0900
Message-ID: <20260910163155.1974118-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PAGE_SIZE in tools/bootconfig has never been used, so remove the
definition.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 tools/bootconfig/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7dc9fff9b637..2b4d9559159c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -134,8 +134,6 @@ static void xbc_show_list(void)
 	}
 }
 
-#define PAGE_SIZE	4096
-
 static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;

base-commit: 13e8b7707efcea3a401d242958ba0a392f227847
-- 
2.43.0

