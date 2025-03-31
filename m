Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DD21638D;
	Mon, 31 Mar 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440831; cv=none; b=qSrqkT9wmY04S0Rql4JnpiacMXo9ej+WIiTWECmsNBncHNgwehPCB9/NsGVqtFP7Sxi7bT3bCuo+ewd40famUHYhMh+PmC+YbE6Bw4Hm85m5ICOworkeKPrdeU6ua0FKGvftOiUc5v3aqhFQGosmAANCpNOyiDeFBkBH+sRFxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440831; c=relaxed/simple;
	bh=7MaHULDzaSkG4icC7UMxUlSRMLE4Y/Cwy2XIplf4Sao=;
	h=Message-ID:From:To:Cc:Subject:Date; b=UU9MLqpYGXxd/ViYEyWXlskVCw9gI3AmD/viW/yVrnLjq9d3TonWIDjPh94vO4lZ3xBmzinhDQYhnvIaN0w9Xl7PiZCH7lUV0xGMQ8FtmSp1lElxQpktvNkWAbmPqMMAMj/MKlqKMMC0AuORk6wBPCeAVycNH5qJkj5ZINWF7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SfVskHiX; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SfVskHiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1743440814;
	bh=aSQCO39e/yaHq1IGMJwSXvNPWc0Kwg4k8lBUzMa7krs=;
	h=From:To:Cc:Subject:Date;
	b=SfVskHiXlyC1qKk+LmUSm6f2iUThFITYC9mHy8HIy/StbvMVEqI8w/ZrKccDUrnL5
	 EDgcb8KccJKTIzUA+DIZiy/849cowOg/1ATPE3GEGAn+cnvOc2gEjmwkWEcLyM8XB2
	 mrkJyceChwRa6fKh+hOFiBUqswFxitFVZFML1U60=
Received: from localhost.localdomain ([124.90.110.106])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 2FB2C33; Tue, 01 Apr 2025 01:00:47 +0800
X-QQ-mid: xmsmtpt1743440447t36xhxnmq
Message-ID: <tencent_3E06CE338692017B5809534B9C5C03DA7705@qq.com>
X-QQ-XMAILINFO: MJ4PQBQ4NCwQ5AhMwf/qMy8AICzZpbCOK3OTKLMLo9WrJ9C5O6BsUTwsV3uBqP
	 D+mS5BShXobmRPgsU+jubnL/mpg2rsVfq6TPGlqfYGYm/+yy0ZVWK4jUiL87g0uEbIFEe4jcXqO4
	 ASEvS8RarGeneW5sWjrl01xezSH5uiuPQ90m2aIMnx+fu2kWsXtVx9RdnnGWW/S2KqKDTfutegw4
	 yYM6TUqlllzLoK8g32ivuTaRpvUJqMz4EVhwJgGwqgFlKdF/mc4vMuHJCoJ88Yrsr90tKS+pEzn0
	 p7YPLbBgV5mzght1DCd/v+AXJj7xHxLC4VJ1qb7JI2agNTE0J4Ja6mzXt2lZ2SbgDpxQojPdlLN1
	 nGQUDlwu44zCd71+tg1zw+++8zhLgAJM0hwiA2wwf6QdGONJ1Xll5SWm4sIBFk6LRSa+lbR0mfVe
	 m8DDyimknkZOoGqlgsL7NzXt40bpS/1sHAF0+zW+ki37PBzQaNdPc15JVu72V1JBjd4+aMo/sRnU
	 +SPHzAtfyvTc8swH4QIA9RpbY/FOit7A/uu3ZPa1KYIuQcP4pskxDOC4ySl5UFnOyoPx5PzG8Tm+
	 g82HNx87H8AVavWQQW2nlfB1VUbUxfaswtQVGvBJYnIb+zRIQnEqsZ30jX/hrIdNKjFf8B4p2qH4
	 dn8BUzTE51LQPTpyAhyZiGifWCwJMiKEqWKB/7ebP+hHDuMNPa8UKo8z1iGxvz5PpsO/edu0Y7kV
	 m/u4S+Bm1/7eixL3LeYebMYo/kJIgVcfbMm9rnjayPive4POY14wEcRPdd2qCcCpcgUabpoiIFwB
	 fi5dbxJknMu+Ow9E/lF/RzGIZbbFzL0b2O9SsnAYUUksENkg6BbvFtX1H96H2+f1yK00yfg7vspQ
	 t0szuyUdKgL0l+dh7aauFk+lAHqiHGUdRjPPBhvQ9OpgJeOobB3WpBISXwRwFwIGBGTYhUyjvVGJ
	 F5NaW5piBEF8u2snTkBeWEFOFyau4qkFIMyQbmL7oCVOJgcTI4ofy6EyxgV/bA18FzVkmKqs4cZ2
	 zcXZeQ7UFinHVEfJ2i42uzRsYam1npH36PVFeFeE3TX0aNmOB1iFoAgZW2lKU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: zhoumin <teczm@foxmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [PATCH] ftrace: add cond resched to ftrace_graph_set_hash
Date: Tue,  1 Apr 2025 01:00:34 +0800
X-OQ-MSGID: <20250331170034.27276-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

When the kernel contains a large number of symbos,loop in
ftrace_graph_set_hash function may take a lot of time to
execute.This may trigger softlockup watchdog.

Add cond _resched within loop. This ensures  the kernel
remains responsive even when processing a large number of symbols.

Signed-off-by: zhoumin <teczm@foxmail.com>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 92015de6203d..1a48aedb5255 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6855,6 +6855,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 
 	return fail ? -EINVAL : 0;
-- 
2.17.1

